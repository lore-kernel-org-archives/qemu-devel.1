Received: from eggs.gnu.org ([2001:4830:134:3::10]:51757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdto3-0001DA-Dp
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdtnz-0003XR-Dg
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:15:15 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:55018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdtnz-0003Wi-3M
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:15:11 -0500
Message-Id: <58A4707602000062000D0393@prv-mh.provo.novell.com>
Date: Wed, 15 Feb 2017 00:15:02 -0700
From: "Lin Ma" <lma@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] virtio-fc: draft idea of virtual fibre channel
 HBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>, hare@suse.de

Hi all,
=20
We know that libvirt can create fibre channels vHBA on host
based on npiv, and present the LUNs to guest.
=20
I'd like to implement a virtual fibre channel HBA for qemu,
I havn't investigate it deeply yet. The idea presents a fc
vHBA in guest, interact with remote fc switch through npiv,
The LUNs will be recognized inside guest. I sent this email
here to see if you are in agreement with this approach and
hope to get some ideas/suggestions.
=20
The frontend is based on virtio, say virtio-fc-pci; the backend
is based on npiv of physical fc hba on host.
The implementation of this virtual fc hba doesn't support Fc-al,
only supports Fabric. It wrappers scsi data info fc frames, then
forwards them to backend, sounds like scsi over fc.
(maybe I can re-use some of virtio-scsi code/idea to deal with scsi data)
=20
The minimum invocation may look like:
qemu-system-x86_64 \
...... \
-object fibrechannel-backend,id=3Dfcdev0,host=3D0000:81:00.0 \
-device virtio-fc-pci,id=3Dvfc0,fc_backend=3Dfcdev0,wwpn=3D1000000000000001=
,wwnn=3D1100000000000001 \
......
=20
BTW, I have no idea how to make migration works:
How to deal with the BDF during migration?
How to deal with the Fabric ID during migration?
=20
It's a draft idea, There are lots of related code I need to
investigate, Currently this is all thoughts I have.
=20
Hello Paolo and Stefan, You are the authors of virtio-scsi,
and had some in-depth discuss about virtio-scsi in 2011
with Hannes, May I have your ideas/thoughts?
=20
Thanks,
Lin
