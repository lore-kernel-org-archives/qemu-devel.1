Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25EC35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711AD21927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711AD21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NrI-00066j-NX
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j6NqY-0005Hh-Sw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j6NqW-00014E-Sg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:13:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62012
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j6NqW-000144-Nw; Mon, 24 Feb 2020 19:13:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01P04Agc120189; Mon, 24 Feb 2020 19:13:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1as190w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 19:13:00 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P0D0AH137248;
 Mon, 24 Feb 2020 19:13:00 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1as190k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 19:13:00 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01P09sct027505;
 Tue, 25 Feb 2020 00:12:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04wdc.us.ibm.com with ESMTP id 2yaux6qq90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 00:12:59 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01P0Cw1q56492404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 00:12:58 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 430A3C605D;
 Tue, 25 Feb 2020 00:12:58 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 840E6C6059;
 Tue, 25 Feb 2020 00:12:57 +0000 (GMT)
Received: from localhost (unknown [9.85.139.151])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Feb 2020 00:12:57 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [PATCH v6 05/18] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
In-Reply-To: <20200224233724.46415-6-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-6-david@gibson.dropbear.id.au>
Date: Mon, 24 Feb 2020 21:12:53 -0300
Message-ID: <87o8tn5xtm.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_12:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240181
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> When running guests under a hypervisor, the hypervisor obviously needs to
> be protected from guest accesses even if those are in what the guest
> considers real mode (translation off).  The POWER hardware provides two
> ways of doing that: The old way has guest real mode accesses simply offset
> and bounds checked into host addresses.  It works, but requires that a
> significant chunk of the guest's memory - the RMA - be physically
> contiguous in the host, which is pretty inconvenient.  The new way, known
> as VRMA, has guest real mode accesses translated in roughly the normal way
> but with some special parameters.
>
> In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes, b=
ut
> in POWER9 only VRMA mode is supported and LPCR[VPM0] no longer exists.  We
> handle that difference in behaviour in ppc_hash64_set_isi().. but not in
> other places that we blindly check LPCR[VPM0].
>
> Correct those instances with a new helper to tell if we should be in VRMA
> mode.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
>  target/ppc/mmu-hash64.c | 43 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 392f90e0ae..e372c42add 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -668,6 +668,21 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU=
 *cpu,
>      return 0;
>  }
>=20=20
> +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> +         * register no longer exist
> +         */
> +        return true;
> +
> +    default:
> +        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +    }
> +}
> +
>  static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
>  {
>      CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
> @@ -676,15 +691,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint64_=
t error_code)
>      if (msr_ir) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HISI;
> @@ -702,15 +709,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
>      if (msr_dr) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HDSI;
> @@ -799,7 +798,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -967,7 +966,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
>          } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
>              /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -1056,8 +1055,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      slb->sps =3D NULL;
>=20=20
>      /* Is VRMA enabled ? */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    if (!(lpcr & LPCR_VPM0)) {
> +    if (!ppc_hash64_use_vrma(env)) {
>          return;
>      }
>=20=20
> @@ -1065,6 +1063,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>       * Make one up. Mostly ignore the ESID which will not be needed
>       * for translation
>       */
> +    lpcr =3D env->spr[SPR_LPCR];
>      vsid =3D SLB_VSID_VRMA;
>      vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
>      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);

