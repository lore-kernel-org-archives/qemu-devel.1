Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoqf-0008QH-OL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoqc-0001u5-If
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:21:37 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXoqc-0001of-CG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:21:34 -0400
Received: by mail-pl0-x243.google.com with SMTP id d10-v6so8630249plo.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:21:34 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-12-richard.henderson@linaro.org>
	<CAFEAcA_2eVmEB_7u+zGiT_kdHPOWHPANdShV4hUxVCt_DxdMpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed1f8b63-fd45-6435-198f-4b1c93f2905f@linaro.org>
Date: Tue, 26 Jun 2018 07:21:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2eVmEB_7u+zGiT_kdHPOWHPANdShV4hUxVCt_DxdMpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/35] target/arm: Implement SVE scatter
 stores
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

On 06/25/2018 09:13 AM, Peter Maydell wrote:
> On 21 June 2018 at 02:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper-sve.h    | 41 +++++++++++++++++++++
>>  target/arm/sve_helper.c    | 62 ++++++++++++++++++++++++++++++++
>>  target/arm/translate-sve.c | 74 ++++++++++++++++++++++++++++++++++++++
>>  target/arm/sve.decode      | 39 ++++++++++++++++++++
>>  4 files changed, 216 insertions(+)
>> +/* Stores with a vector index.  */
>> +
>> +#define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
>> +void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
>> +                  target_ulong base, uint32_t desc)                     \
>> +{                                                                       \
>> +    intptr_t i, oprsz = simd_oprsz(desc) / 8;                           \
>> +    unsigned scale = simd_data(desc);                                   \
>> +    uintptr_t ra = GETPC();                                             \
>> +    uint32_t *d = vd; TYPEI *m = vm; uint8_t *pg = vg;                  \
>> +    for (i = 0; i < oprsz; i++) {                                       \
>> +        uint8_t pp = pg[H1(i)];                                         \
>> +        if (pp & 0x01) {                                                \
>> +            target_ulong off = (target_ulong)m[H4(i * 2)] << scale;     \
>> +            FN(env, base + off, d[H4(i * 2)], ra);                      \
>> +        }                                                               \
>> +        if (pp & 0x10) {                                                \
>> +            target_ulong off = (target_ulong)m[H4(i * 2 + 1)] << scale; \
>> +            FN(env, base + off, d[H4(i * 2 + 1)], ra);                  \
>> +        }                                                               \
>> +    }                                                                   \
>> +}
> 
> Why do we do two operations per loop here? Generally
> we seem to do one operation per loop elsewhere.

I'm not sure why I wrote this one in this way.
There doesn't seem to be a good reason.


>> +static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a, uint32_t insn)
>> +{
>> +    /* Indexed by [xs][msz].  */
>> +    static gen_helper_gvec_mem_scatter * const fn32[2][3] = {
>> +        { gen_helper_sve_stbs_zsu,
>> +          gen_helper_sve_sths_zsu,
>> +          gen_helper_sve_stss_zsu, },
>> +        { gen_helper_sve_stbs_zss,
>> +          gen_helper_sve_sths_zss,
>> +          gen_helper_sve_stss_zss, },
>> +    };
>> +    static gen_helper_gvec_mem_scatter * const fn64[3][4] = {
> 
> In the pseudocode xs is either 0 (zero-extend offset) or
> 1 (sign-extend offset), but here it can also be 2. A
> comment noting that we've overloaded it to also indicate
> whether we're dealing with a 32-bit or 64-bit offset might
> help (at least I think that's what we're doing).

Yes, xs=2 is overloaded to mean 64-bit offset.
I'll add comments.


r~
