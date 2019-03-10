Received: from eggs.gnu.org ([209.51.188.92]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2vVb-0006Mx-A3
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2vVa-0006T3-D7
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:16:43 -0400
From: Markus Armbruster <armbru@redhat.com>
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
	<20190307095901.GF32268@redhat.com>
Date: Sun, 10 Mar 2019 11:16:33 +0100
In-Reply-To: <20190307095901.GF32268@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Thu, 7 Mar 2019 09:59:01 +0000")
Message-ID: <871s3fxce6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, david@gibson.dropbear.id.au

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Mar 06, 2019 at 08:03:48PM +0100, Igor Mammedov wrote:
>> On Mon, 4 Mar 2019 16:35:16 +0000
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> > On Mon, Mar 04, 2019 at 05:20:13PM +0100, Michal Privoznik wrote:
>> > > We couldn't have done that. How we would migrate from older qemu?
>> > >=20
>> > > Anyway, now that I look into this (esp. git log) I came accross:
>> > >=20
>> > > commit f309db1f4d51009bad0d32e12efc75530b66836b
>> > > Author:     Michal Privoznik <mprivozn@redhat.com>
>> > > AuthorDate: Thu Dec 18 12:36:48 2014 +0100
>> > > Commit:     Michal Privoznik <mprivozn@redhat.com>
>> > > CommitDate: Fri Dec 19 07:44:44 2014 +0100
>> > >=20
>> > >     qemu: Create memory-backend-{ram,file} iff needed
>> > >=20
>> > > Or this 7832fac84741d65e851dbdbfaf474785cbfdcf3c. We did try to gene=
rated
>> > > newer cmd line but then for various reasong (e.g. avoiding triggerin=
g a qemu
>> > > bug) we turned it off and make libvirt default to older (now depreca=
ted) cmd
>> > > line.
>> > >=20
>> > > Frankly, I don't know how to proceed. Unless qemu is fixed to allow
>> > > migration from deprecated to new cmd line (unlikely, if not impossib=
le,
>> > > right?) then I guess the only approach we can have is that:
>> > >=20
>> > > 1) whenever so called cold booting a new machine (fresh, brand new s=
tart of
>> > > a new domain) libvirt would default to modern cmd line,
>> > >=20
>> > > 2) on migration, libvirt would record in the migration stream (or st=
atus XML
>> > > or wherever) that modern cmd line was generated and thus it'll make =
the
>> > > destination generate modern cmd line too.
>> > >=20
>> > > This solution still suffers a couple of problems:
>> > > a) migration to older libvirt will fail as older libvirt won't recog=
nize the
>> > > flag set in 2) and therefore would default to deprecated cmd line
>> > > b) migrating from one host to another won't modernize the cmd line
>> > >=20
>> > > But I guess we have to draw a line somewhere (if we are not willing =
to write
>> > > those migration patches).
>> >=20
>> > Yeah supporting backwards migration is a non-optional requirement from=
 at
>> > least one of the mgmt apps using libvirt, so breaking the new to old c=
ase
>> > is something we always aim to avoid.
>> Aiming for support of=20
>> "new QEMU + new machine type" =3D> "old QEMU + non-existing machine type"
>> seems a bit difficult.
>
> That's not the scenario that's the problem. The problem is
>
>    new QEMU + new machine type + new libvirt   -> new QEMU + new machine =
type + old libvirt
>
> Previously released versions of libvirt will happily use any new machine
> type that QEMU introduces. So we can't make new libvirt use a different
> options, only for new machine types, as old libvirt supports those machine
> types too.

Avoiding tight coupling between QEMU und libvirt versions makes sense,
because having to upgrade stuff in lock-step is such a pain.

Does not imply we must support arbitrary combinations of QEMU and
libvirt versions.

Unless upstream libvirt's test matrix covers all versions of libvirt
against all released versions of QEMU, "previously released versions of
libvirt will continue to work with new QEMU" is largely an empty promise
anyway.  The real promise is more like "we won't break it intentionally;
good luck".

Mind, I'm not criticizing that real promise.  I'm criticizing cutting
yourself off from large areas of the solution space so you can continue
to pretend to yourself you actually deliver on the empty promise.

Now, if you limited what you promise to something more realistic,
ideally to something you actually test, we could talk about deprecation
schedules constructively.

For instance, if you promised

    QEMU as of time T + its latest machine type + libvirt as of time T
 -> QEMU as of time T + its latest machine type + libvirt as of time T - d

will work for a certain value of d, then once all released versions of
libvirt since T - d support a new way of doing things, flipping to that
new way becomes a whole lot easier.
