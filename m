Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED71208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBrjeEQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED71208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0lP-0004vw-Hz
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jX0km-0004VE-3w
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:01:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jX0kk-0002kL-AA
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588935672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRLTazxR1tS4LNpLP1ps3/DHyVAQs0s9XAw2k9vItQY=;
 b=iBrjeEQyPAsP+T4eVFLP7YmT/VuctyVDd9NsSdfqlwCNDMehduyYS6X8nYtGCrEhkwm6jO
 ZDzT72UQKswddufQRR0WfNqHQYD6AoapOOnjqGekVvKziCKIlGnl+NMg+iqOITmQdYzfRR
 pq/A1iS24692a8BzQPAbn3OQcL4BvBU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-rS_11SHiN0uu-9D-Xos7xg-1; Fri, 08 May 2020 07:01:03 -0400
X-MC-Unique: rS_11SHiN0uu-9D-Xos7xg-1
Received: by mail-io1-f70.google.com with SMTP id k1so1395824iov.18
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3OcsBVsB6NcoujPekpp5fmVJT3ojXt1NWH2peGtNHfg=;
 b=WsyMBJWVGsoeaJFruw0VHIldgafMDCRkrBYMnii/pNV3H0pp9qAwyzm50h3B2bS56g
 WjXYvg5e+izHDpYxyGBrfUIoEzLYvkRyqctYAQl2lA41BnLhTYdGGYSel1AtydrNNplq
 tgHMAuUA6KoiIyWmkOOUpRQaPnp2PEcWfcmrlPkcnnRjHcz80STBb5+KaI/BCZGwwqCO
 mEaTVJaYFu7tac5/e+0gX8KbyAEPtLx+FUT4oA2GGJb4XEfXpk0WsilCW492Lk+81H0h
 nRA3TW++Gx2vhs3HkilN9IYV2jfcyAKQnDIMOptaNl8gMr9K0kIBw6yAShgDGHIwz9iv
 zYMA==
X-Gm-Message-State: AGi0PuaErEbh6iSzWQwCGnOudf5kFUQO0nvuytrSB1Kur1AWKLbCPZXa
 VbfpChx0G3+bKqo+77AzSKI54vlkiFwtiXoXMfil99D7HRoWNCIvg27Co60nwM1tLvolrBtcYcL
 j/lP4tw/I/AWwZ3gUByRjntDO61GwS6I=
X-Received: by 2002:a05:6e02:c85:: with SMTP id
 b5mr2157055ile.165.1588935662504; 
 Fri, 08 May 2020 04:01:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypL+JZmYug75QyPe8e4yLJLQoumub/vHAp5hT/d9YbM8cyXPKz8zxQ3r6ahIgrLLpyDrjQ1b6kF0U5XI1D5haNE=
X-Received: by 2002:a05:6e02:c85:: with SMTP id
 b5mr2157022ile.165.1588935662165; 
 Fri, 08 May 2020 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
 <20200508051441.8143-3-fengli@smartx.com>
In-Reply-To: <20200508051441.8143-3-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 May 2020 13:00:50 +0200
Message-ID: <CAMxuvawoyrBZdY31RA76bG57MdDEdnau-AN-xwN=8wm-pX2fFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] char-socket: initialize reconnect timer only when
 the timer doesn't start
To: Li Feng <fengli@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Feng Li <lifeng1519@gmail.com>, Dima Stepanov <dimastep@yandex-team.ru>,
 Kyle Zhang <kyle@smartx.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 7:14 AM Li Feng <fengli@smartx.com> wrote:
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

After applying your patch, with qemu configure --enable-debug
--enable-sanitizers:

$ tests/test-char
Unexpected error in qio_channel_readv_all() at
/home/elmarco/src/qq/io/channel.c:147:
Unexpected end-of-file before all bytes were read
[1]    2445287 abort (core dumped)  tests/test-char

> ---
>  chardev/char-socket.c |  2 +-
>  tests/test-char.c     | 68 ++++++++++++++++++++++++++++++++++++++++-----=
------
>  2 files changed, 55 insertions(+), 15 deletions(-)
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
> index 8d39bdc9fa..d5c9049eec 100644
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
> +static int
>  char_socket_ping_pong(QIOChannel *ioc)
>  {
>      char greeting[sizeof(SOCKET_PING)];
>      const char *response =3D SOCKET_PONG;
>
> -    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
> +    int ret;
> +    ret =3D qio_channel_read_all(ioc, greeting, sizeof(greeting), &error=
_abort);
> +    if (ret !=3D 0) {
> +        object_unref(OBJECT(ioc));
> +        return -1;
> +    }
>
>      g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) =3D=3D 0);
>
>      qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abo=
rt);
> -
>      object_unref(OBJECT(ioc));
> +    return 0;
>  }
>
>
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
> +    if (char_socket_ping_pong(QIO_CHANNEL(cioc)) !=3D 0) {
> +        goto retry;
> +    }
>
>      return NULL;
>  }
> @@ -869,6 +901,7 @@ typedef struct {
>      const char *reconnect;
>      bool wait_connected;
>      bool fd_pass;
> +    char_socket_cb event_cb;
>  } CharSocketClientTestConfig;
>
>  static void char_socket_client_dupid_test(gconstpointer opaque)
> @@ -920,6 +953,7 @@ static void char_socket_client_dupid_test(gconstpoint=
er opaque)
>  static void char_socket_client_test(gconstpointer opaque)
>  {
>      const CharSocketClientTestConfig *config =3D opaque;
> +    const char_socket_cb event_cb =3D config->event_cb;
>      QIOChannelSocket *ioc;
>      char *optstr;
>      Chardev *chr;
> @@ -983,8 +1017,9 @@ static void char_socket_client_test(gconstpointer op=
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
> @@ -1022,7 +1057,7 @@ static void char_socket_client_test(gconstpointer o=
paque)
>      /* Setup a callback to receive the reply to our greeting */
>      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
>                               char_socket_read,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      g_assert(data.event =3D=3D CHR_EVENT_OPENED);
>      data.event =3D -1;
> @@ -1467,19 +1502,22 @@ int main(int argc, char **argv)
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
> @@ -1493,7 +1531,9 @@ int main(int argc, char **argv)
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


