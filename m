Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNG8i-0001Wt-IY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNG8d-000257-MG
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:44:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNG8d-00024s-D6
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:44:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FF087CB83
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 10:44:14 +0000 (UTC)
Date: Fri, 8 Dec 2017 10:44:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171208104408.GG2403@work-vm>
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201125813.1437-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] tests: migration test deprecated
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We now test the deprecated commands everytime that we test the new
> commands.  This makes unnecesary to add tests for deprecated commands.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 799e24ebc6..51f49c74e9 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -369,7 +369,7 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
>      QDECREF(rsp);
>  }
>  
> -static void migrate_set_downtime(QTestState *who, const double value)
> +static void deprecated_set_downtime(QTestState *who, const double value)
>  {
>      QDict *rsp;
>      gchar *cmd;
> @@ -388,7 +388,7 @@ static void migrate_set_downtime(QTestState *who, const double value)
>      g_free(expected);
>  }
>  
> -static void migrate_set_speed(QTestState *who, const char *value)
> +static void deprecated_set_speed(QTestState *who, const char *value)
>  {
>      QDict *rsp;
>      gchar *cmd;
> @@ -402,6 +402,30 @@ static void migrate_set_speed(QTestState *who, const char *value)
>      migrate_check_parameter(who, "max-bandwidth", value);
>  }
>  
> +static void migrate_set_parameter(QTestState *who, const char *parameter,
> +                                  const char *value)
> +{
> +    QDict *rsp;
> +    gchar *cmd;
> +
> +    if (strcmp(parameter, "downtime-limit") == 0) {
> +        deprecated_set_downtime(who, 0.12345);
> +    }
> +
> +    if (strcmp(parameter, "max-bandwidth") == 0) {
> +        deprecated_set_speed(who, "12345");
> +    }

I find that odd; you call migrate_set_parameter to set a particular
value, but we set them to a different arbitrary value first?

Dave

> +    cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
> +                          "'arguments': { '%s': %s } }",
> +                          parameter, value);
> +    rsp = qtest_qmp(who, cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +    migrate_check_parameter(who, parameter, value);
> +}
> +
>  static void migrate_set_capability(QTestState *who, const char *capability,
>                                     const char *value)
>  {
> @@ -530,8 +554,8 @@ static void test_migrate(void)
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
>       */
> -    migrate_set_speed(from, "100000000");
> -    migrate_set_downtime(from, 0.001);
> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
> +    migrate_set_parameter(from, "downtime-limit", "1");
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
