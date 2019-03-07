Received: from eggs.gnu.org ([209.51.188.92]:41983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1po7-0000ia-Pd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1po6-00036P-Kl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:59:19 -0500
Date: Thu, 7 Mar 2019 09:59:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307095901.GF32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com>
	<20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com>
	<20190304142432.GM4239@redhat.com>
	<a6081774-c9d5-0496-3e65-ffb885408261@redhat.com>
	<20190304163516.GQ4239@redhat.com>
	<20190306200348.11e9eece@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306200348.11e9eece@Igors-MacBook-Pro.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, Mar 06, 2019 at 08:03:48PM +0100, Igor Mammedov wrote:
> On Mon, 4 Mar 2019 16:35:16 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Mon, Mar 04, 2019 at 05:20:13PM +0100, Michal Privoznik wrote:
> > > We couldn't have done that. How we would migrate from older qemu?
> > >=20
> > > Anyway, now that I look into this (esp. git log) I came accross:
> > >=20
> > > commit f309db1f4d51009bad0d32e12efc75530b66836b
> > > Author:     Michal Privoznik <mprivozn@redhat.com>
> > > AuthorDate: Thu Dec 18 12:36:48 2014 +0100
> > > Commit:     Michal Privoznik <mprivozn@redhat.com>
> > > CommitDate: Fri Dec 19 07:44:44 2014 +0100
> > >=20
> > >     qemu: Create memory-backend-{ram,file} iff needed
> > >=20
> > > Or this 7832fac84741d65e851dbdbfaf474785cbfdcf3c. We did try to gen=
erated
> > > newer cmd line but then for various reasong (e.g. avoiding triggeri=
ng a qemu
> > > bug) we turned it off and make libvirt default to older (now deprec=
ated) cmd
> > > line.
> > >=20
> > > Frankly, I don't know how to proceed. Unless qemu is fixed to allow
> > > migration from deprecated to new cmd line (unlikely, if not impossi=
ble,
> > > right?) then I guess the only approach we can have is that:
> > >=20
> > > 1) whenever so called cold booting a new machine (fresh, brand new =
start of
> > > a new domain) libvirt would default to modern cmd line,
> > >=20
> > > 2) on migration, libvirt would record in the migration stream (or s=
tatus XML
> > > or wherever) that modern cmd line was generated and thus it'll make=
 the
> > > destination generate modern cmd line too.
> > >=20
> > > This solution still suffers a couple of problems:
> > > a) migration to older libvirt will fail as older libvirt won't reco=
gnize the
> > > flag set in 2) and therefore would default to deprecated cmd line
> > > b) migrating from one host to another won't modernize the cmd line
> > >=20
> > > But I guess we have to draw a line somewhere (if we are not willing=
 to write
> > > those migration patches).
> >=20
> > Yeah supporting backwards migration is a non-optional requirement fro=
m at
> > least one of the mgmt apps using libvirt, so breaking the new to old =
case
> > is something we always aim to avoid.
> Aiming for support of=20
> "new QEMU + new machine type" =3D> "old QEMU + non-existing machine typ=
e"
> seems a bit difficult.

That's not the scenario that's the problem. The problem is

   new QEMU + new machine type + new libvirt   -> new QEMU + new machine =
type + old libvirt

Previously released versions of libvirt will happily use any new machine
type that QEMU introduces. So we can't make new libvirt use a different
options, only for new machine types, as old libvirt supports those machin=
e
types too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
