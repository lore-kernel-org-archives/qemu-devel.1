Received: from eggs.gnu.org ([2001:4830:134:3::10]:32835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e44Co-0008QJ-Le
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e44Cl-0005ng-C6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e44Cl-0005mA-5O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 415214E34A
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 12:09:10 +0000 (UTC)
Date: Mon, 16 Oct 2017 13:09:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171016120901.GD2252@work-vm>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004103933.7898-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add basic migration precopy tcp
 test
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
>  tests/migration-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index cd954caee4..8ef2b72459 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -466,6 +466,13 @@ static void test_precopy_unix(void)
>      g_free(uri);
>  }
>  
> +static void test_precopy_tcp(void)
> +{
> +    const char *uri = "tcp:0:44444";
> +
> +    test_precopy(uri);
> +}

The problem is that this will fail if you make check -j  and two
tests use 4444 at the same time.
That's pretty common especially when you've built multiple architectures
as targets and all the same tests run at the same time.

Dave

>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -482,6 +489,7 @@ int main(int argc, char **argv)
>      module_call_init(MODULE_INIT_QOM);
>  
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> +    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>  
>      ret = g_test_run();
>  
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
