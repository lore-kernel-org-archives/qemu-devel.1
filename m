Received: from eggs.gnu.org ([2001:4830:134:3::10]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYSJ-0001SN-Ii
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYSF-0007Kb-HO
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWYSF-0007Jf-8H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:06:55 -0500
Date: Wed, 3 Jan 2018 10:06:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103020646.GA2557@xz-mi>
References: <20171228072945.9573-1-peterx@redhat.com>
	<20171228072945.9573-4-peterx@redhat.com>
	<CAJ+F1CKQrtdm69Tgk-52ZXL6Ze3vH-bYG65Y7fsuhSMKX5Osrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKQrtdm69Tgk-52ZXL6Ze3vH-bYG65Y7fsuhSMKX5Osrw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] chardev: introduce
 qemu_chr_timeout_add() and use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 02, 2018 at 05:10:01PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Dec 28, 2017 at 8:29 AM, Peter Xu <peterx@redhat.com> wrote:
> > It's a replacement of g_timeout_add[_seconds]() for chardevs.  Charde=
vs
> > now can have dedicated gcontext, we should always bind chardev tasks
> > onto those gcontext rather than the default main context.  Since ther=
e
> > are quite a few of g_timeout_add[_seconds]() callers, a new function
> > qemu_chr_timeout_add() is introduced.
> >
> > One thing to mention is that, terminal3270 is still always running on
> > main gcontext.  However let's convert that as well since it's still p=
art
> > of chardev codes and in case one day we'll miss that when we move it =
out
> > of main gcontext too.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-pty.c     |  9 ++-------
> >  chardev/char-socket.c  |  4 ++--
> >  chardev/char.c         | 20 ++++++++++++++++++++
> >  hw/char/terminal3270.c |  7 ++++---
> >  include/chardev/char.h |  2 ++
> >  5 files changed, 30 insertions(+), 12 deletions(-)
> >
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index dd17b1b823..cbd8ac5eb7 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -78,13 +78,8 @@ static void pty_chr_rearm_timer(Chardev *chr, int =
ms)
> >          s->timer_tag =3D 0;
> >      }
> >
> > -    if (ms =3D=3D 1000) {
> > -        name =3D g_strdup_printf("pty-timer-secs-%s", chr->label);
> > -        s->timer_tag =3D g_timeout_add_seconds(1, pty_chr_timer, chr=
);
> > -    } else {
> > -        name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> > -        s->timer_tag =3D g_timeout_add(ms, pty_chr_timer, chr);
> > -    }
> > +    name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> > +    s->timer_tag =3D qemu_chr_timeout_add(chr, ms, pty_chr_timer, ch=
r);
> >      g_source_set_name_by_id(s->timer_tag, name);
> >      g_free(name);
> >  }
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 630a7f2995..644a620599 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -73,8 +73,8 @@ static void qemu_chr_socket_restart_timer(Chardev *=
chr)
> >      char *name;
> >
> >      assert(s->connected =3D=3D 0);
> > -    s->reconnect_timer =3D g_timeout_add_seconds(s->reconnect_time,
> > -                                               socket_reconnect_time=
out, chr);
> > +    s->reconnect_timer =3D qemu_chr_timeout_add(chr, s->reconnect_ti=
me,
>=20
> reconnect_time is in second, you should * 1000.

Yes.  Will fix them all.

>=20
> > +                                              socket_reconnect_timeo=
ut, chr);
> >      name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->lab=
el);
> >      g_source_set_name_by_id(s->reconnect_timer, name);
> >      g_free(name);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 8c3765ee99..a1de662fec 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -1084,6 +1084,26 @@ void qmp_chardev_send_break(const char *id, Er=
ror **errp)
> >      qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> >  }
> >
> > +/*
> > + * Add a timeout callback for the chardev (in milliseconds). Please
> > + * use this to add timeout hook for chardev instead of g_timeout_add=
()
> > + * and g_timeout_add_seconds(), to make sure the gcontext that the
> > + * task bound to is correct.
> > + */
> > +guint qemu_chr_timeout_add(Chardev *chr, guint ms, GSourceFunc func,
> > +                           void *private)
> > +{
> > +    GSource *source =3D g_timeout_source_new(ms);
> > +    guint id;
> > +
> > +    assert(func);
> > +    g_source_set_callback(source, func, private, NULL);
> > +    id =3D g_source_attach(source, chr->gcontext);
> > +    g_source_unref(source);
> > +
> > +    return id;
> > +}
> > +
> >  void qemu_chr_cleanup(void)
> >  {
> >      object_unparent(get_chardevs_root());
> > diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> > index a109ce5987..479e4554d6 100644
> > --- a/hw/char/terminal3270.c
> > +++ b/hw/char/terminal3270.c
> > @@ -94,8 +94,8 @@ static void terminal_read(void *opaque, const uint8=
_t *buf, int size)
> >          g_source_remove(t->timer_tag);
> >          t->timer_tag =3D 0;
> >      }
> > -    t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark_cb,=
 t);
> > -
> > +    t->timer_tag =3D qemu_chr_timeout_add(t->chr.chr, 600,
>=20
> same here
>=20
> > +                                        send_timing_mark_cb, t);
> >      memcpy(&t->inv[t->in_len], buf, size);
> >      t->in_len +=3D size;
> >      if (t->in_len < 2) {
> > @@ -157,7 +157,8 @@ static void chr_event(void *opaque, int event)
> >           * char-socket.c. Once qemu receives the terminal-type of th=
e
> >           * client, mark handshake done and trigger everything rollin=
g again.
> >           */
> > -        t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark=
_cb, t);
> > +        t->timer_tag =3D qemu_chr_timeout_add(t->chr.chr, 600,
>=20
> and again
>=20
> > +                                            send_timing_mark_cb, t);
> >          break;
> >      case CHR_EVENT_CLOSED:
> >          sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index 778d610295..4970e46457 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -258,5 +258,7 @@ extern int term_escape_char;
> >
> >  /* console.c */
> >  void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Erro=
r **errp);
> > +guint qemu_chr_timeout_add(Chardev *chr, guint ms, GSourceFunc func,
> > +                           void *private);
> >
>=20
> Please put the declaration before the /* console.c */ comment.

Sure.  Thanks for review.

--=20
Peter Xu
