Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B91C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231D920782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231D920782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaams-0008D9-5C
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 03:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kaam6-0007cj-QF; Thu, 05 Nov 2020 03:37:42 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:37035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kaam3-000621-Tv; Thu, 05 Nov 2020 03:37:42 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.250])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id BB7956A90D10;
 Thu,  5 Nov 2020 09:37:28 +0100 (CET)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 5 Nov 2020
 09:37:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0058b73b38e-ab32-4944-bdc6-ff1cb17677e9,
 5DF9D6D6E4C5608BB48A30C312C59CD2E053A3DC) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 3/4] spapr/xive: Allocate IPIs independently from the
 other sources
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200820134547.2355743-1-clg@kaod.org>
 <20200820134547.2355743-4-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2d837671-ec7a-2eb8-c9f3-10d031ee4fde@kaod.org>
Date: Thu, 5 Nov 2020 09:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200820134547.2355743-4-clg@kaod.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d696d195-2eb4-410c-b175-dddad7a06f5f
X-Ovh-Tracer-Id: 13386949896290077478
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehvedtjeeltdelueetgfefieevfeejgeegiefhvdfhgfektdfhtdfhudfhveejleenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 03:37:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 3:45 PM, Cédric Le Goater wrote:
> The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect() when the
> vCPU connects to the KVM device and not when all the sources are reset
> in kvmppc_xive_source_reset()

This patch is introducing a regression when vsmt is in used.

  https://bugs.launchpad.net/qemu/+bug/1900241

when the OS boots, H_INT_SET_SOURCE_CONFIG fails with EINVAL, which 
should mean that the IPI is not created at the host/KVM level.

> This requires extra care for hotplug vCPUs and VM restore.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c | 47 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 4ea687c93ecd..f838c208b559 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -146,6 +146,15 @@ int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
>      return s.ret;
>  }
>  
> +static int kvmppc_xive_reset_ipi(SpaprXive *xive, CPUState *cs, Error **errp)
> +{
> +    unsigned long ipi = kvm_arch_vcpu_id(cs);

( I am wondering if this is the correct id to use ? )

> +    uint64_t state = 0;
> +
> +    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, ipi,
> +                              &state, true, errp);
> +}
> +
>  int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -175,6 +184,12 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>          return ret;
>      }
>  
> +    /* Create/reset the vCPU IPI */
> +    ret = kvmppc_xive_reset_ipi(xive, tctx->cs, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>      kvm_cpu_enable(tctx->cs);
>      return 0;
>  }
> @@ -260,6 +275,12 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
>  
>      assert(xive->fd != -1);
>  
> +    /*
> +     * The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect()
> +     * and not with all sources in kvmppc_xive_source_reset()
> +     */
> +    assert(srcno >= SPAPR_XIRQ_BASE);
> +
>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
>          state |= KVM_XIVE_LEVEL_SENSITIVE;
>          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> @@ -271,12 +292,28 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
>                               true, errp);
>  }
>  
> +/*
> + * To be valid, a source must have been claimed by the machine (valid
> + * entry in the EAS table) and if it is a vCPU IPI, the vCPU should
> + * have been enabled, which means the IPI has been allocated in
> + * kvmppc_xive_cpu_connect().
> + */
> +static bool xive_source_is_valid(SpaprXive *xive, int i)
> +{
> +    return xive_eas_is_valid(&xive->eat[i]) &&
> +        (i >= SPAPR_XIRQ_BASE || kvm_cpu_is_enabled(i));
> +}
> +
>  static int kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
>      SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
>      int i;
>  
> -    for (i = 0; i < xsrc->nr_irqs; i++) {
> +    /*
> +     * Skip the vCPU IPIs. These are created/reset when the vCPUs are
> +     * connected in kvmppc_xive_cpu_connect()
> +     */
> +    for (i = SPAPR_XIRQ_BASE; i < xsrc->nr_irqs; i++) {

This change skips the range [ 0x0 ... 0x1000 ] and relies on the presenter
to create the vCPU IPIs at the KVM level. But spapr_irq_init() could have 
claimed more in : 

        /* Enable the CPU IPIs */
        for (i = 0; i < nr_servers; ++i) {
            SpaprInterruptControllerClass *sicc
                = SPAPR_INTC_GET_CLASS(spapr->xive);

            if (sicc->claim_irq(SPAPR_INTC(spapr->xive), SPAPR_IRQ_IPI + i,
                                false, errp) < 0) {
                return;
            }
        }

I think this is what is happening with vsmt. However, I don't know how to
fix it :/

Thanks,

C.

>          int ret;
>  
>          if (!xive_eas_is_valid(&xive->eat[i])) {
> @@ -370,7 +407,7 @@ static void kvmppc_xive_source_get_state(XiveSource *xsrc)
>      for (i = 0; i < xsrc->nr_irqs; i++) {
>          uint8_t pq;
>  
> -        if (!xive_eas_is_valid(&xive->eat[i])) {
> +        if (!xive_source_is_valid(xive, i)) {
>              continue;
>          }
>  
> @@ -553,7 +590,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
>              uint8_t pq;
>              uint8_t old_pq;
>  
> -            if (!xive_eas_is_valid(&xive->eat[i])) {
> +            if (!xive_source_is_valid(xive, i)) {
>                  continue;
>              }
>  
> @@ -581,7 +618,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
>      for (i = 0; i < xsrc->nr_irqs; i++) {
>          uint8_t pq;
>  
> -        if (!xive_eas_is_valid(&xive->eat[i])) {
> +        if (!xive_source_is_valid(xive, i)) {
>              continue;
>          }
>  
> @@ -696,7 +733,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
>  
>      /* Restore the EAT */
>      for (i = 0; i < xive->nr_irqs; i++) {
> -        if (!xive_eas_is_valid(&xive->eat[i])) {
> +        if (!xive_source_is_valid(xive, i)) {
>              continue;
>          }
>  
> 


