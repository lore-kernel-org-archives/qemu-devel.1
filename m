Received: from eggs.gnu.org ([2001:4830:134:3::10]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehdEo-0004a4-5Z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehdDk-00045s-2Q
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehdDj-00044j-Lf
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:25:43 -0500
Date: Fri, 2 Feb 2018 13:25:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180202152532.GL26425@localhost.localdomain>
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
	<20180201202649.GG26425@localhost.localdomain>
	<edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
	<20180202141554.GH26425@localhost.localdomain>
	<20180202141938.GJ15403@redhat.com>
	<20180202092159.48d9bd4c@redhat.com>
	<20180202145014.GI26425@localhost.localdomain>
	<20180202150718.GL15403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180202150718.GL15403@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] kvm: x86: export vCPU halted state to sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 02, 2018 at 03:07:18PM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Feb 02, 2018 at 12:50:14PM -0200, Eduardo Habkost wrote:
> > (CCing qemu-devel)
> >=20
> > On Fri, Feb 02, 2018 at 09:21:59AM -0500, Luiz Capitulino wrote:
> > > On Fri, 2 Feb 2018 14:19:38 +0000
> > > Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
> > > > On Fri, Feb 02, 2018 at 12:15:54PM -0200, Eduardo Habkost wrote:
> > [...]
> > > > > It would be also interesting to update QEMU QMP documentation t=
o
> > > > > clarify the arch-specific semantics of "halted". =20
> > > >=20
> > > > Any also especially clarify the awful performance implications of=
 running
> > > > this particular query command. In general I would not expect quer=
y-xxx
> > > > monitor commands to interrupt all vcpus, so we should clearly war=
n about
> > > > this !
> > >=20
> > > Or deprecate it...
> >=20
> > We could deprecate the expensive fields on query-cpus, and move
> > them to a more expensive query-cpu-state command.  I believe most
> > users of query-cpus are only interested in qom_path, thread_id,
> > and topology info.
> >=20
> > Markus, Eric: from the QAPI point of view, is it OK to remove
> > fields between QEMU versions, as long as we follow our
> > deprecation policy?
>=20
> I would expect that to not be OK.  A fully backwards compatible way to
> deal with this would just be to add a flag to the query-cpus command
> eg something like
>=20
>     query-cpus arch-specific=3Dfalse
>=20
> to turn off all this arch specific state, and just report the cheap
> generic info. If it defaults to arch-specific=3Dtrue when omitted, then
> there's no compat problems.

This would work, too.  I would name it "full-state",
"extended-state" or something similar, though.  Not all
arch-specific data is expensive to fetch, and not all
non-arch-specific data is unexpensive.

But I'd like to confirm if it's OK to make existing non-optional
struct fields optional in the QAPI schema.  Markus, Eric?

--=20
Eduardo
