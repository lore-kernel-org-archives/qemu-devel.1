Received: from eggs.gnu.org ([2001:4830:134:3::10]:33504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1egKak-0002qb-4X
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1egKag-00029P-TL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:20:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:46567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1egKag-000270-KY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:20:02 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 30 Jan 2018 01:19:54 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5FFAB4@SHSMSX103.ccr.corp.intel.com>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<20180129152912.GL20446@stefanha-x1.localdomain>
In-Reply-To: <20180129152912.GL20446@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Harris, James R" <james.r.harris@intel.com>, "Busch, Keith" <keith.busch@intel.com>, "famz@redhat.com" <famz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, January 29, 2018 11:29 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; Harris, James R <james.r.harris@intel.com>; Bu=
sch,
> Keith <keith.busch@intel.com>; famz@redhat.com; pbonzini@redhat.com;
> mst@redhat.com
> Subject: Re: [RFC v1] block/NVMe: introduce a new vhost NVMe host device =
to
> QEMU
>=20
> On Mon, Jan 15, 2018 at 04:01:55PM +0800, Changpeng Liu wrote:
> > NVMe 1.3 specification introduces a new NVMe ADMIN command:
> > doorbell buffer config, which can write shadow doorbell buffer
> > instead of MMIO registers, so it can improve the Guest performance
> > a lot for emulated NVMe devices inside VM.
>=20
> If I understand correctly the Shadow Doorbell Buffer offers two
> optimizations:
>=20
> 1. The guest driver only writes to the MMIO register when EventIdx has
>    been reached.  This eliminates some MMIO writes.
Correct.
>=20
> 2. The device may poll the Shadow Doorbell Buffer so that command
>    processing can begin before guest driver performs an MMIO write.
>=20
> Is this correct?
Guest should write shadow doorbell memory every time(each new request from =
Guest),
Guest may write PCI registers or not, depends on slave target's feedback.
Slave target can poll the shadow doorbell for new requests.
This can eliminate the MMIO writes for submission data path.
>=20
> > Similar with existing vhost-user-scsi solution, this commit builds a
> > new vhost_user_nvme host device to VM and the I/O is processed at
> > the slave I/O target, so users can implement a user space NVMe driver
> > in the slave I/O target.
> >
> > Users can start QEMU with: -chardev socket,id=3Dchar0,path=3D/path/vhos=
t.0 \
> > -device vhost-user-nvme,chardev=3Dchar0,num_io_queues=3D2.
>=20
> Each new feature has a cost in terms of maintainance, testing,
> documentation, and support.  Users need to be educated about the role of
> each available storage controller and how to choose between them.
>=20
> I'm not sure why QEMU should go in this direction since it makes the
> landscape more complex and harder to support.  You've said the
> performance is comparable to vhost-user-blk.  So what does NVMe offer
> that makes this worthwhile?
Good question, from the test results, this solution is almost same with
vhost-blk, this is still an ongoing work, I don't have a *MUST*
justification now.
>=20
> A cool NVMe feature would be the ability to pass through invididual
> queues to different guests without SR-IOV.  In other words, bind a queue
> to namespace subset so that multiple guests can be isolated from each
> other.  That way the data path would not require vmexits.  The control
> path and device initialization would still be emulated by QEMU so the
> hardware does not need to provide the full resources and state needed
> for SR-IOV.  I looked into this but came to the conclusion that it would
> require changes to the NVMe specification because the namespace is a
> per-command field.
