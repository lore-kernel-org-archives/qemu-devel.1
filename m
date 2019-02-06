Received: from eggs.gnu.org ([209.51.188.92]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1grHRH-0006yy-Io
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1grHRB-00044E-Ht
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:16:07 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Wed, 6 Feb 2019 07:15:58 +0000
Message-ID: <VI1PR0602MB3245032D51A5DF45AF6E1952A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
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
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
In-Reply-To: <AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo
	ok.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

I can now confirm that the same happens with virtio-blk and virtio-scsi.
Please find below the qemu log enhanced with the new information added by t=
he patch provided by Stefan:

vdev 0x55d22b8e10f0 ("virtio-blk")
vq 0x55d22b8ebe40 (idx 0)
inuse 128 vring.num 128
2019-02-06T00:40:41.742552Z qemu-system-x86_64: Virtqueue size exceeded

I just changed the disk back to virtio-scsi so I can repro this again with =
the patched qemu and report back.

Thanks.

On lun, feb 4, 2019 at 8:24 AM, Fernando Casas Sch=F6ssow <casasfernando@ou=
tlook.com> wrote:

I can test again with qemu 3.1 but with previous versions yes, it was happe=
ning the same with both virtio-blk and virtio-scsi.
For 3.1 I can confirm it happens for virtio-scsi (already tested it) and I =
can test with virtio-blk again if that will add value to the investigation.
Also I'm attaching a guest console screenshot showing the errors displayed =
by the guest when it goes unresponsive in case it can help.

Thanks for the patch. I will build the custom qemu binary and reproduce the=
 issue. This may take a couple of days since I cannot reproduce it at will.=
 Sometimes it takes 12 hours sometimes 2 days until it happens.
Hopefully the code below will add more light on to this problem.

Thanks,

Fernando

On lun, feb 4, 2019 at 7:06 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
Are you sure this happens with both virtio-blk and virtio-scsi? The followi=
ng patch adds more debug output. You can build as follows: $ git clone http=
s://git.qemu.org/git/qemu.git $ cd qemu $ patch apply -p1 ...paste the patc=
h here... ^D # For info on build dependencies see https://wiki.qemu.org/Hos=
ts/Linux $ ./configure --target-list=3Dx86_64-softmmu $ make -j4 You can co=
nfigure a libvirt domain to use your custom QEMU binary by changing the <de=
vices><emulator> tag to the qemu/x86_64-softmmu/qemu-system-x86_64 path. --=
- diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c index 22bd1ac34e..aa=
44bffa1f 100644 --- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -879,6=
 +879,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D vq->vring.=
num; if (vq->inuse >=3D vq->vring.num) { + fprintf(stderr, "vdev %p (\"%s\"=
)\n", vdev, vdev->name); + fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigne=
d int)(vq - vdev->vq)); + fprintf(stderr, "inuse %u vring.num %u\n", vq->in=
use, vq->vring.num); virtio_error(vdev, "Virtqueue size exceeded"); goto do=
ne; }
