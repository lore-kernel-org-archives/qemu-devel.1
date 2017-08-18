Received: from eggs.gnu.org ([2001:4830:134:3::10]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipFY-0000pG-FW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipFV-0004aD-5Y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:56:16 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dipFV-0004Zy-0q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:56:13 -0400
Received: by mail-qt0-x242.google.com with SMTP id c15so10077974qta.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:56:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-14-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc8e45c2-de8a-6b96-396b-68ffd4c410ce@amsat.org>
Date: Fri, 18 Aug 2017 18:56:09 -0300
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 13/13] numa-test: Use hmp()
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
> Don't open-code something that has a convenient helper available.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/numa-test.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 3f636840b1..e1b6152244 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -17,21 +17,6 @@ static char *make_cli(const char *generic_cli, const char *test_cli)
>       return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
>   }
> 
> -static char *hmp_info_numa(void)
> -{
> -    QDict *resp;
> -    char *s;
> -
> -    resp = qmp("{ 'execute': 'human-monitor-command', 'arguments': "
> -                      "{ 'command-line': 'info numa '} }");
> -    g_assert(resp);
> -    g_assert(qdict_haskey(resp, "return"));
> -    s = g_strdup(qdict_get_str(resp, "return"));
> -    g_assert(s);
> -    QDECREF(resp);
> -    return s;
> -}
> -
>   static void test_mon_explicit(const void *data)
>   {
>       char *s;
> @@ -42,7 +27,7 @@ static void test_mon_explicit(const void *data)
>                      "-numa node,nodeid=1,cpus=4-7 ");
>       qtest_start(cli);
> 
> -    s = hmp_info_numa();
> +    s = hmp("info numa");
>       g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
>       g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
>       g_free(s);
> @@ -59,7 +44,7 @@ static void test_mon_default(const void *data)
>       cli = make_cli(data, "-smp 8 -numa node -numa node");
>       qtest_start(cli);
> 
> -    s = hmp_info_numa();
> +    s = hmp("info numa");
>       g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
>       g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
>       g_free(s);
> @@ -78,7 +63,7 @@ static void test_mon_partial(const void *data)
>                      "-numa node,nodeid=1,cpus=4-5 ");
>       qtest_start(cli);
> 
> -    s = hmp_info_numa();
> +    s = hmp("info numa");
>       g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
>       g_assert(strstr(s, "node 1 cpus: 4 5"));
>       g_free(s);
> 
