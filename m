Received: from eggs.gnu.org ([2001:4830:134:3::10]:35006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dlFgx-0007y3-FG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dlFgs-00015a-RC
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:34:35 -0400
Date: Fri, 25 Aug 2017 16:34:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170825163426.234753d4@nial.brq.redhat.com>
In-Reply-To: <20170825132800.GM2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-3-git-send-email-imammedo@redhat.com>
	<20170825013819.GQ5379@umbus.fritz.box>
	<20170825092740.239b6a82@nial.brq.redhat.com>
	<20170825094538.GI2772@umbus.fritz.box>
	<20170825134007.73d69fa3@nial.brq.redhat.com>
	<20170825132800.GM2772@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/6] ppc: make cpu_model
 translation to type consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, 25 Aug 2017 23:28:00 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Aug 25, 2017 at 01:40:07PM +0200, Igor Mammedov wrote:
> > On Fri, 25 Aug 2017 19:45:38 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Aug 25, 2017 at 09:27:40AM +0200, Igor Mammedov wrote: =20
> > > > On Fri, 25 Aug 2017 11:38:19 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Thu, Aug 24, 2017 at 10:21:47AM +0200, Igor Mammedov wrote:   =
=20
> > > > > > PPC handles -cpu FOO rather incosistently,
> > > > > > i.e. it does case-insensitive matching of FOO to
> > > > > > a CPU type (see: ppc_cpu_compare_class_name) but
> > > > > > handles alias names as case-sensitive, as result:
> > > > > >=20
> > > > > >  # qemu-system-ppc64 -M mac99 -cpu g3
> > > > > >  qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'
> > > > > >=20
> > > > > >  # qemu-system-ppc64 -cpu 970MP_V1.1
> > > > > >  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
> > > > > >=20
> > > > > > while
> > > > > >=20
> > > > > >  # qemu-system-ppc64 -M mac99 -cpu G3
> > > > > >  # qemu-system-ppc64 -cpu 970MP_v1.1
> > > > > >=20
> > > > > > start up just fine.
> > > > > >=20
> > > > > > Considering we can't take case-insensitive matching away,
> > > > > > make it case-insensitive for  all alias/type/core_type
> > > > > > lookups.
> > > > > >=20
> > > > > > As side effect it allows to remove duplicate core types
> > > > > > which are the same but use lower-case letters in name.
> > > > > >=20
> > > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>     =20
> > > > >=20
> > > > > Hmm.  So, I'm certainly good with making the matching more consis=
tent,
> > > > > and removing extra entries differing only in case.
> > > > >=20
> > > > > However, I don't like capitalizing everything in the model table.=
  The
> > > > > "canonical" capitalization - as in how it appears in manuals and
> > > > > marketing info - is quite frequently mixed case.  So I think maki=
ng
> > > > > everything caps in the table will make it harder to read in the
> > > > > context of looking at the corresponding documentation.   =20
> > > > only cpu models =3D> typenames are made caps, the rest   =20
> > >=20
> > > Yes, I know.  A number of the CPU model names themselves have mixed
> > > case.  Really.
> > >  =20
> > > > incl. description is kept as is in mixed case.
> > > > It looks like _desc is the thing one would use for
> > > > 1:1 lookup in spec, while _name isn't direct match consistently
> > > > (i.e. sometimes it skips spaces and sometimes spaces are replaced b=
y underscore).
> > > > So keeping _name in mixed case unnecessarily complicates name->type=
 lookup.
> > > >=20
> > > > These mixed case + case-insensitive is what made lookup
> > > > code over-engineered and overly complex.   =20
> > >=20
> > > I'm fine with making all the lookups case insensitive.  I just don't
> > > want to drop the case on the names in the actual code. =20
> > I've tried to find a way but considering that names are statically
> > 'converted' into typenames and lack of ability to magically
> > uppercase them with preprocessor, I've gave up on this approach. =20
>=20
> Ok.
>=20
> > Providing that there is _desc with model name that should be
> > greppable in spec and complexity of lookup code that mixed-cased
> > typenames incur, I've opted in favor of simplifying lookup
> > code at expense uniform typenames (which is inter QEMU thingy).
> > It is easier to maintain and less chances to make mistake. =20
>=20
> Yeah, I guess.  It just looks weird to have non-standard capsing in
> the table field.
>=20
> Any chance we could standardize on lowercase rather than upper - for
> some reason that would seem less odd to me (I guess because C-ish
> names and identifiers are usually lowercased).
The only reason I've picked up uppercase is that diffstat is smaller
then with lowercase.
So if you prefer lowercase, I'll switch case in v2.
=20
[...]
