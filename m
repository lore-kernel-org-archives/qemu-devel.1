Received: from eggs.gnu.org ([2001:4830:134:3::10]:59631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEoI-0005uh-1X
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEoE-00048b-6G
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIEoC-00045R-8N
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B5DB307D861
	for <qemu-devel@nongnu.org>; Thu,  1 Nov 2018 15:22:54 +0000 (UTC)
Date: Thu, 1 Nov 2018 16:22:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101162245.3ce42fba@redhat.com>
In-Reply-To: <6cdf543e-77b2-ea7f-f0b8-f9da4384bd94@redhat.com>
References: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
	<6cdf543e-77b2-ea7f-f0b8-f9da4384bd94@redhat.com>
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

On Thu, 1 Nov 2018 15:27:02 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/11/18 11:44, Igor Mammedov wrote:
> > object_new() returns a new backend with refcount =3D=3D 1 and
> > then later object_property_add_child() increases refcount to 2
> > So when ivshmem is desroyed, the backend it has created isn't =20
>=20
>                       ^ "destroyed"
Thanks, fixed in v2

>=20
> > destroyed along with it as children cleanup will bring
> > backend's refcount only to 1, which leaks backend including
> > resources it is using.
> >=20
> > Drop the original reference from object_new() once backend
> > is attached to its parent.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   hw/misc/ivshmem.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> > index f88910e..ecfd10a 100644
> > --- a/hw/misc/ivshmem.c
> > +++ b/hw/misc/ivshmem.c
> > @@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
> >       object_property_set_bool(obj, true, "share", &error_abort);
> >       object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
> >                                 &error_abort);
> > +    object_unref(obj);
> >       user_creatable_complete(obj, &error_abort);
> >       s->hostmem =3D MEMORY_BACKEND(obj);
> >   }
> >  =20
>=20
