Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB59C2224D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB59C2224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41d9-0004v3-UA
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k41cZ-0004OM-F5; Fri, 07 Aug 2020 08:37:15 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:44225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k41cX-0000Ma-A3; Fri, 07 Aug 2020 08:37:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.250])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 9BE9D4E0DDA1;
 Fri,  7 Aug 2020 14:37:11 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 14:37:11 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00634a986a4-37fd-439b-874f-884b936e7253,
 9C6B65F6CFD3D723D723CC07BEDAC6F805E88D1E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v3 for-5.2 3/3] spapr/xive: Convert KVM device fd checks
 to assert()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
 <159679994169.876294.11026653581505077112.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5590a3ce-5432-00ca-5aea-5eca409c7651@kaod.org>
Date: Fri, 7 Aug 2020 14:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159679994169.876294.11026653581505077112.stgit@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 382b9ff9-d32f-4e2c-94f2-6aec8088658d
X-Ovh-Tracer-Id: 5401786281112013731
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 08:36:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 1:32 PM, Greg Kurz wrote:
> All callers guard these functions with an xive_in_kernel() helper. Make
> it clear that they are only to be called when the KVM XIVE device exists.
> 
> Note that the check on xive is dropped in kvmppc_xive_disconnect(). It
> really cannot be NULL since it comes from set_active_intc() which only
> passes pointers to allocated objects.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
> v2: Take the helper name change into account in the changelog
> ---
>  hw/intc/spapr_xive_kvm.c |   35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 6130882be678..82a6f99f022d 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -79,10 +79,7 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
>      uint64_t state[2];
>      int ret;
>  
> -    /* The KVM XIVE device is not in use yet */
> -    if (xive->fd == -1) {
> -        return;
> -    }
> +    assert(xive->fd != -1);
>  
>      /* word0 and word1 of the OS ring. */
>      state[0] = *((uint64_t *) &tctx->regs[TM_QW1_OS]);
> @@ -101,10 +98,7 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>      uint64_t state[2] = { 0 };
>      int ret;
>  
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd == -1) {
> -        return;
> -    }
> +    assert(xive->fd != -1);
>  
>      ret = kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
>      if (ret != 0) {
> @@ -156,10 +150,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>      unsigned long vcpu_id;
>      int ret;
>  
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd == -1) {
> -        return;
> -    }
> +    assert(xive->fd != -1);
>  
>      /* Check if CPU was hot unplugged and replugged. */
>      if (kvm_cpu_is_enabled(tctx->cs)) {
> @@ -245,10 +236,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
>      SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
>      uint64_t state = 0;
>  
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd == -1) {
> -        return -ENODEV;
> -    }
> +    assert(xive->fd != -1);
>  
>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
>          state |= KVM_XIVE_LEVEL_SENSITIVE;
> @@ -592,10 +580,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
>  
>  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
>  {
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd == -1) {
> -        return;
> -    }
> +    assert(xive->fd != -1);
>  
>      /*
>       * When the VM is stopped, the sources are masked and the previous
> @@ -622,10 +607,7 @@ int kvmppc_xive_pre_save(SpaprXive *xive)
>  {
>      Error *local_err = NULL;
>  
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd == -1) {
> -        return 0;
> -    }
> +    assert(xive->fd != -1);
>  
>      /* EAT: there is no extra state to query from KVM */
>  
> @@ -845,10 +827,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
>      XiveSource *xsrc;
>      size_t esb_len;
>  
> -    /* The KVM XIVE device is not in use */
> -    if (!xive || xive->fd == -1) {
> -        return;
> -    }
> +    assert(xive->fd != -1);
>  
>      /* Clear the KVM mapping */
>      xsrc = &xive->source;
> 
> 


