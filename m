Received: from eggs.gnu.org ([2001:4830:134:3::10]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1fbPeJ-000868-Q2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1fbPeG-0006If-HX
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:15:43 -0400
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com
	([104.47.37.110]:63033
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1fbPeG-0006IP-3X
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:15:40 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 11:40:18 +0000
Message-ID: <DM6PR08MB48736A43E3F1DD85841D46F9D4470@DM6PR08MB4873.namprd08.prod.outlook.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-6-git-send-email-aleksandar.markovic@rt-rk.com>
	<57a2af86-a882-7974-645b-048b630e9ef7@amsat.org>
	<BYAPR08MB4870FDA59891224B4A0AC3CAD4400@BYAPR08MB4870.namprd08.prod.outlook.com>,
	<6bed7e02-a3d3-ea93-7291-96799d4d2a83@amsat.org>
In-Reply-To: <6bed7e02-a3d3-ea93-7291-96799d4d2a83@amsat.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/8] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>

Hi Philippe,


With solved build issues caused by solution previously proposed, this would=
 be the final fix:


--- a/target-mips/translate.c
+++ b/target-mips/translate.c
@@ -5354,6 +5354,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, in=
t reg, int sel)
         case 3:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+#if defined(TARGET_MIPS64)
+            tcg_gen_andi_i64(arg, arg, ~0xffff);
+#else
+            tcg_gen_andi_i32(arg, arg, ~0xffff);
+#endif
             rn =3D "BadInstrX";
             break;
         default:
@@ -6719,6 +6724,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
         case 3:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+#if defined(TARGET_MIPS64)
+            tcg_gen_andi_i64(arg, arg, ~0xffff);
+#else
+            tcg_gen_andi_i32(arg, arg, ~0xffff);
+#endif
             rn =3D "BadInstrX";
             break;
         default:



Regards,

Stefan

________________________________
From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on behalf=
 of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
Sent: Thursday, July 5, 2018 5:13:42 PM
To: Stefan Markovic; Aleksandar Markovic; qemu-devel@nongnu.org; Richard He=
nderson
Cc: Petar Jovanovic; Aleksandar Markovic; aurelien@aurel32.net; Paul Burton
Subject: Re: [Qemu-devel] [PATCH v3 5/8] target/mips: Add CP0 BadInstrX reg=
ister

On 07/05/2018 10:27 AM, Stefan Markovic wrote:
> Hi Philippe,
>
> Following fix will be added in v4:
>
>
> diff --git a/target-mips/translate.c b/target-mips/translate.c
> index 79a59fd..98ff8d0 100644
> --- a/target-mips/translate.c
> +++ b/target-mips/translate.c
> @@ -5354,6 +5354,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
>          case 3:
>              CP0_CHECK(ctx->bi);
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
> +            tcg_gen_andi_i32(arg, arg, 0xffff0000);

Correct, maybe easier to read as:

tcg_gen_andi_i32(arg, arg, ~0xffff);

With these changes in your v4:
Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

>              rn =3D "BadInstrX";
>              break;
>          default:
> @@ -6719,6 +6720,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
>          case 3:
>              CP0_CHECK(ctx->bi);
>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
> +            tcg_gen_andi_i32(arg, arg, 0xffff0000);
>              rn =3D "BadInstrX";
>              break;
>          default:
>
>
> Regards,
> Stefan
>
>
> ________________________________
> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Sent: Wednesday, July 4, 2018 10:31:27 PM
> To: Aleksandar Markovic; qemu-devel@nongnu.org; Richard Henderson
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Stefan Markovic; Petar Jov=
anovic; Paul Burton
> Subject: Re: [PATCH v3 5/8] target/mips: Add CP0 BadInstrX register
>
> Hi Aleksandar,
>
> On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
>> From: Stefan Markovic <smarkovic@wavecomp.com>
>>
>> Add CP0 BadInstrX register. This register will be used in nanoMIPS.
>>
>> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
>> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>  target/mips/cpu.h       |  1 +
>>  target/mips/machine.c   |  5 +++--
>>  target/mips/translate.c | 20 +++++++++++++++++++-
>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
>> index edbb66d..8ccbc21 100644
>> --- a/target/mips/cpu.h
>> +++ b/target/mips/cpu.h
>> @@ -323,6 +323,7 @@ struct CPUMIPSState {
>>      target_ulong CP0_BadVAddr;
>>      uint32_t CP0_BadInstr;
>>      uint32_t CP0_BadInstrP;
>> +    uint32_t CP0_BadInstrX;
>>      int32_t CP0_Count;
>>      target_ulong CP0_EntryHi;
>>  #define CP0EnHi_EHINV 10
>> diff --git a/target/mips/machine.c b/target/mips/machine.c
>> index 20100d5..5ba78ac 100644
>> --- a/target/mips/machine.c
>> +++ b/target/mips/machine.c
>> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb =3D {
>>
>>  const VMStateDescription vmstate_mips_cpu =3D {
>>      .name =3D "cpu",
>> -    .version_id =3D 10,
>> -    .minimum_version_id =3D 10,
>> +    .version_id =3D 11,
>> +    .minimum_version_id =3D 11,
>>      .post_load =3D cpu_post_load,
>>      .fields =3D (VMStateField[]) {
>>          /* Active TC */
>> @@ -266,6 +266,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
>>          VMSTATE_UINTTL(env.CP0_BadVAddr, MIPSCPU),
>>          VMSTATE_UINT32(env.CP0_BadInstr, MIPSCPU),
>>          VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
>> +        VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
>>          VMSTATE_INT32(env.CP0_Count, MIPSCPU),
>>          VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
>>          VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 88699ae..0562851 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -5315,7 +5315,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP))=
;
>>              rn =3D "BadInstrP";
>>              break;
>> -        default:
>> +        case 3:
>> +            CP0_CHECK(ctx->bi);
>> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX))=
;
>> +            rn =3D "BadInstrX";
>> +            break;
>> +       default:
>>              goto cp0_unimplemented;
>>          }
>>          break;
>> @@ -6006,6 +6011,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>>              /* ignored */
>>              rn =3D "BadInstrP";
>>              break;
>> +        case 3:
>> +            /* ignored */
>> +            rn =3D "BadInstrX";
>> +            break;
>>          default:
>>              goto cp0_unimplemented;
>>          }
>> @@ -6711,6 +6720,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>>              gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP))=
;
>>              rn =3D "BadInstrP";
>>              break;
>> +        case 3:
>> +            CP0_CHECK(ctx->bi);
>> +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX))=
;
>
> I'm unsure re-using gen_mfc0_load32() is enough, shouldn't we zero the
> 16 lower bits?
>
>> +            rn =3D "BadInstrX";
>> +            break;
>>          default:
>>              goto cp0_unimplemented;
>>          }
>> @@ -7385,6 +7399,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>>              /* ignored */
>>              rn =3D "BadInstrP";
>>              break;
>> +        case 3:
>> +            /* ignored */
>> +            rn =3D "BadInstrX";
>> +            break;
>>          default:
>>              goto cp0_unimplemented;
>>          }
>>
