Received: from eggs.gnu.org ([2001:4830:134:3::10]:37800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7vcL-0005Vi-Hj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7vcG-0003P9-JC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e7vcG-0003OD-Ag
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EC7C5F798
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 03:47:26 +0000 (UTC)
Date: Fri, 27 Oct 2017 04:47:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171027034713.GA13631@work-vm>
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026075222.27798-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/10] tests: check that migration
 parameters are really assigned
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index c429a13403..be598d3257 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -354,17 +354,37 @@ static void cleanup(const char *filename)
>      g_free(path);
>  }
>  
> -static void migrate_set_downtime(QTestState *who, const char *value)
> +static void migrate_check_parameter(QTestState *who, const char *parameter,
> +                                    const char *value)
> +{
> +    QDict *rsp, *rsp_return;
> +    const char *result;
> +
> +    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
> +    rsp_return = qdict_get_qdict(rsp, "return");
> +    result = g_strdup_printf("%" PRId64,
> +                             qdict_get_try_int(rsp_return,  parameter, -1));
> +    g_assert_cmpstr(result, ==, value);
> +    QDECREF(rsp);
> +}
> +
> +static void migrate_set_downtime(QTestState *who, const double value)
>  {
>      QDict *rsp;
>      gchar *cmd;
> +    char *expected;
> +    int64_t result_int;
>  
>      cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
> -                          "'arguments': { 'value': %s } }", value);
> +                          "'arguments': { 'value': %g } }", value);

I wonder if that will hit any FP representation problems for some
values?


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      rsp = qtest_qmp(who, cmd);
>      g_free(cmd);
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
> +    result_int = value * 1000L;
> +    expected = g_strdup_printf("%" PRId64, result_int);
> +    migrate_check_parameter(who, "downtime-limit", expected);
> +    g_free(expected);
>  }
>  
>  static void migrate_set_speed(QTestState *who, const char *value)
> @@ -378,6 +398,7 @@ static void migrate_set_speed(QTestState *who, const char *value)
>      g_free(cmd);
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
> +    migrate_check_parameter(who, "max-bandwidth", value);
>  }
>  
>  static void migrate_set_capability(QTestState *who, const char *capability,
> @@ -509,7 +530,7 @@ static void test_migrate(void)
>       * machine, so also set the downtime.
>       */
>      migrate_set_speed(from, "100000000");
> -    migrate_set_downtime(from, "0.001");
> +    migrate_set_downtime(from, 0.001);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
