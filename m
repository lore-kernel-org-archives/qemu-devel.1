Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpA7T-0004GP-DE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpA7K-00054k-E7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpA7K-00054F-8d
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A96BC04B31B
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 09:25:57 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-12-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f065d46f-e295-b4dd-ed9b-a2708b89b5a2@redhat.com>
Date: Tue, 5 Sep 2017 11:25:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 01.09.2017 20:03, Eric Blake wrote:
> There was only one caller; it's easier to inline things.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 5d16351e24..b6dd26e54a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -244,20 +244,6 @@ redo:
>      return words;
>  }
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
>  static void cleanup_sigabrt_handler(void)
>  {
>      sigaction(SIGABRT, &sigact_old, NULL);
> @@ -288,6 +274,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>      gchar *qmp_socket_path;
>      gchar *command;
>      const char *qemu_binary;
> +    gchar **args;
> 
>      qemu_binary = getenv("QTEST_QEMU_BINARY");
>      if (!qemu_binary) {
> @@ -351,8 +338,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>      }
> 
>      /* ask endianness of the target */
> -
> -    s->big_endian = qtest_query_target_endianness(s);
> +    qtest_sendf(s, "endianness\n");
> +    args = qtest_rsp(s, 1);
> +    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
> +    s->big_endian = strcmp(args[1], "big") == 0;
> +    g_strfreev(args);
> 
>      return s;
>  }

Ah, well, now that's another way of getting rid of the forward
declaration in the previous patch - so may I suggest to drop the
previous patch, and simply do the code inlining here instead?

 Thomas
