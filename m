Received: from eggs.gnu.org ([209.51.188.92]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Sqs-00018G-VT
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Sqr-0000vv-4s
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:28:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Sqp-0000sG-0u
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:28:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so12539782wrm.5
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 01:28:32 -0800 (PST)
References: <20190305225135.7060-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92fd635f-2754-0c32-28aa-f887a8f75a56@redhat.com>
Date: Wed, 6 Mar 2019 10:28:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190305225135.7060-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>

On 3/5/19 11:51 PM, Marc-André Lureau wrote:
> Spotted by ASAN.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vhost-user-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 4cd0a97f13..9364227ba4 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -588,6 +588,7 @@ static void test_server_free(TestServer *server)
>          g_test_message("unable to rmdir: path (%s): %s",
>                         server->tmpfs, strerror(errno));
>      }
> +    g_free(server->tmpfs);

Fixes: ae31fb54914 and 4d3f50eb489
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      qemu_chr_fe_deinit(&server->chr, true);
>  
> @@ -605,6 +606,8 @@ static void test_server_free(TestServer *server)
>  
>      g_main_loop_unref(server->loop);
>      g_main_context_unref(server->context);
> +    g_cond_clear(&server->data_cond);
> +    g_mutex_clear(&server->data_mutex);
>      g_free(server);
>  }
>  
> 
