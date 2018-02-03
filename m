Received: from eggs.gnu.org ([2001:4830:134:3::10]:51230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei50n-0003X1-Mz
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei50i-0001y7-Ot
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:06:13 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei50i-0001vh-I3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:06:08 -0500
Received: by mail-pg0-x241.google.com with SMTP id s73so1450339pgc.1
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:06:08 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de16ce7c-ae92-e103-aa85-02006937892d@linaro.org>
Date: Sat, 3 Feb 2018 13:06:04 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/arm: Split "get pending
 exception info" from "acknowledge it"
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

On 01/30/2018 07:02 AM, Peter Maydell wrote:
> Currently armv7m_nvic_acknowledge_irq() does three things:
>  * make the current highest priority pending interrupt active
>  * return a bool indicating whether that interrupt is targeting
>    Secure or NonSecure state
>  * implicitly tell the caller which is the highest priority
>    pending interrupt by setting env->v7m.exception
> 
> We need to split these jobs, because v7m_exception_taken()
> needs to know whether the pending interrupt targets Secure so
> it can choose to stack callee-saves registers or not, but it
> must not make the interrupt active until after it has done
> that stacking, in case the stacking causes a derived exception.
> Similarly, it needs to know the number of the pending interrupt
> so it can read the correct vector table entry before the
> interrupt is made active, because vector table reads might
> also cause a derived exception.
> 
> Create a new armv7m_nvic_get_pending_irq_info() function which simply
> returns information about the highest priority pending interrupt, and
> use it to rearrange the v7m_exception_taken() code so we don't
> acknowledge the exception until we've done all the things which could
> possibly cause a derived exception.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 19 ++++++++++++++++---
>  hw/intc/armv7m_nvic.c | 30 +++++++++++++++++++++++-------
>  target/arm/helper.c   | 16 ++++++++++++----
>  hw/intc/trace-events  |  3 ++-
>  4 files changed, 53 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
