Received: from eggs.gnu.org ([2001:4830:134:3::10]:32920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvip-00081g-Vj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvii-0002eH-8B
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpvih-0002dy-VG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:15:44 -0400
Date: Thu, 7 Sep 2017 13:15:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907121534.GN2098@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-29-dgilbert@redhat.com>
	<CAJ+F1CLnEb-V4aTMThiC0pQqLFKY1JRGFxM9R6Cpq5kW_1Qb=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLnEb-V4aTMThiC0pQqLFKY1JRGFxM9R6Cpq5kW_1Qb=Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 28/32] postcopy: Allow shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Now that we have the mechanisms in here, allow shared memory in a
> > postcopy.
> >
> > Note that QEMU can't tell who all the users of shared regions are
> > and thus can't tell whether all the users of the shared regions
> > have appropriate support for postcopy.  Those devices that explicitly
> > support shared memory (e.g. vhost-user) must check, but it doesn't
> > stop weirder configurations causing problems.
> >
>=20
> Other users should have their own migration blocker, I guess.

Yes, the ones that know about it.
The tricky thing is you can add a shared=3Don to any memory object you
add; I don't know that the reason it's shared is purely because it's
used by vhost-user - for all qemu knows it could be shared with 5 other
things as well.

> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks.

Dave

>=20
>=20
> > ---
> >  migration/postcopy-ram.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 28791cf1f1..89c3aadda1 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -138,12 +138,6 @@ static int test_ramblock_postcopiable(const char=
 *block_name, void *host_addr,
> >      RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
> >      size_t pagesize =3D qemu_ram_pagesize(rb);
> >
> > -    if (qemu_ram_is_shared(rb)) {
> > -        error_report("Postcopy on shared RAM (%s) is not yet support=
ed",
> > -                     block_name);
> > -        return 1;
> > -    }
> > -
> >      if (length % pagesize) {
> >          error_report("Postcopy requires RAM blocks to be a page size=
 multiple,"
> >                       " block %s is 0x" RAM_ADDR_FMT " bytes with a "
> > --
> > 2.13.5
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
