Received: from eggs.gnu.org ([209.51.188.92]:34508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpLO6-0001xk-1N
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpLO4-0001pJ-Tk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:04:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:44747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpLO4-0001oa-Fv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:04:48 -0500
Received: by mail-pl1-x62f.google.com with SMTP id e11so2155381plt.11
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:04:48 -0800 (PST)
References: <20190131130700.28392-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3d50ef7-9777-b647-2e11-8f9229ca6022@linaro.org>
Date: Thu, 31 Jan 2019 15:04:44 -0800
MIME-Version: 1.0
In-Reply-To: <20190131130700.28392-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Make FPSCR/FPCR
 trapped-exception bits RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Martin Husemann <martin@netbsd.org>, patches@linaro.org

On 1/31/19 5:07 AM, Peter Maydell wrote:
> The {IOE, DZE, OFE, UFE, IXE, IDE} bits in the FPSCR/FPCR are for
> enabling trapped IEEE floating point exceptions (where IEEE exception
> conditions cause a CPU exception rather than updating the FPSR status
> bits). QEMU doesn't implement this (and nor does the hardware we're
> modelling), but for implementations which don't implement trapped
> exception handling these control bits are supposed to be RAZ/WI.
> This allows guest code to test for whether the feature is present
> by trying to write to the bit and checking whether it sticks.
> 
> QEMU is incorrectly making these bits read as written. Make them
> RAZ/WI as the architecture requires.
> 
> In particular this was causing problems for the NetBSD automatic
> test suite.
> 
> Reported-by: Martin Husemann <martin@netbsd.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Martin: this is a different fix to the one I suggested you test,
> because I realized we need to make these bits RAZ/WI in the aarch32
> FPSCR as well as the aarch64 FPCR, but it should have the same effect.
> 
> General note: the difference between "RAZ/WI" and "RES0" is a bit
> subtle (see the Arm ARM glossary), but the main distinction is that
> RES0 bits can often be implemented as reads-as-written whilst
> RAZ/WI bits never can.
> ---
>  target/arm/cpu.h    | 6 ++++++
>  target/arm/helper.c | 6 ++++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
