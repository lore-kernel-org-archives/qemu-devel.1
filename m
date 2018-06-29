Received: from eggs.gnu.org ([2001:4830:134:3::10]:52179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ04C-0008RP-MI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ049-0000iI-Hj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:32:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fZ049-0000ge-Bb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:32:25 -0400
References: <cover.1527814874.git.keno@juliacomputing.com>
	<dc7a7959808593c941fbf73f9f426f92632c0029.1527814874.git.keno@juliacomputing.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc97fc23-6e0f-e232-1ef8-3c562b28c9cd@redhat.com>
Date: Fri, 29 Jun 2018 15:32:23 -0500
MIME-Version: 1.0
In-Reply-To: <dc7a7959808593c941fbf73f9f426f92632c0029.1527814874.git.keno@juliacomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/20] 9p: darwin: Explicitly cast
 comparisons of mode_t with -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>, qemu-devel@nongnu.org
Cc: groug@kaod.org

On 05/31/2018 08:26 PM, Keno Fischer wrote:
> Comparisons of mode_t with -1 require an explicit cast, since mode_t
> is unsigned on Darwin.

It's not JUST that mode_t is unsigned (an unsigned int compares just 
fine against -1), but ALSO that mode_t has unspecified width.  That is, 
you cannot portably assume whether mode_t is smaller, equivalent, or 
larger rank than int.  If it is smaller, then you can't use mode_t in 
va_arg(), and mode_t will promote to signed int, whether or not mode_t 
is unsigned; but '((mode_t)-1) == -1' is going to be false if mode_t is 
unsigned (because the cast truncates the sign extension bits into a 
positive value).  Conversely, since mode_t can be larger than int 
(although I know of no such platform that does so), blindly using 'int' 
when trying to parse a mode_t argument through va_arg() will truncate bits.

So, for example, to portably write a wrapper around open(), you HAVE to 
use hairy constructions like:

mode = (sizeof (mode_t) < sizeof (int)
         ? va_arg (ap, int)
         : va_arg (ap, mode_t));

or, to avoid spurious compiler warnings on the branch not taken, define 
a macro learned at configure time.  This is what gnulib does, for example:

   AC_CACHE_CHECK([for promoted mode_t type], [gl_cv_promoted_mode_t], [
     dnl Assume mode_t promotes to 'int' if and only if it is smaller 
than 'int',
     dnl and to itself otherwise. This assumption is not guaranteed by 
the ISO C
     dnl standard, but we don't know of any real-world counterexamples.
     AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <sys/types.h>]],
       [[typedef int array[2 * (sizeof (mode_t) < sizeof (int)) - 1];]])],
       [gl_cv_promoted_mode_t='int'],
       [gl_cv_promoted_mode_t='mode_t'])
   ])
   AC_DEFINE_UNQUOTED([PROMOTED_MODE_T], [$gl_cv_promoted_mode_t],
     [Define to the type that is the result of default argument 
promotions of type mode_t.])

> +++ b/hw/9pfs/9p-local.c
> @@ -310,7 +310,7 @@ update_map_file:
>       if (credp->fc_gid != -1) {
>           gid = credp->fc_gid;
>       }
> -    if (credp->fc_mode != -1) {
> +    if (credp->fc_mode != (mode_t)-1) {

At any rate, this is the correct portability fix for this code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
