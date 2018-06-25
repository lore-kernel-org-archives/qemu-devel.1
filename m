Received: from eggs.gnu.org ([2001:4830:134:3::10]:44077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXTQk-0005Bv-71
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXTQf-0000dV-A6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXTQf-0000dQ-4r
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:21 -0400
Date: Mon, 25 Jun 2018 16:29:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180625152916.GG2390@work-vm>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625151803.GA2393@work-vm>
	<ad36fd83-8de6-1e9e-db51-1ceaf0f0269a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ad36fd83-8de6-1e9e-db51-1ceaf0f0269a@linux.vnet.ibm.com>
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
> On 06/25/2018 11:18 AM, Dr. David Alan Gilbert wrote:
> > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > Hi!
> > >=20
> > >  =A0I am sending this email to solicit input on the choice of the P=
CR banks to
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
> > >=20
> > > That said, my suggestion would be to enable only PCR banks for SHA2=
56 for
> > > 'now' and SHA512 for the future. Having two PCR banks should enable=
 decent
> > > performance. If someone wants to have better performance he will ha=
ve to go
> > > through the firmware to select the PCR banks at the expense of loos=
ing
> > > suspend/resume support.
> > >=20
> > > The change of PCR banks for the current 4 PCR banks will break the =
state of
> > > all swtpms.
> > >=20
> > > If you have suggestions, please let me know.
> > Is this something that has to be set at compile time or could it be
> > something chosen at run time (as options to the swtpm command line?)
> It is a compile-time option...

Hmm, that's a shame - I was hoping you'd be able to switch them at
runtime (or at least hide them?) then you can solve the upgrade problem
by running the new swtpm with a flag telling it to hide the new banks.
I hope the ondisk formats for suspend/resume/migration are descriptive
enough to be able to spot an error if you try and load one configured
differently.

Dave

> =A0=A0 Stefan
>=20
> >=20
> > Dave
> > > Regards,
> > >=20
> > >  =A0=A0 Stefan
> > >=20
> > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
