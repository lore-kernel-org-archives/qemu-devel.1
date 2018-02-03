Received: from eggs.gnu.org ([2001:4830:134:3::10]:53371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5Fd-00038m-2f
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5FZ-0004Eo-4B
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:21:33 -0500
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei5FY-0004EM-SE
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:21:29 -0500
Received: by mail-pl0-x22b.google.com with SMTP id j19so8980205pll.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:21:28 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <675ab9e3-80ec-97fc-5c01-ce28b2d2d4d1@linaro.org>
Date: Sat, 3 Feb 2018 13:21:24 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/arm: Make v7M exception entry
 stack push check MPU
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
> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &physaddr,
> +                      &attrs, &prot, &page_size, &fi, NULL)) {

Given that you know you're going to call this at least 8 times in a row,
probably with all operations on the same page, it is worth querying the qemu
tlb first, and when that fails but the lookup succeeds, installing the result
into the tlb?

I know we don't have a primitive for that within exec/cputlb.h, but perhaps we
should.  Perhaps a more generic form of probe_write...

That said, this isn't wrong so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
