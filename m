Received: from eggs.gnu.org ([208.118.235.92]:34394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuwFV-0001LI-CP
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuwB2-0002Tc-IT
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:50:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fuwB2-0002RS-CC
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:50:12 -0400
Date: Wed, 29 Aug 2018 10:50:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180829105009.07e5255f@redhat.com>
In-Reply-To: <CAJ+F1C+7zis5wmV_V9MuL5bMvPp9CnCuUrg_yQgQuYM3p_3xxA@mail.gmail.com>
References: <20180828153840.22519-1-marcandre.lureau@redhat.com>
	<20180828184312.6e0e417d@redhat.com>
	<CAJ+F1CLvye1F9xKskpPiogeTU+54+=Lurg3qX4cYpq1=r5sNaQ@mail.gmail.com>
	<CAJ+F1C+7zis5wmV_V9MuL5bMvPp9CnCuUrg_yQgQuYM3p_3xxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hostmem-memfd: honour share=on/off property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, 28 Aug 2018 18:55:35 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Tue, Aug 28, 2018 at 6:54 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Tue, Aug 28, 2018 at 6:49 PM Igor Mammedov <imammedo@redhat.com> wro=
te: =20
> > >
> > > On Tue, 28 Aug 2018 17:38:40 +0200
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > =20
> > > > The share=3Don/off property is used to modified mmap() MAP_SHARED
> > > > setting. Make it on by default for convenience and compatibility
> > > > reasons. =20
> > > it would be nice to state reasons here.
> > >
> > > also flipping default to on is behavioral change when
> > > used with bind policy which could make backend initialization fail
> > > so CLI that used to work (if there are any users of this without shar=
ed=3Don)
> > > won't work anymore. =20
> >
> > memfd backend is passing shared=3Dtrue to memory_region_init_ram_from_f=
d().
> >
> > The patch allows to tweak that (instead of ignoring the property),
> > while keeping the value to shared=3Dtrue. =20
>=20
> keeping the default value to shared=3Dtrrue.
ok,
another question:
 does it make sense to allow "shared=3Dfalse" at all?
 should we bail out if user asks for it?

>=20
> > =20
> > > =20
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  backends/hostmem-memfd.c | 4 +++-
> > > >  qemu-options.hx          | 4 +++-
> > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > > > index 1e20fe0ba8..abd52364db 100644
> > > > --- a/backends/hostmem-memfd.c
> > > > +++ b/backends/hostmem-memfd.c
> > > > @@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *bac=
kend, Error **errp)
> > > >
> > > >      name =3D object_get_canonical_path(OBJECT(backend));
> > > >      memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
> > > > -                                   name, backend->size, true, fd, =
errp);
> > > > +                                   name, backend->size,
> > > > +                                   backend->share, fd, errp);
> > > >      g_free(name);
> > > >  }
> > > >
> > > > @@ -131,6 +132,7 @@ memfd_backend_instance_init(Object *obj)
> > > >
> > > >      /* default to sealed file */
> > > >      m->seal =3D true;
> > > > +    MEMORY_BACKEND(m)->share =3D true;
> > > >  }
> > > >
> > > >  static void
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index f14e423b7c..25c02d72b8 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -4029,7 +4029,7 @@ Memory backend objects offer more control tha=
n the @option{-m} option that is
> > > >  traditionally used to define guest RAM. Please refer to
> > > >  @option{memory-backend-file} for a description of the options.
> > > >
> > > > -@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|o=
ff},dump=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-node=
s=3D@var{host-nodes},policy=3D@var{default|preferred|bind|interleave},seal=
=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
> > > > +@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|o=
ff},dump=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=
=3D@var{size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred=
|bind|interleave},seal=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D=
@var{size}
> > > >
> > > >  Creates an anonymous memory file backend object, which allows QEMU=
 to
> > > >  share the memory with an external process (e.g. when using
> > > > @@ -4051,6 +4051,8 @@ with the @option{seal} option (requires at le=
ast Linux 4.16).
> > > >  Please refer to @option{memory-backend-file} for a description of =
the
> > > >  other options.
> > > >
> > > > +The @option{share} boolean option is @var{on} by default with memf=
d.
> > > > +
> > > >  @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
> > > >
> > > >  Creates a random number generator backend which obtains entropy fr=
om =20
> > >
> > > =20
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau =20
>=20
>=20
>=20
