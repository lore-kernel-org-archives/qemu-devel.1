Received: from eggs.gnu.org ([2001:4830:134:3::10]:34944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZJjT-00026p-ST
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZJjQ-0004ap-PT
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:32:23 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZJjQ-0004ZY-Gw
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:32:20 -0400
Received: by mail-pf0-x242.google.com with SMTP id a11-v6so5621583pff.8
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 10:32:20 -0700 (PDT)
References: <20180622135823.32421-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <953186cb-c73b-c2ba-f083-58864e0bec41@linaro.org>
Date: Sat, 30 Jun 2018 10:32:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180622135823.32421-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] xtensa: Avoid calling
 get_page_addr_code() from helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 06/22/2018 06:58 AM, Peter Maydell wrote:
> The xtensa frontend calls get_page_addr_code() from its
> itlb_hit_test helper function. This function is really part
> of the TCG core's internals, and calling it from a target
> helper makes it awkward to make changes to that core code.
> It also means that we don't pass the correct retaddr to
> tlb_fill(), so we won't correctly handle the case where
> an exception is generated.
> 
> The helper is used for the instructions IHI, IHU and IPFL.

I think the implementation of these instructions is completely wrong.

(1a) IHI is not invalidating the cacheline within env->config->itlb,
(1b) IHI is not invalidating the qemu TLB that might contain a copy
     of same.

(2a) IPFL is not locking the entry in env->config->itlb,
(2b) IHU is not unlocking the same entry.
(2c) "Xtensa ISA implementations that do not implement cache locking
     must raise an illegal instruction exception when [IPFL or IHU]
     is executed."


r~
