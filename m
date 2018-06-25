Received: from eggs.gnu.org ([2001:4830:134:3::10]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTu3-0003we-JA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTu0-0004nz-FQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:59:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXTu0-0004nq-9V
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:59:40 -0400
Date: Mon, 25 Jun 2018 16:59:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625155933.GK18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625152513.GI18580@redhat.com>
	<6adb28e6-85eb-38dc-ad24-99a5daa0f972@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6adb28e6-85eb-38dc-ad24-99a5daa0f972@linux.vnet.ibm.com>
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

On Mon, Jun 25, 2018 at 11:56:24AM -0400, Stefan Berger wrote:
> On 06/25/2018 11:25 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jun 25, 2018 at 11:05:55AM -0400, Stefan Berger wrote:
> > > Hi!
> > >=20
> > >  =C2=A0I am sending this email to solicit input on the choice of th=
e PCR banks to
> > > enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
> > > SHA{1,256,384,512}. The downside of this is that running the TPM 2 =
with so
> > > many PCR banks has a performance impact when the Linux integrity me=
asurement
> > > architecture is used and has to extend measurements into all PCR ba=
nks,
> > > which Linux does already.
> > >=20
> > > TPM 2 has the PCR_Allocate() command for a user to select the PCR b=
anks to
> > > use. This command allows to make some PCR banks invisible. The chan=
ge has to
> > > be done through the firmware and has the downside that the TPM2 doe=
s not
> > > support TPM2_Shutdown(SU_STATE) after this command was used. This p=
revents
> > > suspend/resume from working properly. So, it seems that one shouldn=
't have
> > > to use this command, which in turn means the number of PCR banks sh=
ould be
> > > small.
> > >=20
> > > Another complication with the swtpm is the upgrade path. Suspended =
VMs will
> > > expect that the PCR banks that were available before the suspend wi=
ll be
> > > available after the resume and a possible swtpm upgrade. This in tu=
rn means
> > > that the PCR banks should be chosen now and we'll have to stick wit=
h them.
> > Anything that has a risk of needing to change between versions would =
need
> > to be tied into the machine type in some way.
>=20
> You mean a machine type like q35? I am not sure how it would be tied in=
to
> QEMU since the swtpm command line options are chosen more or less
> independently of the ones from QEMU.

Yes, each QEMU release introduces a new versioned machine type eg
  q35-2.10,  q35-2.11, q35-2.12, q35-3.0

If anything in QEMU changes which impacts live migraiton/save/restore/etc
then we tie it to the versioned machine type. so q35-3.0 would get the
new default value, and all previous machine types keep the old default
value.

For this to be possible with externally launched swtpm though, would
require some way for QEMU to talk to swtpm to tell it what default
to use for this. I don't know enough about swtpm to have an idea how
practical this is or not.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
