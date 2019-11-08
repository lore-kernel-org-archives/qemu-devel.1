Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40250FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141FD2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141FD2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7SE-00054v-6y
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iT7Qo-0004OU-3Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iT7Qm-0003aM-RN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:48:17 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:33576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iT7Qi-0003Sc-Te
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:48:14 -0500
Received: from player759.ha.ovh.net (unknown [10.108.42.5])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5281B259565
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 17:48:10 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id DDE8ABF39256;
 Fri,  8 Nov 2019 16:48:00 +0000 (UTC)
Date: Fri, 8 Nov 2019 17:47:59 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191108174759.2d4040f1@bahia.lan>
In-Reply-To: <20191108154035.12913-1-lvivier@redhat.com>
References: <20191108154035.12913-1-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 11261532344613312806
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.182.191
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  8 Nov 2019 16:40:35 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> but older kernels (< 4.13) don't support that.
>=20
> We can reasonably restore previous behavior with this kernel
> to allow to run QEMU as before.
>=20
> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> as it is done for previous machine types (< pseries-4.2)
>=20

It is usually _bad_ to base the machine behavior on host capabilities.
What happens if we migrate between an older kernel and a recent one ?

I understand this is to fix tests/migration-test on older kernels.
Couldn't this be achieved with migration-test doing some introspection
and maybe pass vsmt=3D8 on the QEMU command line ?

> Fixes: 29cb4187497d ("spapr: Set VSMT to smp_threads by default")
> Cc: groug@kaod.org
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c       | 2 +-
>  target/ppc/kvm.c     | 5 +++++
>  target/ppc/kvm_ppc.h | 6 ++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 94f9d27096af..f6c8ad1eda32 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2522,7 +2522,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>              goto out;
>          }
>          /* In this case, spapr->vsmt has been set by the command line */
> -    } else if (!smc->smp_threads_vsmt) {
> +    } else if (!smc->smp_threads_vsmt || !kvmppc_check_smt_possible()) {
>          /*
>           * Default VSMT value is tricky, because we need it to be as
>           * consistent as possible (for migration), but this requires
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7d2e8969ac5f..40ed59881167 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2060,6 +2060,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +bool kvmppc_check_smt_possible(void)
> +{
> +    return kvm_enabled() && cap_ppc_smt_possible;
> +}
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6d6..c9629a416b0b 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +bool kvmppc_check_smt_possible(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +static inline bool kvmppc_check_smt_possible(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;


