Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbO6g-00017B-Lk
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbO6d-0002bU-GW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:36:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37630
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fbO6d-0002Tp-9d
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:36:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66ASW6E051718
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 06:36:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k25sfah8s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:36:48 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 6 Jul 2018 11:36:47 +0100
Date: Fri, 6 Jul 2018 16:06:40 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-6-peterx@redhat.com>
Message-Id: <20180706103640.GA16585@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org

On Thu, Jul 05, 2018 at 11:17:51AM +0800, Peter Xu wrote:
> For example, we can pass in '"resume": true' to resume a migration.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

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
> 
> -- 
> 2.17.1
> 
> 
