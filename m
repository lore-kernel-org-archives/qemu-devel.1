Received: from eggs.gnu.org ([209.51.188.92]:52846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1hGAtI-0003gc-C7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1hGAtG-0002aU-R2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1hGAtG-0002YW-DW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:54 -0400
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
Date: Tue, 16 Apr 2019 07:23:38 +0800
MIME-Version: 1.0
In-Reply-To: <60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Li <wei.d.li@oracle.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org



On 4/16/19 1:34 AM, Wei Li wrote:
> Hi @Paolo Bonzini & @Stefan Hajnoczi,
>=20
> Would you please help confirm whether @Paolo Bonzini's multiqueue featu=
re change will benefit virtio-scsi or not? Thanks!
>=20
> @Stefan Hajnoczi,
> I also spent some time on exploring the virtio-scsi multi-queue feature=
s via num_queues parameter as below, here are what we found:
>=20
> 1. Increase number of Queues from one to the same number as CPU will ge=
t better IOPS increase.
> 2. Increase number of Queues to the number (e.g. 8) larger than the num=
ber of vCPU (e.g. 2) can get even better IOPS increase.

As mentioned in below link, when the number of hw queues is larger than
nr_cpu_ids, the blk-mq layer would limit and only use at most nr_cpu_ids =
queues
(e.g., /sys/block/sda/mq/).

That is, when the num_queus=3D4 while vcpus is 2, there should be only 2 =
queues
available /sys/block/sda/mq/

https://lore.kernel.org/lkml/1553682995-5682-1-git-send-email-dongli.zhan=
g@oracle.com/

I am just curious how increasing the num_queues from 2 to 4 would double =
the
iops, while there are only 2 vcpus available...

Dongli Zhang

>=20
> In addition, It seems Qemu can get better IOPS while the attachment use=
s more queues than the number of vCPU, how could it possible? Could you p=
lease help us better understand the behavior? Thanks a lot!
>=20
>=20
> Host CPU Configuration:
> CPU(s):                2
> Thread(s) per core:    2
> Core(s) per socket:    1
> Socket(s):             1
>=20
> Commands for multi queue Setup:
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D1 id=3Dtest1
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D2 id=3Dtest2
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D4 id=3Dtest4
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D8 id=3Dtest8
>=20
>=20
> Result:
> 	|  8 Queues   |  4 Queues     |      2 Queues    |      Single Queue
> IOPS 	|   +29%         |      27%           |        11%           |   =
   Baseline
>=20
> Thanks,
> Wei
>=20
> =EF=BB=BFOn 4/5/19, 2:09 PM, "Wei Li" <wei.d.li@oracle.com> wrote:
>=20
>     Thanks Stefan for your quick response!
>    =20
>     Hi Paolo,
>     Could you please send us a link related to the multiqueue feature w=
hich you are working on so that we could start getting some details about=
 the feature.
>    =20
>     Thanks again,
>     Wei=20
>    =20
>     =EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com>=
 wrote:
>    =20
>         On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
>         > Thanks Stefan for your reply and guidance!
>         >=20
>         > We spent some time on exploring the multiple I/O Threads appr=
oach per your feedback. Based on the perf measurement data, we did see so=
me IOPS improvement for multiple volumes, which is great. :)
>         >=20
>         > In addition, IOPS for single Volume will still be a bottlenec=
k, it seems like multiqueue block layer feature which Paolo is working on=
 may be able to help improving the IOPS for single volume.
>         >=20
>         > @Paolo, @Stefan,=20
>         > Would you mind sharing the multiqueue feature code branch wit=
h us? So that we could get some rough idea about this feature and maybe s=
tart doing some exploration?=20
>        =20
>         Paolo last worked on this code, so he may be able to send you a=
 link.
>        =20
>         Stefan
>        =20
>    =20
>=20
>=20
>=20
