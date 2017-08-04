Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddhYP-0004R9-1d
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddhYL-0001pX-Tk
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:42:33 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddhYL-0001o2-Lr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:42:29 -0400
Received: by mail-pg0-x22d.google.com with SMTP id l64so11050991pge.5
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 11:42:29 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45d91dda-55e3-0221-d56d-66fbecdb7d9c@linaro.org>
Date: Fri, 4 Aug 2017 11:42:26 -0700
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] cpu: Define new
 cpu_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/04/2017 10:20 AM, Peter Maydell wrote:
> Currently we have a rather half-baked setup for allowing CPUs to
> generate exceptions on accesses to invalid memory: the CPU has a
> cpu_unassigned_access() hook which the memory system calls in
> unassigned_mem_write() and unassigned_mem_read() if the current_cpu
> pointer is non-NULL.  This was originally designed before we
> implemented the MemTxResult type that allows memory operations to
> report a success or failure code, which is why the hook is called
> right at the bottom of the memory system.  The major problem with
> this is that it means that the hook can be called even when the
> access was not actually done by the CPU: for instance if the CPU
> writes to a DMA engine register which causes the DMA engine to begin
> a transaction which has been set up by the guest to operate on
> invalid memory then this will casue the CPU to take an exception
> incorrectly.  Another minor problem is that currently if a device
> returns a transaction error then this won't turn into a CPU exception
> at all.
> 
> The right way to do this is to have allow the CPU to respond
> to memory system transaction failures at the point where the
> CPU specific code calls into the memory system.
> 
> Define a new QOM CPU method and utility function
> cpu_transaction_failed() which is called in these cases.
> The functionality here overlaps with the existing
> cpu_unassigned_access() because individual target CPUs will
> need some work to convert them to the new system. When this
> transition is complete we can remove the old cpu_unassigned_access()
> code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qom/cpu.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
