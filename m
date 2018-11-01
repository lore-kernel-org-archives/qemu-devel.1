Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gICAZ-0004B0-MA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gICAU-0002Ra-JF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gICAU-0002DH-6k
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:33:46 -0400
Date: Thu, 1 Nov 2018 13:33:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101133313.533f7834@redhat.com>
In-Reply-To: <CAJ+F1CKE56kB+RokaNBwy1zB=xEeo-UaXgqp2-poMsprzY9Osw@mail.gmail.com>
References: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
	<CAJ+F1CKE56kB+RokaNBwy1zB=xEeo-UaXgqp2-poMsprzY9Osw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, 1 Nov 2018 15:02:04 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Thu, Nov 1, 2018 at 2:53 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > object_new() returns a new backend with refcount =3D=3D 1 and
> > then later object_property_add_child() increases refcount to 2
> > So when ivshmem is desroyed, the backend it has created isn't
> > destroyed along with it as children cleanup will bring
> > backend's refcount only to 1, which leaks backend including
> > resources it is using.
> >
> > Drop the original reference from object_new() once backend
> > is attached to its parent.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
> I would rather have the unref in finalize, but that is ok too.
I followed the pattern we use else where, i.e. drop reference
as soon as we set the parent (virtio-rng/cpus) within the same
scope as object_new().

There is no point in keeping reference until finalize time since
backend is kept alive as child and is destroyed well after all
nonexistent ivshmem::unrealize/finilize() are finished when generic
Object is being destroyed.

>  Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> > ---
> >  hw/misc/ivshmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> > index f88910e..ecfd10a 100644
> > --- a/hw/misc/ivshmem.c
> > +++ b/hw/misc/ivshmem.c
> > @@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
> >      object_property_set_bool(obj, true, "share", &error_abort);
> >      object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
> >                                &error_abort);
> > +    object_unref(obj);
> >      user_creatable_complete(obj, &error_abort);
> >      s->hostmem =3D MEMORY_BACKEND(obj);
> >  }
> > --
> > 2.7.4
> >
> > =20
>=20
>=20
