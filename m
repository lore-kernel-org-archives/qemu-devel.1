Received: from eggs.gnu.org ([2001:4830:134:3::10]:55008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXdjA-0000j0-Kr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXdj7-0000cH-5Y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:01:24 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXdj6-0000Zk-LX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:01:21 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so3423618oie.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:01:20 -0800 (PST)
References: <20181213235804.14956-1-benh@kernel.crashing.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ad68048-8f16-930f-2e87-ca90d8038bd0@linaro.org>
Date: Thu, 13 Dec 2018 21:01:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181213235804.14956-1-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] memory_ldst: Add atomic ops for PTE
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 12/13/18 5:58 PM, Benjamin Herrenschmidt wrote:
> +#ifdef CONFIG_ATOMIC64
> +/* This is meant to be used for atomic PTE updates under MT-TCG */
> +uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs, MemTxResult *result)
> +{
> +    uint8_t *ptr;
> +    MemoryRegion *mr;
> +    hwaddr l = 8;
> +    hwaddr addr1;
> +    MemTxResult r;
> +    uint8_t dirty_log_mask;
> +
> +    /* Must test result */
> +    assert(result);
> +
> +    RCU_READ_LOCK();
> +    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> +    if (l < 8 || !memory_access_is_direct(mr, true)) {
> +        r = MEMTX_ERROR;
> +    } else {
> +        uint32_t orig = old;
> +
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> +        old = atomic_cmpxchg(ptr, orig, new);
> +

I think you need atomic_cmpxchg__nocheck here.

Failure would be with a 32-bit host that supports ATOMIC64.
E.g. i686.


r~
