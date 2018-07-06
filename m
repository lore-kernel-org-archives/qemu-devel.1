Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbOBH-0002fD-Pf
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbOBC-0005J0-QZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:41:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43638
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fbOBC-0005Gb-JW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:41:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66AchQa113253
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 06:41:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k24m5drms-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:41:32 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 6 Jul 2018 11:41:31 +0100
Date: Fri, 6 Jul 2018 16:11:24 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-8-peterx@redhat.com>
Message-Id: <20180706104124.GB16585@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org

On Thu, Jul 05, 2018 at 11:17:53AM +0800, Peter Xu wrote:
> It's generalized from wait_for_migration_complete() to allow us to wait
> for any migration status besides failure.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

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
> 
