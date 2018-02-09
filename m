Received: from eggs.gnu.org ([2001:4830:134:3::10]:33905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF9z-0003ND-FQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF9w-0003wb-80
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:20:39 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:40433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekF9w-0003wR-1V
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:20:36 -0500
Received: by mail-it0-x229.google.com with SMTP id 196so12138817iti.5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:20:35 -0800 (PST)
References: <20180209104546.29401-1-pbonzini@redhat.com>
	<20180209104546.29401-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ee62d37-c56c-d2f0-029b-921699273cfa@linaro.org>
Date: Fri, 9 Feb 2018 12:20:32 -0800
MIME-Version: 1.0
In-Reply-To: <20180209104546.29401-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] memory: introduce
 memory_global_after_dirty_log_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 02/09/2018 02:45 AM, Paolo Bonzini wrote:
> There is a race between TCG and accesses to the dirty log:
> 
>       vCPU thread                  reader thread
>       -----------------------      -----------------------
>       TLB check -> slow path
>         notdirty_mem_write
>           write to RAM
>           set dirty flag
>                                    clear dirty flag
>       TLB check -> fast path
>                                    read memory
>         write to RAM
> 
> Fortunately, in order to fix it, no change is required to the
> vCPU thread.  However, the reader thread must delay the read after
> the vCPU thread has finished the write.  This can be approximated
> conservatively by run_on_cpu, which waits for the end of the current
> translation block.
> 
> A similar technique is used by KVM, which has to do a synchronous TLB
> flush after doing a test-and-clear of the dirty-page flags.
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c                | 31 +++++++++++++++++++++++++++++++
>  include/exec/memory.h | 12 ++++++++++++
>  memory.c              | 10 +++++++++-
>  migration/ram.c       |  1 +
>  4 files changed, 53 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
