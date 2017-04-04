Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cvRMh-0004IR-Sn
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cvRMe-00073f-Po
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cvRMe-000734-Ha
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:31:28 -0400
Date: Tue, 4 Apr 2017 12:31:24 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1383568703.20466358.1491323484821.JavaMail.zimbra@redhat.com>
In-Reply-To: <1b1cce3c-5a0c-13a2-413a-e96cf08a6b7a@amsat.org>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-3-marcandre.lureau@redhat.com>
	<1b1cce3c-5a0c-13a2-413a-e96cf08a6b7a@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/21] mux: simplfy muxes_realize_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Hi Philippe

----- Original Message -----
> Hi Marc-Andr=C3=A9,
>=20
> On 03/16/2017 06:21 AM, Marc-Andr=C3=A9 Lureau wrote:
> > mux_chr_event() already send events to all backends, rename it,
> > export it, and use it from muxes_realize_done. This should help abstrac=
t
> > away mux implementation.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  chardev/char-mux.h |  2 +-
> >  chardev/char-mux.c | 11 ++++++++---
> >  chardev/char.c     |  9 ++-------
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/chardev/char-mux.h b/chardev/char-mux.h
> > index 9a2fffce91..3f41dfcfd2 100644
> > --- a/chardev/char-mux.h
> > +++ b/chardev/char-mux.h
> > @@ -58,6 +58,6 @@ typedef struct MuxChardev {
> >
> >  void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
> >  void mux_set_focus(Chardev *chr, int focus);
> > -void mux_chr_send_event(MuxChardev *d, int mux_nr, int event);
> > +void mux_chr_send_all_event(Chardev *chr, int event);
> >
> >  #endif /* CHAR_MUX_H */
> > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > index 5547a36a0a..37d42c65c6 100644
> > --- a/chardev/char-mux.c
> > +++ b/chardev/char-mux.c
> > @@ -114,7 +114,7 @@ static void mux_print_help(Chardev *chr)
> >      }
> >  }
> >
> > -void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
> > +static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
> >  {
> >      CharBackend *be =3D d->backends[mux_nr];
> >
> > @@ -222,9 +222,9 @@ static void mux_chr_read(void *opaque, const uint8_=
t
> > *buf, int size)
> >
> >  bool muxes_realized;
> >
> > -static void mux_chr_event(void *opaque, int event)
> > +void mux_chr_send_all_event(Chardev *chr, int event)
> >  {
> > -    MuxChardev *d =3D MUX_CHARDEV(opaque);
> > +    MuxChardev *d =3D MUX_CHARDEV(chr);
> >      int i;
> >
> >      if (!muxes_realized) {
> > @@ -237,6 +237,11 @@ static void mux_chr_event(void *opaque, int event)
> >      }
> >  }
> >
> > +static void mux_chr_event(void *opaque, int event)
>=20
> Why use an opaque pointer and not Chardev *chr here? Not a big deal but
> it eases debugging sessions.
> Anyway it'll be correctly displayed single-stepping in :)

It's the signature of IOEventHandler, avoiding casting.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> > +{
> > +    mux_chr_send_all_event(CHARDEV(opaque), event);
> > +}
> > +
> >  static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
> >  {
> >      MuxChardev *d =3D MUX_CHARDEV(s);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index aad639b620..674c097fbe 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -451,22 +451,17 @@ static void muxes_realize_done(Notifier *notifier=
,
> > void *unused)
> >  {
> >      Chardev *chr;
> >
> > +    muxes_realized =3D true;
> >      QTAILQ_FOREACH(chr, &chardevs, next) {
> >          if (CHARDEV_IS_MUX(chr)) {
> > -            MuxChardev *d =3D MUX_CHARDEV(chr);
> > -            int i;
> > -
> >              /* send OPENED to all already-attached FEs */
> > -            for (i =3D 0; i < d->mux_cnt; i++) {
> > -                mux_chr_send_event(d, i, CHR_EVENT_OPENED);
> > -            }
> > +            mux_chr_send_all_event(CHARDEV(chr), CHR_EVENT_OPENED);
> >              /* mark mux as OPENED so any new FEs will immediately rece=
ive
> >               * OPENED event
> >               */
> >              qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> >          }
> >      }
> > -    muxes_realized =3D true;
> >  }
> >
> >  static Notifier muxes_realize_notify =3D {
> >
>=20
