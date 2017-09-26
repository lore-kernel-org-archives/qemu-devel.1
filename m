Received: from eggs.gnu.org ([2001:4830:134:3::10]:37956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwqyL-0005ec-JF
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwqyI-0005IK-UK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dwqyI-0005HU-LB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:36:26 -0400
Date: Tue, 26 Sep 2017 17:36:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170926170901-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Relph, Richard" <Richard.Relph@amd.com>

On Fri, Sep 08, 2017 at 06:57:30AM -0500, Brijesh Singh wrote:
> Hi All,

Sorry if below comment doesn't make sense, I might be misunderstanding
something basic about SEV. Also sorry about the delay, I've been on
vacation.


> (sorry for the long message)
>=20
> CPUs from AMD EPYC family supports Secure Encrypted Virtualization (SEV=
)
> feature - the feature allows running encrypted VMs. To enable the featu=
re,
> I have been submitting patches to Linux kernel [1], Qemu [2] and OVMF [=
3].
> We have been making some good progress in getting patches accepted upst=
ream
> in Linux and OVMF trees. SEV builds upon SME (Secure Memory Encryption)
> feature -- SME support just got pulled into 4.14 merge window. The base
> SEV patches are accepted in OVMF tree -- now we have SEV aware guest BI=
OS.
> I am getting ready to take off "RFC" tag from remaining patches to get =
them
> reviewed and accepted.
>=20
> The boot flow for launching an SEV guest is a bit different from a typi=
cal
> guest launch. In order to launch SEV guest from virt-manager or other
> high-level VM management tools, we need to design and implement new
> interface between libvirt and qemu, and probably add new APIs in libvir=
t
> to be used by VM management tools. I am new to the libvirt and need som=
e
> expert advice while designing this interface. A pictorial representatio=
n
> for a SEV guest launch flow is available in SEV Spec Appendix A [4].
>=20
> A typical flow looks like this:
>=20
> 1. Guest owner (GO) asks the cloud provider to launch SEV guest.
> 2. VM tool asks libvirt to provide its Platform Diffie-Hellman (PDH) ke=
y.
> 3. libvirt opens /dev/sev device to get its PDH and return the blob to =
the
> =A0=A0 caller.
> 4. VM tool gives its PDH to GO.
> 5. GO provides its DH key, session-info and guest policy.
> 6. VM tool somehow communicates the GO provided information to libvirt.
> 7. libvirt adds "sev-guest" object in its xml file with all the informa=
tion
> =A0=A0 obtained from #5
>=20
> =A0=A0 (currently my xml file looks like this)
>=20
> =A0=A0 <qemu:arg value=3D'-object'>
> =A0=A0 <qemu:arg
> value=3D'sev-guest,id=3Dsev0,policy=3D<GO_policy>,dh-key-file=3D<filena=
me>,session-file=3D<filename>/>
> =A0=A0 <qemu:arg value=3D'-machine'/>
> =A0=A0 <qemu:arg value=3D'memory-encryption=3Dsev0'/>
>=20
> 8. libvirt launches the guest with "-S"
> 9. While creating the SEV guest qemu does the following
> =A0i) create encryption context using GO's DH, session-info and guest p=
olicy
> =A0=A0=A0 (LAUNCH_START)
> =A0ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
> =A0iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measurement

This part troubles me. This seems to mean that the guest being launched
must know what the measurement of the bios is going to be.  This means
that the cloud provider can not update the bios without breaking guests.
Also, while in practice you typically can run an old bios image on a new
qemu instance, this is not really tested so would be very hard to
support properly in QEMU.


And this looks like a fundamental problem with the hash based
measurement that's in hardware. So below I suggest that we layer
some software on top to rely on the hash as little as possible.



> 10. By some interface we must propagate the measurement all the way to =
GO
> =A0 before libvirt starts the guest.
> 11. GO verifies the measurement and if measurement matches then it may
> =A0give a secret blob -- which must be injected into the guest before
> =A0libvirt starts the VM. If verification failed, GO will request cloud
> =A0provider to destroy the VM.
> 12. After secret blob is injected into guest, we call LAUNCH_FINISH
> =A0 to destory the encryption context.
> 13. libvirt issues "continue" command to resume the guest boot.
>=20
> Please note that the measurement value is protected with transport
> encryption key (TIK) and it changes on each run. Similarly the secret b=
lob
> provided by GO does not need to be protected using libvirt/qemu APIs. T=
he
> secret is protected by TIK. From qemu and libvirt point of view these a=
re
> blobs and must be passed as-is to the SEV FW.

So here's an alternative idea for starting guests:

How about building a minimal shim firmware that
runs on a single CPU and uses no hardware at all,
it just contains the secret blob.

That firmware just immediately stops and signals
hypervisor that it is ready to be run in the cloud.

Have user generate and start this shim firmware as a guest in a private
setup, then export it out using SEND_* commands.

Then instead of asking to launch guest, you ask provider
to load it with RECEIVE_* commands.

Unlike bios the shim firmware
can hopefully be static so supporting it across qemu
versions should be easy.

The shim firmware then loads bios from qemu, verifies
it in any way it sees fit (e.g. it could check a signature, version, etc:
it is not limited to a hardware hash anymore).
It then jumps to the bios.


While not exactly the same, there is some similarity
here with how people solved the issues around secureboot -
by using a shim.

Thanks!


> Questions:
> a) Do we need to add a new set of APIs in libvirt to return the PDH fro=
m
> libvirt and VM tool ? Or can we use some pre-existing APIs to pass the
> opaque blobs ? (this is mainly for step 3 and 6)
> b) do we need to define a new xml tag to for memory-encryption ? or jus=
t
> use the qemu:args tag ? (step 6)
> c) what existing communicate interface can be used between libvirt and =
qemu
> to get the measurement ? can we add a new qemu monitor command
> 'get_sev_measurement' to get the measurement ? (step 10)
> d) how to pass the secret blob from libvirt to qemu ? should we conside=
r
> adding a new object (sev-guest-secret) -- libvirt can add the object th=
rough
> qemu monitor.
>=20
>=20
> [1] https://marc.info/?l=3Dkvm&m=3D150092661105069&w=3D2
> [2] https://marc.info/?l=3Dqemu-devel&m=3D148901186615642&w=3D2
> [3] https://lists.01.org/pipermail/edk2-devel/2017-July/012220.html
> [4] http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pd=
f
>=20
> Thanks
>=20
> Brijesh
>=20
