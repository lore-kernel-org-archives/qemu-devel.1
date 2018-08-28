Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuhGl-0005ZY-P3
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuhGe-0001Iq-3K
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:55:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fuhGb-0001DC-7Q
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:54:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id k5-v6so2222370wre.10
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 09:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180828153840.22519-1-marcandre.lureau@redhat.com>
	<20180828184312.6e0e417d@redhat.com>
In-Reply-To: <20180828184312.6e0e417d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 18:54:40 +0200
Message-ID: <CAJ+F1CLvye1F9xKskpPiogeTU+54+=Lurg3qX4cYpq1=r5sNaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Aug 28, 2018 at 6:49 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 28 Aug 2018 17:38:40 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > The share=3Don/off property is used to modified mmap() MAP_SHARED
> > setting. Make it on by default for convenience and compatibility
> > reasons.
> it would be nice to state reasons here.
>
> also flipping default to on is behavioral change when
> used with bind policy which could make backend initialization fail
> so CLI that used to work (if there are any users of this without shared=
=3Don)
> won't work anymore.

memfd backend is passing shared=3Dtrue to memory_region_init_ram_from_fd().

The patch allows to tweak that (instead of ignoring the property),
while keeping the value to shared=3Dtrue.

>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  backends/hostmem-memfd.c | 4 +++-
> >  qemu-options.hx          | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index 1e20fe0ba8..abd52364db 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend=
, Error **errp)
> >
> >      name =3D object_get_canonical_path(OBJECT(backend));
> >      memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
> > -                                   name, backend->size, true, fd, errp=
);
> > +                                   name, backend->size,
> > +                                   backend->share, fd, errp);
> >      g_free(name);
> >  }
> >
> > @@ -131,6 +132,7 @@ memfd_backend_instance_init(Object *obj)
> >
> >      /* default to sealed file */
> >      m->seal =3D true;
> > +    MEMORY_BACKEND(m)->share =3D true;
> >  }
> >
> >  static void
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index f14e423b7c..25c02d72b8 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4029,7 +4029,7 @@ Memory backend objects offer more control than th=
e @option{-m} option that is
> >  traditionally used to define guest RAM. Please refer to
> >  @option{memory-backend-file} for a description of the options.
> >
> > -@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},=
dump=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-nodes=3D=
@var{host-nodes},policy=3D@var{default|preferred|bind|interleave},seal=3D@v=
ar{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
> > +@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},=
dump=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@va=
r{size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred|bind|=
interleave},seal=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{s=
ize}
> >
> >  Creates an anonymous memory file backend object, which allows QEMU to
> >  share the memory with an external process (e.g. when using
> > @@ -4051,6 +4051,8 @@ with the @option{seal} option (requires at least =
Linux 4.16).
> >  Please refer to @option{memory-backend-file} for a description of the
> >  other options.
> >
> > +The @option{share} boolean option is @var{on} by default with memfd.
> > +
> >  @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
> >
> >  Creates a random number generator backend which obtains entropy from
>
>


--=20
Marc-Andr=C3=A9 Lureau
