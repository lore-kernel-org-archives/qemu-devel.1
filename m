Received: from eggs.gnu.org ([209.51.188.92]:47362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1q6N-0004yZ-HB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1q6I-00049P-0W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1q6H-00049B-NF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:18:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id g12so16733297wrm.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:18:05 -0800 (PST)
Date: Thu, 7 Mar 2019 10:18:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307101802.GB2843@stefanha-x1.localdomain>
References: <20190306170025.3830-1-rusakova.nastasia@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20190306170025.3830-1-rusakova.nastasia@icloud.com>
Subject: Re: [Qemu-devel] [PATCH] hw/block/virtio-blk: Clean req->dev
 repetitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anastasiia Rusakova <arusakova917@gmail.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, stefanha@redhat.com


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 07:00:25PM +0200, Anastasiia Rusakova wrote:
> @@ -260,9 +260,10 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
>  {
>      int status = VIRTIO_BLK_S_OK;
>      struct virtio_scsi_inhdr *scsi = NULL;
> -    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
> +    VirtIOBlock *s = req->dev;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>      VirtQueueElement *elem = &req->elem;
> -    VirtIOBlock *blk = req->dev;
> +    VirtIOBlock *blk = s;

Hi Anastasiia,
Thanks for the patch!

This function calls it 'blk' instead of 's'.  's' can be eliminated by
reordering the variable definitions:

  VirtIOBlock *blk = req->dev;
  VirtIODevice *vdev = VIRTIO_DEVICE(blk);

The rest looks good to me.

Stefan

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgO/aAAoJEJykq7OBq3PIRRwIAKW3AeqBquTHgkhp/JVHNQ19
Pbgf1bPKV93k9k9rgiVNjbkZKBuI0xOjmYq0HBVkpebNmIP2ZhssLxMujFgwCcZo
cSnN+sYmf7C+OYMCofiX6XbVm4TaKb2s9ZQnLgJ1ottiUCqwgTl5sDn8GY7t48hd
AW8ynamqq1kiEKd7AXyBuhsPm1G9kKLXP39qUctf9l8KiPFHRBONvtE4O59rLfbq
J8/DBmm4GDwQ9Zv6XYd2SjGf1iOtlt4hGn8UBgGMPSl3Byq7IOZAYipfhXHdT1g1
owO/jHgwrBQEx6AWQ45ThHmwluNEwOKSL8BF6TpsHO8SRYEwlzzAz7I4Dogj4VY=
=3qE4
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
