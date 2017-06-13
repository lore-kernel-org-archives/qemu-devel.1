Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dKkOa-0000Vi-Mb
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dKkOX-0007CS-JQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:04 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com
	([40.107.1.101]:5571
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dKkOW-00077V-R2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:01 -0400
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
	<e7bb9020-99b1-bb6f-0bf4-1c5d20c692fa@virtuozzo.com>
	<CAJ+F1CLZmEPN-Jw3dZc64UnFFye29gyPaz+O=DHES6Vjh-hDHw@mail.gmail.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <180cb703-0d20-c167-c368-094c314f7126@virtuozzo.com>
Date: Tue, 13 Jun 2017 14:53:37 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLZmEPN-Jw3dZc64UnFFye29gyPaz+O=DHES6Vjh-hDHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/13] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com


On 06/09/2017 05:53 PM, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> On Thu, Jun 1, 2017 at 3:23 PM Anton Nefedov=20
> <anton.nefedov@virtuozzo.com <mailto:anton.nefedov@virtuozzo.com>> wrote:
>=20
>=20
>=20
>     On 05/31/2017 10:20 PM, Marc-Andr=C3=A9 Lureau wrote:
>      > Hi
>      >
>      > On Tue, May 30, 2017 at 6:12 PM Anton Nefedov
>      > <anton.nefedov@virtuozzo.com <mailto:anton.nefedov@virtuozzo.com>
>     <mailto:anton.nefedov@virtuozzo.com
>     <mailto:anton.nefedov@virtuozzo.com>>> wrote:
>      >
>      >     This patch adds a possibility to change a char device without
>     a frontend
>      >     removal.
>      >
>      >     1. Ideally, it would have to happen transparently to a
>     frontend, i.e.
>      >     frontend would continue its regular operation.
>      >     However, backends are not stateless and are set up by the
>     frontends
>      >     via qemu_chr_fe_<> functions, and it's not (generally)
>     possible to
>      >     replay
>      >     that setup entirely in a backend code, as different chardevs
>     respond
>      >     to the setup calls differently, so do frontends work
>     differently basing
>      >     on those setup responses.
>      >     Moreover, some frontend can generally get and save the
>     backend pointer
>      >     (qemu_chr_fe_get_driver()), and it will become invalid after
>     backend
>      >     change.
>      >
>      >     So, a frontend which would like to support chardev hotswap has=
 to
>      >     register
>      >     a "backend change" handler, and redo its backend setup there.
>      >
>      >     2. Write path can be used by multiple threads and thus
>     protected with
>      >     chr_write_lock.
>      >     So hotswap also has to be protected so write functions won't
>     access
>      >     a backend being replaced.
>      >
>      >
>      > Tbh, I don't understand the need for a different lock. Could you
>      > explain? Even better would be to write a test that shows in which =
way
>      > the lock helps.
>      >
>=20
>     hi Marc-Andr=C3=A9,
>=20
>     The existing chr_write_lock belongs to Chardev.
>     For the hotswap case, we need to ensure that be->chr won't change and
>     the old Chardev (together with its mutex) won't be destroyed while it=
's
>     used in the write functions.
>=20
>     Maybe we could move the lock to CharBackend, instead of creating a ne=
w
>     one. But I guess this
>        1. won't work for mux, where multiple CharBackends share the same
>     Chardev
>        2. won't work for some chardevs, like pty which uses the lock for =
the
>     timer handler
>=20
>     Sorry if I'm not explaining clearly enough or maybe I'm missing some
>     easier solution?
>=20
>=20
> It looks to me like you would get the same guarantees by using the=20
> chr_write_lock directly:
>=20
> @@ -1381,7 +1374,7 @@ ChardevReturn *qmp_chardev_change(const char *id,=20
> ChardevBackend *backend,
>           closed_sent =3D true;
>       }
>=20
> -    qemu_mutex_lock(&be->chr_lock);
> +    qemu_mutex_lock(&chr->chr_write_lock);
>       chr->be =3D NULL;
>       qemu_chr_fe_connect(be, chr_new, &error_abort);
>=20
> @@ -1389,14 +1382,14 @@ ChardevReturn *qmp_chardev_change(const char=20
> *id, ChardevBackend *backend,
>           error_setg(errp, "Chardev '%s' change failed", chr_new->label);
>           chr_new->be =3D NULL;
>           qemu_chr_fe_connect(be, chr, &error_abort);
> -        qemu_mutex_unlock(&be->chr_lock);
> +        qemu_mutex_unlock(&chr->chr_write_lock);
>           if (closed_sent) {
>               qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>           }
>           object_unref(OBJECT(chr_new));
>           return NULL;
>       }
> -    qemu_mutex_unlock(&be->chr_lock);
> +    qemu_mutex_unlock(&chr->chr_write_lock);
>=20
> I wonder if we should rename 'chr_write_lock' to just 'lock' :)
>=20

hi,

but isn't there a potential race?

Assume thread-1 is somewhere in qemu_chr_write() and thread-2 is in
qmp_chardev_change().

T2 can change the chardev, and destroy the old one while T1 still has
the pointer ( =3D use after free).
Or T1 unlocks chr_write_lock, T2 acquires that in
qemu_chr_write_buffer(), then T1 destroys it together
with the chardev ( =3D undefined behaviour).

What I'm trying to say is that the critical section for the hotswap is
bigger than what chr_write_lock currently covers - we also need to cover
the be->chr pointer.
Or am I missing something?


>     I can try to add a test but can't quite see yet how to freeze the old
>     chardev somewhere in cc->chr_write() and hotswap it while it's there.
>=20
>=20
>      >
>      >
>      >     Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com
>     <mailto:anton.nefedov@virtuozzo.com>
>      >     <mailto:anton.nefedov@virtuozzo.com
>     <mailto:anton.nefedov@virtuozzo.com>>>
>      >     Reviewed-by: Vladimir Sementsov-Ogievskiy
>     <vsementsov@virtuozzo.com <mailto:vsementsov@virtuozzo.com>
>      >     <mailto:vsementsov@virtuozzo.com
>     <mailto:vsementsov@virtuozzo.com>>>
>      >
>      >
>      > patch looks good otherwise
>      >
>      >     ---
>      >       chardev/char.c        | 126
>      >     ++++++++++++++++++++++++++++++++++++++++++++++----
>      >       include/sysemu/char.h |   9 ++++
>      >       qapi-schema.json      |  40 ++++++++++++++++
>      >       3 files changed, 165 insertions(+), 10 deletions(-)
>      >
>      > --
>      > Marc-Andr=C3=A9 Lureau
>=20
>     /Anton
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

/Anton
