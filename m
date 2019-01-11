Received: from eggs.gnu.org ([209.51.188.92]:48164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi3px-0002bx-5D
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi3pv-0006Jd-Fz
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:55:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gi3pv-0006Cr-3P
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:55:27 -0500
Date: Fri, 11 Jan 2019 18:55:16 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190111205516.GR4500@habkost.net>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110201124.GJ2589@work-vm>
	<2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 06:49:53PM +0300, Yury Kotov wrote:
> 10.01.2019, 23:12, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >>  Hi,
> >>
> >>  The series adds migration capability which allows to skip 'external=
' RAM blocks
> >>  during migration. External block is a RAMBlock which available from=
 the outside
> >>  of current QEMU process (e.g. file in /dev/shm). It's useful for fa=
st local
> >>  migration to update QEMU for the running guests.
> >
> > Hi Yury,
> >   There have been a few similar patch series around from people wanti=
ng
> > to do similar things.
> >   In particular Lai Jiangshan's https://lists.nongnu.org/archive/html=
/qemu-devel/2018-03/msg07511.html
> > and C=E9dric Le Goater wanted to skip regions for a different reason.
> >
> >   We merged some of C=E9dric's code last year so that we now
> > have the qemu_ram_is_migratable() function - and we should be reusing
> > that to skip things rather than adding a new check that we have to ad=
d
> > everywhere.
> >
>=20
> I didn't see the series, so I'll check it, thanks!
> But I saw qemu_ram_is_migratable() function and corresponding patch.
> It's very close to my needs, but it works a bit different IIUC:
> 1. Not migratable blocks isn't validated (existence and size) during mi=
gration,
> 2. "Migratable" state is determined during the block creation time.
>    Such case isn't valid because of it:
>    * Source has one migratable and one not migratable RAM blocks,
>    * Target has the same (idstr) blocks, but both are not migratable.
>    Thus, target will not expect pages for not migratable blocks.
>=20
> >   Also, ypu're skipping 'external' things, I think the other suggesti=
on
> > was to skip 'shared' things (i.e. anything with share=3D0); skipping
> > share=3Don cases sounds easier to me.
>=20
> I agree that introducing new term is a complication, but 'share' and 'e=
xternal'
> terms have important differences (I'll describe it below).
>=20
> Just to clarify:
> * 'share' means that other processes has an access to such memory,
> * 'external' means file backed memory.

If you use file backed memory with share=3Doff, writes are not
propagated to the file (they are mapped with MAP_PRIVATE).  Would
you really want to skip file backed memory if it has share=3Doff?

>=20
> There is another use case I wanted to support (I had to write about it =
in
> the cover letter, sorry..):
> 1. Migrate source VM to file and kill source,
> 2. Start target VM and migrate it from file.
> In such case source VM may have memory-backend-ram with share=3Doff, it=
's ok.
>=20
> Thus, in the new migration capability I want to migrate memory that mee=
ts
> three conditions:
> 1. The source will not use the memory after migration ends,
> 2. The source may exit before target starts (migrate to file),
> 3. The target has an access to the memory.
>=20
> I think 'external' fits them better than 'share'.
>=20

In either case, defining "external" seems tricky.  A memory
region might be backed by a file on tmpfs or hugetlbfs that was
deleted, which makes the file "internal" for practical purposes.
QEMU has no way to tell if (3) is really true.

--=20
Eduardo
