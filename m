Received: from eggs.gnu.org ([209.51.188.92]:44963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwUU4-0007mY-GY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwUU3-00004u-LX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:12:32 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwUU3-0008UX-AO
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:12:31 -0500
Received: by mail-pl1-x642.google.com with SMTP id q3so5065735pll.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:12:29 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-8-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <751dd076-6e63-2c10-e8a3-a4a8ef2cc00a@linaro.org>
Date: Wed, 20 Feb 2019 08:12:26 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-8-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 07/73] cpu: make per-CPU locks an alias
 of the BQL in TCG rr mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 1/29/19 4:47 PM, Emilio G. Cota wrote:
> Before we can switch from the BQL to per-CPU locks in
> the CPU loop, we have to accommodate the fact that TCG
> rr mode (i.e. !MTTCG) cannot work with separate per-vCPU
> locks. That would lead to deadlock since we need a single
> lock/condvar pair on which to wait for events that affect
> any vCPU, e.g. in qemu_tcg_rr_wait_io_event.
> 
> At the same time, we are moving towards an interface where
> the BQL and CPU locks are independent, and the only requirement
> is that the locking order is respected, i.e. the BQL is
> acquired first if both locks have to be held at the same time.
> 
> In this patch we make the BQL a recursive lock under the hood.
> This allows us to (1) keep the BQL and CPU locks interfaces
> separate, and (2) use a single lock for all vCPUs in TCG rr mode.
> 
> Note that the BQL's API (qemu_mutex_lock/unlock_iothread) remains
> non-recursive.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  2 +-
>  cpus-common.c     |  2 +-
>  cpus.c            | 90 +++++++++++++++++++++++++++++++++++++++++------
>  qom/cpu.c         |  3 +-
>  stubs/cpu-lock.c  |  6 ++--
>  5 files changed, 86 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
