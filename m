Received: from eggs.gnu.org ([2001:4830:134:3::10]:59304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gCg3V-0007Fd-6E
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 03:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gCg3S-00083U-2N
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 03:15:45 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:49631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gCg3R-0007Ue-Rh
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 03:15:41 -0400
Received: from player691.ha.ovh.net (unknown [10.109.160.232])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C2CFC163C0A
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 09:15:18 +0200 (CEST)
Date: Wed, 17 Oct 2018 09:15:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181017091516.35af8b13@bahia.lan>
In-Reply-To: <20181016174158.15229-9-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
	<20181016174158.15229-9-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/38] 9pfs: Fix CLI parsing crash on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 16 Oct 2018 19:41:28 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  9p-handle.c's handle_parse_opts() does that, and then
> fails without setting an error.  Wrong.  Its caller crashes when it
> tries to report the error:
> 
>     $ qemu-system-x86_64 -nodefaults -fsdev id=foo,fsdriver=handle
>     qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: warning: handle backend is deprecated
>     qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: fsdev: No path specified
>     Segmentation fault (core dumped)
> 
> Screwed up when commit 91cda4e8f37 (v2.12.0) converted the function to
> Error.  Fix by calling error_setg() instead of error_report().
> 
> Fixes: 91cda4e8f372602795e3a2f4bd2e3adaf9f82255
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Greg Kurz <groug@kaod.org>
> ---

Hi Markus,

FWIW you had a Reviewed-by from Eric.

https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03297.html

Cheers,

--
Greg

>  hw/9pfs/9p-handle.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
> index f3641dbe4a..3465b1ef30 100644
> --- a/hw/9pfs/9p-handle.c
> +++ b/hw/9pfs/9p-handle.c
> @@ -19,6 +19,7 @@
>  #include <grp.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> +#include "qapi/error.h"
>  #include "qemu/xattr.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> @@ -655,12 +656,13 @@ static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>      warn_report("handle backend is deprecated");
>  
>      if (sec_model) {
> -        error_report("Invalid argument security_model specified with handle fsdriver");
> +        error_setg(errp,
> +                   "Invalid argument security_model specified with handle fsdriver");
>          return -1;
>      }
>  
>      if (!path) {
> -        error_report("fsdev: No path specified");
> +        error_setg(errp, "fsdev: No path specified");
>          return -1;
>      }
>      fse->path = g_strdup(path);
