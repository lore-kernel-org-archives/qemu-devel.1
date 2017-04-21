Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1VnX-0001e8-EQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1VnV-0003oy-L6
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:28:19 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1VnV-0003oL-AY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:28:17 -0400
Received: by mail-wr0-x233.google.com with SMTP id c55so51983119wrc.3
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:28:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
References: <CGME20170414131739eucas1p1ea9a6adcdbe8cfe45ac1ff582d28d873@eucas1p1.samsung.com>
	<1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 11:27:55 +0100
Message-ID: <CAFEAcA9ve6APJtoHrqmzOTMcmu0KAFqdJ9bfyfTX7wjJD7eULQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/6] util: introduce glib-helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, i.maximets@samsung.com

On 14 April 2017 at 14:17, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> There is a lack of g_int_cmp which compares pointers value in glib,
> xen_disk.c introduced its own, so the same function now requires
> in migration.c. So logically to move it into common place.
> Futher: maybe extend glib.
>
> Also this commit moves existing glib-compat.h into util/glib
> folder for consolidation purpose.
>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Hi; thanks for this patch. I have some comments below, mostly
aimed at improving the documentation in comments of what these
new header files and functions are for -- the bar for "how
much explanation do we need" moves up when a function is
moved from being local to a single file to being available
to all of QEMU.

> diff --git a/include/glib/glib-helper.h b/include/glib/glib-helper.h
> new file mode 100644
> index 0000000..db740fb
> --- /dev/null
> +++ b/include/glib/glib-helper.h
> @@ -0,0 +1,30 @@
> +/*
> + * Helpers for GLIB
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */

So glib-compat.h is for functions which exist in newer versions
of glib but not older ones. What's this header for? Ideally the
comment at the top of the file should make it clear what kinds
of functions go here rather than elsewhere.

Also, GLib is capitalized like that, and you should have a
Copyright line here.

> +
> +#ifndef QEMU_GLIB_HELPER_H
> +#define QEMU_GLIB_HELPER_H
> +
> +
> +#include "glib/glib-compat.h"

Nothing needs to include glib-compat.h directly, because osdep.h does.

> +
> +#define GPOINTER_TO_UINT64(a) ((guint64) (a))
> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */

Can we have a proper doc comment format comment, please,
since this is now a function available to all of QEMU?

> +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data);

What is this actually for? Looking at the original uses
I can tell that this is a GCompareDataFunc function, but
the comment should tell me that.

It also looks very fishy because the function name suggests
a 64 bit compare but gconstpointer may only be 32 bits.

I'm not sure it makes sense to specify the unused attribute
on the function prototype -- that is a property of the
implementation, not of the API exposed to callers, so it
should go on the function definition IMHO.

> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */

This is the same comment as above, so it doesn't explain
what the difference between the two functions is.

> +int g_int_cmp(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data);
> +
> +#endif /* QEMU_GLIB_HELPER_H */
> +
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 122ff06..36f8a89 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -104,7 +104,7 @@ extern int daemon(int, int);
>  #include "sysemu/os-posix.h"
>  #endif
>
> -#include "glib-compat.h"
> +#include "glib/glib-compat.h"
>  #include "qemu/typedefs.h"
>
>  #ifndef O_LARGEFILE
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 10a3bb3..7cea6bc 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -35,7 +35,7 @@
>  #include "elf.h"
>  #include "exec/log.h"
>  #include "trace/control.h"
> -#include "glib-compat.h"
> +#include "glib/glib-compat.h"

osdep.h includes glib-compat.h so we should just delete the #include,
not change it.

This patch looks like it will break bsd-user compiles, because
bsd-user/main.c has the same unnecessary glib-compat.h include
and the patch doesn't change or delete it.

>
>  char *exec_path;
>
> diff --git a/scripts/clean-includes b/scripts/clean-includes
> index dd938da..b32b928 100755
> --- a/scripts/clean-includes
> +++ b/scripts/clean-includes
> @@ -123,7 +123,7 @@ for f in "$@"; do
>        ;;
>      *include/qemu/osdep.h | \
>      *include/qemu/compiler.h | \
> -    *include/glib-compat.h | \
> +    *include/glib/glib-compat.h | \
>      *include/sysemu/os-posix.h | \
>      *include/sysemu/os-win32.h | \
>      *include/standard-headers/ )
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index c6205eb..0080712 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -43,3 +43,4 @@ util-obj-y += qdist.o
>  util-obj-y += qht.o
>  util-obj-y += range.o
>  util-obj-y += systemd.o
> +util-obj-y += glib-helper.o
> diff --git a/util/glib-helper.c b/util/glib-helper.c
> new file mode 100644
> index 0000000..2557009
> --- /dev/null
> +++ b/util/glib-helper.c
> @@ -0,0 +1,29 @@
> +/*
> + * Implementation for GLIB helpers
> + * this file is intented to commulate and later reuse
> + * additional glib functions

Did you mean "accumulate" ?

More detailed description of what functions live in this
file would be useful -- these aren't actually GLib
functions, just utility routines that are useful to
code which uses GLib, as far as I can tell.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> +

Stray blank line.

> + */

This is also missing the copyright line.

> +
> +#include "glib/glib-helper.h"

Every C file should start by including "qemu/osdep.h" as the
first thing it does.

> +
> +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data)
> +{
> +    guint64 ua = GPOINTER_TO_UINT64(a);
> +    guint64 ub = GPOINTER_TO_UINT64(b);
> +    return (ua > ub) - (ua < ub);
> +}
> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */
> +gint g_int_cmp(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data)
> +{
> +    return g_int_cmp64(a, b, user_data);
> +}
> +
> --
> 1.8.3.1
>
>

thanks
-- PMM
