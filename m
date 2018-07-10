Received: from eggs.gnu.org ([2001:4830:134:3::10]:56336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxEJ-0006I4-Cy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxEF-0007Ve-EM
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:19:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-2-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <48a986e1-acd8-ce94-cf2a-763d51878ad6@twiddle.net>
Date: Tue, 10 Jul 2018 11:19:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] accel/tcg: Pass read access type
 through to io_readx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/10/2018 09:00 AM, Peter Maydell wrote:
> The io_readx() function needs to know whether the load it is
> doing is an MMU_DATA_LOAD or an MMU_INST_FETCH, so that it
> can pass the right value to the cpu_transaction_failed()
> function. Plumb this information through from the softmmu
> code.
> 
> This is currently not often going to give the wrong answer,
> because usually instruction fetches go via get_page_addr_code().
> However once we switch over to handling execution from non-RAM by
> creating single-insn TBs, the path for an insn fetch to generate
> a bus error will be through cpu_ld*_code() and io_readx(),
> so without this change we will generate a d-side fault when we
> should generate an i-side fault.
> 
> We also have to pass the access type via a CPU struct global
> down to unassigned_mem_read(), for the benefit of the targets
> which still use the cpu_unassigned_access() hook (m68k, mips,
> sparc, xtensa).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/softmmu_template.h | 11 +++++++----
>  include/qom/cpu.h            |  6 ++++++
>  accel/tcg/cputlb.c           |  5 +++--
>  memory.c                     |  3 ++-
>  4 files changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
