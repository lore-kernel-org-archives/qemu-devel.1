Received: from eggs.gnu.org ([209.51.188.92]:42105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gqYcW-0007RS-ET
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 02:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gqYcU-0005dT-Gi
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 02:24:44 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Mon, 4 Feb 2019 07:24:38 +0000
Message-ID: <AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
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
In-Reply-To: <20190204060636.GF29758@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0AM5PR0602MB3236_"
MIME-Version: 1.0
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

--_004_AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0AM5PR0602MB3236_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


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



--_004_AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0AM5PR0602MB3236_
Content-Type: image/png; name="libvirt-php-tmp-wuYYkI.png"
Content-Description: libvirt-php-tmp-wuYYkI.png
Content-Disposition: attachment; filename="libvirt-php-tmp-wuYYkI.png";
	size=4382; creation-date="Mon, 04 Feb 2019 07:24:37 GMT";
	modification-date="Mon, 04 Feb 2019 07:24:37 GMT"
Content-ID: <627038811133A64E82E419B6A0993251@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64

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
6pH1yQUlv9uGwZ5guvoP/Se3fPBkVspBn2C6+g/9J7d88GQO0sd32WIe34VDNYmTVEmIE7hXNokT
5DLoE6s8yFX/CT5JEhHIFnFCIH1811ml0/iukf+ExMn5sP6DJ3O6+vguDGgkzXjVf4IPKUKcNF6H
DXFeI/9JA3LVf6LxUZMe5EZxQnT18V1tSQZ9MvKfYMI1iJN7+E/gh+lEUBPfNfOfRJvjvEb+E7hI
pvFdg/+k9uKE/SezB5qTNzKwRm5Mslxzwsie+P4unPOGVvckH2y40/dPMODsC/QJ1RvB9UkDElif
nNM0/Ph4iSW4PmlBAvtPmpJ4kGD6hJ7gr/Cf8Pj4i/qR9ckFJb/bBrInCl+NR/RWEi2Oj0db+BPy
xH9PC19HEg7yY5egcTeMP9n+PcY5k+Q/KTyItGkBkHt8j/ECBONPMEOxOOJ7izl6ia7PL0wd9Td8
j/ECBOerM77HiO8t4ktPC/ML457c8j3GCxDoEyXxPUZ8b7EmkKvj4wFyy/cYL0C09iCV1PiOZNOq
h6D43PcYL0CgTwjEQXh2IJfzC4NS7N8a3kWPMAWI4R/MSVuST3+PcV4S0icQJj6W8mFxfPz27zHO
8Tj9b2ZgjdyY8LPmhJE9MTXsCc55C6JPWnsSdvxJa0+chD0J5j9p7UkTFRXKf9LaE0N1VzD/SWdP
gvpPOnsSU0lC6ZPOngwgAfRJZ088SCj/SWdPYh5/clHZsz65oIQ3MAPMADPADHyegeUPA38+7z6H
LwG54/VyVswAM8AMMAPMADPADDADzAAzwAwwA8wAM8AMMAPMADPADDADzAAzwAwwA8wAM8AMMAPM
ADPADDADzAAzwAwwA8wAM8AMMAPMADPADDADzAAzwAwwA8wAM8AMMAPMADPADDADzAAzwAwwA8wA
M8AMMAPMADPADDADzAAzwAwwA8wAM8AMMAPMwP8Bn2TI0IQM07MAAAAASUVORK5CYII=

--_004_AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0AM5PR0602MB3236_--
