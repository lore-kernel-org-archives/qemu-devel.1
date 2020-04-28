Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EEC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954C9206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="rT09X/OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954C9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMZN-00072d-I9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jTMPy-0002Bu-S5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jTM5i-0004Rv-L0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:02:28 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:36167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jTM5h-0004Nj-Vp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:59:46 -0400
Received: by mail-vk1-xa44.google.com with SMTP id v192so5428410vkd.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=6VZhjaVndNXizGaGybTKoso9DZRzL6Mv7Ft/Heo/wcs=;
 b=rT09X/ORilnSopnQl8i55Ta+UBEa1sWTbT+jq6Up3MxVgxPcA/Uf/aOJoHxQdAp76M
 gexYVEucnHkJI4ECZl6Nv5MMOGhsv1IRL96bvV5SiZjaxQpKcj7rKTqvz/K4tu7trIDi
 F1gMxXx7bG4rK6JkLnvF0kHdLl/t3TVy95M9gM8JCIPFc5vez07e6c2L7kedfzrUsM+5
 99l6/dG58uCgDc18hvjwmDe/p++jjEVpOr1GY3xWIiQYMt19uPPJrIzkG3GKiglQSDy5
 1140shrxpTa1UVMby5cTcfjrbL95C+6gDL6tdgDw+Eq2BZe2G7y7X72uDx0jGuL0JFQA
 2ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=6VZhjaVndNXizGaGybTKoso9DZRzL6Mv7Ft/Heo/wcs=;
 b=PpnCOuUVn1xmvotJcdGN8pt2ze/qPLqKflTFG26c5c5IllATgBlyAlYqbI/nyqypJZ
 1xJ9m+Ags+rbc75JTWP13vJmMbiksZPrEOh57cCP5ZNZi84eIiKydb56HmA5fq9jVdd0
 lX1tkPl26qLvHXp5m+UxnIa4LkhUiHnmy4Qz7wm9FGUaGJKvcMQK19inNK9/ciOZbvfM
 eWSkvTwgvNgcLybt6WDFBK8yb0o9guKv05WT9vucrEX99oHp8jTEx7HTsu17/UbCBoyO
 QbJpnb4dn6T2wnXW5sQ/xBjx21Z1iqL+6i15pTem0ISHAdYB6B8bemZ9IpJ6PRLGIOZV
 9QHg==
X-Gm-Message-State: AGi0PuZDl95AJ4mtpR1Ig3dZTdsLywjbkkAcitYiqF7fn3yBuoqaiSIy
 21UgtszYyqmwaQaon5qUrD5C31lRY5iHFL/GZ6Zsgw==
X-Google-Smtp-Source: APiQypKqzZgU4iq1HwZyTQhh+Wv2SA0u+2q3SAIt0O6eDoeNARw6jdrKzcrhk2eNhytRpTBKH6UmR6158VY9k23sJV8=
X-Received: by 2002:a1f:3210:: with SMTP id y16mr19729327vky.89.1588064384699; 
 Tue, 28 Apr 2020 01:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200415032826.16701-4-fengli@smartx.com>
 <20200428085409.2414-1-fengli@smartx.com>
In-Reply-To: <20200428085409.2414-1-fengli@smartx.com>
From: Li Feng <fengli@smartx.com>
Date: Tue, 28 Apr 2020 16:59:33 +0800
Message-ID: <CAHckoCy3iwhep4iQrqqK6FxHSPp+D_7659wSz8hNJ4qgaDhnmg@mail.gmail.com>
Subject: Re: [PATCH v2] char-socket: initialize reconnect timer only when the
 timer doesn't start
To: Kyle Zhang <kyle@smartx.com>, Feng Li <lifeng1519@gmail.com>, 
 Dima Stepanov <dimastep@yandex-team.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yutian Zhou <yutian@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::a44;
 envelope-from=fengli@smartx.com; helo=mail-vk1-xa44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::a44
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for sending the weird same mail out.
Ignore the second one.

Hi Lureau,

I found another issue when running my new test:  tests/test-char -p
/char/socket/client/reconnect-error/unix
The backtrace like this:
#0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
#1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
#2  0x00005555555aaa34 in error_handle_fatal (errp=3D<optimized out>,
err=3D0x7fffec0012d0) at util/error.c:40
#3  0x00005555555aab0d in error_setv (errp=3D0x555555802a08
<error_abort>, src=3D0x5555555c4220 "io/channel.c", line=3D148,
func=3D0x5555555c4520 <__func__.17450> "qio_channel_readv_all",
    err_class=3DERROR_CLASS_GENERIC_ERROR, fmt=3D<optimized out>,
ap=3D0x7ffff423bb10, suffix=3D0x0) at util/error.c:73
#4  0x00005555555aac90 in error_setg_internal
(errp=3Derrp@entry=3D0x555555802a08 <error_abort>,
src=3Dsrc@entry=3D0x5555555c4220 "io/channel.c", line=3Dline@entry=3D148,
    func=3Dfunc@entry=3D0x5555555c4520 <__func__.17450>
"qio_channel_readv_all", fmt=3Dfmt@entry=3D0x5555555c4340 "Unexpected
end-of-file before all bytes were read") at util/error.c:97
#5  0x000055555556c1fc in qio_channel_readv_all (ioc=3D<optimized out>,
iov=3D<optimized out>, niov=3D<optimized out>, errp=3D0x555555802a08
<error_abort>) at io/channel.c:147
#6  0x000055555556c23a in qio_channel_read_all (ioc=3D<optimized out>,
buf=3D<optimized out>, buflen=3D<optimized out>, errp=3D<optimized out>) at
io/channel.c:247
#7  0x000055555556ad0e in char_socket_ping_pong (ioc=3D0x7fffec0008c0)
at tests/test-char.c:727
#8  0x000055555556adcf in char_socket_client_server_thread
(data=3Ddata@entry=3D0x55555582e350) at tests/test-char.c:881
#9  0x00005555555a9556 in qemu_thread_start (args=3D<optimized out>) at
util/qemu-thread-posix.c:519
#10 0x00007ffff5e61e25 in start_thread () from /lib64/libpthread.so.0
#11 0x00007ffff5b8bbad in clone () from /lib64/libc.so.6

I think this is a new issue of qemu, not my test issue.
How do you think?

Thanks,

Feng Li

Li Feng <fengli@smartx.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=9A

>
> When the disconnect event is triggered in the connecting stage,
> the tcp_chr_disconnect_locked may be called twice.
>
> The first call:
>     #0  qemu_chr_socket_restart_timer (chr=3D0x55555582ee90) at chardev/c=
har-socket.c:120
>     #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=3D<optimized=
 out>) at chardev/char-socket.c:490
>     #2  0x000055555558e3cd in tcp_chr_disconnect (chr=3D0x55555582ee90) a=
t chardev/char-socket.c:497
>     #3  0x000055555558ea32 in tcp_chr_new_client (chr=3Dchr@entry=3D0x555=
55582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-socket.c:892
>     #4  0x000055555558eeb8 in qemu_chr_socket_connected (task=3D0x5555558=
2f300, opaque=3D<optimized out>) at chardev/char-socket.c:1090
>     #5  0x0000555555574352 in qio_task_complete (task=3Dtask@entry=3D0x55=
555582f300) at io/task.c:196
>     #6  0x00005555555745f4 in qio_task_thread_result (opaque=3D0x55555582=
f300) at io/task.c:111
>     #7  qio_task_wait_thread (task=3D0x55555582f300) at io/task.c:190
>     #8  0x000055555558f17e in tcp_chr_wait_connected (chr=3D0x55555582ee9=
0, errp=3D0x555555802a08 <error_abort>) at chardev/char-socket.c:1013
>     #9  0x0000555555567cbd in char_socket_client_reconnect_test (opaque=
=3D0x5555557fe020 <client8unix>) at tests/test-char.c:1152
> The second call:
>     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
>     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
>     #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/libc.so.6
>     #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.6
>     #4  0x000055555558d10a in qemu_chr_socket_restart_timer (chr=3D0x5555=
5582ee90) at chardev/char-socket.c:125
>     #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=3D<optimized=
 out>) at chardev/char-socket.c:490
>     #6  0x000055555558df4d in tcp_chr_disconnect (chr=3D0x55555582ee90) a=
t chardev/char-socket.c:497
>     #7  0x000055555558e5b2 in tcp_chr_new_client (chr=3Dchr@entry=3D0x555=
55582ee90, sioc=3Dsioc@entry=3D0x55555582f0b0) at chardev/char-socket.c:892
>     #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=3Dchr@entr=
y=3D0x55555582ee90, errp=3Derrp@entry=3D0x7fffffffd178) at chardev/char-soc=
ket.c:944
>     #9  0x000055555558ec78 in tcp_chr_wait_connected (chr=3D0x55555582ee9=
0, errp=3D0x555555802a08 <error_abort>) at chardev/char-socket.c:1035
>     #10 0x000055555556804b in char_socket_client_test (opaque=3D0x5555557=
fe020 <client8unix>) at tests/test-char.c:1023
>
> Run test/test-char to reproduce this issue.
>
> test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer: Asse=
rtion `!s->reconnect_timer' failed.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> v2:
> - Rewrite the solution.
> - Add test to reproduce this issue.
>
>  chardev/char-socket.c |  2 +-
>  tests/test-char.c     | 48 ++++++++++++++++++++++++++++++++++++++-------=
---
>  2 files changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1f14c2c7c8..d84330b3c9 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
>      if (emit_close) {
>          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>      }
> -    if (s->reconnect_time) {
> +    if (s->reconnect_time && !s->reconnect_timer) {
>          qemu_chr_socket_restart_timer(chr);
>      }
>  }
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 8d39bdc9fa..13dbbfe2a3 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -625,12 +625,14 @@ static void char_udp_test(void)
>  typedef struct {
>      int event;
>      bool got_pong;
> +    CharBackend *be;
>  } CharSocketTestData;
>
>
>  #define SOCKET_PING "Hello"
>  #define SOCKET_PONG "World"
>
> +typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);
>
>  static void
>  char_socket_event(void *opaque, QEMUChrEvent event)
> @@ -639,6 +641,23 @@ char_socket_event(void *opaque, QEMUChrEvent event)
>      data->event =3D event;
>  }
>
> +static void
> +char_socket_event_with_error(void *opaque, QEMUChrEvent event)
> +{
> +    CharSocketTestData *data =3D opaque;
> +    CharBackend *be =3D data->be;
> +    data->event =3D event;
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        qemu_chr_fe_disconnect(be);
> +        return;
> +    case CHR_EVENT_CLOSED:
> +        return;
> +    default:
> +        return;
> +    }
> +}
> +
>
>  static void
>  char_socket_read(void *opaque, const uint8_t *buf, int size)
> @@ -783,6 +802,7 @@ static void char_socket_server_test(gconstpointer opa=
que)
>
>   reconnect:
>      data.event =3D -1;
> +    data.be =3D &be;
>      qemu_chr_fe_set_handlers(&be, NULL, NULL,
>                               char_socket_event, NULL,
>                               &data, NULL, true);
> @@ -869,6 +889,7 @@ typedef struct {
>      const char *reconnect;
>      bool wait_connected;
>      bool fd_pass;
> +    char_socket_cb event_cb;
>  } CharSocketClientTestConfig;
>
>  static void char_socket_client_dupid_test(gconstpointer opaque)
> @@ -920,6 +941,7 @@ static void char_socket_client_dupid_test(gconstpoint=
er opaque)
>  static void char_socket_client_test(gconstpointer opaque)
>  {
>      const CharSocketClientTestConfig *config =3D opaque;
> +    const char_socket_cb event_cb =3D config->event_cb;
>      QIOChannelSocket *ioc;
>      char *optstr;
>      Chardev *chr;
> @@ -983,8 +1005,9 @@ static void char_socket_client_test(gconstpointer op=
aque)
>
>   reconnect:
>      data.event =3D -1;
> +    data.be =3D &be;
>      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      if (config->reconnect) {
>          g_assert(data.event =3D=3D -1);
> @@ -1022,7 +1045,7 @@ static void char_socket_client_test(gconstpointer o=
paque)
>      /* Setup a callback to receive the reply to our greeting */
>      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
>                               char_socket_read,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      g_assert(data.event =3D=3D CHR_EVENT_OPENED);
>      data.event =3D -1;
> @@ -1467,19 +1490,22 @@ int main(int argc, char **argv)
>
>  #define SOCKET_CLIENT_TEST(name, addr)                                  =
\
>      static CharSocketClientTestConfig client1 ## name =3D               =
  \
> -        { addr, NULL, false, false };                                   =
\
> +        { addr, NULL, false, false, char_socket_event};                 =
\
>      static CharSocketClientTestConfig client2 ## name =3D               =
  \
> -        { addr, NULL, true, false };                                    =
\
> +        { addr, NULL, true, false, char_socket_event };                 =
\
>      static CharSocketClientTestConfig client3 ## name =3D               =
  \
> -        { addr, ",reconnect=3D1", false };                              =
  \
> +        { addr, ",reconnect=3D1", false, false, char_socket_event };    =
  \
>      static CharSocketClientTestConfig client4 ## name =3D               =
  \
> -        { addr, ",reconnect=3D1", true };                               =
  \
> +        { addr, ",reconnect=3D1", true, false, char_socket_event };     =
  \
>      static CharSocketClientTestConfig client5 ## name =3D               =
  \
> -        { addr, NULL, false, true };                                    =
\
> +        { addr, NULL, false, true, char_socket_event };                 =
\
>      static CharSocketClientTestConfig client6 ## name =3D               =
  \
> -        { addr, NULL, true, true };                                     =
\
> +        { addr, NULL, true, true, char_socket_event };                  =
\
>      static CharSocketClientTestConfig client7 ## name =3D               =
  \
> -        { addr, ",reconnect=3D1", false, false };                       =
  \
> +        { addr, ",reconnect=3D1", false, false, char_socket_event };    =
  \
> +    static CharSocketClientTestConfig client8 ## name =3D               =
  \
> +        { addr, ",reconnect=3D1", true, false,                          =
  \
> +            char_socket_event_with_error };                             =
\
>      g_test_add_data_func("/char/socket/client/mainloop/" # name,        =
\
>                           &client1 ##name, char_socket_client_test);     =
\
>      g_test_add_data_func("/char/socket/client/wait-conn/" # name,       =
\
> @@ -1493,7 +1519,9 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name,=
 \
>                           &client6 ##name, char_socket_client_test);     =
\
>      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, =
\
> -                         &client7 ##name, char_socket_client_dupid_test)
> +                         &client7 ##name, char_socket_client_dupid_test)=
;\
> +    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, =
\
> +                         &client8 ##name, char_socket_client_test)
>
>      if (has_ipv4) {
>          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> --
> 2.11.0
>

