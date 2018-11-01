Received: from eggs.gnu.org ([2001:4830:134:3::10]:35113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gIEx1-0005r1-Ec
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gIEww-0002vH-CJ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gIEwv-0002uw-Vw
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:31:58 -0400
Date: Thu, 1 Nov 2018 12:31:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181101153147.GA3902@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-11-marcandre.lureau@redhat.com>
	<20181031202757.GE30771@habkost.net>
	<20181101161612.0287cdb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181101161612.0287cdb5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/10] hostmem: use object id for memory
 region name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 01, 2018 at 04:16:12PM +0100, Igor Mammedov wrote:
> On Wed, 31 Oct 2018 17:27:57 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Oct 30, 2018 at 07:04:53PM +0400, Marc-Andr=E9 Lureau wrote:
> > > hostmem-file and hostmem-memfd use the whole object path for the
> > > memory region name, and hostname-ram uses only the path component (=
the
> > > object id, or canonical path basename):
> > >=20
> > > qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-pat=
h=3D/tmp/foo -numa node,memdev=3Dmem -monitor stdio
> > > (qemu) info ramblock
> > >               Block Name    PSize              Offset              =
 Used              Total
> > >             /objects/mem    4 KiB  0x0000000000000000 0x00000000400=
00000 0x0000000040000000
> > >=20
> > > qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa =
node,memdev=3Dmem -monitor stdio
> > > (qemu) info ramblock
> > >               Block Name    PSize              Offset              =
 Used              Total
> > >             /objects/mem    4 KiB  0x0000000000000000 0x00000000400=
00000 0x0000000040000000
> > >=20
> > > qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa no=
de,memdev=3Dmem -monitor stdio
> > > (qemu) info ramblock
> > >               Block Name    PSize              Offset              =
 Used              Total
> > >                      mem    4 KiB  0x0000000000000000 0x00000000400=
00000 0x0000000040000000
> > >=20
> > > Use the object id for -file and -memfd with >=3D 3.1 for consistenc=
y.
> > > Having a consistent naming allow to migrate to different hostmem
> > > backends.
> > >=20
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> =20
> >=20
> > I don't want to make you feel like you wasted your time on the
> > global property system refactor, but:
> >=20
> > Maybe it would be simpler to add a
> >   bool MachineClass::canonical_path_for_ramblock_id
> I dislike adding compat flags in random places in this case=20
> it has nothing to do with machine.

I don't see why it would be a problem.  If you really believe
this compat flag doesn't belong to a MachineClass field, it would
not belong to MachineClass::compat_props either.


>=20
> > field, instead of refactoring the global property system,
> > considering that we're past soft freeze?
> We can merge it for 3.2,
> I have another potential usage for Mark's work,
> converting initial memory to memory devices (so far only ARM),
> where we would need to keep ramblock id's compatible across
> different machine versions and a different way we were creating
> initial memory memory regions so migration would not fail.

Right, so allowing backend objects to be affected by
MachineClass::compat_props would be nice to have, long term.

>=20
> > Sometimes I think the global property system was a mistake, and
> > that we should avoid spreading it to other subsystems.
> Well user accessible globals might be a mistake,
> but it's quite useful/convenient API to fix compatibility parameters
> for different machines/versions in uniform way without hacking
> unrelated code.

Agreed.  Having compat_props is nice.  Mixing -global and
MachineClass::compat_props was a mistake, and I want to revert
that.  See the suggestion on the reply to 05/10 on how we could
do this.

--=20
Eduardo
