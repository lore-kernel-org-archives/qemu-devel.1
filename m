Received: from eggs.gnu.org ([2001:4830:134:3::10]:58878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb1U8-0007yr-Gn
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb1U3-0007lU-Ke
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:27:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fb1U3-0007kj-GC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16DD240251DD
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 10:27:31 +0000 (UTC)
Date: Thu, 5 Jul 2018 11:27:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180705102725.GI2538@work-vm>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 7/9] tests: introduce
 wait_for_migration_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> It's generalized from wait_for_migration_complete() to allow us to wait
> for any migration status besides failure.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 1d85ccbef1..761bf62ffe 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -231,14 +231,15 @@ static void read_blocktime(QTestState *who)
>      qobject_unref(rsp_return);
>  }
>  
> -static void wait_for_migration_complete(QTestState *who)
> +static void wait_for_migration_status(QTestState *who,
> +                                      const char *goal)
>  {
>      while (true) {
>          bool completed;
>          char *status;
>  
>          status = migrate_query_status(who);
> -        completed = strcmp(status, "completed") == 0;
> +        completed = strcmp(status, goal) == 0;
>          g_assert_cmpstr(status, !=,  "failed");
>          g_free(status);
>          if (completed) {
> @@ -248,6 +249,11 @@ static void wait_for_migration_complete(QTestState *who)
>      }
>  }
>  
> +static void wait_for_migration_complete(QTestState *who)
> +{
> +    wait_for_migration_status(who, "completed");
> +}
> +
>  static void wait_for_migration_pass(QTestState *who)
>  {
>      uint64_t initial_pass = get_migration_pass(who);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
