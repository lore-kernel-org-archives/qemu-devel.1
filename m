Received: from eggs.gnu.org ([2001:4830:134:3::10]:53833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKlBy-0005c8-7f
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKlBv-0001P0-HK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:21:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKlBv-0001Oe-AK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:21:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id i17-v6so21449591wre.7
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:21:51 -0800 (PST)
References: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
	<1541616504-68526-2-git-send-email-bijan.mottahedeh@oracle.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <47f78310-56e7-ba5e-0fb1-99830750e49b@linaro.org>
Date: Thu, 8 Nov 2018 15:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <1541616504-68526-2-git-send-email-bijan.mottahedeh@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC QEMU 1/2] arm/virt: Initialize generic timer
 scale factor dynamically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>, qemu-devel@nongnu.org
Cc: kvmarm@lists.cs.columbia.edu

On 11/7/18 7:48 PM, Bijan Mottahedeh wrote:
>  
> +static void set_system_clock_scale(void)
> +{
> +    unsigned long cntfrq_el0;
> +
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(cntfrq_el0));
> +
> +    if (cntfrq_el0 == 0) {
> +        cntfrq_el0 = GTIMER_SCALE_DEF;
> +    }
> +
> +    system_clock_scale = NANOSECONDS_PER_SECOND / (int)cntfrq_el0;
> +}

This only works for kvm.

For TCG you need to use the default always.  In particular, it won't even
compile for an x86 host.


r~
