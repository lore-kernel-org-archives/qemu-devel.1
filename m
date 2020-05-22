Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C53206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBsYAA2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C53206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc3WP-0002tc-C9
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 04:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jc3Vq-0002Ty-4q
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:58:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jc3Vo-0007a2-BV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590137918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGIaY2502WjX38eCaYppE+JzIE73jkl5vo3mNvPdCIc=;
 b=NBsYAA2FKFt7YNlwHjtgw5sYB50APURv+StJg1Kt58XAbxsHWGonI+sZfyLuqBeTJd+Z1m
 lGw1lV1oy8+xP0bnQgMt7JJ88jTGDkr3OjffwFyEd6/lBewEu1HFZ+oBIBwJ7kzMrZnf1T
 5egyWesv9hW5ok6fsdHRSTwfHc8BVSc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-KsTGgYNrMu-m9s71eUI4rQ-1; Fri, 22 May 2020 04:58:31 -0400
X-MC-Unique: KsTGgYNrMu-m9s71eUI4rQ-1
Received: by mail-io1-f70.google.com with SMTP id s1so2470610ioo.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zGIaY2502WjX38eCaYppE+JzIE73jkl5vo3mNvPdCIc=;
 b=pNuTcy9zHNn/hqECv/x1nhUnfOJDyP98WerXsEjpw5dhQ4TJsWWjO72vooQiEd3AAQ
 7dKM2GxPH/7b0SUqoCplmofPB9ZwiIifu5+zj9ki4SiHN1ARJD9RutYtoWkrvEm1459O
 dNaW4I+80+SrpMcTUjpLSgFwqJ8vkv7cRSNjBkd9LqmXd9Xr4zP1QsLS3IdnQaoJHZlj
 fvBM2RCCvwOHnML1Os+42uR8ntOL4DQWOPCITZKj4OpE1rOLX9CxfIKjsfiJQKqZemUb
 uCC/riOs2ayIWCXDr8hcH7OL6Kj06fJrFC8Hu8YLdJssxuY4vKATNX5dnK9tUj4NphmC
 xzpA==
X-Gm-Message-State: AOAM533U/pejfXnHqG4CkHnRtAcJDhnpqTMDgYfqErC08D9h2jhR3CXF
 CRafdpF9kqxy7PY6Mt7a4guJBFYaxFx3xOjIjnzYsZg2PzRvaohQ0BJr9zaCbmUrpK8ZA7dlAH9
 34+Ma92s7dnH9Empc3BV3beQTxcOrtKw=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id
 k3mr12214722ils.11.1590137911107; 
 Fri, 22 May 2020 01:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznnCzs/cG7l0/Ku9j6vN0RVY789gJmjKnukcjVrzUWxtAEskxNSA76jmRKwrmupPpbvXR73BQJbJmiTrVcxGU=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id
 k3mr12214705ils.11.1590137910748; 
 Fri, 22 May 2020 01:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smarx.com>
 <20200522025554.41063-1-fengli@smartx.com>
In-Reply-To: <20200522025554.41063-1-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 May 2020 10:58:19 +0200
Message-ID: <CAMxuvayF+eLH+7LAcEjYUN2ydf1EUL5y7KkgcqMubLjiGhA0AA@mail.gmail.com>
Subject: Re: [PATCH v5] char-socket: initialize reconnect timer only when the
 timer doesn't start
To: Li Feng <fengli@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:07:09
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

On Fri, May 22, 2020 at 4:56 AM Li Feng <fengli@smartx.com> wrote:
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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


