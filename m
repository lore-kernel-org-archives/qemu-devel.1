Received: from eggs.gnu.org ([2001:4830:134:3::10]:40043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTjUD-0001uV-Gn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTjKa-00056l-AT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:11:53 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gTjKa-00056Y-0f
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:11:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id f81so2204722wmd.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 00:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-4-marcandre.lureau@redhat.com>
	<87d0qj84al.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0qj84al.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Dec 2018 12:11:39 +0400
Message-ID: <CAJ+F1CLwTyjGGL7Wc+j-xj_RqHbMh+o3j00+zGZSHNdkQUrHRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] char: add a
 QEMU_CHAR_FEATURE_GCONTEXT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Dec 3, 2018 at 11:25 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> This one needs review by a chardev guy, with an eye on its use in the
> next patch.  Paolo?
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The feature should be set if the chardev is able to switch
> > GMainContext. Callers that want to put a chardev in a different thread
> > context can/should check this capabilities.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/chardev/char.h |  3 +++
> >  chardev/char.c         | 11 +++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index 7becd8c80c..014566c3de 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -47,6 +47,9 @@ typedef enum {
> >      QEMU_CHAR_FEATURE_FD_PASS,
> >      /* Whether replay or record mode is enabled */
> >      QEMU_CHAR_FEATURE_REPLAY,
> > +    /* Whether the gcontext can be changed after calling
> > +     * qemu_chr_be_update_read_handlers() */
> > +    QEMU_CHAR_FEATURE_GCONTEXT,
> >
> >      QEMU_CHAR_FEATURE_LAST,
> >  } ChardevFeature;
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 7f07a1bfbd..b5ee58b7d2 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -196,6 +196,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
> >      s->gcontext =3D context;
> >      if (cc->chr_update_read_handler) {
> >          cc->chr_update_read_handler(s);
> > +    } else if (s->gcontext) {
> > +        error_report("switching context isn't supported by this charde=
v");
>
> Code smell: error_report() without returning failure.
>
> If it's truly an error, then the function should fail.  We'd still need
> to decide how: error_report() and return -1, or error_setg().
>
> Except if it's a programming error; then we should assert().
>

After this patch, it's an error.
There should be a preliminary check for qemu_chr_has_feature(chr,
QEMU_CHAR_FEATURE_GCONTEXT) before switching context.

I'll replace the error_report() with an assert.

> If it's not an error, it's probably a warning, and we should use
> warn_report().
>
> >      }
> >  }
> >
> > @@ -240,6 +242,15 @@ static void char_init(Object *obj)
> >
> >      chr->logfd =3D -1;
> >      qemu_mutex_init(&chr->chr_write_lock);
> > +
> > +    /*
> > +     * Assume if chr_update_read_handler is implemented it will
> > +     * take the updated gcontext into account.
> > +     */
> > +    if (CHARDEV_GET_CLASS(chr)->chr_update_read_handler) {
> > +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT);
> > +    }
> > +
> >  }
> >
> >  static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
>


--=20
Marc-Andr=C3=A9 Lureau
