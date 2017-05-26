Received: from eggs.gnu.org ([2001:4830:134:3::10]:59455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEEUo-00047J-0U
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEEUm-0001ZO-9O
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:37:34 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dEEUl-0001ZI-TN
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:37:32 -0400
Received: by mail-lf0-x241.google.com with SMTP id 99so906257lfu.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 05:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-10-marcandre.lureau@redhat.com>
	<7a271264-56e5-e919-09d1-9e058ef6b2f5@amsat.org>
In-Reply-To: <7a271264-56e5-e919-09d1-9e058ef6b2f5@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 12:37:19 +0000
Message-ID: <CAJ+F1C+oCnJ-X+ZYOW-OGkR4nTNmL38uPZ-43conZdeW4YTjmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/13] char: generalize qemu_chr_write_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi

On Tue, May 9, 2017 at 4:59 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Hi Marc-Andr=C3=A9,
>
> On 05/09/2017 08:33 AM, Marc-Andr=C3=A9 Lureau wrote:
> > qemu_chr_fe_write() is similar to qemu_chr_write_all(): the later write
> > all with a chardev backend.
> >
> > Make qemu_chr_write() and qemu_chr_fe_write_buffer() take an 'all'
> > argument. If false, handle 'partial' write the way qemu_chr_fe_write()
> > use to, and call qemu_chr_write() from qemu_chr_fe_write().
>
> What about invert logic and name the argument 'is_partial[_write]'? Else
> 'write_all' to have more readable code?
>
>
I have a slight preference for the 'all' over 'partial' logic argument, but
I don't mind much.

It's fine to rename it write_all too.


> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char.c | 69
> +++++++++++++++++++++++-----------------------------------
> >  1 file changed, 27 insertions(+), 42 deletions(-)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index af7d871ed5..392dba6a86 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -96,7 +96,8 @@ static void qemu_chr_fe_write_log(Chardev *s,
> >  }
> >
> >  static int qemu_chr_fe_write_buffer(Chardev *s,
> > -                                    const uint8_t *buf, int len, int
> *offset)
> > +                                    const uint8_t *buf, int len,
> > +                                    int *offset, bool all)
> >  {
> >      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
> >      int res =3D 0;
> > @@ -106,7 +107,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
> >      while (*offset < len) {
> >      retry:
> >          res =3D cc->chr_write(s, buf + *offset, len - *offset);
> > -        if (res < 0 && errno =3D=3D EAGAIN) {
> > +        if (res < 0 && errno =3D=3D EAGAIN && all) {
> >              g_usleep(100);
> >              goto retry;
> >          }
> > @@ -116,6 +117,9 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
> >          }
> >
> >          *offset +=3D res;
> > +        if (!all) {
> > +            break;
> > +        }
> >      }
> >      if (*offset > 0) {
> >          qemu_chr_fe_write_log(s, buf, *offset);
> > @@ -130,54 +134,19 @@ static bool qemu_chr_replay(Chardev *chr)
> >      return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> >  }
> >
> > -int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> > +static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, boo=
l
> all)
> >  {
> > -    Chardev *s =3D be->chr;
> > -    ChardevClass *cc;
> > -    int ret;
> > -
> > -    if (!s) {
> > -        return 0;
> > -    }
> > -
> > -    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
> > -        int offset;
> > -        replay_char_write_event_load(&ret, &offset);
> > -        assert(offset <=3D len);
> > -        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
> > -        return ret;
> > -    }
> > -
> > -    cc =3D CHARDEV_GET_CLASS(s);
> > -    qemu_mutex_lock(&s->chr_write_lock);
> > -    ret =3D cc->chr_write(s, buf, len);
> > -
> > -    if (ret > 0) {
> > -        qemu_chr_fe_write_log(s, buf, ret);
> > -    }
> > -
> > -    qemu_mutex_unlock(&s->chr_write_lock);
> > -
> > -    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
> > -        replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
> > -    }
> > -
> > -    return ret;
> > -}
> > -
> > -int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
> > -{
> > -    int offset;
> > +    int offset =3D 0;
> >      int res;
> >
> >      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
> >          replay_char_write_event_load(&res, &offset);
> >          assert(offset <=3D len);
> > -        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
> > +        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
> >          return res;
> >      }
> >
> > -    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset);
> > +    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset, all);
> >
> >      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
> >          replay_char_write_event_save(res, offset);
> > @@ -189,6 +158,22 @@ int qemu_chr_write_all(Chardev *s, const uint8_t
> *buf, int len)
> >      return offset;
> >  }
> >
> > +int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
> > +{
> > +    return qemu_chr_write(s, buf, len, true);
> > +}
> > +
> > +int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
> > +{
> > +    Chardev *s =3D be->chr;
> > +
> > +    if (!s) {
> > +        return 0;
> > +    }
> > +
> > +    return qemu_chr_write(s, buf, len, false);
> > +}
> > +
> >  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len=
)
> >  {
> >      Chardev *s =3D be->chr;
> > @@ -197,7 +182,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const
> uint8_t *buf, int len)
> >          return 0;
> >      }
> >
> > -    return qemu_chr_write_all(s, buf, len);
> > +    return qemu_chr_write(s, buf, len, true);
> >  }
> >
> >  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
> >
>
> --
Marc-Andr=C3=A9 Lureau
