Received: from eggs.gnu.org ([2001:4830:134:3::10]:50039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPul4-0003ad-Dl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPukz-0004Hq-FS
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPukz-0004Gc-3T
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:33 -0400
References: <20170626220330.6785-1-laurent@vivier.eu>
	<20170626220330.6785-3-laurent@vivier.eu>
	<20170627124541.2ab44983@x1.local>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <283fac39-6f22-c3a2-50e5-1a434404e483@vivier.eu>
Date: Tue, 27 Jun 2017 19:58:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170627124541.2ab44983@x1.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] target/m68k: add fmovecr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 27/06/2017 à 17:45, Philippe Mathieu-Daudé a écrit :
> I find this patch aesthetically very nice :)
> 
> On Tue, 27 Jun 2017 00:03:25 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>> fmovecr moves a floating point constant from the
>> FPU ROM to a floating point register.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/m68k/fpu_helper.c | 30 ++++++++++++++++++++++++++++++
>>  target/m68k/helper.h     |  1 +
>>  target/m68k/translate.c  | 13 ++++++++++++-
>>  3 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
>> index a9e17f5..912c0b7 100644
>> --- a/target/m68k/fpu_helper.c
>> +++ b/target/m68k/fpu_helper.c
>> @@ -23,6 +23,31 @@
>>  #include "exec/helper-proto.h"
>>  #include "exec/exec-all.h"
>>  
>> +static const floatx80 fpu_rom[128] = {
>> +    [0x00] = floatx80_pi,                                   /* Pi */
>> +    [0x0b] = make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /*
>> Log10(2) */
>> +    [0x0c] = make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /*
>> e        */
>> +    [0x0d] = make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /*
>> Log2(e)  */
>> +    [0x0e] = make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /*
>> Log10(e) */
>> +    [0x0f] = floatx80_zero,                                 /*
>> Zero     */
>> +    [0x30] = floatx80_ln2,                                  /*
>> ln(2)    */
>> +    [0x31] = make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /*
>> ln(10)   */
>> +    [0x32] = floatx80_one,                                  /*
>> 10^0     */
>> +    [0x33] = make_floatx80(0x4002, 0xa000000000000000ULL),  /*
>> 10^1     */
>> +    [0x34] = make_floatx80(0x4005, 0xc800000000000000ULL),  /*
>> 10^2     */
>> +    [0x35] = make_floatx80(0x400c, 0x9c40000000000000ULL),  /*
>> 10^4     */
>> +    [0x36] = make_floatx80(0x4019, 0xbebc200000000000ULL),  /*
>> 10^8     */
>> +    [0x37] = make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /*
>> 10^16    */
>> +    [0x38] = make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /*
>> 10^32    */
>> +    [0x39] = make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /*
>> 10^64    */
>> +    [0x3a] = make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /*
>> 10^128   */
>> +    [0x3b] = make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /*
>> 10^256   */
>> +    [0x3c] = make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /*
>> 10^512   */
>> +    [0x3d] = make_floatx80(0x4d48, 0xc976758681750c17ULL),  /*
>> 10^1024  */
>> +    [0x3e] = make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /*
>> 10^2048  */
>> +    [0x3f] = make_floatx80(0x7525, 0xc46052028a20979bULL),  /*
>> 10^4096  */ +};
>> +
>>  int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
>>  {
>>      return floatx80_to_int32(val->d, &env->fp_status);
>> @@ -204,3 +229,8 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
>>      }
>>      env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | cc;
>>  }
>> +
>> +void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
>> +{
>> +    val->d = fpu_rom[offset];
> 
> For offset not declared in fpu_rom (0x1..0xa, 0x10..0x2f, 0x40..0x7f),
> this will return floatx80_zero, is this correct?

yes, according to the doc:

The values contained at offsets other than those defined above are
reserved for the use of Motorola and may be different on various mask
sets of the floating-point coprocessor. These undefined values yield the
value 0.0 in the M68040FPSP

> 
>> +}
>> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
>> index 98cbf18..d6e80e4 100644
>> --- a/target/m68k/helper.h
>> +++ b/target/m68k/helper.h
>> @@ -35,6 +35,7 @@ DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
>>  DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
>>  DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
>>  DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
>> +DEF_HELPER_3(fconst, void, env, fp, i32)
>>  
>>  DEF_HELPER_3(mac_move, void, env, i32, i32)
>>  DEF_HELPER_3(macmulf, i64, env, i32, i32)
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 8824f81..ab2fe50 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -4510,6 +4510,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env,
>> DisasContext *s, DISAS_INSN(fpu)
>>  {
>>      uint16_t ext;
>> +    uint8_t rom_offset;
>>      int opmode;
>>      TCGv tmp32;
>>      int opsize;
>> @@ -4518,10 +4519,20 @@ DISAS_INSN(fpu)
>>      ext = read_im16(env, s);
>>      opmode = ext & 0x7f;
>>      switch ((ext >> 13) & 7) {
>> -    case 0: case 2:
>> +    case 0:
>>          break;
>>      case 1:
>>          goto undef;
>> +    case 2:
>> +        if (insn == 0xf200 && (ext & 0xfc00) == 0x5c00) {
>> +            /* fmovecr */
>> +            rom_offset = ext & 0x7f;
> 
> you can use opmode directly.

yes, I will update.

Thanks,
Laurent
