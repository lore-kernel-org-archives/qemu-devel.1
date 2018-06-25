Received: from eggs.gnu.org ([2001:4830:134:3::10]:55264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXU4r-00058x-Ih
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXU4o-00028J-9r
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:10:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXU4o-000282-4D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:10:50 -0400
Date: Mon, 25 Jun 2018 17:10:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625161044.GL18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625152513.GI18580@redhat.com>
	<6adb28e6-85eb-38dc-ad24-99a5daa0f972@linux.vnet.ibm.com>
	<20180625155933.GK18580@redhat.com>
	<759e2eab-bc8a-a841-5016-4308c3a680bb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <759e2eab-bc8a-a841-5016-4308c3a680bb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Choosing PCR banks for swtpm's TPM 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Jun 25, 2018 at 12:08:34PM -0400, Stefan Berger wrote:
> On 06/25/2018 11:59 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jun 25, 2018 at 11:56:24AM -0400, Stefan Berger wrote:
> > > On 06/25/2018 11:25 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Mon, Jun 25, 2018 at 11:05:55AM -0400, Stefan Berger wrote:
> > > > > Hi!
> > > > >=20
> > > > >   =C2=A0I am sending this email to solicit input on the choice =
of the PCR banks to
> > > > > enable for swtpm's TPM 2. I have currently enabled 4 PCR banks =
for
> > > > > SHA{1,256,384,512}. The downside of this is that running the TP=
M 2 with so
> > > > > many PCR banks has a performance impact when the Linux integrit=
y measurement
> > > > > architecture is used and has to extend measurements into all PC=
R banks,
> > > > > which Linux does already.
> > > > >=20
> > > > > TPM 2 has the PCR_Allocate() command for a user to select the P=
CR banks to
> > > > > use. This command allows to make some PCR banks invisible. The =
change has to
> > > > > be done through the firmware and has the downside that the TPM2=
 does not
> > > > > support TPM2_Shutdown(SU_STATE) after this command was used. Th=
is prevents
> > > > > suspend/resume from working properly. So, it seems that one sho=
uldn't have
> > > > > to use this command, which in turn means the number of PCR bank=
s should be
> > > > > small.
> > > > >=20
> > > > > Another complication with the swtpm is the upgrade path. Suspen=
ded VMs will
> > > > > expect that the PCR banks that were available before the suspen=
d will be
> > > > > available after the resume and a possible swtpm upgrade. This i=
n turn means
> > > > > that the PCR banks should be chosen now and we'll have to stick=
 with them.
> > > > Anything that has a risk of needing to change between versions wo=
uld need
> > > > to be tied into the machine type in some way.
> > > You mean a machine type like q35? I am not sure how it would be tie=
d into
> > > QEMU since the swtpm command line options are chosen more or less
> > > independently of the ones from QEMU.
> > Yes, each QEMU release introduces a new versioned machine type eg
> >    q35-2.10,  q35-2.11, q35-2.12, q35-3.0
> >=20
> > If anything in QEMU changes which impacts live migraiton/save/restore=
/etc
> > then we tie it to the versioned machine type. so q35-3.0 would get th=
e
> > new default value, and all previous machine types keep the old defaul=
t
> > value.
> >=20
> > For this to be possible with externally launched swtpm though, would
> > require some way for QEMU to talk to swtpm to tell it what default
> > to use for this. I don't know enough about swtpm to have an idea how
> > practical this is or not.
>=20
> The set of PCR banks a future TPM 2 would be 'manufactured with' would =
be
> determined by parameters to swtpm_setup. That's when the TPM2 is
> 'manufactured' and the certificates are created and written into its NV=
RAM
> locations. QEMU is not talking to the TPM 2 at this point. So it would =
be
> parameters passed from libvirt to swtpm_setup that determine the set of=
 PCR
> banks. swtpm itself would get those supplied via command line options w=
hen
> invoked by swtpm_setup. If one was to skip over the swtpm_setup step, t=
hen
> why not use the swtpm command line options that need to be there for
> swtpm_setup support. Though I think few people will use it like that. I
> would not extend the protocol for this purpose.

Ah so in that case, we would merely require ability to record the desired
PCR setup in the XML, and libvirt would then pass the right args to
swtpm_setup when required.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
