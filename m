Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJhb-0007Bs-Iz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJhW-0002VR-KY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:12:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euJhW-0002VF-G9
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:12:54 -0500
Date: Fri, 9 Mar 2018 15:12:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180309151241.GD13990@work-vm>
References: <20180306173042.24572-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306173042.24572-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Silence migration-test 'bad' test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, peter.maydell@linaro.org

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> In 2c9bb29703c I added a migration test that purposely fails;
> unfortunately it prints a copy of the failure message to stderr
> which makes the output a bit messy.
> 
> Hide stderr for that test.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  tests/migration-test.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 74f9361bdd..422bf1afdf 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -382,7 +382,7 @@ static void migrate_start_postcopy(QTestState *who)
>  }
>  
>  static void test_migrate_start(QTestState **from, QTestState **to,
> -                               const char *uri)
> +                               const char *uri, bool hide_stderr)
>  {
>      gchar *cmd_src, *cmd_dst;
>      char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> @@ -427,6 +427,17 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>  
>      g_free(bootpath);
>  
> +    if (hide_stderr) {
> +        gchar *tmp;
> +        tmp = g_strdup_printf("%s 2>/dev/null", cmd_src);
> +        g_free(cmd_src);
> +        cmd_src = tmp;
> +
> +        tmp = g_strdup_printf("%s 2>/dev/null", cmd_dst);
> +        g_free(cmd_dst);
> +        cmd_dst = tmp;
> +    }
> +
>      *from = qtest_start(cmd_src);
>      g_free(cmd_src);
>  
> @@ -518,7 +529,7 @@ static void test_migrate(void)
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>  
> -    test_migrate_start(&from, &to, uri);
> +    test_migrate_start(&from, &to, uri, false);
>  
>      migrate_set_capability(from, "postcopy-ram", "true");
>      migrate_set_capability(to, "postcopy-ram", "true");
> @@ -560,7 +571,7 @@ static void test_baddest(void)
>      const char *status;
>      bool failed;
>  
> -    test_migrate_start(&from, &to, "tcp:0:0");
> +    test_migrate_start(&from, &to, "tcp:0:0", true);
>      migrate(from, "tcp:0:0");
>      do {
>          rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
