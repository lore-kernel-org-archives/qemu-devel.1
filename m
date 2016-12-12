Received: from eggs.gnu.org ([2001:4830:134:3::10]:42400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cGHp1-00033s-LU
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 23:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cGHp0-00032l-JT
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 23:02:39 -0500
MIME-Version: 1.0
In-Reply-To: <20161212003055.GC12127@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161212003055.GC12127@umbus.fritz.box>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Mon, 12 Dec 2016 09:31:11 +0530
Message-ID: <CALAZu38RiyxcnV5uXucUcyyV9aeWqXXpEznUF9z2gNrn0Fy4tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/6] target-ppc: implement
 xxextractuw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12 December 2016 at 06:00, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Dec 09, 2016 at 05:47:24PM +0530, Nikunj A Dadhania wrote:
>> xxextractuw: VSX Vector Extract Unsigned Word
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target-ppc/helper.h                 |  1 +
>>  target-ppc/int_helper.c             | 21 +++++++++++++++++++++
>>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>>  target-ppc/translate/vsx-ops.inc.c  |  5 +++++
>>  4 files changed, 54 insertions(+)
>>
>> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
>> index 4707db4..8b30420 100644
>> --- a/target-ppc/helper.h
>> +++ b/target-ppc/helper.h
>> @@ -540,6 +540,7 @@ DEF_HELPER_2(xvrspip, void, env, i32)
>>  DEF_HELPER_2(xvrspiz, void, env, i32)
>>  DEF_HELPER_2(xxperm, void, env, i32)
>>  DEF_HELPER_2(xxpermr, void, env, i32)
>> +DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
>>
>>  DEF_HELPER_2(efscfsi, i32, env, i32)
>>  DEF_HELPER_2(efscfui, i32, env, i32)
>> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
>> index 7989b1f..e3f66ac 100644
>> --- a/target-ppc/int_helper.c
>> +++ b/target-ppc/int_helper.c
>> @@ -2033,6 +2033,27 @@ VEXTRACT(uw, u32)
>>  VEXTRACT(d, u64)
>>  #undef VEXTRACT
>>
>> +void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
>> +                        target_ulong xbn, uint32_t index)
>> +{
>> +    ppc_vsr_t xt, xb;
>> +    size_t es = sizeof(uint32_t);
>> +    uint32_t ext_index;
>> +
>> +    getVSR(xbn, &xb, env);
>> +    memset(&xt, 0, sizeof(xt));
>> +
>> +#if defined(HOST_WORDS_BIGENDIAN)
>> +    ext_index = index;
>> +    memcpy(&xt.u8[8 - es], &xb.u8[ext_index], es);
>> +#else
>> +    ext_index = (16 - index) - es;
>> +    memcpy(&xt.u8[8], &xb.u8[ext_index], es);
>
> Hm.  So, IIUC, ext_index is the byte element - in IBM numbering - to
> start copying from.  But I thought that when we have an LE host, the
> IBM byte element ordering is reversed from the actual order in host
> memory, so we'd need &xb.u8[16 - ext_index - es]

I am not getting you, I am getting index from user. So in case of BE host:

ext_index = index;

LE Host:

ext_index = (16 - index) - es;

I am already doing that. Am I missing something.

>
>> +#endif
>> +
>> +    putVSR(xtn, &xt, env);
>> +}
>> +
>>  #define VEXT_SIGNED(name, element, mask, cast, recast)              \
>>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>>  {                                                                   \
>> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/vsx-impl.inc.c
>> index 2a17c35..1c40a35 100644
>> --- a/target-ppc/translate/vsx-impl.inc.c
>> +++ b/target-ppc/translate/vsx-impl.inc.c
>> @@ -1180,6 +1180,33 @@ static void gen_xxsldwi(DisasContext *ctx)
>>      tcg_temp_free_i64(xtl);
>>  }
>>
>> +#define VSX_EXTRACT(name)                                       \
>> +static void gen_##name(DisasContext *ctx)                       \
>> +{                                                               \
>> +    TCGv xt, xb;                                                \
>> +    TCGv_i32 t0 = tcg_temp_new_i32();                           \
>> +    uint8_t uimm = UIMM4(ctx->opcode);                          \
>> +                                                                \
>> +    if (unlikely(!ctx->vsx_enabled)) {                          \
>> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
>> +        return;                                                 \
>> +    }                                                           \
>> +    if (uimm > 12) {                                            \
>
> Throughout the helper you use es == sizeof(uint32_t), but here you
> hardcode the assumption of 4 bytes, seems a bit inconsistent.
>
>> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
>> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
>> +        return;                                                 \
>
> So, I know the architecture says it is undefined.  But since you're
> testing for the bogus case anyway, why not turn this into an
> exception. That seems like it would be more helpful for debugging the
> guest than just setting the result to zero.  Or is this done to match
> actual hardware behaviour?

I havent had a change to run on the real hardware, but on the system
simulator, it happily
returns extracted content even if UIMM > 12.

Regards
Nikunj
