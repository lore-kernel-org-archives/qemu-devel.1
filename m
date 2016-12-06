Received: from eggs.gnu.org ([2001:4830:134:3::10]:36610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8Fg-0001dr-O2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8Fe-00067a-83
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:25:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43262
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cE8Fe-00067N-21
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:25:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB65MGtu101286
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 00:25:13 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275jgq0x28-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 00:25:13 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 10:55:09 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <37c840a9-b9c1-4308-fbff-2e22c8f57d09@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<37c840a9-b9c1-4308-fbff-2e22c8f57d09@twiddle.net>
Date: Tue, 06 Dec 2016 10:55:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87d1h5iq8g.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 03/13] target-ppc: implement lxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
>> lxvl: Load VSX Vector with Length
>>=20
>> Little/Big-endian Storage:
>> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>> |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=
=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=
=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=
=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
>> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>>=20
>> Loading 14 bytes results in:
>>=20
>> Vector (8-bit elements) in BE:
>> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>> |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=
=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=
=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=
=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
>> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>>=20
>> Vector (8-bit elements) in LE:
>> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
>> |00|00|=E2=80=9CT=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CE=E2=80=9D|=E2=
=80=9CT=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=
=9D|=E2=80=9Cs=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Cs=
=E2=80=9D|=E2=80=9Ci=E2=80=9D|"h"|"T"|
>> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
>>=20
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target-ppc/helper.h                 |  1 +
>>  target-ppc/mem_helper.c             | 25 +++++++++++++++++++++++++
>>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>>  4 files changed, 54 insertions(+)
>>=20
>> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
>> index bc39efb..d9ccafd 100644
>> --- a/target-ppc/helper.h
>> +++ b/target-ppc/helper.h
>> @@ -317,6 +317,7 @@ DEF_HELPER_3(lvewx, void, env, avr, tl)
>>  DEF_HELPER_3(stvebx, void, env, avr, tl)
>>  DEF_HELPER_3(stvehx, void, env, avr, tl)
>>  DEF_HELPER_3(stvewx, void, env, avr, tl)
>> +DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
>>  DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
>>  DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
>>  DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
>> diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
>> index 1ab8a6e..0a8ff54 100644
>> --- a/target-ppc/mem_helper.c
>> +++ b/target-ppc/mem_helper.c
>> @@ -24,6 +24,7 @@
>>=20=20
>>  #include "helper_regs.h"
>>  #include "exec/cpu_ldst.h"
>> +#include "internal.h"
>>=20=20
>>  //#define DEBUG_OP
>>=20=20
>> @@ -284,6 +285,30 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
>>  #undef I
>>  #undef LVE
>>=20=20
>> +void helper_lxvl(CPUPPCState *env, target_ulong addr,
>> +                 target_ulong xt_num, target_ulong rb)
>> +{
>> +    ppc_vsr_t xt;
>> +
>> +    getVSR(xt_num, &xt, env);
>> +    if (unlikely((rb & 0xFF) =3D=3D 0)) {
>> +        xt.s128 =3D int128_make128(0, 0);
>> +    } else {
>> +        target_ulong end =3D ((rb & 0xFF) * 8) - 1;
>> +        if (msr_le) {
>> +            xt.u64[HI_IDX] =3D bswap64(cpu_ldq_data_ra(env, addr, GETPC=
()));
>> +            addr =3D addr_add(env, addr, 8);
>> +            xt.u64[LO_IDX] =3D bswap64(cpu_ldq_data_ra(env, addr, GETPC=
()));
>
> hi/lo assignment reversed for le.

Already taken care here:

#if defined(HOST_WORDS_BIGENDIAN)
#define HI_IDX 0
#define LO_IDX 1
#else
#define HI_IDX 1
#define LO_IDX 0
#endif

>
>> +        } else {
>> +            xt.u64[HI_IDX] =3D cpu_ldq_data_ra(env, addr, GETPC());
>> +            addr =3D addr_add(env, addr, 8);
>> +            xt.u64[LO_IDX] =3D cpu_ldq_data_ra(env, addr, GETPC());
>> +        }
>> +        xt.s128 =3D int128_and(xt.s128, mask_u128(0, end));
>
> I don't think mask_u128 does the right thing for end > 127.
> I think you need a check here.

Sure. Will do that.

Regards
Nikunj
