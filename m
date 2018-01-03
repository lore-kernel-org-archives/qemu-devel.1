Received: from eggs.gnu.org ([2001:4830:134:3::10]:46900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWs4F-0007y4-Ak
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWs4B-0005bT-Vn
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:03:27 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWs4B-0005aW-Ow
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:03:23 -0500
Received: by mail-pf0-x243.google.com with SMTP id y89so1356417pfk.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 15:03:23 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-10-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2f758ef-d699-7b4d-cef5-bd692b8ba791@linaro.org>
Date: Wed, 3 Jan 2018 15:03:19 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-10-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/21] RISC-V Physical Memory Protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +#ifdef DEBUG_PMP
> +#define PMP_PRINTF(fmt, ...) \
> +do { fprintf(stderr, "pmp: " fmt, ## __VA_ARGS__); } while (0)
> +#else
> +#define PMP_PRINTF(fmt, ...) \
> +do {} while (0)
> +#endif

Debugging goes to qemu_log.

Rearrange this so that formatting is always compile-time checked.
E.g.

#define DEBUG_PMP 0
#define PMP_PRINTF(fmt, ...)                  \
  do {                                        \
    if (DEBUG_PMP) {                          \
      qemu_log("pmp: " fmt, ##__VA_ARGS__);   \
    }                                         \
  } while (0)

> 
> +static target_ulong pmp_get_napot_base_and_range(target_ulong reg,
> +    target_ulong *range)
> +{
> +    /* construct a mask of all bits bar the top bit */
> +    target_ulong mask = 0u;
> +    target_ulong base = reg;
> +    target_ulong numbits = (sizeof(target_ulong) * 8u) + 2u;
> +    mask = (mask - 1u) >> 1;
> +
> +    while (mask) {
> +        if ((reg & mask) == mask) {
> +            /* this is the mask to use */
> +            base = reg & ~mask;
> +            break;
> +        }
> +        mask >>= 1;
> +        numbits--;
> +    }
> +
> +    *range = (1lu << numbits) - 1u;
> +    return base;
> +}

You can compute napot with ctz64(~reg).
More useless LU suffixes.

> +    if (pmp_index >= 1u) {
> +        prev_addr = env->pmp_state.pmp[pmp_index].addr_reg;

pmp_index - 1

> 
> +    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +        const uint8_t a_field =
> +            pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
> +        if (PMP_AMATCH_OFF != a_field) {
> +            env->pmp_state.num_rules++;
> +        }
> +    }

Doesn't this mean that pmp_index ordering != pmp_state ordering?  Which would
mean that you'd be matching rules in the wrong order for the static prioirity.

> +static int pmp_is_in_range(CPURISCVState *env, int pmp_index, target_ulong addr)
> +{
> +    int result = 0;
> +
> +    if ((addr >= env->pmp_state.addr[pmp_index].sa)
> +        && (addr < env->pmp_state.addr[pmp_index].ea)) {
> +        result = 1;

Given how the range is computed in pmp_update_rule, surely <= ea.

> +        s = pmp_is_in_range(env, i, addr);
> +        e = pmp_is_in_range(env, i, addr + size);

Surely addr + size - 1.

> 
> +    /* val &= 0x3ffffffffffffful; */
> +

Why is this commented out?  Surely that's exactly what the spec says.
Although it's easier to compare as

  val = extract64(val, 0, 54);


r~
