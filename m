Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC24Q-0002WZ-KK
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC24N-0004RQ-7I
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:29:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eC24N-0004Qv-15
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2336D5D5E6
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 11:29:26 +0000 (UTC)
References: <20171106190233.1175-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1164825c-8f4a-ec21-0a29-ae0ff42bdb1d@redhat.com>
Date: Tue, 7 Nov 2017 12:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171106190233.1175-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests-aio-multithread: fix
 /aio/multi/schedule race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 06/11/2017 20:02, Stefan Hajnoczi wrote:
> test_multi_co_schedule_entry() set to_schedule[id] in the final loop
> iteration before terminating the coroutine.  There is a race condition
> where the main thread attempts to enter the terminating or terminated
> coroutine when signalling coroutines to stop:
> 
>   atomic_mb_set(&now_stopping, true);
>   for (i = 0; i < NUM_CONTEXTS; i++) {
>       ctx_run(i, finish_cb, NULL);  <--- enters dead coroutine!
>       to_schedule[i] = NULL;
>   }
> 
> Make sure only to set to_schedule[id] if this coroutine really needs to
> be scheduled!
> 
> Reported-by: "R.Nageswara Sastry" <nasastry@in.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This patch is appropriate for the QEMU 2.11 release to eliminate
> spurious test failures.
> 
>  tests/test-aio-multithread.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
> index 549d784915..d396185972 100644
> --- a/tests/test-aio-multithread.c
> +++ b/tests/test-aio-multithread.c
> @@ -144,17 +144,16 @@ static void finish_cb(void *opaque)
>  static coroutine_fn void test_multi_co_schedule_entry(void *opaque)
>  {
>      g_assert(to_schedule[id] == NULL);
> -    atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
>  
>      while (!atomic_mb_read(&now_stopping)) {
>          int n;
>  
>          n = g_test_rand_int_range(0, NUM_CONTEXTS);
>          schedule_next(n);
> +
> +        atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
>          qemu_coroutine_yield();
> -
>          g_assert(to_schedule[id] == NULL);
> -        atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
>      }
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo
