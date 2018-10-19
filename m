Received: from eggs.gnu.org ([2001:4830:134:3::10]:60063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTZL-0001Xk-JG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDTZI-0001Hp-Fs
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:07:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDTZH-00012P-NZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:07:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so3472384wmt.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 05:07:47 -0700 (PDT)
References: <20181019101346.3316-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d287443e-c995-9525-914b-aad1018a7d59@redhat.com>
Date: Fri, 19 Oct 2018 14:07:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181019101346.3316-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] websock: fix handshake leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: jusual@mail.ru

On 19/10/2018 12:13, Marc-André Lureau wrote:
> Thanks Valgrind:
> 
> ==955== 217 bytes in 1 blocks are definitely lost in loss record 275 of 321
> ==955==    at 0x483A965: realloc (vg_replace_malloc.c:785)
> ==955==    by 0x50B6839: __vasprintf_chk (in /usr/lib64/libc-2.28.so)
> ==955==    by 0x49AA05C: g_vasprintf (in /usr/lib64/libglib-2.0.so.0.5800.1)
> ==955==    by 0x4983440: g_strdup_vprintf (in /usr/lib64/libglib-2.0.so.0.5800.1)
> ==955==    by 0x126048: qio_channel_websock_handshake_send_res (channel-websock.c:162)
> ==955==    by 0x1266E6: qio_channel_websock_handshake_send_res_ok (channel-websock.c:362)
> ==955==    by 0x126D3E: qio_channel_websock_handshake_process (channel-websock.c:468)
> ==955==    by 0x126EF2: qio_channel_websock_handshake_read (channel-websock.c:511)
> ==955==    by 0x12715B: qio_channel_websock_handshake_io (channel-websock.c:571)
> ==955==    by 0x125027: qio_channel_fd_source_dispatch (channel-watch.c:84)
> ==955==    by 0x496326C: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5800.1)
> ==955==    by 0x169EC3: glib_pollfds_poll (main-loop.c:215)
> 
Oops..

Missed in f69a8bde293.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  io/channel-websock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index e6608b969d..dc43dc6bb9 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -163,6 +163,7 @@ qio_channel_websock_handshake_send_res(QIOChannelWebsock *ioc,
>      responselen = strlen(response);
>      buffer_reserve(&ioc->encoutput, responselen);
>      buffer_append(&ioc->encoutput, response, responselen);
> +    g_free(response);
>      va_end(vargs);
>  }
>  
> 
