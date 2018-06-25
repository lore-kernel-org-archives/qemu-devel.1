Received: from eggs.gnu.org ([2001:4830:134:3::10]:55484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXU5s-00064e-PJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXU5p-0002uQ-II
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:11:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXU5p-0002uE-A7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:11:53 -0400
Date: Mon, 25 Jun 2018 17:11:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180625161147.GH2390@work-vm>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625151803.GA2393@work-vm>
	<ad36fd83-8de6-1e9e-db51-1ceaf0f0269a@linux.vnet.ibm.com>
	<20180625152916.GG2390@work-vm>
	<0bddd044-c9bf-37b9-814b-8eeaf13c9f64@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0bddd044-c9bf-37b9-814b-8eeaf13c9f64@linux.vnet.ibm.com>
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
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> On 06/25/2018 11:29 AM, Dr. David Alan Gilbert wrote:
> > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > On 06/25/2018 11:18 AM, Dr. David Alan Gilbert wrote:
> > > > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > > > Hi!
> > > > >=20
> > > > >   =A0I am sending this email to solicit input on the choice of =
the PCR banks to
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
> > > > >=20
> > > > > That said, my suggestion would be to enable only PCR banks for =
SHA256 for
> > > > > 'now' and SHA512 for the future. Having two PCR banks should en=
able decent
> > > > > performance. If someone wants to have better performance he wil=
l have to go
> > > > > through the firmware to select the PCR banks at the expense of =
loosing
> > > > > suspend/resume support.
> > > > >=20
> > > > > The change of PCR banks for the current 4 PCR banks will break =
the state of
> > > > > all swtpms.
> > > > >=20
> > > > > If you have suggestions, please let me know.
> > > > Is this something that has to be set at compile time or could it =
be
> > > > something chosen at run time (as options to the swtpm command lin=
e?)
> > > It is a compile-time option...
> > Hmm, that's a shame - I was hoping you'd be able to switch them at
> > runtime (or at least hide them?) then you can solve the upgrade probl=
em
> > by running the new swtpm with a flag telling it to hide the new banks=
.
> > I hope the ondisk formats for suspend/resume/migration are descriptiv=
e
> > enough to be able to spot an error if you try and load one configured
> > differently.4
>=20
> The disk format does detect it and refuses to take the state if either =
there
> are too many PCR banks or not enough.

What happens if there are the right number just the wrong type?

> For the initial version of swtpm we would need to define a default set =
of
> PCR banks since the TPM 2 code uses compile time options to build in th=
at
> set of PCR banks.

You talk of PCR_Allocate() above as a spec-defined command to hide PCRs
but with the downside of breaking TPM2_Shutdown - could you implement
something from the commandline without that downside (I don't know how
PCR banks work).

> A future version of swtpm could expose command line options for selecti=
ng
> the PCR banks an instance of swtpm is to run with. libtpms would be com=
piled
> with support for all of them and only the chosen subset would be active
> starting with the initial creation of a particular instance of swtpm.

Right, that would solve the upgrade half of the problem.

Dave

> =A0=A0=A0 Stefan
>=20
> >=20
> > Dave
> >=20
> > >  =A0=A0 Stefan
> > >=20
> > > > Dave
> > > > > Regards,
> > > > >=20
> > > > >   =A0=A0 Stefan
> > > > >=20
> > > > >=20
> > > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
