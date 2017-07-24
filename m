Received: from eggs.gnu.org ([2001:4830:134:3::10]:41177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZlAv-0005ES-LC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZlAq-0006Mo-PA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:46:01 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZlAq-0006Mc-L1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:45:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id d136so11124720qkg.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:45:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170724210306.18428-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <90aa3a51-a392-931b-45a0-ba5e6530277f@twiddle.net>
Date: Mon, 24 Jul 2017 14:45:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170724210306.18428-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] tcg/softmmu: Increase size of TLB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On 07/24/2017 02:03 PM, Pranith Kumar wrote:
>   
> +#ifndef CPU_TLB_BITS_MAX
> +# define CPU_TLB_BITS_MAX 8

You should simply require each backend to define this.

> +++ b/tcg/i386/tcg-target.h
> @@ -162,6 +162,8 @@ extern bool have_popcnt;
>  # define TCG_AREG0 TCG_REG_EBP
>  #endif
>  
> +#define CPU_TLB_BITS_MAX 12

This is probably too much.

Exemplars:
NB_MMU_MODES = 1	moxie
NB_MMU_MODES = 2	m68k
NB_MMU_MODES = 3	alpha
NB_MMU_MODES = 7	arm
NB_MMU_MODES = 8	ppc64

sizeof(CPUArchState):

   tlb bits \ modes	1	2	3	7	8
	8		13856	25840	38952	92024	182576
	12		198176	394480	591912	1382264	1657136

Having 1.5MB of TLB data seems excessive.

Please let's get some performance numbers for various tlb bit sizes.

How much improvement do you get if you increase the size of the victim tlb cache?


r~
