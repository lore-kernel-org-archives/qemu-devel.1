Received: from eggs.gnu.org ([2001:4830:134:3::10]:35144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cweO3-0001iB-EN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cweO0-0006qP-Bh
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cweO0-0006q0-5n
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A89C8553C
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 00:37:51 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-8-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <47608498-a23c-37d4-2b31-f2d70bdcdd87@redhat.com>
Date: Fri, 7 Apr 2017 20:37:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/10] blockjob: strengthen a bit
 test-blockjob-txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
> Unlike test-blockjob-txn, QMP releases the reference to the transaction
> before the jobs finish.  Thus, while working on the next patch,
> qemu-iotest 124 showed a failure that the unit tests did not have.
> Make the unit test just a little nastier, so that it fails too.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
> index 4ccbda1..bfc2aaa 100644
> --- a/tests/test-blockjob-txn.c
> +++ b/tests/test-blockjob-txn.c
> @@ -165,6 +165,11 @@ static void test_pair_jobs(int expected1, int expected2)
>      job2 = test_block_job_start(2, true, expected2, &result2);
>      block_job_txn_add_job(txn, job2);
>  

^ Oh, this might cause you grief too. Should be add-add-start-start, not
start-add-start-add. Fam sent a patch fixing this recently.

> +    /* Release our reference now to trigger as many nice
> +     * use-after-free bugs as possible.
> +     */
> +    block_job_txn_unref(txn);
> +

This is fine, though.

>      if (expected1 == -ECANCELED) {
>          block_job_cancel(job1);
>      }
> @@ -185,8 +190,6 @@ static void test_pair_jobs(int expected1, int expected2)
>  
>      g_assert_cmpint(result1, ==, expected1);
>      g_assert_cmpint(result2, ==, expected2);
> -
> -    block_job_txn_unref(txn);
>  }
>  
>  static void test_pair_jobs_success(void)
> 

Reviewed-by: John Snow <jsnow@redhat.com>
