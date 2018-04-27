Received: from eggs.gnu.org ([2001:4830:134:3::10]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBr2C-0000pu-D7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBr2B-0007rj-Fn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:14:44 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:41110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBr2B-0007rQ-8H
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:14:43 -0400
Received: by mail-pf0-x22a.google.com with SMTP id v63so110753pfk.8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 17:14:43 -0700 (PDT)
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-23-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ec6ba72-fee7-52db-a73a-be1720a06383@linaro.org>
Date: Thu, 26 Apr 2018 14:14:37 -1000
MIME-Version: 1.0
In-Reply-To: <1524699938-6764-23-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 22/35] RISC-V: Use atomic_cmpxchg to
 update PLIC bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 04/25/2018 01:45 PM, Michael Clark wrote:
> +    uint32_t old, new;
> +    do {
> +        old = atomic_read(&plic->pending[word]);
> +        new = (old & ~(1 << (irq & 31))) | (-!!pending & (1 << (irq & 31)));
> +    } while (atomic_cmpxchg(&plic->pending[word], old, new) != old);

I prefer

  uint32_t old, new, cmp = atomic_read(...);
  do {
    old = cmp;
    new = ...;
    cmp = atomic_cmpxchg(...);
  } while (old != cmp);

to avoid an extra load, should we loop.

That said, what you have is not wrong.  So,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
