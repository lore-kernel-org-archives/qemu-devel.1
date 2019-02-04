Received: from eggs.gnu.org ([209.51.188.92]:50719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gqXPF-0001iE-40
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gqXPD-0004g8-5Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:06:57 -0500
Date: Mon, 4 Feb 2019 14:06:36 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190204060636.GF29758@stefanha-x1.localdomain>
References: <CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@outlook.com>
Cc: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Are you sure this happens with both virtio-blk and virtio-scsi?

The following patch adds more debug output.  You can build as follows:

  $ git clone https://git.qemu.org/git/qemu.git
  $ cd qemu
  $ patch apply -p1
  ...paste the patch here...
  ^D

  # For info on build dependencies see https://wiki.qemu.org/Hosts/Linux
  $ ./configure --target-list=x86_64-softmmu
  $ make -j4

You can configure a libvirt domain to use your custom QEMU binary by
changing the <devices><emulator> tag to the
qemu/x86_64-softmmu/qemu-system-x86_64 path.

---

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22bd1ac34e..aa44bffa1f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -879,6 +879,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max = vq->vring.num;

     if (vq->inuse >= vq->vring.num) {
+        fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name);
+        fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->vq));
+        fprintf(stderr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.num);
         virtio_error(vdev, "Virtqueue size exceeded");
         goto done;
     }


--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV9ZsAAoJEJykq7OBq3PI6pMH/1OpJWO+1usV/N+1XBE1+VUi
5cR9aD+Va9QrnUkUdrXnRKyrUjlYtnJscWrG5guozuaRSENO0zqC/Apjy0jfSXQf
HWXdTSue8lFAUqWdKqRfdV6sKvEe5Q0+V7Vdg6l3l4qE6OfuY0U7pOty7Rdqg9oE
aMXe7s8cGsHLq8UzegsxxTVbnu/olJ61+28xIrOB3DYnFJrzA00C0bLDoZnErVBN
12E2l+jY8v6cb1AMqdx0nfraW4PwQbCOi9pwZQnBWOrUAVyptNZPt9JsEVg2R1eL
F4DoTTZ0d0bbZRjd2ciWbMXUM12Wf9NM7Caj1kS6BfzyOGY1rL2NNrkS3G2OZxs=
=EGkE
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
