Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZaXB-0001lU-QA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZaX6-0000gy-RM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZaX6-0000gA-Id
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:56:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A495CBDC1
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:56:27 +0000 (UTC)
Date: Thu, 11 Jan 2018 10:56:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111105621.GB2669@work-vm>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105215246.908-11-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/11] tests: Adjust sleeps for
 migration test
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
> Also reorder code to not sleep when event already happened.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 70b3c0870b..8914829006 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -280,10 +280,9 @@ static void read_blocktime(QTestState *who)
>  
>  static void wait_for_migration_complete(QTestState *who)
>  {
> -    QDict *rsp, *rsp_return;
> -    bool completed;
> -
> -    do {
> +    while (true) {
> +        QDict *rsp, *rsp_return;
> +        bool completed;
>          const char *status;
>  
>          rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
> @@ -292,8 +291,11 @@ static void wait_for_migration_complete(QTestState *who)
>          completed = strcmp(status, "completed") == 0;
>          g_assert_cmpstr(status, !=,  "failed");
>          QDECREF(rsp);
> -        usleep(1000 * 100);
> -    } while (!completed);
> +        if (completed) {
> +            return;
> +        }
> +        usleep(1000);
> +    }

OK, so that's mostly about avoiding a sleep in the exit from the normal
path.

>  }
>  
>  static void wait_for_migration_pass(QTestState *who)
> @@ -302,16 +304,13 @@ static void wait_for_migration_pass(QTestState *who)
>      uint64_t pass;
>  
>      /* Wait for the 1st sync */
> -    do {
> +    while (!got_stop && !initial_pass) {
> +        usleep(1000);
>          initial_pass = get_migration_pass(who);
> -        if (got_stop || initial_pass) {
> -            break;
> -        }
> -        usleep(1000 * 100);
> -    } while (true);
> +    }
>  
>      do {
> -        usleep(1000 * 100);
> +        usleep(1000);
>          pass = get_migration_pass(who);
>      } while (pass == initial_pass && !got_stop);
>  }

OK

> @@ -510,13 +509,13 @@ static void test_migrate_end(QTestState *from, QTestState *to)
>      /* Destination still running, wait for a byte to change */
>      do {
>          qtest_memread(to, start_address, &dest_byte_b, 1);
> -        usleep(10 * 1000);
> +        usleep(1000 * 10);

Profound :-)

>      } while (dest_byte_a == dest_byte_b);
>  
>      qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
>      /* With it stopped, check nothing changes */
>      qtest_memread(to, start_address, &dest_byte_c, 1);
> -    sleep(1);
> +    usleep(1000 * 200);

OK

>      qtest_memread(to, start_address, &dest_byte_d, 1);
>      g_assert_cmpint(dest_byte_c, ==, dest_byte_d);



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
