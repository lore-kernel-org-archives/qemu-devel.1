Received: from eggs.gnu.org ([2001:4830:134:3::10]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evJSk-0004O6-Io
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evJSf-0001Kn-Ho
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:09:46 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:53416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1evJSf-0001HG-Al
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:09:41 -0400
Received: from player693.ha.ovh.net (unknown [10.109.120.41])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B3EC75BDE8
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:09:39 +0100 (CET)
Date: Mon, 12 Mar 2018 10:01:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180312100146.132ad93a@bahia.lan>
In-Reply-To: <20180311201239.25506-1-nia.alarie@gmail.com>
References: <20180311201239.25506-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9p: Convert use of atoi to qemu_strtol to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Sun, 11 Mar 2018 20:12:39 +0000
Nia Alarie <nia.alarie@gmail.com> wrote:

> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---

Applied, thanks.

>  hw/9pfs/9p.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 48fa48e720..64f3bb976c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -15,6 +15,7 @@
>  #include <glib/gprintf.h>
>  #include "hw/virtio/virtio.h"
>  #include "qapi/error.h"
> +#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
>  #include "qemu/sockets.h"
> @@ -2213,8 +2214,15 @@ static void coroutine_fn v9fs_create(void *opaque)
>          }
>          v9fs_path_copy(&fidp->path, &path);
>      } else if (perm & P9_STAT_MODE_LINK) {
> -        int32_t ofid = atoi(extension.data);
> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
> +        long ofid;
> +        V9fsFidState *ofidp;
> +
> +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
> +            ofid > INT32_MAX || ofid < INT32_MIN) {
> +            err = -EINVAL;
> +            goto out;
> +        }
> +        ofidp = get_fid(pdu, (int32_t)ofid);
>          if (ofidp == NULL) {
>              err = -EINVAL;
>              goto out;
