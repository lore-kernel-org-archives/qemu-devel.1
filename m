Received: from eggs.gnu.org ([2001:4830:134:3::10]:56990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWpI-0001PD-Mf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWpF-0005Xz-Cn
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:44:12 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:40909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEWpF-0005XQ-3w
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:44:09 -0500
Received: by mail-wm0-x229.google.com with SMTP id b189so12850518wmd.5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 00:44:08 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-4-richard.henderson@linaro.org>
	<87wp2u9m5k.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13dec407-103d-ead5-94f4-b35cd8b3d83a@linaro.org>
Date: Tue, 14 Nov 2017 09:44:04 +0100
MIME-Version: 1.0
In-Reply-To: <87wp2u9m5k.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 03/12] target/arm: Decode
 aa64 armv8.1 scalar three same extra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 11/13/2017 05:30 PM, Alex Bennée wrote:
>>  DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
>>  DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
>> +DEF_HELPER_4(neon_qrdmlah_s16, i32, env, i32, i32, i32)
>> +DEF_HELPER_4(neon_qrdmlsh_s16, i32, env, i32, i32, i32)
>>  DEF_HELPER_3(neon_qdmulh_s32, i32, env, i32, i32)
>>  DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
>> +DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
>> +DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
> 
> Hmm are these really NEON or should they be advsimd_qrdm....?

Same thing.  It seemed nicer to keep the naming consistent.
Probably when we rewrite for SVE we will rename them all...

>> +    switch (opcode) {
>> +    case 0x0: /* SQRDMLAH (vector) */
>> +    case 0x1: /* SQRDMLSH (vector) */
>> +        if (size != 1 && size != 2) {
>> +            unallocated_encoding(s);
>> +            return;
>> +        }
>> +        feature = ARM_FEATURE_V8_1_SIMD;
>> +        break;
>> +    default:
>> +        unallocated_encoding(s);
>> +        return;
>> +    }
>> +
>> +    if (!arm_dc_feature(s, feature)) {
>> +        unallocated_encoding(s);
>> +        return;
>> +    }
> 
> I guess this is because we are expecting additional features to be added
> to the encoding space...

Yes.

>> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
>> index 847fb52ee0..c2d32988f9 100644
>> --- a/target/arm/Makefile.objs
>> +++ b/target/arm/Makefile.objs
>> @@ -5,7 +5,7 @@ obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
>>  obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
>>  obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>>  obj-y += translate.o op_helper.o helper.o cpu.o
>> -obj-y += neon_helper.o iwmmxt_helper.o
>> +obj-y += neon_helper.o iwmmxt_helper.o advsimd_helper.o
> 
> Given this is AArch64 only it makes me wonder if we should be using helper-a64.h?

It isn't aarch64 only.  The aarch32 part is patch 6.


r~
