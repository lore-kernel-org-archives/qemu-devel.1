Received: from eggs.gnu.org ([2001:4830:134:3::10]:56103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZI3E-0001zu-IM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZI3B-000754-GN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:16:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZI3B-00074C-6p
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:16:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id z10so8025832pgp.7
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 08:16:53 -0800 (PST)
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
	<5139703f-0573-7498-b3a5-3d09661618ff@ilande.co.uk>
	<b0fc04d3-967d-f4c0-defe-63f1fbcd3893@linaro.org>
	<b63dda3a-7532-1685-d6fa-65180715a596@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41834473-b92d-8fd0-eb84-4f0cf1e7eedc@linaro.org>
Date: Tue, 18 Dec 2018 08:16:49 -0800
MIME-Version: 1.0
In-Reply-To: <b63dda3a-7532-1685-d6fa-65180715a596@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/18/18 7:26 AM, Mark Cave-Ayland wrote:
> That seems wrong to me. Given that the ppc_avr_t is a union then I'd expect it to be
> in host order? Certainly in the VMX helper macros I've looked at, the members are set
> directly with no byte swapping.

"Host order"?  For both words of the vector?

That's certainly going to cause problems wrt VSX and FPU registers.  We're
hard-coding that as fpu == vsx.u64[0] (both before and after your patch set).

For vscr, on master we have

void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)
{
#if defined(HOST_WORDS_BIGENDIAN)
    env->vscr = r->u32[3];
#else
    env->vscr = r->u32[0];
#endif

and

        if (needs_byteswap) {
            vmxregset->avr[i].u64[0] = bswap64(cpu->env.avr[i].u64[1]);
            vmxregset->avr[i].u64[1] = bswap64(cpu->env.avr[i].u64[0]);
        } else {
            vmxregset->avr[i].u64[0] = cpu->env.avr[i].u64[0];
            vmxregset->avr[i].u64[1] = cpu->env.avr[i].u64[1];
        }
    }
    vmxregset->vscr.u32[3] = cpu_to_dump32(s, cpu->env.vscr);

For helper macros that apply the same operation to all lanes, it doesn't matter
which order in which the lanes are processed, so of course I would expect them
to be processed in host order.

It's cases that do not apply the same operation, such as merges, where the
problems would arise.

There are at least 3 schemes being employed to address this:

#if defined(HOST_WORDS_BIGENDIAN)
#define HI_IDX 0
#define LO_IDX 1
#define AVRB(i) u8[i]
#define AVRW(i) u32[i]
#else
#define HI_IDX 1
#define LO_IDX 0
#define AVRB(i) u8[15-(i)]
#define AVRW(i) u32[3-(i)]
#endif

...
#if defined(HOST_WORDS_BIGENDIAN)
#define EL_IDX(i) (i)
#else
#define EL_IDX(i) (3 - (i))
#endif

...
#define EL_IDX(i) (i)
#else
#define EL_IDX(i) (1 - (i))
#endif

...
#if defined(HOST_WORDS_BIGENDIAN)
        result.u8[i] = a->u8[indexA] ^ b->u8[indexB];
#else
        result.u8[i] = a->u8[15-indexA] ^ b->u8[15-indexB];
#endif


r~
