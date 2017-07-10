Received: from eggs.gnu.org ([2001:4830:134:3::10]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUY86-0002Ri-Q5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUY83-0006Mo-Ov
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:49:34 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:37895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dUY83-0006Kj-EX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:49:31 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8C42F6AEB7
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 14:49:29 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
	<20170710102655.GE4083@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
Date: Mon, 10 Jul 2017 14:49:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170710102655.GE4083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/10/2017 12:26 PM, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:16PM +0200, C=E9dric Le Goater wrote:
>> Prepare ground for the new exception model XIVE of POWER9.
>=20
> I'm a bit confused by this.  The excp_model is about the CPU core's
> irq model, not the external irq controller's.

yes this is true, but the POWER9 CPU is the only criteria we have=20
to distinguish a machine supporting XIVE and XICS from one only=20
supporting XICS.

My idea was to use this flag to activate the OV5_XIVE_EXPLOIT bit=20
in ibm,arch-vec-5-platform-support ov5_platform, like this is done
for the MMU. See spapr_dt_ov5_platform_support()
=20
> Now.. I could imagine the POWER9 having a different core model that
> came along with XIVE, but I can't see this new model being used for
> anything anywhere in the rest of the series.

See patch 26. But, maybe, I am taking a shortcut and we need another
family of flags.=20

Thanks,

C.=20

>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  target/ppc/cpu-qom.h        | 2 ++
>>  target/ppc/excp_helper.c    | 9 ++++++---
>>  target/ppc/translate.c      | 3 ++-
>>  target/ppc/translate_init.c | 2 +-
>>  4 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
>> index d0cf6ca2a971..d7b78cf3f71c 100644
>> --- a/target/ppc/cpu-qom.h
>> +++ b/target/ppc/cpu-qom.h
>> @@ -132,6 +132,8 @@ enum powerpc_excp_t {
>>      POWERPC_EXCP_POWER7,
>>      /* POWER8 exception model           */
>>      POWERPC_EXCP_POWER8,
>> +    /* POWER9 exception model           */
>> +    POWERPC_EXCP_POWER9,
>>  };
>> =20
>>  /********************************************************************=
*********/
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 3a9f0861e773..dc7dff36a580 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -148,9 +148,11 @@ static inline void powerpc_excp(PowerPCCPU *cpu, =
int excp_model, int excp)
>>       */
>>  #if defined(TARGET_PPC64)
>>      if (excp_model =3D=3D POWERPC_EXCP_POWER7 ||
>> -        excp_model =3D=3D POWERPC_EXCP_POWER8) {
>> +        excp_model =3D=3D POWERPC_EXCP_POWER8 ||
>> +        excp_model =3D=3D POWERPC_EXCP_POWER9) {
>>          lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>> -        if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
>> +        if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
>> +            excp_model =3D=3D POWERPC_EXCP_POWER9) {
>>              ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT=
;
>>          } else {
>>              ail =3D 0;
>> @@ -651,7 +653,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, i=
nt excp_model, int excp)
>>          if (!(new_msr & MSR_HVB) && (env->spr[SPR_LPCR] & LPCR_ILE)) =
{
>>              new_msr |=3D (target_ulong)1 << MSR_LE;
>>          }
>> -    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
>> +    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
>> +               excp_model =3D=3D POWERPC_EXCP_POWER9) {
>>          if (new_msr & MSR_HVB) {
>>              if (env->spr[SPR_HID0] & HID0_HILE) {
>>                  new_msr |=3D (target_ulong)1 << MSR_LE;
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index c0cd64d927c2..2d8c1b9e6836 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -7064,7 +7064,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function cpu_fprintf,
>> =20
>>  #if defined(TARGET_PPC64)
>>      if (env->excp_model =3D=3D POWERPC_EXCP_POWER7 ||
>> -        env->excp_model =3D=3D POWERPC_EXCP_POWER8) {
>> +        env->excp_model =3D=3D POWERPC_EXCP_POWER8 ||
>> +        env->excp_model =3D=3D POWERPC_EXCP_POWER9) {
>>          cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx=
 "\n",
>>                      env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
>>      }
>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
>> index 53aff5a7b734..b8c7b8150318 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -8962,7 +8962,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *da=
ta)
>>      pcc->sps =3D &POWER7_POWER8_sps;
>>      pcc->radix_page_info =3D &POWER9_radix_page_info;
>>  #endif
>> -    pcc->excp_model =3D POWERPC_EXCP_POWER8;
>> +    pcc->excp_model =3D POWERPC_EXCP_POWER9;
>>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
>>      pcc->bfd_mach =3D bfd_mach_ppc64;
>>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>=20
