Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD515C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE2720679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="JYDqj0hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE2720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlT8q-0003Mk-QT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jlT8F-0002vR-K3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:09:15 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31]:37682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jlT8C-0001d9-Jl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:09:15 -0400
Received: by mail-vk1-xa31.google.com with SMTP id q10so350972vka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=KJJn/nWU8SLnfuCYAPHY3NXhV/dNIPfgIHxCeIk4ZO0=;
 b=JYDqj0hPuSN/RzrgceENL6hXANc0HOCC2Ph1M6lvJOuP/CsPZV1G72NgIk6ljxNoMQ
 5p9dt84GpXRBBqj1/41dSdQKphND1EWVUSZtibr7tOVoQMSNpe1UGesmhznkCyMg1VcT
 KdsyEf6k7qkziz3bXrWizqhIiQyMj4YDFpLgEeD/CGz0+MlsU5t3uje/MDAhtdyPV9YH
 /eMuqMisnQ6MtjabkO2FShwTbYV361XaHzlKgn9MslILHyMyOGbe4fztIqo9yeIShB8G
 Q27bymKeVcrjGth4cA5N/RLGRC57Kr2E3BU9oslFLq7Tw22RFg7CZ3qluFHagleNtnv0
 t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=KJJn/nWU8SLnfuCYAPHY3NXhV/dNIPfgIHxCeIk4ZO0=;
 b=bdceAmj+5QMASOZYyqN1WLI5lVGuRRJ9PQFeXrPD4VvHhm2z/Dv2tBccu9ugJBXCYd
 Lxj0xFWpLucpK/qS6i3YfiqVTjycggPWFzoWIVzYNRK8Wj+U3/9/Dpv2GZ2U0BHPhikk
 /YukuOU0otXTY43ZwxnEOUr+mEyUUq/FXoZqjLpczZqSJmzRfkCNLck6Px5Cyfx+c1UJ
 zegvBT5HectQTJiF0XwB44hu6W+PQ1eZ+eSVdqFmtQAFqMcgOV+XT0dDjQ4ocrndlnmy
 VJddXva4hWoYLvngwlyVnr2zMJKghhiAUed2r3sk+cmI1N0R+CYaiRJ6ECu0sjGvSNrq
 Od4g==
X-Gm-Message-State: AOAM530L+Hb6fFb5b1ZW3VwX6r7/uup5vZpBvl1Beo1VAdwThzpSbQtc
 XbkM7kZVIaXBQRUENBLvKeuyTJpg763rWShVuFHBeQ==
X-Google-Smtp-Source: ABdhPJwuo8Q6l3oSOEnQPVCfeWb5oJWPx52x/L1yuxYBa3XkQ2TJccT4jaPtQutZDO1IDBWcNcSECyc05cM+A+XW914=
X-Received: by 2002:a1f:b647:: with SMTP id g68mr4521254vkf.76.1592381349794; 
 Wed, 17 Jun 2020 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smarx.com>
 <20200522025554.41063-1-fengli@smartx.com>
 <20200615084341.GA25038@dimastep-nix>
In-Reply-To: <20200615084341.GA25038@dimastep-nix>
From: Li Feng <fengli@smartx.com>
Date: Wed, 17 Jun 2020 16:08:58 +0800
Message-ID: <CAHckoCyj9JteH0_v08mCU36P3Tz47VsWfjWbUP_NL8d7pzMGwA@mail.gmail.com>
Subject: Fwd: [PATCH v5] char-socket: initialize reconnect timer only when the
 timer doesn't start
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Dima Stepanov <dimastep@yandex-team.ru>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::a31;
 envelope-from=fengli@smartx.com; helo=mail-vk1-xa31.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Lureau,

When will this patch be merged?

Thanks, Feng Li.

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dima Stepanov <dimastep@yandex-team.ru=
>
Date: 2020=E5=B9=B46=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=
=884:43
Subject: Re: [PATCH v5] char-socket: initialize reconnect timer only
when the timer doesn't start
To: Li Feng <fengli@smartx.com>


Hi,

I don't see this change merged to upstream. Any updates on it?

Thanks, Dima.


On Fri, May 22, 2020 at 10:55:54AM +0800, Li Feng wrote:
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
> v5:
> - rebase to master
>
> v4:
> - remove the wrong patch
> - fix the char_socket_ping_pong to support the reconnect exception test
>
> v3:
> - add a patch to fix a crash when recvmsg return 0
> - make the tests reproduce the two crash
>
> v2:
> - add unit test
>
>  chardev/char-socket.c |  2 +-
>  tests/test-char.c     | 73 +++++++++++++++++++++++++++++++++++++++------=
------
>  2 files changed, 57 insertions(+), 18 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e77699db48..8af7fdce88 100644
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
> index 3afc9b1b8d..73ba1cf601 100644
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
> @@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent event)
>      data->event =3D event;
>  }
>
> +static void
> +char_socket_event_with_error(void *opaque, QEMUChrEvent event)
> +{
> +    static bool first_error;
> +    CharSocketTestData *data =3D opaque;
> +    CharBackend *be =3D data->be;
> +    data->event =3D event;
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (!first_error) {
> +            first_error =3D true;
> +            qemu_chr_fe_disconnect(be);
> +        }
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
> @@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr, bo=
ol fd_pass,
>  }
>
>
> -static void
> -char_socket_ping_pong(QIOChannel *ioc)
> +static int
> +char_socket_ping_pong(QIOChannel *ioc, Error **errp)
>  {
>      char greeting[sizeof(SOCKET_PING)];
>      const char *response =3D SOCKET_PONG;
>
> -    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
> +    int ret;
> +    ret =3D qio_channel_read_all(ioc, greeting, sizeof(greeting), errp);
> +    if (ret !=3D 0) {
> +        object_unref(OBJECT(ioc));
> +        return -1;
> +    }
>
>      g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) =3D=3D 0);
>
> -    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abo=
rt);
> -
> +    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), errp);
>      object_unref(OBJECT(ioc));
> +    return 0;
>  }
>
>
> @@ -723,7 +751,7 @@ char_socket_server_client_thread(gpointer data)
>
>      qio_channel_socket_connect_sync(ioc, addr, &error_abort);
>
> -    char_socket_ping_pong(QIO_CHANNEL(ioc));
> +    char_socket_ping_pong(QIO_CHANNEL(ioc), &error_abort);
>
>      return NULL;
>  }
> @@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer opa=
que)
>
>   reconnect:
>      data.event =3D -1;
> +    data.be =3D &be;
>      qemu_chr_fe_set_handlers(&be, NULL, NULL,
>                               char_socket_event, NULL,
>                               &data, NULL, true);
> @@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)
>      QIOChannelSocket *ioc =3D data;
>      QIOChannelSocket *cioc;
>
> +retry:
>      cioc =3D qio_channel_socket_accept(ioc, &error_abort);
>      g_assert_nonnull(cioc);
>
> -    char_socket_ping_pong(QIO_CHANNEL(cioc));
> +    if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) !=3D 0) {
> +        goto retry;
> +    }
>
>      return NULL;
>  }
> @@ -869,12 +901,13 @@ typedef struct {
>      const char *reconnect;
>      bool wait_connected;
>      bool fd_pass;
> +    char_socket_cb event_cb;
>  } CharSocketClientTestConfig;
>
> -
>  static void char_socket_client_test(gconstpointer opaque)
>  {
>      const CharSocketClientTestConfig *config =3D opaque;
> +    const char_socket_cb event_cb =3D config->event_cb;
>      QIOChannelSocket *ioc;
>      char *optstr;
>      Chardev *chr;
> @@ -938,8 +971,9 @@ static void char_socket_client_test(gconstpointer opa=
que)
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
> @@ -977,7 +1011,7 @@ static void char_socket_client_test(gconstpointer op=
aque)
>      /* Setup a callback to receive the reply to our greeting */
>      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
>                               char_socket_read,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      g_assert(data.event =3D=3D CHR_EVENT_OPENED);
>      data.event =3D -1;
> @@ -1422,17 +1456,20 @@ int main(int argc, char **argv)
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
> +    static CharSocketClientTestConfig client7 ## name =3D               =
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
> @@ -1444,7 +1481,9 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name, =
\
>                           &client5 ##name, char_socket_client_test);     =
\
>      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name,=
 \
> -                         &client6 ##name, char_socket_client_test)
> +                         &client6 ##name, char_socket_client_test);     =
\
> +    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, =
\
> +                         &client7 ##name, char_socket_client_test)
>
>      if (has_ipv4) {
>          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> --
> 2.11.0
>

