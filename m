Received: from eggs.gnu.org ([209.51.188.92]:38467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hELy2-0001x7-T5
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hELy1-0007dm-Lj
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hELy1-0007cO-8Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:17 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190409142925.GG16944@stefanha-x1.localdomain>
Date: Thu, 11 Apr 2019 01:45:06 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<20190409142925.GG16944@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Nir Weiner <nir.weiner@oracle.com>, qemu-devel@nongnu.org, bijan.mottahedeh@oracle.com



> On 9 Apr 2019, at 17:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
>> Originally migration was not possible with vhost-scsi because
>> as part of migration, the source host target SCSI device state
>> needs to be saved and loaded into the destination host target SCSI
>> device. This cannot be done by QEMU.
>>=20
>> As this can be handled either by external orchestrator or by having
>> shared-storage (i.e. iSCSI), there is no reason to limit the
>> orchestrator from being able to explictly specify it wish to enable
>> migration even when VM have a vhost-scsi device.
>>=20
>> Liran Alon (1):
>>  vhost-scsi: Allow user to enable migration
>>=20
>> Nir Weiner (2):
>>  vhost-scsi: The vhost device should be stopped when the VM is not
>>    running
>>  vhost-scsi: Add vmstate descriptor
>>=20
>> hw/scsi/vhost-scsi.c                  | 57 =
++++++++++++++++++++++-----
>> include/hw/virtio/vhost-scsi-common.h |  1 +
>> 2 files changed, 48 insertions(+), 10 deletions(-)
>=20
> What happens when migration is attempted while there is in-flight I/O =
in
> the vring?
>=20
> Stefan

What do you define as =E2=80=9Cin-flight I/O=E2=80=9D? I think there is =
a need to separate the discussion here to multiple cases:

1) The I/O request was written to vring but guest have not yet written =
to doorbell:
This is the simplest case. No state is lost as the vring is migrated =
from source host to dest host as part of guest memory migration.
Also, the vring properties (E.g. Guest base address) is transferred from =
source host to dest host as part of vhost-scsi VMState.
(See patch 2/3 of series which adds VMSTATE_VIRTIO_DEVICE to vhost-scsi =
VMState which will cause virtio_save() to save vring on migration =
stream).

2) The I/O request was written to vring and the guest have written to =
doorbell:
The I/O request was submitted and processed by the vhost-scsi backend. =
Therefore, the I/O request was sent to the remote TGT server.
If the the TGT server has performed the write and returned ACK but the =
ACK was not received by guest, then guest is expected to initiate the =
write again.
(Similar to what happens for a momentary TGT server downtime / network =
downtime). So this isn=E2=80=99t suppose to be an issue.

An interesting case is what happens if there is an in-flight I/O write =
request (Request A) performed by source host that was sent already over =
the network to the TGT server.
But until it reaches the TGT server, the VM running on dest performs =
another I/O write request (Request B) to the same sector which results =
in Request B being handled by TGT server before Request A. In this case, =
it is possible that TGT server will actually overwrite data written by =
Request B with older request Request A that arrived to TGT later.
(This will be the result in case of using an iSCSI TGT).
But, there are various techniques that TGT server can implement to avoid =
this. For example, fencing-out requests from any older iSCSI connection =
than the most recent one.

In general, vhost-scsi migration shouldn=E2=80=99t be different than =
vhost-net or vhost-vsock migration.
The only thing that may be problematic in case of vhost-scsi is because =
the source host target SCSI device state may need to be saved and =
restored on dest host target SCSI device.
However, when using a shared-storage via iSCSI, this concern is =
irrelevant. Therefore, this patch series attempts to allow the admin to =
remove the migration-blocker limitation from vhost-scsi if it is using =
such a setup. As described in cover-letter.

-Liran
