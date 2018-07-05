Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3wx-0006pY-TB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3wt-0007Kx-Rb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:05:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb3wt-0007II-0s
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:05:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85F6981663C5
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:05:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705031755.3254-6-peterx@redhat.com> (Peter Xu's message of
	"Thu, 5 Jul 2018 11:17:51 +0800")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-6-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:05:18 +0200
Message-ID: <87o9fl25pt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 5/9] tests: allow migrate() to take
 extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> For example, we can pass in '"resume": true' to resume a migration.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

sometime I miss a "hmp_to_qmp()" function O:-)


> ---
>  tests/migration-test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 2155869b96..af82a04789 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -337,14 +337,14 @@ static void migrate_set_capability(QTestState *who, const char *capability,
>      qobject_unref(rsp);
>  }
>  
> -static void migrate(QTestState *who, const char *uri)
> +static void migrate(QTestState *who, const char *uri, const char *extra)
>  {
>      QDict *rsp;
>      gchar *cmd;
>  
>      cmd = g_strdup_printf("{ 'execute': 'migrate',"
> -                          "'arguments': { 'uri': '%s' } }",
> -                          uri);
> +                          "  'arguments': { 'uri': '%s' %s } }",
> +                          uri, extra ? extra : "");
>      rsp = qtest_qmp(who, cmd);
>      g_free(cmd);
>      g_assert(qdict_haskey(rsp, "return"));
> @@ -533,7 +533,7 @@ static void migrate_postcopy_prepare(QTestState **from_ptr,
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate(from, uri);
> +    migrate(from, uri, NULL);
>      g_free(uri);
>  
>      wait_for_migration_pass(from);
> @@ -573,7 +573,7 @@ static void test_baddest(void)
>      bool failed;
>  
>      test_migrate_start(&from, &to, "tcp:0:0", true);
> -    migrate(from, "tcp:0:0");
> +    migrate(from, "tcp:0:0", NULL);
>      do {
>          rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
>          rsp_return = qdict_get_qdict(rsp, "return");
> @@ -615,7 +615,7 @@ static void test_precopy_unix(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>  
> -    migrate(from, uri);
> +    migrate(from, uri, NULL);
>  
>      wait_for_migration_pass(from);
