Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B537C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181CD21473
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="0SWemZPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181CD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2BE-0003P0-8f
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jX2A0-0002yV-Te
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:31:24 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:39458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jX29y-0006RZ-9S
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:31:24 -0400
Received: by mail-ua1-x942.google.com with SMTP id b6so569074uak.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0jYCpINWWFT/W3IH7KXUjICPMoSEGNzIJDdvuGQaB6M=;
 b=0SWemZPvCii40SOl8SRlj9qa5Mc1h0IEdwKxdi7jQ1G8oSKlAPcaavUOs2rNvoQNXU
 YTN09CVA+mdoN8YCcX4KLLNTCJ8TjO1IkIwGp1MgsZ8oy70m4ia81Nkp+FR0Z3qL5Zh5
 H+UhwNtGUJgx0zwp7YEYUDuA0CWVFH9Le87lhoQ45nAKKHsfozOCjVIU/ljNMBjhs9oK
 k7X/iuA6hRYpakwyTTIuoT9Op4qGG4uhchY/ZnQO5CB5PynHHZDKf9SdhWjZvG9yvGuI
 x8yYH9zkhjY6VPQ0Sb7ZMV8FzUuD7z8Y5PuxAh3nIHgNSXAeNgbD71fFcR1BYPt7KWTF
 WcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0jYCpINWWFT/W3IH7KXUjICPMoSEGNzIJDdvuGQaB6M=;
 b=GHBwyZH0Y+1/tGw5XaiKIQNitDTTcVDxSIaWCG+BCAmySKiwgyvTSPQ2IfyK5Gj5Q1
 ISP84TJz7nc2V1YccAshfI8qrsOlcyNm5WIGBef+c7Psv/bmQIUTise9S+VKSHLWSmY6
 IvhBHmE1D6EdKnXW3wCPswh52qxrsfSFYZSx1xF3IAAQKCaYFVWMA4BnY1hiwzn+BNG2
 sXlPzxlZ0YvewXxFxSnNVBy9EUITo/4Ky0eo5Aq1rWLhYzj0GLYZ51ULKnoD15P0DyrO
 sGqEioMIiapBI1NoP2p0FOVWKWS9UpY13hnPN2xScGG2f+nElVC6cRj4DLrY4TmdD7Ca
 th4g==
X-Gm-Message-State: AGi0PubudMVpAFNETCd6ymSW04qgJoitPk4JS7rwdaJJ/5SLuyLucccH
 iqyFyIJMtqbsyXWJfM+bqhSRrxiI4CQwQAhj/xhKsA==
X-Google-Smtp-Source: APiQypLWTd4XTioarezvrehuo/uw/roU+81fmNsBtMTThcBejKfbTNwBoNc5wINRfq8LOfWIiSmzDczQxNi1Iv3vMZ0=
X-Received: by 2002:ab0:45c6:: with SMTP id u64mr1561908uau.133.1588941080526; 
 Fri, 08 May 2020 05:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
 <20200508051441.8143-3-fengli@smartx.com>
 <CAMxuvawoyrBZdY31RA76bG57MdDEdnau-AN-xwN=8wm-pX2fFg@mail.gmail.com>
 <CAHckoCwWU5vDf5_-q1MVuFE-m4KKWkq7cgbAY5u5uTLz9uJE0Q@mail.gmail.com>
 <CAJ+F1CJ9NmVzLDmX+ykn+SF_E8tawD6Lm-H_jAV65OiyzpZ8MA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ9NmVzLDmX+ykn+SF_E8tawD6Lm-H_jAV65OiyzpZ8MA@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Fri, 8 May 2020 20:31:06 +0800
Message-ID: <CAHckoCzCF_cwLQJ9_yYjYKL_nxqzGJfhQGusCA0ROSKGo0dz1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] char-socket: initialize reconnect timer only when
 the timer doesn't start
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::942;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Feng Li <lifeng1519@gmail.com>, Kyle Zhang <kyle@smartx.com>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks!

Feng Li

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2020=E5=B9=B45=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:29=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi
>
> On Fri, May 8, 2020 at 2:16 PM Li Feng <fengli@smartx.com> wrote:
> >
> > Have you applied the first one?
> >  io/channel: fix crash when qio_channel_readv_all return 0
> >
>
> Sorry, I missed that one. With that it passes. thanks
>
> > Thanks,
> >
> > Feng Li
> >
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =E4=BA=8E2020=E5=
=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:01=E5=86=
=99=E9=81=93=EF=BC=9A
> >
> > >
> > > On Fri, May 8, 2020 at 7:14 AM Li Feng <fengli@smartx.com> wrote:
> > > >
> > > > When the disconnect event is triggered in the connecting stage,
> > > > the tcp_chr_disconnect_locked may be called twice.
> > > >
> > > > The first call:
> > > >     #0  qemu_chr_socket_restart_timer (chr=3D0x55555582ee90) at cha=
rdev/char-socket.c:120
> > > >     #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=3D<opt=
imized out>) at chardev/char-socket.c:490
> > > >     #2  0x000055555558e3cd in tcp_chr_disconnect (chr=3D0x55555582e=
e90) at chardev/char-socket.c:497
> > > >     #3  0x000055555558ea32 in tcp_chr_new_client (chr=3Dchr@entry=
=3D0x55555582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-sock=
et.c:892
> > > >     #4  0x000055555558eeb8 in qemu_chr_socket_connected (task=3D0x5=
5555582f300, opaque=3D<optimized out>) at chardev/char-socket.c:1090
> > > >     #5  0x0000555555574352 in qio_task_complete (task=3Dtask@entry=
=3D0x55555582f300) at io/task.c:196
> > > >     #6  0x00005555555745f4 in qio_task_thread_result (opaque=3D0x55=
555582f300) at io/task.c:111
> > > >     #7  qio_task_wait_thread (task=3D0x55555582f300) at io/task.c:1=
90
> > > >     #8  0x000055555558f17e in tcp_chr_wait_connected (chr=3D0x55555=
582ee90, errp=3D0x555555802a08 <error_abort>) at chardev/char-socket.c:1013
> > > >     #9  0x0000555555567cbd in char_socket_client_reconnect_test (op=
aque=3D0x5555557fe020 <client8unix>) at tests/test-char.c:1152
> > > > The second call:
> > > >     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
> > > >     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
> > > >     #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/lib=
c.so.6
> > > >     #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.=
6
> > > >     #4  0x000055555558d10a in qemu_chr_socket_restart_timer (chr=3D=
0x55555582ee90) at chardev/char-socket.c:125
> > > >     #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=3D<opt=
imized out>) at chardev/char-socket.c:490
> > > >     #6  0x000055555558df4d in tcp_chr_disconnect (chr=3D0x55555582e=
e90) at chardev/char-socket.c:497
> > > >     #7  0x000055555558e5b2 in tcp_chr_new_client (chr=3Dchr@entry=
=3D0x55555582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-sock=
et.c:892
> > > >     #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=3Dch=
r@entry=3D0x55555582ee90, errp=3Derrp@entry=3D0x7fffffffd178) at chardev/ch=
ar-socket.c:944
> > > >     #9  0x000055555558ec78 in tcp_chr_wait_connected (chr=3D0x55555=
582ee90, errp=3D0x555555802a08 <error_abort>) at chardev/char-socket.c:1035
> > > >     #10 0x000055555556804b in char_socket_client_test (opaque=3D0x5=
555557fe020 <client8unix>) at tests/test-char.c:1023
> > > >
> > > > Run test/test-char to reproduce this issue.
> > > >
> > > > test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer=
: Assertion `!s->reconnect_timer' failed.
> > > >
> > > > Signed-off-by: Li Feng <fengli@smartx.com>
> > >
> > > After applying your patch, with qemu configure --enable-debug
> > > --enable-sanitizers:
> > >
> > > $ tests/test-char
> > > Unexpected error in qio_channel_readv_all() at
> > > /home/elmarco/src/qq/io/channel.c:147:
> > > Unexpected end-of-file before all bytes were read
> > > [1]    2445287 abort (core dumped)  tests/test-char
> > >
> > > > ---
> > > >  chardev/char-socket.c |  2 +-
> > > >  tests/test-char.c     | 68 +++++++++++++++++++++++++++++++++++++++=
+-----------
> > > >  2 files changed, 55 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > > index 1f14c2c7c8..d84330b3c9 100644
> > > > --- a/chardev/char-socket.c
> > > > +++ b/chardev/char-socket.c
> > > > @@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *=
chr)
> > > >      if (emit_close) {
> > > >          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> > > >      }
> > > > -    if (s->reconnect_time) {
> > > > +    if (s->reconnect_time && !s->reconnect_timer) {
> > > >          qemu_chr_socket_restart_timer(chr);
> > > >      }
> > > >  }
> > > > diff --git a/tests/test-char.c b/tests/test-char.c
> > > > index 8d39bdc9fa..d5c9049eec 100644
> > > > --- a/tests/test-char.c
> > > > +++ b/tests/test-char.c
> > > > @@ -625,12 +625,14 @@ static void char_udp_test(void)
> > > >  typedef struct {
> > > >      int event;
> > > >      bool got_pong;
> > > > +    CharBackend *be;
> > > >  } CharSocketTestData;
> > > >
> > > >
> > > >  #define SOCKET_PING "Hello"
> > > >  #define SOCKET_PONG "World"
> > > >
> > > > +typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);
> > > >
> > > >  static void
> > > >  char_socket_event(void *opaque, QEMUChrEvent event)
> > > > @@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent e=
vent)
> > > >      data->event =3D event;
> > > >  }
> > > >
> > > > +static void
> > > > +char_socket_event_with_error(void *opaque, QEMUChrEvent event)
> > > > +{
> > > > +    static bool first_error;
> > > > +    CharSocketTestData *data =3D opaque;
> > > > +    CharBackend *be =3D data->be;
> > > > +    data->event =3D event;
> > > > +    switch (event) {
> > > > +    case CHR_EVENT_OPENED:
> > > > +        if (!first_error) {
> > > > +            first_error =3D true;
> > > > +            qemu_chr_fe_disconnect(be);
> > > > +        }
> > > > +        return;
> > > > +    case CHR_EVENT_CLOSED:
> > > > +        return;
> > > > +    default:
> > > > +        return;
> > > > +    }
> > > > +}
> > > > +
> > > >
> > > >  static void
> > > >  char_socket_read(void *opaque, const uint8_t *buf, int size)
> > > > @@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *ad=
dr, bool fd_pass,
> > > >  }
> > > >
> > > >
> > > > -static void
> > > > +static int
> > > >  char_socket_ping_pong(QIOChannel *ioc)
> > > >  {
> > > >      char greeting[sizeof(SOCKET_PING)];
> > > >      const char *response =3D SOCKET_PONG;
> > > >
> > > > -    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_a=
bort);
> > > > +    int ret;
> > > > +    ret =3D qio_channel_read_all(ioc, greeting, sizeof(greeting), =
&error_abort);
> > > > +    if (ret !=3D 0) {
> > > > +        object_unref(OBJECT(ioc));
> > > > +        return -1;
> > > > +    }
> > > >
> > > >      g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) =3D=
=3D 0);
> > > >
> > > >      qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &err=
or_abort);
> > > > -
> > > >      object_unref(OBJECT(ioc));
> > > > +    return 0;
> > > >  }
> > > >
> > > >
> > > > @@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpoint=
er opaque)
> > > >
> > > >   reconnect:
> > > >      data.event =3D -1;
> > > > +    data.be =3D &be;
> > > >      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> > > >                               char_socket_event, NULL,
> > > >                               &data, NULL, true);
> > > > @@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer dat=
a)
> > > >      QIOChannelSocket *ioc =3D data;
> > > >      QIOChannelSocket *cioc;
> > > >
> > > > +retry:
> > > >      cioc =3D qio_channel_socket_accept(ioc, &error_abort);
> > > >      g_assert_nonnull(cioc);
> > > >
> > > > -    char_socket_ping_pong(QIO_CHANNEL(cioc));
> > > > +    if (char_socket_ping_pong(QIO_CHANNEL(cioc)) !=3D 0) {
> > > > +        goto retry;
> > > > +    }
> > > >
> > > >      return NULL;
> > > >  }
> > > > @@ -869,6 +901,7 @@ typedef struct {
> > > >      const char *reconnect;
> > > >      bool wait_connected;
> > > >      bool fd_pass;
> > > > +    char_socket_cb event_cb;
> > > >  } CharSocketClientTestConfig;
> > > >
> > > >  static void char_socket_client_dupid_test(gconstpointer opaque)
> > > > @@ -920,6 +953,7 @@ static void char_socket_client_dupid_test(gcons=
tpointer opaque)
> > > >  static void char_socket_client_test(gconstpointer opaque)
> > > >  {
> > > >      const CharSocketClientTestConfig *config =3D opaque;
> > > > +    const char_socket_cb event_cb =3D config->event_cb;
> > > >      QIOChannelSocket *ioc;
> > > >      char *optstr;
> > > >      Chardev *chr;
> > > > @@ -983,8 +1017,9 @@ static void char_socket_client_test(gconstpoin=
ter opaque)
> > > >
> > > >   reconnect:
> > > >      data.event =3D -1;
> > > > +    data.be =3D &be;
> > > >      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> > > > -                             char_socket_event, NULL,
> > > > +                             event_cb, NULL,
> > > >                               &data, NULL, true);
> > > >      if (config->reconnect) {
> > > >          g_assert(data.event =3D=3D -1);
> > > > @@ -1022,7 +1057,7 @@ static void char_socket_client_test(gconstpoi=
nter opaque)
> > > >      /* Setup a callback to receive the reply to our greeting */
> > > >      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
> > > >                               char_socket_read,
> > > > -                             char_socket_event, NULL,
> > > > +                             event_cb, NULL,
> > > >                               &data, NULL, true);
> > > >      g_assert(data.event =3D=3D CHR_EVENT_OPENED);
> > > >      data.event =3D -1;
> > > > @@ -1467,19 +1502,22 @@ int main(int argc, char **argv)
> > > >
> > > >  #define SOCKET_CLIENT_TEST(name, addr)                            =
      \
> > > >      static CharSocketClientTestConfig client1 ## name =3D         =
        \
> > > > -        { addr, NULL, false, false };                             =
      \
> > > > +        { addr, NULL, false, false, char_socket_event};           =
      \
> > > >      static CharSocketClientTestConfig client2 ## name =3D         =
        \
> > > > -        { addr, NULL, true, false };                              =
      \
> > > > +        { addr, NULL, true, false, char_socket_event };           =
      \
> > > >      static CharSocketClientTestConfig client3 ## name =3D         =
        \
> > > > -        { addr, ",reconnect=3D1", false };                        =
        \
> > > > +        { addr, ",reconnect=3D1", false, false, char_socket_event =
};      \
> > > >      static CharSocketClientTestConfig client4 ## name =3D         =
        \
> > > > -        { addr, ",reconnect=3D1", true };                         =
        \
> > > > +        { addr, ",reconnect=3D1", true, false, char_socket_event }=
;       \
> > > >      static CharSocketClientTestConfig client5 ## name =3D         =
        \
> > > > -        { addr, NULL, false, true };                              =
      \
> > > > +        { addr, NULL, false, true, char_socket_event };           =
      \
> > > >      static CharSocketClientTestConfig client6 ## name =3D         =
        \
> > > > -        { addr, NULL, true, true };                               =
      \
> > > > +        { addr, NULL, true, true, char_socket_event };            =
      \
> > > >      static CharSocketClientTestConfig client7 ## name =3D         =
        \
> > > > -        { addr, ",reconnect=3D1", false, false };                 =
        \
> > > > +        { addr, ",reconnect=3D1", false, false, char_socket_event =
};      \
> > > > +    static CharSocketClientTestConfig client8 ## name =3D         =
        \
> > > > +        { addr, ",reconnect=3D1", true, false,                    =
        \
> > > > +            char_socket_event_with_error };                       =
      \
> > > >      g_test_add_data_func("/char/socket/client/mainloop/" # name,  =
      \
> > > >                           &client1 ##name, char_socket_client_test)=
;     \
> > > >      g_test_add_data_func("/char/socket/client/wait-conn/" # name, =
      \
> > > > @@ -1493,7 +1531,9 @@ int main(int argc, char **argv)
> > > >      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" #=
 name, \
> > > >                           &client6 ##name, char_socket_client_test)=
;     \
> > > >      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # =
name, \
> > > > -                         &client7 ##name, char_socket_client_dupid=
_test)
> > > > +                         &client7 ##name, char_socket_client_dupid=
_test);\
> > > > +    g_test_add_data_func("/char/socket/client/reconnect-error/" # =
name, \
> > > > +                         &client8 ##name, char_socket_client_test)
> > > >
> > > >      if (has_ipv4) {
> > > >          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> > > > --
> > > > 2.11.0
> > > >
> > >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

