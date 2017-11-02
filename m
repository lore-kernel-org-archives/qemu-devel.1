Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eADud-00018c-4n
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eADuZ-00049q-73
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:55 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eADuZ-00048X-10
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id r68so10732153wmr.3
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 04:43:50 -0700 (PDT)
References: <1509622400-13351-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa20fe35-6c76-3194-d633-cae8d2a6116f@linaro.org>
Date: Thu, 2 Nov 2017 12:43:46 +0100
MIME-Version: 1.0
In-Reply-To: <1509622400-13351-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] translate.c: Fix usermode big-endian
 AArch32 LDREXD and STREXD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, christophe.lyon@linaro.org

On 11/02/2017 12:33 PM, Peter Maydell wrote:
> For AArch32 LDREXD and STREXD, architecturally the 32-bit word at the
> lowest address is always Rt and the one at addr+4 is Rt2, even if the
> CPU is big-endian. Our implementation does these with a single
> 64-bit store, so if we're big-endian then we need to put the two
> 32-bit halves together in the opposite order to little-endian,
> so that they end up in the right places. We were trying to do
> this with the gen_aa32_frob64() function, but that is not correct
> for the usermode emulator, because there there is a distinction
> between "load a 64 bit value" (which does a BE 64-bit access
> and doesn't need swapping) and "load two 32 bit values as one
> 64 bit access" (where we still need to do the swapping, like
> system mode BE32).
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1725267
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * use correct "s->be_data == MO_BE" check for bigendian
>  * don't mangle the data from the atomic-cmpxchg before
>    comparing against expected value
>  * tcg_temp_free() the TCGv from gen_aa32_addr()
>  * name that TCGv "taddr" rather than "a"...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
