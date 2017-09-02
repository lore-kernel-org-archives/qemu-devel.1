Received: from eggs.gnu.org ([2001:4830:134:3::10]:50178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnw1a-00055r-P7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnw1V-0007TW-Pn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:10:58 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnw1V-0007TN-Kr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:10:53 -0400
Received: by mail-qk0-x244.google.com with SMTP id c6so474046qkh.4
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 17:10:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-12-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e282830f-476d-2b18-5f8e-2d577d9409e4@amsat.org>
Date: Fri, 1 Sep 2017 21:10:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 11/29] libqtest: Inline
 qtest_query_target_endianness()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 09/01/2017 03:03 PM, Eric Blake wrote:
> There was only one caller; it's easier to inline things.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/libqtest.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 5d16351e24..b6dd26e54a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -244,20 +244,6 @@ redo:
>       return words;
>   }
> 
> -static int qtest_query_target_endianness(QTestState *s)
> -{
> -    gchar **args;
> -    int big_endian;
> -
> -    qtest_sendf(s, "endianness\n");
> -    args = qtest_rsp(s, 1);
> -    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
> -    big_endian = strcmp(args[1], "big") == 0;
> -    g_strfreev(args);
> -
> -    return big_endian;
> -}
> -
>   static void cleanup_sigabrt_handler(void)
>   {
>       sigaction(SIGABRT, &sigact_old, NULL);
> @@ -288,6 +274,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>       gchar *qmp_socket_path;
>       gchar *command;
>       const char *qemu_binary;
> +    gchar **args;
> 
>       qemu_binary = getenv("QTEST_QEMU_BINARY");
>       if (!qemu_binary) {
> @@ -351,8 +338,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>       }
> 
>       /* ask endianness of the target */
> -
> -    s->big_endian = qtest_query_target_endianness(s);
> +    qtest_sendf(s, "endianness\n");
> +    args = qtest_rsp(s, 1);
> +    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
> +    s->big_endian = strcmp(args[1], "big") == 0;
> +    g_strfreev(args);
> 
>       return s;
>   }
> 
