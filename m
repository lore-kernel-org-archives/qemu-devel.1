Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dLVMk-0003K0-GU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dLVMh-0006Lp-Ch
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:03:18 -0400
Received: from mail-eopbgr20138.outbound.protection.outlook.com
	([40.107.2.138]:45124
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dLVMg-0006Jn-Oq
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:03:15 -0400
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
	<e7bb9020-99b1-bb6f-0bf4-1c5d20c692fa@virtuozzo.com>
	<CAJ+F1CLZmEPN-Jw3dZc64UnFFye29gyPaz+O=DHES6Vjh-hDHw@mail.gmail.com>
	<180cb703-0d20-c167-c368-094c314f7126@virtuozzo.com>
	<CAJ+F1C+RERi==AHy4n9JMyV+=joMBZzWr23mvAkrrb3wqynXwA@mail.gmail.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <2e6da3c3-252e-fe21-332c-a435e0282caa@virtuozzo.com>
Date: Thu, 15 Jun 2017 17:03:06 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+RERi==AHy4n9JMyV+=joMBZzWr23mvAkrrb3wqynXwA@mail.gmail.com>
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



On 06/13/2017 03:32 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jun 13, 2017 at 3:53 PM Anton Nefedov=20
> <anton.nefedov@virtuozzo.com <mailto:anton.nefedov@virtuozzo.com>> wrote:
>=20
>      >     The existing chr_write_lock belongs to Chardev.
>      >     For the hotswap case, we need to ensure that be->chr won't
>     change and
>      >     the old Chardev (together with its mutex) won't be destroyed
>     while it's
>      >     used in the write functions.
>      >
>      >     Maybe we could move the lock to CharBackend, instead of
>     creating a new
>      >     one. But I guess this
>      >        1. won't work for mux, where multiple CharBackends share
>     the same
>      >     Chardev
>      >        2. won't work for some chardevs, like pty which uses the
>     lock for the
>      >     timer handler
>      >
>      >     Sorry if I'm not explaining clearly enough or maybe I'm
>     missing some
>      >     easier solution?
>      >
>      >
>      > It looks to me like you would get the same guarantees by using the
>      > chr_write_lock directly:
>      >
>      > @@ -1381,7 +1374,7 @@ ChardevReturn *qmp_chardev_change(const
>     char *id,
>      > ChardevBackend *backend,
>      >           closed_sent =3D true;
>      >       }
>      >
>      > -    qemu_mutex_lock(&be->chr_lock);
>      > +    qemu_mutex_lock(&chr->chr_write_lock);
>      >       chr->be =3D NULL;
>      >       qemu_chr_fe_connect(be, chr_new, &error_abort);
>      >
>      > @@ -1389,14 +1382,14 @@ ChardevReturn *qmp_chardev_change(const ch=
ar
>      > *id, ChardevBackend *backend,
>      >           error_setg(errp, "Chardev '%s' change failed",
>     chr_new->label);
>      >           chr_new->be =3D NULL;
>      >           qemu_chr_fe_connect(be, chr, &error_abort);
>      > -        qemu_mutex_unlock(&be->chr_lock);
>      > +        qemu_mutex_unlock(&chr->chr_write_lock);
>      >           if (closed_sent) {
>      >               qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      >           }
>      >           object_unref(OBJECT(chr_new));
>      >           return NULL;
>      >       }
>      > -    qemu_mutex_unlock(&be->chr_lock);
>      > +    qemu_mutex_unlock(&chr->chr_write_lock);
>      >
>      > I wonder if we should rename 'chr_write_lock' to just 'lock' :)
>      >
>=20
>     hi,
>=20
>     but isn't there a potential race?
>=20
>     Assume thread-1 is somewhere in qemu_chr_write() and thread-2 is in
>     qmp_chardev_change().
>=20
>     T2 can change the chardev, and destroy the old one while T1 still has
>     the pointer ( =3D use after free).
>     Or T1 unlocks chr_write_lock, T2 acquires that in
>     qemu_chr_write_buffer(), then T1 destroys it together
>     with the chardev ( =3D undefined behaviour).
>=20
>=20
>     What I'm trying to say is that the critical section for the hotswap i=
s
>     bigger than what chr_write_lock currently covers - we also need to co=
ver
>     the be->chr pointer.
>     Or am I missing something?
>=20
>=20
> Thanks for the detail, I think you are correct, and probably your=20
> solution is good. Another way would be to object_ref/unref the Chardev=20
> when using it in seperate thread, this way we wouldn't need an extra=20
> lock, I think. Paolo might be of good advice to get this right.
>=20

We also need to protect be->chr pointer, not just the Chardev itself, so
probably ref/unref won't be thread-safe, strictly speaking?

e.g.

   fe_write(CharBackend *be) {
     ref(be->chr);
     ...
     unref(be->chr); // oops, be->chr might have changed
   }

or

   fe_write(CharBackend *be) {
     Chardev *chr =3D be->chr;
     ref(chr); // not good either, chr might be destroyed already
     ...
     unref(chr);
   }


>=20
> --=20
> Marc-Andr=C3=A9 Lureau
/Anton
