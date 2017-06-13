Received: from eggs.gnu.org ([2001:4830:134:3::10]:35750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKkzh-0006cG-CX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKkzd-0002hn-1b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:32:25 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dKkzc-0002hV-Lz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:32:20 -0400
Received: by mail-lf0-x229.google.com with SMTP id p189so69773804lfe.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 05:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
	<e7bb9020-99b1-bb6f-0bf4-1c5d20c692fa@virtuozzo.com>
	<CAJ+F1CLZmEPN-Jw3dZc64UnFFye29gyPaz+O=DHES6Vjh-hDHw@mail.gmail.com>
	<180cb703-0d20-c167-c368-094c314f7126@virtuozzo.com>
In-Reply-To: <180cb703-0d20-c167-c368-094c314f7126@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jun 2017 12:32:08 +0000
Message-ID: <CAJ+F1C+RERi==AHy4n9JMyV+=joMBZzWr23mvAkrrb3wqynXwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

Hi

On Tue, Jun 13, 2017 at 3:53 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> >     The existing chr_write_lock belongs to Chardev.
> >     For the hotswap case, we need to ensure that be->chr won't change a=
nd
> >     the old Chardev (together with its mutex) won't be destroyed while
> it's
> >     used in the write functions.
> >
> >     Maybe we could move the lock to CharBackend, instead of creating a
> new
> >     one. But I guess this
> >        1. won't work for mux, where multiple CharBackends share the sam=
e
> >     Chardev
> >        2. won't work for some chardevs, like pty which uses the lock fo=
r
> the
> >     timer handler
> >
> >     Sorry if I'm not explaining clearly enough or maybe I'm missing som=
e
> >     easier solution?
> >
> >
> > It looks to me like you would get the same guarantees by using the
> > chr_write_lock directly:
> >
> > @@ -1381,7 +1374,7 @@ ChardevReturn *qmp_chardev_change(const char *id,
> > ChardevBackend *backend,
> >           closed_sent =3D true;
> >       }
> >
> > -    qemu_mutex_lock(&be->chr_lock);
> > +    qemu_mutex_lock(&chr->chr_write_lock);
> >       chr->be =3D NULL;
> >       qemu_chr_fe_connect(be, chr_new, &error_abort);
> >
> > @@ -1389,14 +1382,14 @@ ChardevReturn *qmp_chardev_change(const char
> > *id, ChardevBackend *backend,
> >           error_setg(errp, "Chardev '%s' change failed", chr_new->label=
);
> >           chr_new->be =3D NULL;
> >           qemu_chr_fe_connect(be, chr, &error_abort);
> > -        qemu_mutex_unlock(&be->chr_lock);
> > +        qemu_mutex_unlock(&chr->chr_write_lock);
> >           if (closed_sent) {
> >               qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> >           }
> >           object_unref(OBJECT(chr_new));
> >           return NULL;
> >       }
> > -    qemu_mutex_unlock(&be->chr_lock);
> > +    qemu_mutex_unlock(&chr->chr_write_lock);
> >
> > I wonder if we should rename 'chr_write_lock' to just 'lock' :)
> >
>
> hi,
>
> but isn't there a potential race?
>
> Assume thread-1 is somewhere in qemu_chr_write() and thread-2 is in
> qmp_chardev_change().
>
> T2 can change the chardev, and destroy the old one while T1 still has
> the pointer ( =3D use after free).
> Or T1 unlocks chr_write_lock, T2 acquires that in
> qemu_chr_write_buffer(), then T1 destroys it together
> with the chardev ( =3D undefined behaviour).
>

> What I'm trying to say is that the critical section for the hotswap is
> bigger than what chr_write_lock currently covers - we also need to cover
> the be->chr pointer.
> Or am I missing something?
>

Thanks for the detail, I think you are correct, and probably your solution
is good. Another way would be to object_ref/unref the Chardev when using it
in seperate thread, this way we wouldn't need an extra lock, I think. Paolo
might be of good advice to get this right.


--=20
Marc-Andr=C3=A9 Lureau
