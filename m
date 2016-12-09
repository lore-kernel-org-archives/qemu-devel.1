Received: from eggs.gnu.org ([2001:4830:134:3::10]:33464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFE9W-0000V4-Dp
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFE9Q-0000Gp-5n
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48577
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFE9Q-0000GS-1B
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB95tHvS103576
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 00:55:19 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277gu4nvp3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 00:55:18 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 15:54:32 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20161208222546.GC13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161208222546.GC13139@umbus.fritz.box>
Date: Fri, 09 Dec 2016 11:24:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <8737hx3awj.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 1/9] target-ppc: implement lxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Wed, Dec 07, 2016 at 11:54:54PM +0530, Nikunj A Dadhania wrote:
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
>
> Took a while to wrap my head around the semantics, but I believe this
> is correct.  However, there are a couple of nits:
>
>>=20
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target-ppc/helper.h                 |  1 +
>>  target-ppc/mem_helper.c             | 33 ++++++++++++++++++++++++++++++=
+++
>>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>>  4 files changed, 62 insertions(+)
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
>> index 1ab8a6e..54447a7 100644
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
>> @@ -284,8 +285,40 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
>>  #undef I
>>  #undef LVE
>>=20=20
>> +#ifdef TARGET_PPC64
>> +#define GET_NB(rb) ((rb >> 56) & 0xFF)
>> +#else
>> +#define GET_NB(rb) ((rb >> 24) & 0xFF)
>> +#endif
>
> A 32-bit VSX implementation seems... improbable.  Simpler to just
> bracket the whole thing with ifdef TARGET_PPC64.

Sure, can be done, just that the instruction specifically got bit 0:7, i
thought that I shouldn't limit my implementation to just PPC64.


>> +
>> +void helper_lxvl(CPUPPCState *env, target_ulong addr,
>> +                 target_ulong xt_num, target_ulong rb)
>
> I think it would be nicer to either have two different helpers for the
> LE and BE cases, or take an endian parameter.  That should allow you
> to share the helper with the lxvll implementation.

Something like the below should work:

#define VSX_LXVL(name, lj)                                              \
void helper_##name(CPUPPCState *env, target_ulong addr,                 \
                   target_ulong xt_num, target_ulong rb)                \
{                                                                       \
    int i;                                                              \
    ppc_vsr_t xt;                                                       \
    uint64_t nb =3D GET_NB(rb);                                           \
                                                                        \
    xt.s128 =3D int128_zero();                                            \
    if (nb) {                                                           \
        nb =3D (nb >=3D 16) ? 16 : nb;                                     =
 \
        if (msr_le && !lj) {                                            \
            for (i =3D 16; i > 16 - nb; i--) {                            \
                xt.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC());  \
                addr =3D addr_add(env, addr, 1);                          \
            }                                                           \
        } else {                                                        \
            for (i =3D 0; i < nb; i++) {                                  \
                xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());      \
                addr =3D addr_add(env, addr, 1);                          \
            }                                                           \
        }                                                               \
    }                                                                   \
    putVSR(xt_num, &xt, env);                                           \
}

VSX_LXVL(lxvl, 0)
VSX_LXVL(lxvll, 1)

Regards
Nikunj
