Received: from eggs.gnu.org ([2001:4830:134:3::10]:45196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoxFy-0003oV-7I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoxFt-00076R-8C
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:14:18 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoxFt-00075s-12
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:14:13 -0500
Received: by mail-pf0-x244.google.com with SMTP id a17so2531289pff.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 12:14:12 -0800 (PST)
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-6-richard.henderson@linaro.org>
	<CAFEAcA8bkt+dOehzyWm3=KUtiVRHak8Ge2gJTJuCg3VAyLQoSQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e62e1429-b812-7b92-5d61-055d6aa6a31e@linaro.org>
Date: Thu, 22 Feb 2018 12:14:08 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bkt+dOehzyWm3=KUtiVRHak8Ge2gJTJuCg3VAyLQoSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] aarch64-linux-user: Add support for
 SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/22/2018 08:41 AM, Peter Maydell wrote:
> On 16 February 2018 at 21:56, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Depending on the currently selected size of the SVE vector registers,
>> we can either store the data within the "standard" allocation, or we
>> may beedn to allocate additional space with an EXTRA record.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/signal.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 138 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index ca0ba28c98..4c9fef4bb2 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -1452,6 +1452,30 @@ struct target_extra_context {
>>      uint32_t reserved[3];
>>  };
>>
>> +#define TARGET_SVE_MAGIC    0x53564501
>> +
>> +struct target_sve_context {
>> +    struct target_aarch64_ctx head;
>> +    uint16_t vl;
>> +    uint16_t reserved[3];
> 
> Worth commenting that actual SVE register data will directly follow the struct.

Sure.

>> +static void target_restore_sve_record(CPUARMState *env,
>> +                                      struct target_sve_context *sve, int vq)
>> +{
>> +    int i, j;
>> +
>> +    /* Note that SVE regs are stored as a byte stream, with each byte element
>> +     * at a subsequent address.  This corresponds to a little-endian store
>> +     * of our 64-bit hunks.
> 
> We're doing loads in this function, not stores.

Oops.

>> +    /* SVE state needs saving only if it exists.  */
>> +    if (arm_feature(env, ARM_FEATURE_SVE)) {
>> +        vq = (env->vfp.zcr_el[1] & 0xf) + 1;
>> +        sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
>> +
>> +        /* For VQ <= 6, there is room in the standard space.  */
> 
> The kernel header arch/arm64/include/uapi/asm/sigcontext.h
> claims the record is in the standard space if "vl <= 64", which
> doesn't seem to match up with "VQ <= 6" ?

*shrug* I suppose the kernel guys only considered sizes that are powers of two,
even though other sizes are clearly allowed by the implementation?

The 4096 reserved bytes - sizeof(fpsimd) - sizeof(end) = 3560 bytes.
Values for TARGET_SVE_SIG_CONTEXT_SIZE(vq) are:
1	562
2	1108
3	1654
4	2200
5	2746
6	3292
7	3838
8	4384

So there's definitely room for VQ=6, with 268 bytes left over.

> 
>> +        if (sve_size <= std_size) {
>> +            sve_ofs = size;
>> +            size += sve_size;
>> +            end1_ofs = size;
>> +        } else {
>> +            /* Otherwise we need to allocate extra space.  */
>> +            extra_ofs = size;
>> +            size += sizeof(struct target_extra_context);
>> +            end1_ofs = size;
>> +            size += QEMU_ALIGN_UP(sizeof(struct target_aarch64_ctx), 16);
> 
> Why do we add the size of target_aarch64_ctx to size here?
> We already account for the size of the end record later, so
> what is this one?

This is for the end record within the extra space, as opposed to the end record
within the standard space which is what we accounted for before.  A comment
would help, I supposed.

> 
>> +            extra_base = size;
>> +            extra_size = sve_size + sizeof(struct target_aarch64_ctx);
> 
> If we ever get two different kinds of optional record that need to
> live in the extra space, this is going to need refactoring,
> because at the moment it assumes that the SVE record is the first
> and only thing that might live there. I guess that's OK for now, though.

I'm not quite sure how to generalize this; let's just let the next thing make
that change, once we know what's needed?


r~
