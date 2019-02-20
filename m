Received: from eggs.gnu.org ([209.51.188.92]:45323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVcG-00022z-Su
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVcG-0008H4-98
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:25:04 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwVcG-0008Gg-1x
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:25:04 -0500
Received: by mail-pf1-x441.google.com with SMTP id j5so7720247pfa.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:25:03 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-71-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <718fcd4c-2782-e05d-8363-c1da66e9c556@linaro.org>
Date: Wed, 20 Feb 2019 09:25:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-71-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 70/73] cpu: protect CPU state with
 cpu->lock instead of the BQL
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

On 1/29/19 4:48 PM, Emilio G. Cota wrote:
> Use the per-CPU locks to protect the CPUs' state, instead of
> using the BQL. These locks are uncontended (they are mostly
> acquired by the corresponding vCPU thread), so acquiring them
> is cheaper than acquiring the BQL, which particularly in
> MTTCG can be contended at high core counts.
> 
> In this conversion we drop qemu_cpu_cond and qemu_pause_cond,
> and use cpu->cond instead.
> 
> In qom/cpu.c we can finally remove the ugliness that
> results from having to hold both the BQL and the CPU lock;
> now we just have to grab the CPU lock.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  20 ++--
>  cpus.c            | 280 ++++++++++++++++++++++++++++++++++------------
>  qom/cpu.c         |  29 +----
>  3 files changed, 225 insertions(+), 104 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
