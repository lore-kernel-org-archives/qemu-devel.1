Received: from eggs.gnu.org ([2001:4830:134:3::10]:39789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRc2Y-0005AJ-Qx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRc2X-0004y2-RN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:00:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gRc2X-0004xK-K6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:00:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id j207so14463701wmj.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 04:00:29 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-2-i.maximets@samsung.com>
	<CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
	<78f31962-8d54-19c1-e8fb-c21f95a491f0@samsung.com>
In-Reply-To: <78f31962-8d54-19c1-e8fb-c21f95a491f0@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Nov 2018 16:00:16 +0400
Message-ID: <CAJ+F1C+XFs++Q044Y8CvVYFhtNpaEDS8qjx0BjsJN1yukZURkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] hostmem-memfd: enable seals only if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi
On Tue, Nov 27, 2018 at 3:56 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> On 27.11.2018 14:49, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> > On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung.com> =
wrote:
> >>
> >> If seals are not supported, memfd_create() will fail.
> >> Furthermore, there is no way to disable it in this case because
> >> '.seal' property is not registered.
> >>
> >> This issue leads to vhost-user-test failures on RHEL 7.2:
> >>
> >>   qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,=
: \
> >>                       failed to create memfd: Invalid argument
> >>
> >> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> >
> >
> > This will change the default behaviour of memfd backend, and may thus
> > me considered a break.
>
> This will change the default behaviour only on systems without sealing
> support. But current implementation is broken there anyway and does not
> work.
>
> >
> > Instead, memfd vhost-user-test should skipped (or tuned with
> > sealed=3Dfalse if unsupported)
>
> vhost-user-test is just an example here. In fact memfd could not be
> used at all on system without sealing support. And there is no way
> to disable seals.

which system supports memfd without sealing?

>
> >
> >> ---
> >>  backends/hostmem-memfd.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> >> index b6836b28e5..ee39bdbde6 100644
> >> --- a/backends/hostmem-memfd.c
> >> +++ b/backends/hostmem-memfd.c
> >> @@ -129,8 +129,8 @@ memfd_backend_instance_init(Object *obj)
> >>  {
> >>      HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
> >>
> >> -    /* default to sealed file */
> >> -    m->seal =3D true;
> >> +    /* default to sealed file if supported */
> >> +    m->seal =3D qemu_memfd_check(MFD_ALLOW_SEALING);
> >>  }
> >>
> >>  static void
> >> --
> >> 2.17.1
> >>
> >
> >
>


--=20
Marc-Andr=C3=A9 Lureau
