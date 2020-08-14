Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1DFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E2E20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E2E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bKB-0003Uq-18
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k6bJd-000301-9S; Fri, 14 Aug 2020 11:08:21 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:43125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k6bJa-0005Fe-Li; Fri, 14 Aug 2020 11:08:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.235])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2BE8E5085A46;
 Fri, 14 Aug 2020 17:08:14 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 14 Aug
 2020 17:08:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005f2f51d1e-2c74-4e2b-91d5-1f8ad162394c,
 373B2072066AFC5654FE77EA66C144DA3E99FD02) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] spapr/xive: Allocate IPIs from the vCPU contexts
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200814150358.1682513-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <42e8bb9f-c052-5abb-9ffe-0700bfe3904d@kaod.org>
Date: Fri, 14 Aug 2020 17:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814150358.1682513-1-clg@kaod.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 16342f1d-4a3b-4a3a-a32e-1463220d3640
X-Ovh-Tracer-Id: 12168163244321508259
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleejgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:08:15
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This works as expected with a 128 vCPUs guest with pinned vcpus. The
first 64 IPIs are allocated on the first chip and the remaining 64
on the second chip.

Still, this is more an RFC. We have time before the end of the merge
window.

Thanks,

C.  


On 8/14/20 5:03 PM, Cédric Le Goater wrote:
> When QEMU switches to the XIVE interrupt mode, it performs a
> kvmppc_xive_source_reset() which creates all the guest interrupts at
> the level of the KVM device. These interrupts are backed by real HW
> interrupts from the IPI interrupt pool of the XIVE controller.
> 
> Currently, this is done from the QEMU main thread, which results in
> allocating all interrupts from the chip on which QEMU is running. IPIs
> are not distributed across the system and the load is not well
> balanced across the interrupt controllers.
> 
> Change the vCPU IPI allocation to run from the vCPU context in order
> to allocate the associated XIVE IPI interrupt on the chip on which the
> vCPU is running. This gives a chance to a better distribution of the
> IPIs when the guest has a lot of vCPUs. When the vCPUs are pinned, it
> makes the IPI local to the chip of the vCPU which reduces rerouting
> between interrupt controllers and gives better performance.
> 
> This is only possible for running vCPUs. The IPIs of hot plugable
> vCPUs will still be allocated in the context of the QEMU main thread.
> 
> Device interrupts are treated the same. To improve placement, we would
> need some information on the chip owning the virtual source or HW
> source in case of passthrough. This requires changes in PAPR.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index c6958f2da218..553fd7fd8f56 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -223,6 +223,47 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
>                        NULL, true, errp);
>  }
>  
> +/*
> + * Allocate the IPIs from the vCPU context. This will allocate the
> + * XIVE IPI interrupt on the chip on which the vCPU is running. This
> + * gives a better distribution of IPIs when the guest has a lot of
> + * vCPUs. When the vCPU are pinned, the IPIs are local which reduces
> + * rerouting between interrupt controllers and gives better
> + * performance.
> + */
> +typedef struct {
> +    SpaprXive *xive;
> +    int ipi;
> +    Error *err;
> +    int rc;
> +} XiveInitIPI;
> +
> +static void kvmppc_xive_reset_ipi_on_cpu(CPUState *cs, run_on_cpu_data arg)
> +{
> +    XiveInitIPI *s = arg.host_ptr;
> +    uint64_t state = 0;
> +
> +    s->rc = kvm_device_access(s->xive->fd, KVM_DEV_XIVE_GRP_SOURCE, s->ipi,
> +                              &state, true, &s->err);
> +}
> +
> +static int kvmppc_xive_reset_ipi(SpaprXive *xive, int ipi, Error **errp)
> +{
> +    PowerPCCPU *cpu = spapr_find_cpu(ipi);
> +    XiveInitIPI s = {
> +        .xive = xive,
> +        .ipi  = ipi,
> +        .err  = NULL,
> +        .rc   = 0,
> +    };
> +
> +    run_on_cpu(CPU(cpu), kvmppc_xive_reset_ipi_on_cpu, RUN_ON_CPU_HOST_PTR(&s));
> +    if (s.err) {
> +        error_propagate(errp, s.err);
> +    }
> +    return s.rc;
> +}
> +
>  /*
>   * At reset, the interrupt sources are simply created and MASKED. We
>   * only need to inform the KVM XIVE device about their type: LSI or
> @@ -230,11 +271,20 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **errp)
>   */
>  int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
>  {
> +    MachineState *machine = MACHINE(qdev_get_machine());
>      SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
>      uint64_t state = 0;
>  
>      assert(xive->fd != -1);
>  
> +    /*
> +     * IPIs are special. Allocate the IPIs from the vCPU context for
> +     * those running. Hotplugged CPUs will the QEMU context.
> +     */
> +    if (srcno < machine->smp.cpus) {
> +        return kvmppc_xive_reset_ipi(xive, srcno, errp);
> +    }
> +
>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
>          state |= KVM_XIVE_LEVEL_SENSITIVE;
>          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> 


