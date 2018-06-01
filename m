Received: from eggs.gnu.org ([2001:4830:134:3::10]:54227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgDh-00026g-OM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgDd-0002dc-PE
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:19:37 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:48337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOgDd-0002bK-IS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:19:33 -0400
Received: from player734.ha.ovh.net (unknown [10.109.122.84])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C60B117CC90
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 11:19:31 +0200 (CEST)
Date: Fri, 1 Jun 2018 11:19:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601111929.18d58909@bahia.lan>
In-Reply-To: <d837331570879a9fe9e4f1e466905213099f7bf0.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<d837331570879a9fe9e4f1e466905213099f7bf0.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/20] 9p: xattr: Fix crash due to free
 of uninitialized value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Thu, 31 May 2018 21:25:58 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> If the size returned from llistxattr is 0, we skipped the malloc
> call, leaving xattr.value uninitialized. However, this value is
> later passed to `g_free` without any further checks, causing an

Ouch, good catch.

> error. Fix that by always calling g_malloc unconditionally. If
> `size` is 0, it will return a pointer that is safe to pass to g_free,
> likely NULL.
> 

"Allocates n_bytes bytes of memory, initialized to 0's. If n_bytes is 0 it
 returns NULL."

https://developer.gnome.org/glib/unstable/glib-Memory-Allocation.html#g-malloc

The fix is good, but it seems the same can also happen if v9fs_co_lgetxattr()
returns 0 a few lines below. Can you check this out and fix it if needed ?

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> 
> Changes since v1: New patch
> 
>  hw/9pfs/9p.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index d74302d..b80db65 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3256,8 +3256,8 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
>          xattr_fidp->fs.xattr.len = size;
>          xattr_fidp->fid_type = P9_FID_XATTR;
>          xattr_fidp->fs.xattr.xattrwalk_fid = true;
> +        xattr_fidp->fs.xattr.value = g_malloc0(size);
>          if (size) {
> -            xattr_fidp->fs.xattr.value = g_malloc0(size);
>              err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
>                                       xattr_fidp->fs.xattr.value,
>                                       xattr_fidp->fs.xattr.len);
