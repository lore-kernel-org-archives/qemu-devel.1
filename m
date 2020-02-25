Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA6C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD5320726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD5320726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XUP-00069Y-0Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6XTW-0005Gj-1C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6XTR-00080H-Vb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:30:01 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:35890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6XTR-0007zg-Oe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:29:57 -0500
Received: from player695.ha.ovh.net (unknown [10.108.57.178])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 594C81C803B
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:29:55 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 383DDF9F3C28;
 Tue, 25 Feb 2020 10:29:36 +0000 (UTC)
Date: Tue, 25 Feb 2020 11:29:33 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 04/18] target/ppc: Correct handling of real mode
 accesses with vhyp on hash MMU
Message-ID: <20200225112933.2261beae@bahia.home>
In-Reply-To: <20200224233724.46415-5-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-5-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17807795877882468838
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
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
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:10 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On ppc we have the concept of virtual hypervisor ("vhyp") mode, where we
> only model the non-hypervisor-privileged parts of the cpu.  Essentially we
> model the hypervisor's behaviour from the point of view of a guest OS, but
> we don't model the hypervisor's execution.
>=20
> In particular, in this mode, qemu's notion of target physical address is
> a guest physical address from the vcpu's point of view.  So accesses in
> guest real mode don't require translation.  If we were modelling the
> hypervisor mode, we'd need to translate the guest physical address into
> a host physical address.
>=20
> Currently, we handle this sloppily: we rely on setting up the virtual LPCR
> and RMOR registers so that GPAs are simply HPAs plus an offset, which we
> set to zero.  This is already conceptually dubious, since the LPCR and RM=
OR
> registers don't exist in the non-hypervisor portion of the CPU.  It gets
> worse with POWER9, where RMOR and LPCR[VPM0] no longer exist at all.
>=20
> Clean this up by explicitly handling the vhyp case.  While we're there,
> remove some unnecessary nesting of if statements that made the logic to
> select the correct real mode behaviour a bit less clear than it could be.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-hash64.c | 60 ++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 3e0be4d55f..392f90e0ae 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -789,27 +789,30 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
>           */
>          raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> -        /* In HV mode, add HRMOR if top EA bit is clear */
> -        if (msr_hv || !env->has_hv_mode) {
> +        if (cpu->vhyp) {
> +            /*
> +             * In virtual hypervisor mode, there's nothing to do:
> +             *   EA =3D=3D GPA =3D=3D qemu guest address
> +             */
> +        } else if (msr_hv || !env->has_hv_mode) {
> +            /* In HV mode, add HRMOR if top EA bit is clear */
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else {
> -            /* Otherwise, check VPM for RMA vs VRMA */
> -            if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> -                slb =3D &env->vrma_slb;
> -                if (slb->sps) {
> -                    goto skip_slb_search;
> -                }
> -                /* Not much else to do here */
> +        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +            /* Emulated VRMA mode */
> +            slb =3D &env->vrma_slb;
> +            if (!slb->sps) {
> +                /* Invalid VRMA setup, machine check */
>                  cs->exception_index =3D POWERPC_EXCP_MCHECK;
>                  env->error_code =3D 0;
>                  return 1;
> -            } else if (raddr < env->rmls) {
> -                /* RMA. Check bounds in RMLS */
> -                raddr |=3D env->spr[SPR_RMOR];
> -            } else {
> -                /* The access failed, generate the approriate interrupt =
*/
> +            }
> +
> +            goto skip_slb_search;
> +        } else {
> +            /* Emulated old-style RMO mode, bounds check against RMLS */
> +            if (raddr >=3D env->rmls) {
>                  if (rwx =3D=3D 2) {
>                      ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
> @@ -821,6 +824,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>                  }
>                  return 1;
>              }
> +
> +            raddr |=3D env->spr[SPR_RMOR];
>          }
>          tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_M=
ASK,
>                       PAGE_READ | PAGE_WRITE | PAGE_EXEC, mmu_idx,
> @@ -953,22 +958,27 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
>          /* In real mode the top 4 effective address bits are ignored */
>          raddr =3D addr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> -        /* In HV mode, add HRMOR if top EA bit is clear */
> -        if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
> +        if (cpu->vhyp) {
> +            /*
> +             * In virtual hypervisor mode, there's nothing to do:
> +             *   EA =3D=3D GPA =3D=3D qemu guest address
> +             */
> +            return raddr;
> +        } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
> +            /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        }
> -
> -        /* Otherwise, check VPM for RMA vs VRMA */
> -        if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +            /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
>                  return -1;
>              }
> -        } else if (raddr < env->rmls) {
> -            /* RMA. Check bounds in RMLS */
> -            return raddr | env->spr[SPR_RMOR];
>          } else {
> -            return -1;
> +            /* Emulated old-style RMO mode, bounds check against RMLS */
> +            if (raddr >=3D env->rmls) {
> +                return -1;
> +            }
> +            return raddr | env->spr[SPR_RMOR];
>          }
>      } else {
>          slb =3D slb_lookup(cpu, addr);


