Received: from eggs.gnu.org ([2001:4830:134:3::10]:50752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqLW1-00032B-0W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqLVw-0007wx-Vn
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:48:21 -0400
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com
	([104.47.41.44]:9856
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dqLVw-0007vu-JR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:48:16 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
Date: Fri, 8 Sep 2017 10:48:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170908145201.GJ32645@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: "Daniel P. Berrange" <berrange@redhat.com>, "Relph, Richard" <Richard.Relph@amd.com>
Cc: brijesh.singh@amd.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

Hi Daniel,


On 09/08/2017 09:52 AM, Daniel P. Berrange wrote:
> On Fri, Sep 08, 2017 at 01:45:06PM +0000, Relph, Richard wrote:
>> A few answers in line=E2=80=A6
>>
>> On 9/8/17, 8:16 AM, "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>
>>      On Fri, Sep 08, 2017 at 06:57:30AM -0500, Brijesh Singh wrote:
>>      > Hi All,
>>      >
>>      > (sorry for the long message)
>>      >
>>      > CPUs from AMD EPYC family supports Secure Encrypted Virtualizatio=
n (SEV)
>>      > feature - the feature allows running encrypted VMs. To enable the=
 feature,
>>      > I have been submitting patches to Linux kernel [1], Qemu [2] and =
OVMF [3].
>>      > We have been making some good progress in getting patches accepte=
d upstream
>>      > in Linux and OVMF trees. SEV builds upon SME (Secure Memory Encry=
ption)
>>      > feature -- SME support just got pulled into 4.14 merge window. Th=
e base
>>      > SEV patches are accepted in OVMF tree -- now we have SEV aware gu=
est BIOS.
>>      > I am getting ready to take off "RFC" tag from remaining patches t=
o get them
>>      > reviewed and accepted.
>>      >
>>      > The boot flow for launching an SEV guest is a bit different from =
a typical
>>      > guest launch. In order to launch SEV guest from virt-manager or o=
ther
>>      > high-level VM management tools, we need to design and implement n=
ew
>>      > interface between libvirt and qemu, and probably add new APIs in =
libvirt
>>      > to be used by VM management tools. I am new to the libvirt and ne=
ed some
>>      > expert advice while designing this interface. A pictorial represe=
ntation
>>      > for a SEV guest launch flow is available in SEV Spec Appendix A [=
4].
>>      >
>>      > A typical flow looks like this:
>>      >
>>      > 1. Guest owner (GO) asks the cloud provider to launch SEV guest.
>>      > 2. VM tool asks libvirt to provide its Platform Diffie-Hellman (P=
DH) key.
>>      > 3. libvirt opens /dev/sev device to get its PDH and return the bl=
ob to the
>>      >    caller.
>>     =20
>>      What sort of size are we talking about for the PDH ?
>>
>> The PDH blob is described in reference 4. It=E2=80=99s 0x824 bytes long=
=E2=80=A6 a bit over 2K bytes.
>> PDH is =E2=80=9CPlatform Diffie-Hellman=E2=80=9D key, public portion.
>>     =20
>>      There's a few ways libvirt could report it
>>     =20
>>       1. As an XML element in the host capabilities XML
>>       2. As an XML element in the emulator capabilities XML
>>       3. Via a newly added host API
>>     =20
>>      > 4. VM tool gives its PDH to GO.
>>      > 5. GO provides its DH key, session-info and guest policy.
>>     =20
>>      Are steps 4 & 5 strictly required to be in this order, or is it
>>      possible
>>
>> Steps 4 and 5 must occur in that order. The data sent by the GO in the
>> =E2=80=9Csession info=E2=80=9D is encrypted and integrity protected with=
 keys that the
>> GO derives from the GO private Diffie-Hellman key and the PDH public
>> Diffie-Hellman key.
>>     =20
>>      What are the security requirements around the DH key, session info
>>      and guest policy ? Are any of them sensitive data which needs to be
>>      kept private from untrustworthy users. Also are all three of these
>>      items different for every guest launched, or are some of them
>>      likely to be the same for every guest ?
>>
>> The PDH is not sensitive. It is relatively static for the platform.
>> (It only changes when the platform owner chooses to change the apparent
>> identity of the platform that will actually run the virtual machine.)
>> The 128-byte session info data is encrypted and integrity protected by
>> the GO. It need not be additionally encrypted or integrity protected.
>> It should vary for EVERY guest launch.
>> The 4-byte guest policy must be sent in the clear as some components
>> may want to observe the policy bits. It may change from guest to guest,
>> but there will likely only be a few common values.
>=20
> Given this, and the pretty small data sizes, I think this info could
> in fact all be provided inline in the XML config - either hex or base64
> encoded for the binary blobs.
>=20
>=20
>=20
>>      > 8. libvirt launches the guest with "-S"
>>     =20
>>      All libvirt guests get launched with -S, to give libvirt chance to =
do some
>>      setup before starting vCPUs. Normally vCPUs are started by default,=
 but
>>      the VIR_DOMAIN_START_PAUSED flag allows the mgmt app to tell libvir=
t to
>>      leave vCPUS paused.
>>     =20
>>      Alternatively, if libvirt sees presencese of 'sev' config for the g=
uest,
>>      it could automatically leave it in PAUSED state regardless of the
>>      VIR_DOMAIN_START_PAUSED flag.
>>
>> While using the LAUNCH_MEASURE and LAUNCH_SECRET operations is expected
>> to be the common case, they are optional. I would recommend requiring
>> the upstream software to explicitly set the VIR_DOMAIN_START_PAUSED flag=
,
>> if only to minimize the dependencies=E2=80=A6
>=20
> Ok.
>=20
>>      > 9. While creating the SEV guest qemu does the following
>>      >  i) create encryption context using GO's DH, session-info and gue=
st policy
>>      >     (LAUNCH_START)
>>      >  ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
>>      >  iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measurem=
ent
>>      > 10. By some interface we must propagate the measurement all the w=
ay to GO
>>      >   before libvirt starts the guest.
>>     =20
>>      Again, what kind of size data are we talking about for athe "measur=
ement"
>>      blob ? a KB, 10's of KB, or more ?
>>
>> The measurement is 48 bytes=E2=80=A6
>=20
> For that small size we can definitely provide is inline in the event
> payload then.
>=20
>>      My first gut instinct would be for QEMU to emit a QMP event when it=
 has
>>      the measurement available. The event could include the actual data =
blob,
>>      or we can could add an explicit QMP command to fetch the data blob.
>>     =20
>>      Libvirt could listen for this QEMU event, and in turn emit an event=
 from
>>      libvirt with the same data, which the mgmt tool can finally give to=
 the
>>      GO.
>>     =20
>>      > 11. GO verifies the measurement and if measurement matches then i=
t may
>>      >  give a secret blob -- which must be injected into the guest befo=
re
>>      >  libvirt starts the VM. If verification failed, GO will request c=
loud
>>      >  provider to destroy the VM.
>>     =20
>>      So we need some mechanism to provide the secret blob.  This could b=
e
>>      done via a new libvirt API.  Alternatively, if we're using virSecre=
t
>>      for the other stuff, the guest config XML could include the UUID of
>>      a 4th  secret. Libvirt would then watch to see when that secret has
>>      a value set, and pass that onto QEMU.
>>
>> The secret is optional=E2=80=A6 it is up to 16KB, already encrypted, and=
 integrity
>> protected with an IV and MAC value passed with the secret. The guest
>> address the secret should be deposited at is
>> Technically, the SEV FW API allows there to be more than one secret=E2=
=80=A6
>> I don=E2=80=99t see a strong reason to require libvirt to support more t=
han one,
>> though.
>=20
> So I think we could simply add a new API to libvirt to provide this
> data item.
>=20
>>      > 12. After secret blob is injected into guest, we call LAUNCH_FINI=
SH
>>      >   to destory the encryption context.
>>      > 13. libvirt issues "continue" command to resume the guest boot.
>>     =20
>>      This is as simple as the mgmt tool calling virDomainResume to unpau=
se
>>      CPUs. We could have it such that virDomainResume checks whether the
>>      virSecret has been populated secret blob by GO, and pass it onto
>>      QEMU at this time.
>>     =20
>>      > Please note that the measurement value is protected with transpor=
t
>>      > encryption key (TIK) and it changes on each run. Similarly the se=
cret blob
>>      > provided by GO does not need to be protected using libvirt/qemu A=
PIs. The
>>      > secret is protected by TIK. From qemu and libvirt point of view t=
hese are
>>      > blobs and must be passed as-is to the SEV FW.
>>      >
>>      > Questions:
>>      > a) Do we need to add a new set of APIs in libvirt to return the P=
DH from
>>      > libvirt and VM tool ? Or can we use some pre-existing APIs to pas=
s the
>>      > opaque blobs ? (this is mainly for step 3 and 6)
>>      > b) do we need to define a new xml tag to for memory-encryption ? =
or just
>>      > use the qemu:args tag ? (step 6)
>>     =20
>>      <qemu:args> is explicitly only ever for ad-hoc testing.
>>     =20
>>      For anything that is to be used in production deployment we must
>>      explicitly model it in the XML. So we definitely need new XML
>>      defined.
>>     =20
>>      > c) what existing communicate interface can be used between libvir=
t and qemu
>>      > to get the measurement ? can we add a new qemu monitor command
>>      > 'get_sev_measurement' to get the measurement ? (step 10)
>>     =20
>>      Yes, QMP commands seeem most likely.
>>     =20
>>      > d) how to pass the secret blob from libvirt to qemu ? should we c=
onsider
>>      > adding a new object (sev-guest-secret) -- libvirt can add the obj=
ect through
>>      > qemu monitor.
>>     =20
>>      Yeah, that looks like a viable option too.
>=20
> So I could see a flow like the following:


The flow looks good

>=20
>=20
>    1. mgmt tool calls  virConnectGetCapabilities. This returns an XML
>       document that includes the following
>=20
>        <host>
>           ...other bits...
>          <sev>
> 	  <platform-key>...hex encoded PDH key...</platform-key>
> 	</sev>
>        </host>
>=20
>    2. mgmt tool requests to start a guest calling virCreateXML(),
>       passing VIR_DOMAIN_START_PAUSED. The XML would include
>=20
>        <sev>
>          <owner-key>...hex encode DH key...</owner-key>
> 	<session-info>..hex encode info...</session-info>
> 	<policy>...int32 value..</policy>
>        </sev>
>=20
>=20
>       if <sev> is provided and VIR_DOMAIN_START_PAUSED is missing,
>       libvirt would report an error and refuse to start the guest
>=20


One thing which is not clear to me is, how do we know that we are asked
to launch SEV guest? Are you thinking that <sev> tag in the XML will
hint libvirt that GO has asked to launch a SEV guest?


>    3. Libvirt generates the QEMU cli arg to enable SEV using
>       the XML data and starts QEMU, leaving CPUs paused
>=20


I am looking at [1] to get the feel for how do we model it in the XML.
As you can see I am using ad-hoc <qemu:args> to create the sev-guest
object. Currently, sev-guest object accepts the following properties:

dh-cert-file: <file containing the GO DH key>
session-info-file: <file contain the GO session info>
policy: <int32 GO policy>

I believe the new XML model will influence the property input type,
Any recommendation on how do model this part ? thank you so much.

[1] https://libvirt.org/formatdomain.html#elementsCPU


>    4. QEMU emits a SEV_MEASURE event containing the measurement
>       blob
>=20
>    5. Libvirt catches the QEMU event and emits its own
>       VIR_CONNECT_DOMAIN_EVENT_SEV_MEASURE event containing
>       the measurement blob
>=20
>    6. GO does its validation of the measurement
>=20
>    7a  If validation failed, then virDomainDestroy() to stop QEMU
>=20
>    7b  If validation succeeed
>=20
>       Optionally call
>=20
>           virDomainSetSEVSecret()
>=20
>       providing the optional secret, then
>=20
>           virDomainResume()
>=20
>       to let QEMU continue
>=20
>=20
>=20
>=20
> Regards,
> Daniel
>=20
