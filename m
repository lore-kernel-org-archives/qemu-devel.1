Received: from eggs.gnu.org ([209.51.188.92]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1h0rT9-0003rb-N3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1h0rT8-0003Ct-Bn
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:33:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1h0rT7-0003BW-U0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:33:38 -0500
Date: Mon, 04 Mar 2019 09:33:26 -0800
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
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
To: stefanha@redhat.com, qemu-devel@nongnu.org

Hi Stefan and all,

=20

I spent some time on getting familiar with QEMU and relevant concepts. My p=
roject is using QEMU 2.9 with virtio-scsi backend, and I am exploring proper=
 way to improve the IOPS of my project.

=20

Thanks @Stefan for the response and advices!

=20

Could you please help review and clarify following questions:
While @Stefan mentioned about additional iothread object support of virtio-=
blk, Is the feature also supported by virtio-scsi? I am trying to exploring =
the perf multiple IO threads / per VM via followings:
QMP setup example to create 2 io threads in QEMU, one io thread per device:

(QEMU) object-add qom-type=3Diothread id=3Diothread0

(QEMU) object-add qom-type=3Diothread id=3Diothread1

=20

(QEMU) device_add driver=3Dvirtio-scsi-pci id=3Dtest0 iothread=3Diothread0

(QEMU) device_add driver=3Dvirtio-scsi-pci id=3Dtest1 iothread=3Diothread1

=20

(QEMU) device_add driver=3Dscsi-block drive=3Dnone0 id=3Dv0 bus=3Dtest0.0

(QEMU) device_add driver=3Dscsi-block drive=3Dnone1 id=3Dv1 bus=3Dtest1.0
You mentioned about the multi-queue devices feature, it seems like the mult=
i-queue feature will help improve the IOPS of =C2=A0single Device. Could you ple=
ase provide more details?
What=E2=80=99s the current plan of support multi-queue device? Which release will=
 include the support or it has already been included in any existing release=
 newer than 2.9?
Is there any feature branch which I would get more details about the code a=
nd in progress status?
In addition, Someone posted related to multi-queue https://marc.info/?l=3Dlin=
ux-virtualization&m=3D135583400026151&w=3D2, but it only measure the bandwidth, =
do we have any perf result about IOPS improvement of Multi-Queue approach?
=20

Thanks again,

Wei

=20

=20

On 2/18/19, 2:24 AM, "Stefan Hajnoczi" <stefanha@redhat.com> wrote:

=20

=C2=A0=C2=A0=C2=A0 On Thu, Feb 14, 2019 at 08:21:30AM -0800, Wei Li wrote:

=C2=A0=C2=A0=C2=A0 > I learnt that QEMU iothread architecture has one QEMU thread per v=
CPU and a dedicated event loop thread which is iothread, and I want to bette=
r understand whether there is any specific reason to have a single iothead i=
nstead of multiple iothreads?

=C2=A0=C2=A0=C2=A0 > Given that single iothread becomes a performance bottleneck in my =
project, if there any proper way to support multiple iothreads? E.g. have on=
e iothread per volume attachment instead of single iothread per host?=C2=A0 But =
I am not quite sure whether it is feasible or not. Please let me know if you=
 have any advices.

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0Hi,

=C2=A0=C2=A0=C2=A0 Please send general questions to qemu-devel@nongnu.org and CC me in =
the

=C2=A0=C2=A0=C2=A0 future.=C2=A0 That way others can participate in the discussion and it w=
ill

=C2=A0=C2=A0=C2=A0 be archived so someone searching for the same question will find the

=C2=A0=C2=A0=C2=A0 answer in the future.

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0QEMU supports additional IOThread objects:

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-object iothread,id=3Diothread0

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device virtio-blk-pci,iothread=3Diothread0,drive=3Ddrive0

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0This virtio-blk device will perform device emulation and I/O in

=C2=A0=C2=A0=C2=A0 iothread0 instead of the main loop thread.

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0Currently only 1:1 device<->IOThread association is possible.=C2=A0 In =
the

=C2=A0=C2=A0=C2=A0 future 1:N should be possible and will allow multi-queue devices to

=C2=A0=C2=A0=C2=A0 achieve better performance.

=C2=A0=C2=A0=C2=A0=20

=C2=A0=C2=A0=C2=A0=C2=A0Stefan

=20
