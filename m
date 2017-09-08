Received: from eggs.gnu.org ([2001:4830:134:3::10]:34979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqHui-0008D5-GW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqHuf-0007q8-Uf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:36 -0400
Received: from mail-by2nam01on0056.outbound.protection.outlook.com
	([104.47.34.56]:20256
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dqHuf-0007pR-II
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:57:33 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
Date: Fri, 8 Sep 2017 06:57:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Relph, Richard" <Richard.Relph@amd.com>
Cc: brijesh.singh@amd.com

Hi All,

(sorry for the long message)

CPUs from AMD EPYC family supports Secure Encrypted Virtualization (SEV)
feature - the feature allows running encrypted VMs. To enable the feature,
I have been submitting patches to Linux kernel [1], Qemu [2] and OVMF [3].
We have been making some good progress in getting patches accepted upstream
in Linux and OVMF trees. SEV builds upon SME (Secure Memory Encryption)
feature -- SME support just got pulled into 4.14 merge window. The base
SEV patches are accepted in OVMF tree -- now we have SEV aware guest BIOS.
I am getting ready to take off "RFC" tag from remaining patches to get them
reviewed and accepted.

The boot flow for launching an SEV guest is a bit different from a typical
guest launch. In order to launch SEV guest from virt-manager or other
high-level VM management tools, we need to design and implement new
interface between libvirt and qemu, and probably add new APIs in libvirt
to be used by VM management tools. I am new to the libvirt and need some
expert advice while designing this interface. A pictorial representation
for a SEV guest launch flow is available in SEV Spec Appendix A [4].

A typical flow looks like this:

1. Guest owner (GO) asks the cloud provider to launch SEV guest.
2. VM tool asks libvirt to provide its Platform Diffie-Hellman (PDH) key.
3. libvirt opens /dev/sev device to get its PDH and return the blob to the
=C2=A0=C2=A0 caller.
4. VM tool gives its PDH to GO.
5. GO provides its DH key, session-info and guest policy.
6. VM tool somehow communicates the GO provided information to libvirt.
7. libvirt adds "sev-guest" object in its xml file with all the information
=C2=A0=C2=A0 obtained from #5

=C2=A0=C2=A0 (currently my xml file looks like this)

=C2=A0=C2=A0 <qemu:arg value=3D'-object'>
=C2=A0=C2=A0 <qemu:arg
value=3D'sev-guest,id=3Dsev0,policy=3D<GO_policy>,dh-key-file=3D<filename>,=
session-file=3D<filename>/>
=C2=A0=C2=A0 <qemu:arg value=3D'-machine'/>
=C2=A0=C2=A0 <qemu:arg value=3D'memory-encryption=3Dsev0'/>

8. libvirt launches the guest with "-S"
9. While creating the SEV guest qemu does the following
=C2=A0i) create encryption context using GO's DH, session-info and guest po=
licy
=C2=A0=C2=A0=C2=A0 (LAUNCH_START)
=C2=A0ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
=C2=A0iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measurement
10. By some interface we must propagate the measurement all the way to GO
=C2=A0 before libvirt starts the guest.
11. GO verifies the measurement and if measurement matches then it may
=C2=A0give a secret blob -- which must be injected into the guest before
=C2=A0libvirt starts the VM. If verification failed, GO will request cloud
=C2=A0provider to destroy the VM.
12. After secret blob is injected into guest, we call LAUNCH_FINISH
=C2=A0 to destory the encryption context.
13. libvirt issues "continue" command to resume the guest boot.

Please note that the measurement value is protected with transport
encryption key (TIK) and it changes on each run. Similarly the secret blob
provided by GO does not need to be protected using libvirt/qemu APIs. The
secret is protected by TIK. From qemu and libvirt point of view these are
blobs and must be passed as-is to the SEV FW.

Questions:
a) Do we need to add a new set of APIs in libvirt to return the PDH from
libvirt and VM tool ? Or can we use some pre-existing APIs to pass the
opaque blobs ? (this is mainly for step 3 and 6)
b) do we need to define a new xml tag to for memory-encryption ? or just
use the qemu:args tag ? (step 6)
c) what existing communicate interface can be used between libvirt and qemu
to get the measurement ? can we add a new qemu monitor command
'get_sev_measurement' to get the measurement ? (step 10)
d) how to pass the secret blob from libvirt to qemu ? should we consider
adding a new object (sev-guest-secret) -- libvirt can add the object throug=
h
qemu monitor.


[1] https://marc.info/?l=3Dkvm&m=3D150092661105069&w=3D2
[2] https://marc.info/?l=3Dqemu-devel&m=3D148901186615642&w=3D2
[3] https://lists.01.org/pipermail/edk2-devel/2017-July/012220.html
[4] http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf

Thanks

Brijesh
