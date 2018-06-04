Received: from eggs.gnu.org ([2001:4830:134:3::10]:34491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPuFs-0002IN-Tn
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPuFp-00043E-Q1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fPuFp-00042j-G7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:30:53 -0400
Date: Mon, 4 Jun 2018 15:30:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180604183046.GR7451@localhost.localdomain>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604125415.GN7451@localhost.localdomain>
	<20180604130129.GG19749@redhat.com>
	<20180604132624.GO7451@localhost.localdomain>
	<20180604194913-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604194913-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Mon, Jun 04, 2018 at 08:17:23PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jun 04, 2018 at 10:26:24AM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 04, 2018 at 02:01:29PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Mon, Jun 04, 2018 at 09:54:15AM -0300, Eduardo Habkost wrote:
> > > > On Mon, Jun 04, 2018 at 04:38:22AM +0300, Michael S. Tsirkin wrot=
e:
> > > > > On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrot=
e:
> > > > > > Moving to QEMU 3.0 seems like a good opportunity for such a c=
hange.
> > > > > >=20
> > > > > > I440FX is really old and does not support modern features lik=
e IOMMU.
> > > > > > Q35's SATA emulation is faster than pc's IDE, native PCI expr=
ess hotplug
> > > > > > is cleaner than ACPI based one and so on...
> > > > > >=20
> > > > > > Also the libvirt guys added very good support for the Q35 mac=
hine (thanks!).
> > > > > >=20
> > > > > > Management software should always specify the machine type an=
d for the
> > > > > > current setups, adding '-machine pc' to the command line is n=
ot such a
> > > > > > big deal.
> > > > > >=20
> > > > > > In time the pc machine will fade out and we will probably sto=
p adding
> > > > > > new versions at some point.
> > > > > >=20
> > > > > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > >=20
> > > > > For command line users, I think changing the default isn't nice=
.
> > > > >=20
> > > > > Yes it's easy to add -machine pc but there's no documentation
> > > > > that tells you to do so. Add to that shortcuts like -cdrom
> > > > > stop working, hotplug needs extra bridges to work, and one
> > > > > can see that while management tool users benefit from q35,
> > > > > command line users will suffer.
> > > > >=20
> > > > > Can't we add a tag for management without changing the command =
line
> > > > > default? How about "management-default"? "recommended"? "latest=
"?
> > > >=20
> > > > We could add new aliases if they are useful for management
> > > > software, but we would need a well-defined use case and set of
> > > > requirements+expectations for the new alias.
> > >=20
> > > I'm not convinced by the idea of adding a distinct default "for mgm=
t". All
> > > the problems described wrt 'q35' vs 'pc' apply equally to managemen=
t apps
> > > as they do to humans. It just happens that one common mgmt layer (l=
ibvirt)
> > > knows how to handle some of the complexity of q35. Other mgmt apps =
though
> > > are just as likely to be hurt by the change as humans are. So effec=
tively
> > > the proposed "for mgmt" is actually  "for libvirt >=3D some version=
", which
> > > feels like a layering violation to me.
> >=20
> > This means the new alias would be used only if requested
> > explicitly by management software (not used automatically by
> > libvirt).
> >=20
> > Taking that into account, I still don't see what exactly would be
> > the use case here, and what exactly users can/can't expect when
> > using the new alias.
>=20
> Let's see what we have now first:
>=20
> 1. We have a requirement for the user to save the machine type on insta=
ll
> and maintain it with the image (a separate thread discusses saving that
> as part of a qcow2 image).
>=20
> 2. If you use an alias instead you are supposed to resolve it
> and save the resolved value. If you save the alias instead,
> you can't do cross-version live migration.
>=20
> 3. If you don't specify anything you get a machine tagged default.  You=
 are
> supposed to find it and save the value found.  If you don't and just
> keep using the default, you can't do cross-version live migration.
>=20
> ---
>=20
> So now we would like to relax 3 to say
> 	"If you don't and just keep using the default, some images might not
> 	boot".
>=20
> unfortunately we probably can't change 3 like this.
> So what I propose instead is simply:
>=20
> 4. If you find a machine type value tagged "qmp-default" you must save
>    the value found.  If you don't and just keep using the qmp-default e=
ach
>    time, then existing guest images won't boot.
>    This relaxed compatibility requirement allows for advanced features
>    as compared to default.

What problems would this system solve?  Who would prefer to use
the "qmp-default" machine-type instead of the "pc" or "q35"
aliases?

--=20
Eduardo
