Received: from eggs.gnu.org ([2001:4830:134:3::10]:55939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ez3Hi-0003Lc-Bf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ez3Hh-0001Y3-Hf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:41:50 -0400
References: <20180322152834.12656-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c80e31f8-b049-6634-6eb5-c81914983922@redhat.com>
Date: Thu, 22 Mar 2018 17:41:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180322152834.12656-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] coroutine: avoid co_queue_wakeup
 recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On 22/03/2018 16:28, Stefan Hajnoczi wrote:
> co_queue_wakeup is currently implemented in a recursive fashion.  Pathological
> patterns of aio_co_enter() between coroutines can cause stack exhaustion.
> 
> This patch series implements co_queue_wakeup iteratively and avoids stack
> exhaustion.
> 
> This issue was originally reported with qemu-img convert but I don't have a
> good reproducer.  See Patch 3 for a test-aio test case instead.
> 
> Stefan Hajnoczi (3):
>   queue: add QSIMPLEQ_PREPEND()
>   coroutine: avoid co_queue_wakeup recursion
>   coroutine: add test-aio coroutine queue chaining test case
> 
>  include/qemu/coroutine_int.h |   1 -
>  include/qemu/queue.h         |   8 ++++
>  block/io.c                   |   3 +-
>  tests/test-aio.c             |  65 ++++++++++++++++++++-----
>  util/qemu-coroutine-lock.c   |  34 -------------
>  util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------------
>  6 files changed, 120 insertions(+), 101 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

I was a little surprised by the disappearing of the "do not use co
anymore" comments, but they seem unnecessary indeed with the new code.

Paolo
