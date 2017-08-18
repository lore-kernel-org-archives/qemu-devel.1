Received: from eggs.gnu.org ([2001:4830:134:3::10]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dip6F-00059f-Hw
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dip6B-0007Nl-Lu
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:46:39 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dip6B-0007Nc-FB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:46:35 -0400
Received: by mail-qt0-x241.google.com with SMTP id t37so10038749qtg.2
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:46:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-8-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a12d0bfc-4112-414c-6d19-8f9071b5f936@amsat.org>
Date: Fri, 18 Aug 2017 18:46:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/13] libqtest: Inline
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
Cc: armbru@redhat.com

On 08/18/2017 06:15 PM, Eric Blake wrote:
> There was only one caller; it's easier to inline things.

What's the benefit of this change? Having a separate function ease code 
reading. You might add the 'inline' qualifier but the compiler is smart 
enough to inline it.

Instead of this change I'd inline it and remove the return value, having 
a void function initializing s->big_endian. Matter of taste I think :)

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
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
