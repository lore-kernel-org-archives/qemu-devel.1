Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B01C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E5D20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJxx1fPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E5D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmvy-0005V8-BX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmvB-0004yn-8a
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:15:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmv9-0000j9-Nj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590074142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lziz8NNor4QY+xjfliBg11K/nv0m46HZLLyissg9h+A=;
 b=cJxx1fPWFKXKd4Dcg8IYmaxgVsvDLQRAUf0+2xQddCXD1n6Bp6FcLe/Z6EbcgPtP8d7jzO
 bHaDKYrUv5IY5sPWtXrR+HB0YH99sP0EZED3eUx5U8HuaBKAGYQf92marMCfndYJzH+pG7
 Ks1vfKqEYiTM6bBUk67//p/O+OK0Ajc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-DL8HpqSDMPmgjwyoValfJA-1; Thu, 21 May 2020 11:15:37 -0400
X-MC-Unique: DL8HpqSDMPmgjwyoValfJA-1
Received: by mail-wr1-f72.google.com with SMTP id p8so3051705wrj.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lziz8NNor4QY+xjfliBg11K/nv0m46HZLLyissg9h+A=;
 b=j5PiK646RJzby3MMF7QOTZoJnms3OWQsSea/UKy4m3xLtpAZpy+eFJqBIa5MU2pvfm
 LAO2dKrXer/Y727MYygOkoqTAWR1TU33HDEC9WRJn9Mt6Pvp/ie4agcX7pNUmN79g3PD
 QUA3mStyiygkW7MGa2qtSAI5+SXoYWna6EQWFWhDfilMtuzb8/2aCdGs4wmbiKJqcZKa
 K3zy4aCPkjWxTynDLobZrd9WZMCcTiG4NEvRlRQvUTsKC7hu722NVb0QbZh8vpVWMGED
 10iTatzXTPJXLABfI1U4oHKAnx4DwSGtIHuP8f9tj2/3FJmw9VFhRziNQ228WJZRZGPu
 5v5w==
X-Gm-Message-State: AOAM530CvADAdAeH214lLKmYRlP7zmw7N7OI+3sjzXv2ZtLAFPlx3iuu
 1giG/O4zfaYIDzsA6KERBW0VrieRjyJ3ryV24U/GAw4Gjes/QoOxNa7JOUHXs9iOxnN+KyfyDE/
 2Sbao17o+o9up8G8=
X-Received: by 2002:a7b:c207:: with SMTP id x7mr9809606wmi.79.1590074135751;
 Thu, 21 May 2020 08:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9uh7PyMfL8O3Rw90uU8Ch5LhZ04HqjsMnEE9M6j/CZlJvAvKz85s40SlCqbP8iWKXNLUA8A==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr9809578wmi.79.1590074135309;
 Thu, 21 May 2020 08:15:35 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id z132sm7631989wmc.29.2020.05.21.08.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:15:34 -0700 (PDT)
Subject: Re: [PATCH v4] char-socket: initialize reconnect timer only when the
 timer doesn't start
To: Li Feng <fengli@smartx.com>, kyle@smartx.com, lifeng1519@gmail.com,
 dimastep@yandex-team.ru, marcandre.lureau@redhat.com,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200511123947.74383-1-fengli@smartx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2764f56-21f5-fc22-7744-7a8abfa2fea8@redhat.com>
Date: Thu, 21 May 2020 17:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511123947.74383-1-fengli@smartx.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Sorry, can you resend this?

I cannot apply it.

Paolo

On 11/05/20 14:39, Li Feng wrote:
> When the disconnect event is triggered in the connecting stage,
> the tcp_chr_disconnect_locked may be called twice.
> 
> The first call:
>     #0  qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:120
>     #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
>     #2  0x000055555558e3cd in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
>     #3  0x000055555558ea32 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
>     #4  0x000055555558eeb8 in qemu_chr_socket_connected (task=0x55555582f300, opaque=<optimized out>) at chardev/char-socket.c:1090
>     #5  0x0000555555574352 in qio_task_complete (task=task@entry=0x55555582f300) at io/task.c:196
>     #6  0x00005555555745f4 in qio_task_thread_result (opaque=0x55555582f300) at io/task.c:111
>     #7  qio_task_wait_thread (task=0x55555582f300) at io/task.c:190
>     #8  0x000055555558f17e in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1013
>     #9  0x0000555555567cbd in char_socket_client_reconnect_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1152
> The second call:
>     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
>     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
>     #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/libc.so.6
>     #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.6
>     #4  0x000055555558d10a in qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:125
>     #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
>     #6  0x000055555558df4d in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
>     #7  0x000055555558e5b2 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
>     #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=chr@entry=0x55555582ee90, errp=errp@entry=0x7fffffffd178) at chardev/char-socket.c:944
>     #9  0x000055555558ec78 in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1035
>     #10 0x000055555556804b in char_socket_client_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1023
> 
> Run test/test-char to reproduce this issue.
> 
> test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.
> 
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
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
>  tests/test-char.c     | 74 +++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 58 insertions(+), 18 deletions(-)
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
> index 8d39bdc9fa..d94580c61e 100644
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
>      data->event = event;
>  }
>  
> +static void
> +char_socket_event_with_error(void *opaque, QEMUChrEvent event)
> +{
> +    static bool first_error;
> +    CharSocketTestData *data = opaque;
> +    CharBackend *be = data->be;
> +    data->event = event;
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (!first_error) {
> +            first_error = true;
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
> @@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr, bool fd_pass,
>  }
>  
>  
> -static void
> -char_socket_ping_pong(QIOChannel *ioc)
> +static int
> +char_socket_ping_pong(QIOChannel *ioc, Error **errp)
>  {
>      char greeting[sizeof(SOCKET_PING)];
>      const char *response = SOCKET_PONG;
>  
> -    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
> +    int ret;
> +    ret = qio_channel_read_all(ioc, greeting, sizeof(greeting), errp);
> +    if (ret != 0) {
> +        object_unref(OBJECT(ioc));
> +        return -1;
> +    }
>  
>      g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) == 0);
>  
> -    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abort);
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
> @@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer opaque)
>  
>   reconnect:
>      data.event = -1;
> +    data.be = &be;
>      qemu_chr_fe_set_handlers(&be, NULL, NULL,
>                               char_socket_event, NULL,
>                               &data, NULL, true);
> @@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)
>      QIOChannelSocket *ioc = data;
>      QIOChannelSocket *cioc;
>  
> +retry:
>      cioc = qio_channel_socket_accept(ioc, &error_abort);
>      g_assert_nonnull(cioc);
>  
> -    char_socket_ping_pong(QIO_CHANNEL(cioc));
> +    if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) != 0) {
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
> @@ -920,6 +953,7 @@ static void char_socket_client_dupid_test(gconstpointer opaque)
>  static void char_socket_client_test(gconstpointer opaque)
>  {
>      const CharSocketClientTestConfig *config = opaque;
> +    const char_socket_cb event_cb = config->event_cb;
>      QIOChannelSocket *ioc;
>      char *optstr;
>      Chardev *chr;
> @@ -983,8 +1017,9 @@ static void char_socket_client_test(gconstpointer opaque)
>  
>   reconnect:
>      data.event = -1;
> +    data.be = &be;
>      qemu_chr_fe_set_handlers(&be, NULL, NULL,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      if (config->reconnect) {
>          g_assert(data.event == -1);
> @@ -1022,7 +1057,7 @@ static void char_socket_client_test(gconstpointer opaque)
>      /* Setup a callback to receive the reply to our greeting */
>      qemu_chr_fe_set_handlers(&be, char_socket_can_read,
>                               char_socket_read,
> -                             char_socket_event, NULL,
> +                             event_cb, NULL,
>                               &data, NULL, true);
>      g_assert(data.event == CHR_EVENT_OPENED);
>      data.event = -1;
> @@ -1467,19 +1502,22 @@ int main(int argc, char **argv)
>  
>  #define SOCKET_CLIENT_TEST(name, addr)                                  \
>      static CharSocketClientTestConfig client1 ## name =                 \
> -        { addr, NULL, false, false };                                   \
> +        { addr, NULL, false, false, char_socket_event};                 \
>      static CharSocketClientTestConfig client2 ## name =                 \
> -        { addr, NULL, true, false };                                    \
> +        { addr, NULL, true, false, char_socket_event };                 \
>      static CharSocketClientTestConfig client3 ## name =                 \
> -        { addr, ",reconnect=1", false };                                \
> +        { addr, ",reconnect=1", false, false, char_socket_event };      \
>      static CharSocketClientTestConfig client4 ## name =                 \
> -        { addr, ",reconnect=1", true };                                 \
> +        { addr, ",reconnect=1", true, false, char_socket_event };       \
>      static CharSocketClientTestConfig client5 ## name =                 \
> -        { addr, NULL, false, true };                                    \
> +        { addr, NULL, false, true, char_socket_event };                 \
>      static CharSocketClientTestConfig client6 ## name =                 \
> -        { addr, NULL, true, true };                                     \
> +        { addr, NULL, true, true, char_socket_event };                  \
>      static CharSocketClientTestConfig client7 ## name =                 \
> -        { addr, ",reconnect=1", false, false };                         \
> +        { addr, ",reconnect=1", false, false, char_socket_event };      \
> +    static CharSocketClientTestConfig client8 ## name =                 \
> +        { addr, ",reconnect=1", true, false,                            \
> +            char_socket_event_with_error };                             \
>      g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
>                           &client1 ##name, char_socket_client_test);     \
>      g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
> @@ -1493,7 +1531,9 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
>                           &client6 ##name, char_socket_client_test);     \
>      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
> -                         &client7 ##name, char_socket_client_dupid_test)
> +                         &client7 ##name, char_socket_client_dupid_test);\
> +    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
> +                         &client8 ##name, char_socket_client_test)
>  
>      if (has_ipv4) {
>          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> 


