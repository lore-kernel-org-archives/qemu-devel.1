Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grPg7-00027I-Rd
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grPS1-0005cb-GX
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:49:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grPRu-0005ZB-A3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:49:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F636811DC
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 15:49:15 +0000 (UTC)
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f8d5617e-c1bb-24a2-2ac0-3956137b96b3@redhat.com>
Date: Wed, 6 Feb 2019 16:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190206132331.1694-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] tests: Add migration multifd test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 2019-02-06 14:23, Juan Quintela wrote:
> We set multifd-channels.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index a27f095b28..3e0e447f95 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -942,6 +942,53 @@ static void test_precopy_tcp(void)
>      g_free(uri);
>  }
>  
> +static void test_multifd_tcp(void)
> +{
> +    char *uri;
> +    QTestState *from, *to;
> +
> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false)) {
> +        return;
> +    }
> +
> +    /*
> +     * We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 1 ms should make it not converge*/
> +    migrate_set_parameter(from, "downtime-limit", 1);
> +    /* 1GB/s */
> +    migrate_set_parameter(from, "max-bandwidth", 1000000000);
> +
> +    migrate_set_parameter(from, "multifd-channels", 2);
> +    migrate_set_parameter(to, "multifd-channels", 2);
> +
> +    migrate_set_capability(from, "multifd", "true");
> +    migrate_set_capability(to, "multifd", "true");
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    uri = migrate_get_socket_address(to, "socket-address");
> +
> +    migrate(from, uri, "{}");
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 300ms it should converge */
> +    migrate_set_parameter(from, "downtime-limit", 300);
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +
> +    test_migrate_end(from, to, true);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -995,6 +1042,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
> +    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
>  
>      ret = g_test_run();

Acked-by: Thomas Huth <thuth@redhat.com>
