Received: from eggs.gnu.org ([2001:4830:134:3::10]:55690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzilK-0003vT-8G
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzilF-0007In-BN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:26:54 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:52046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dzilF-0007GT-5q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:26:49 -0400
Received: from player756.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A528A9C720
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 14:26:46 +0200 (CEST)
Date: Wed, 4 Oct 2017 14:26:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171004142634.3fb6f4ed@bahia.lan>
In-Reply-To: <20171004113652.29620-1-ppandit@redhat.com>
References: <20171004113652.29620-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: use g_malloc0 to allocate space for
 xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>

On Wed,  4 Oct 2017 17:06:52 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> 9p back-end first queries the size of an extended attribute,
> allocates space for it via g_malloc() and then retrieves its
> value into allocated buffer. Race between querying attribute
> size and retrieving its could lead to memory bytes disclosure.
> Use g_malloc0() to avoid it.
> 

Applied to 9p-next.

Thanks.

> Reported-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/9pfs/9p.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 23ac7bb532..f8bbac251d 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3234,7 +3234,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
>          xattr_fidp->fid_type = P9_FID_XATTR;
>          xattr_fidp->fs.xattr.xattrwalk_fid = true;
>          if (size) {
> -            xattr_fidp->fs.xattr.value = g_malloc(size);
> +            xattr_fidp->fs.xattr.value = g_malloc0(size);
>              err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
>                                       xattr_fidp->fs.xattr.value,
>                                       xattr_fidp->fs.xattr.len);
> @@ -3267,7 +3267,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
>          xattr_fidp->fid_type = P9_FID_XATTR;
>          xattr_fidp->fs.xattr.xattrwalk_fid = true;
>          if (size) {
> -            xattr_fidp->fs.xattr.value = g_malloc(size);
> +            xattr_fidp->fs.xattr.value = g_malloc0(size);
>              err = v9fs_co_lgetxattr(pdu, &xattr_fidp->path,
>                                      &name, xattr_fidp->fs.xattr.value,
>                                      xattr_fidp->fs.xattr.len);
