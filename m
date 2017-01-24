Received: from eggs.gnu.org ([2001:4830:134:3::10]:57347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWArz-0002Dn-VR
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWArw-0001ip-VI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:51:24 -0500
Received: from mail.kernel.org ([198.145.29.136]:45204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cWArw-0001iZ-Ov
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:51:20 -0500
Date: Tue, 24 Jan 2017 15:51:15 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <148530022936.13158.7140713668400986309.stgit@bahia>
Message-ID: <alpine.DEB.2.10.1701241550370.10192@sstabellini-ThinkPad-X260>
References: <148530022936.13158.7140713668400986309.stgit@bahia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix offset error in
 v9fs_xattr_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Wed, 25 Jan 2017, Greg Kurz wrote:
> The current code tries to copy `read_count' bytes starting at offset
> `offset' from a `read_count`-sized iovec. This causes v9fs_pack() to
> fail with ENOBUFS.
> 
> Since the PDU iovec is already partially filled with `offset' bytes,
> let's skip them when creating `qiov_full' and have v9fs_pack() to
> copy the whole of it. Moreover, this is consistent with the other
> places where v9fs_init_qiov_from_pdu() is called.
> 
> This fixes commit "bcb8998fac16 9pfs: call v9fs_init_qiov_from_pdu
> before v9fs_pack".
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> v2: - pass size + skip to the init_in_iov_from_pdu callback
> ---
>  hw/9pfs/9p.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index fa58877570f6..f22d39064f6b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1655,7 +1655,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
>      if (is_write) {
>          pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
>      } else {
> -        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size);
> +        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
>      }
>  
>      qemu_iovec_init_external(&elem, iov, niov);
> @@ -1685,8 +1685,8 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
>      }
>      offset += err;
>  
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, 0, read_count, false);
> -    err = v9fs_pack(qiov_full.iov, qiov_full.niov, offset,
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
> +    err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
>                      ((char *)fidp->fs.xattr.value) + off,
>                      read_count);
>      qemu_iovec_destroy(&qiov_full);
> 
