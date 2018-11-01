Received: from eggs.gnu.org ([2001:4830:134:3::10]:57616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEho-00019U-O8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEhl-0008N6-Cw
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIEhl-0008Mv-3q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:16:17 -0400
Date: Thu, 1 Nov 2018 16:16:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101161612.0287cdb5@redhat.com>
In-Reply-To: <20181031202757.GE30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-11-marcandre.lureau@redhat.com>
	<20181031202757.GE30771@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, 31 Oct 2018 17:27:57 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 30, 2018 at 07:04:53PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > hostmem-file and hostmem-memfd use the whole object path for the
> > memory region name, and hostname-ram uses only the path component (the
> > object id, or canonical path basename):
> >=20
> > qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D=
/tmp/foo -numa node,memdev=3Dmem -monitor stdio
> > (qemu) info ramblock
> >               Block Name    PSize              Offset               Use=
d              Total
> >             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
> >=20
> > qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa node=
,memdev=3Dmem -monitor stdio
> > (qemu) info ramblock
> >               Block Name    PSize              Offset               Use=
d              Total
> >             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
> >=20
> > qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa node,m=
emdev=3Dmem -monitor stdio
> > (qemu) info ramblock
> >               Block Name    PSize              Offset               Use=
d              Total
> >                      mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
> >=20
> > Use the object id for -file and -memfd with >=3D 3.1 for consistency.
> > Having a consistent naming allow to migrate to different hostmem
> > backends.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =20
>=20
> I don't want to make you feel like you wasted your time on the
> global property system refactor, but:
>=20
> Maybe it would be simpler to add a
>   bool MachineClass::canonical_path_for_ramblock_id
I dislike adding compat flags in random places in this case=20
it has nothing to do with machine.

> field, instead of refactoring the global property system,
> considering that we're past soft freeze?
We can merge it for 3.2,
I have another potential usage for Mark's work,
converting initial memory to memory devices (so far only ARM),
where we would need to keep ramblock id's compatible across
different machine versions and a different way we were creating
initial memory memory regions so migration would not fail.

> Sometimes I think the global property system was a mistake, and
> that we should avoid spreading it to other subsystems.
Well user accessible globals might be a mistake,
but it's quite useful/convenient API to fix compatibility parameters
for different machines/versions in uniform way without hacking
unrelated code.
