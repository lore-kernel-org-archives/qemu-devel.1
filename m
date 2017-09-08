Received: from eggs.gnu.org ([2001:4830:134:3::10]:58788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJ8k-0000hM-Tj
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJ8h-0002xu-LK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqJ8h-0002wR-Aq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:16:07 -0400
Date: Fri, 8 Sep 2017 14:15:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908131555.GD32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
>=20
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
> =C2=A0=C2=A0 caller.

What sort of size are we talking about for the PDH ?

There's a few ways libvirt could report it

 1. As an XML element in the host capabilities XML
 2. As an XML element in the emulator capabilities XML
 3. Via a newly added host API

> 4. VM tool gives its PDH to GO.
> 5. GO provides its DH key, session-info and guest policy.

Are steps 4 & 5 strictly required to be in this order, or is it
possible

What are the security requirements around the DH key, session info
and guest policy ? Are any of them sensitive data which needs to be
kept private from untrustworthy users. Also are all three of these
items different for every guest launched, or are some of them
likely to be the same for every guest ?

eg, would the same guest policy blob be used for every guest, with
only session info changing ?

Also what sort of size are we talking about for each of these
data items, KBs, 10's of KB, 100's of KBs or larger ?

The security and data size can influence our design approach from
the libvirt POV.

> 6. VM tool somehow communicates the GO provided information to libvirt.

Essentially we have two choices

 1. inline in the guest XML config description passed to libvirt
    when defining the guest XML

 2. out of band, ahead of time, via some other API prior to defining
    the guest XML, which is then referenced in guest XML. THis could
    be done using the virSecret APIs, where we create 3 secrets, one
    each for DH key, session-info and guets policy. The UUID of the
    secret could be specified in the guest XML. This has flexibility
    of allowing the same secrets ot be used for many guests (if this
    is valid for SEV)


> 7. libvirt adds "sev-guest" object in its xml file with all the informa=
tion
> =C2=A0=C2=A0 obtained from #5
>=20
> =C2=A0=C2=A0 (currently my xml file looks like this)
>=20
> =C2=A0=C2=A0 <qemu:arg value=3D'-object'>
> =C2=A0=C2=A0 <qemu:arg
> value=3D'sev-guest,id=3Dsev0,policy=3D<GO_policy>,dh-key-file=3D<filena=
me>,session-file=3D<filename>/>
> =C2=A0=C2=A0 <qemu:arg value=3D'-machine'/>
> =C2=A0=C2=A0 <qemu:arg value=3D'memory-encryption=3Dsev0'/>
>=20
> 8. libvirt launches the guest with "-S"

All libvirt guests get launched with -S, to give libvirt chance to do som=
e
setup before starting vCPUs. Normally vCPUs are started by default, but
the VIR_DOMAIN_START_PAUSED flag allows the mgmt app to tell libvirt to
leave vCPUS paused.

Alternatively, if libvirt sees presencese of 'sev' config for the guest,
it could automatically leave it in PAUSED state regardless of the
VIR_DOMAIN_START_PAUSED flag.

> 9. While creating the SEV guest qemu does the following
> =C2=A0i) create encryption context using GO's DH, session-info and gues=
t policy
> =C2=A0=C2=A0=C2=A0 (LAUNCH_START)
> =C2=A0ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
> =C2=A0iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measureme=
nt
> 10. By some interface we must propagate the measurement all the way to =
GO
> =C2=A0 before libvirt starts the guest.

Again, what kind of size data are we talking about for athe "measurement"
blob ? a KB, 10's of KB, or more ?

My first gut instinct would be for QEMU to emit a QMP event when it has
the measurement available. The event could include the actual data blob,
or we can could add an explicit QMP command to fetch the data blob.

Libvirt could listen for this QEMU event, and in turn emit an event from
libvirt with the same data, which the mgmt tool can finally give to the
GO.

> 11. GO verifies the measurement and if measurement matches then it may
> =C2=A0give a secret blob -- which must be injected into the guest befor=
e
> =C2=A0libvirt starts the VM. If verification failed, GO will request cl=
oud
> =C2=A0provider to destroy the VM.

So we need some mechanism to provide the secret blob.  This could be
done via a new libvirt API.  Alternatively, if we're using virSecret
for the other stuff, the guest config XML could include the UUID of
a 4th  secret. Libvirt would then watch to see when that secret has
a value set, and pass that onto QEMU.

> 12. After secret blob is injected into guest, we call LAUNCH_FINISH
> =C2=A0 to destory the encryption context.
> 13. libvirt issues "continue" command to resume the guest boot.

This is as simple as the mgmt tool calling virDomainResume to unpause
CPUs. We could have it such that virDomainResume checks whether the
virSecret has been populated secret blob by GO, and pass it onto
QEMU at this time.

> Please note that the measurement value is protected with transport
> encryption key (TIK) and it changes on each run. Similarly the secret b=
lob
> provided by GO does not need to be protected using libvirt/qemu APIs. T=
he
> secret is protected by TIK. From qemu and libvirt point of view these a=
re
> blobs and must be passed as-is to the SEV FW.
>=20
> Questions:
> a) Do we need to add a new set of APIs in libvirt to return the PDH fro=
m
> libvirt and VM tool ? Or can we use some pre-existing APIs to pass the
> opaque blobs ? (this is mainly for step 3 and 6)
> b) do we need to define a new xml tag to for memory-encryption ? or jus=
t
> use the qemu:args tag ? (step 6)

<qemu:args> is explicitly only ever for ad-hoc testing.

For anything that is to be used in production deployment we must
explicitly model it in the XML. So we definitely need new XML
defined.

> c) what existing communicate interface can be used between libvirt and =
qemu
> to get the measurement ? can we add a new qemu monitor command
> 'get_sev_measurement' to get the measurement ? (step 10)

Yes, QMP commands seeem most likely.

> d) how to pass the secret blob from libvirt to qemu ? should we conside=
r
> adding a new object (sev-guest-secret) -- libvirt can add the object th=
rough
> qemu monitor.

Yeah, that looks like a viable option too.

>=20
>=20
> [1] https://marc.info/?l=3Dkvm&m=3D150092661105069&w=3D2
> [2] https://marc.info/?l=3Dqemu-devel&m=3D148901186615642&w=3D2
> [3] https://lists.01.org/pipermail/edk2-devel/2017-July/012220.html
> [4] http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pd=
f

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
