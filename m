Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1ceGIa-0001Ko-7m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 02:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1ceGIX-0004Fe-0B
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 02:16:16 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:44182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1ceGIW-0004EU-M1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 02:16:12 -0500
Message-Id: <58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
Date: Thu, 16 Feb 2017 00:16:02 -0700
From: "Lin Ma" <lma@suse.com>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
In-Reply-To: <20170215153306.GF16064@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSN77yaIFJlOiAgW1JGQ10gdmlydGlvLWZj?=
 =?utf-8?q?=3A_draft_idea_of_virtual_fibre_channel_HBA?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>, hare@suse.de



>>> Stefan Hajnoczi <stefanha@gmail.com> 2/15/2017 11:33 =E4=B8=8B=E5=8D=88=
 >>>
>On Wed, Feb 15, 2017 at 12:15:02AM -0700, Lin Ma wrote:
>> Hi all,
>> =20
>> We know that libvirt can create fibre channels vHBA on host
>> based on npiv, and present the LUNs to guest.
>> =20
>> I'd like to implement a virtual fibre channel HBA for qemu,
>> I havn't investigate it deeply yet. The idea presents a fc
>> vHBA in guest, interact with remote fc switch through npiv,
>> The LUNs will be recognized inside guest. I sent this email
>> here to see if you are in agreement with this approach and
>> hope to get some ideas/suggestions.
>> =20
>> The frontend is based on virtio, say virtio-fc-pci; the backend
>> is based on npiv of physical fc hba on host.
>> The implementation of this virtual fc hba doesn't support Fc-al,
>> only supports Fabric. It wrappers scsi data info fc frames, then
>> forwards them to backend, sounds like scsi over fc.
>> (maybe I can re-use some of virtio-scsi code/idea to deal with scsi =
data)
>> =20
>> The minimum invocation may look like:
>> qemu-system-x86_64 \
>> ...... \
>> -object fibrechannel-backend,id=3Dfcdev0,host=3D0000:81:00.0 \
>> -device virtio-fc-pci,id=3Dvfc0,fc_backend=3Dfcdev0,wwpn=3D1000000000000=
001,wwnn=3D1100000000000001 \
>> ......
>> =20
>> BTW, I have no idea how to make migration works:
>> How to deal with the BDF during migration?
>> How to deal with the Fabric ID during migration?
>> =20
>> It's a draft idea, There are lots of related code I need to
>> investigate, Currently this is all thoughts I have.
>> =20
>> Hello Paolo and Stefan, You are the authors of virtio-scsi,
>> and had some in-depth discuss about virtio-scsi in 2011
>> with Hannes, May I have your ideas/thoughts?
>
>I'm not sure it's necessary for the guest to have FC access.  Fam Zheng
>and Paolo are working on virtio-scsi FC NPIV enhancements.  It should
>make NPIV work better without adding a whole new FC device.
>
>https://lkml.org/lkml/2017/1/16/439
>
>The plan is:
>
>1. libvirt listens to udev events on the host so it can add/remove
>   QEMU SCSI LUNs.
>
>2. virtio-scsi is extended to include a WWPN that the guest can see.
>
>The guest doesn't do any FC fabric level stuff, it just does virtio-scsi
>as usual.
>
>It supports live migration by swapping between a pair of WWPNs across
>migration.
OK, Thanks for the information. This way still makes qemu as a SCSI
TARGET, I'm not sure which way makes more sense, But it does solve
the live migration case.

>What are the benefits of having FC access from the guest?
Actually, I havn't dug it too much, Just thought that from virtualization's=

perspective, when interact with FC storage, having complete FC access
from the guest is the way it should use.
Lin
