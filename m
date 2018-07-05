Received: from eggs.gnu.org ([2001:4830:134:3::10]:47271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fb0cG-0005Ii-HM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fb0cD-0000C1-CY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40862
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fb0cD-00009j-4v
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w659Sktx032736
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 05:31:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1cqu1hcy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 05:31:52 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Thu, 5 Jul 2018 10:31:50 +0100
Date: Thu, 5 Jul 2018 15:01:44 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-5-peterx@redhat.com>
Message-Id: <20180705093144.GA22608@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 4/9] tests: introduce
 migrate_postcopy_* helpers
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

On Thu, Jul 05, 2018 at 11:17:50AM +0800, Peter Xu wrote:
> Separate the old postcopy UNIX socket test into three steps, provide a
> helper for each step.  With these helpers, we can do more compliated
> tests like postcopy recovery, while keep the codes shared.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/migration-test.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 3a85446f95..2155869b96 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -351,13 +351,19 @@ static void migrate(QTestState *who, const char *uri)
>      qobject_unref(rsp);
>  }
> 
> -static void migrate_start_postcopy(QTestState *who)
> +static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  {
>      QDict *rsp;
> 
> -    rsp = wait_command(who, "{ 'execute': 'migrate-start-postcopy' }");
> +    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +
> +    qtest_qmp_eventwait(to, "RESUME");
>  }
> 
>  static void test_migrate_start(QTestState **from, QTestState **to,
> @@ -505,7 +511,8 @@ static void test_deprecated(void)
>      qtest_quit(from);
>  }
> 
> -static void test_postcopy(void)
> +static void migrate_postcopy_prepare(QTestState **from_ptr,
> +                                     QTestState **to_ptr)

if we have uri as one of the configurable argument, it would be still
better, so that in future we can call migrate_postcopy_prepare() with
any different uri.

-- Bala

>  {
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> @@ -527,28 +534,37 @@ static void test_postcopy(void)
>      wait_for_serial("src_serial");
> 
>      migrate(from, uri);
> +    g_free(uri);
> 
>      wait_for_migration_pass(from);
> 
> -    migrate_start_postcopy(from);
> -
> -    if (!got_stop) {
> -        qtest_qmp_eventwait(from, "STOP");
> -    }
> +    *from_ptr = from;
> +    *to_ptr = to;
> +}
> 
> -    qtest_qmp_eventwait(to, "RESUME");
> +static void migrate_postcopy_complete(QTestState *from, QTestState *to)
> +{
> +    wait_for_migration_complete(from);
> 
> +    /* Make sure we get at least one "B" on destination */
>      wait_for_serial("dest_serial");
> -    wait_for_migration_complete(from);
> 
>      if (uffd_feature_thread_id) {
>          read_blocktime(to);
>      }
> -    g_free(uri);
> 
>      test_migrate_end(from, to, true);
>  }
> 
> +static void test_postcopy(void)
> +{
> +    QTestState *from, *to;
> +
> +    migrate_postcopy_prepare(&from, &to);
> +    migrate_postcopy_start(from, to);
> +    migrate_postcopy_complete(from, to);
> +}
> +




>  static void test_baddest(void)
>  {
>      QTestState *from, *to;
> -- 
> 2.17.1
> 
> 
