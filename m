Received: from eggs.gnu.org ([209.51.188.92]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gzBjF-00047J-CG
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gzBjE-0006tP-3x
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:47:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gzBjD-0006nu-KQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:47:19 -0500
References: <MN2PR02MB580680857B3390A2447B512DB67B0@MN2PR02MB5806.namprd02.prod.outlook.com>
	<20190227152347.GF22539@stefanha-x1.localdomain>
	<MN2PR02MB580695B27405FA206A38110FB6740@MN2PR02MB5806.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da9ffd31-370d-6f6f-5fd9-bba08de1f66e@redhat.com>
Date: Thu, 28 Feb 2019 10:47:03 +0800
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB580695B27405FA206A38110FB6740@MN2PR02MB5806.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtio-net control queue handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikhil Agarwal <nagarwal@xilinx.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


On 2019/2/28 =E4=B8=8A=E5=8D=881:39, Nikhil Agarwal wrote:
> Hi Stefan,
>
> Thanks for directing question to correct people, yes your understanding=
 is correct.
>
> I want virtio-net control virtqueue to be handled by vhost-user-net dev=
ice based backend for vdpa use case where control message would do some c=
onfiguration on actual hw device. Or these changes should to be done in l=
ibvirt where QMP event are being handled as of now?
>
> Regards
> Nikhil


Cc Michael. Several methods for dealing with control virtqueue:

1) using backend specific method. For example, multiqueue control for=20
TAP was done in this way, and we plan to support RSS in this way as well=20
(through steering eBPF program). But this may not work for the=20
privilleged operations.
2) inventing new vhost(user) protocol, convert the vq command to=20
vhost(user) command and pass it to vhost(user) backend.
3) extend vhost protocol to deal with control vq like you propose here.
4) notify libvirt using QMP event, we've already supported this if rx=20
filter is changed for virtio-net, and let management to deal with the=20
changes.
5) implementing or linking vhost backend qemu, then there's no need to=20
invent no IPCs

For the case of vDPA, I'm not sure the use case for vDPA through=20
vhost-user. Can you describe more about that? To me the best way is=20
probably done through mdev and VFIO not userspace path.

Thanks


>
>
> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@gmail.com>
> Sent: Wednesday, February 27, 2019 8:54 PM
> To: Nikhil Agarwal <nagarwal@xilinx.com>
> Cc: qemu-devel@nongnu.org; jasowang@redhat.com; libvir-list@redhat.com
> Subject: Re: [Qemu-devel] Virtio-net control queue handling
>
> On Tue, Feb 26, 2019 at 02:13:43PM +0000, Nikhil Agarwal wrote:
>> Is there any option in QEMU to offload virtio device control queue han=
dling to backend instead of deciphering and passing to libvirt via QMP? i=
f not, is there any interface in libvirt which passes on these message to=
 application or i directly use QMP interface from QEMU?
> I'm not sure I understand your question.  It could be because of
> terminology:
>
> "virtio device control queue" =3D=3D virtio-net control virtqueue?
>
> "backend" =3D=3D vhost-user-net device backend?
>
> "message" =3D=3D QMP event?
>
> I have CCed Jason Wang, QEMU network subsystem maintainer, and the libv=
irt mailing list.
>
> Stefan
>
