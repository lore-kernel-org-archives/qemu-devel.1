Received: from eggs.gnu.org ([2001:4830:134:3::10]:55535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5zg-0000pd-Hw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5zf-0005VD-LV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:46:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gH5zf-0005Tk-Dw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:46:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id i17-v6so8270238wre.7
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
	<20181009131251.721-4-marcandre.lureau@redhat.com>
	<20181010035411.GN18728@xz-x1>
In-Reply-To: <20181010035411.GN18728@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Oct 2018 15:45:49 +0400
Message-ID: <CAJ+F1C+yWsqN0A8575Fu=rfz7xrZZ6MY0+qog=kAFpApWXHfbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] char: add a QEMU_CHAR_FEATURE_GCONTEXT
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Oct 10, 2018 at 7:54 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 05:12:48PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > The feature should be set if the chardev is able to switch
> > GMainContext. Callers that want to put a chardev in a different thread
> > context can/should check this capabilities.
>
> IIRC we've had some discussion about whether we should allow to
> dynamically switch context for chardevs, and a (temporarily)
> conclusion is that we'd prefer to forbidden it for simplicity
> (although it's still allowed in current master).  Does this patch mean
> that we'd still want to allow that for some future scenarios?

Currently, the API let you change context dynamically, although doing
it safely is left for the caller to handle. And it's not guarantee to
work with all backends: some chardev don't simply allow you to use a
different gcontext, this is what this flag should be about.

The flag may become obsolete if we change the API to restrict setting
context at creation time. For now, I think we should consider this
patch and the following one.

thanks

>
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
> > index e115166995..fa1b74e0d9 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -196,6 +196,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
> >      s->gcontext =3D context;
> >      if (cc->chr_update_read_handler) {
> >          cc->chr_update_read_handler(s);
> > +    } else if (s->gcontext) {
> > +        error_report("switching context isn't supported by this charde=
v");
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
> > --
> > 2.19.0.271.gfe8321ec05
> >
>
> Regards,
>
> --
> Peter Xu
>


--=20
Marc-Andr=C3=A9 Lureau
