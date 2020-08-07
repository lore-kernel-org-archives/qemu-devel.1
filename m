Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BF12086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BF12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41cH-0003vb-3A
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k41bW-0003PZ-GB; Fri, 07 Aug 2020 08:36:10 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:37605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k41bU-0000IO-8b; Fri, 07 Aug 2020 08:36:10 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.121])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2DC904E0DC8E;
 Fri,  7 Aug 2020 14:36:02 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 14:36:02 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0067b75e85a-6d7d-47c0-869f-b481db73e458,
 9C6B65F6CFD3D723D723CC07BEDAC6F805E88D1E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v3 for-5.2 1/3] ppc/xive: Rework setup of
 XiveSource::esb_mmio
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
 <159679992680.876294.7520540158586170894.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed5e553d-0cd5-9195-ff0d-681b79d432c1@kaod.org>
Date: Fri, 7 Aug 2020 14:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159679992680.876294.7520540158586170894.stgit@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3490542b-5333-4ff6-81c9-5c6f686b7141
X-Ovh-Tracer-Id: 5382364507744340899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
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
> Depending on whether XIVE is emultated or backed with a KVM XIVE device,
> the ESB MMIOs of a XIVE source point to an I/O memory region or a mapped
> memory region.
> 
> This is currently handled by checking kvm_irqchip_in_kernel() returns
> false in xive_source_realize(). This is a bit awkward as we usually
> need to do extra things when we're using the in-kernel backend, not
> less. But most important, we can do better: turn the existing "xive.esb"
> memory region into a plain container, introduce an "xive.esb-emulated"
> I/O subregion and rename the existing "xive.esb" subregion in the KVM
> code to "xive.esb-kvm". Since "xive.esb-kvm" is added with overlap
> and a higher priority, it prevails over "xive.esb-emulated" (ie.
> a guest using KVM XIVE will interact with "xive.esb-kvm" instead of
> the default "xive.esb-emulated" region.
> 
> While here, consolidate the computation of the MMIO region size in
> a common helper.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>

This is much better

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/spapr_xive_kvm.c |    4 ++--
>  hw/intc/xive.c           |   11 ++++++-----
>  include/hw/ppc/xive.h    |    6 ++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 893a1ee77e70..6130882be678 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -742,7 +742,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
>      SpaprXive *xive = SPAPR_XIVE(intc);
>      XiveSource *xsrc = &xive->source;
>      Error *local_err = NULL;
> -    size_t esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +    size_t esb_len = xive_source_esb_len(xsrc);
>      size_t tima_len = 4ull << TM_SHIFT;
>      CPUState *cs;
>      int fd;
> @@ -788,7 +788,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
>      }
>  
>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
> -                                      "xive.esb", esb_len, xsrc->esb_mmap);
> +                                      "xive.esb-kvm", esb_len, xsrc->esb_mmap);
>      memory_region_add_subregion_overlap(&xsrc->esb_mmio, 0,
>                                          &xsrc->esb_mmio_kvm, 1);
>  
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9b55e0356c62..561d746cd1da 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1128,6 +1128,7 @@ static void xive_source_reset(void *dev)
>  static void xive_source_realize(DeviceState *dev, Error **errp)
>  {
>      XiveSource *xsrc = XIVE_SOURCE(dev);
> +    size_t esb_len = xive_source_esb_len(xsrc);
>  
>      assert(xsrc->xive);
>  
> @@ -1147,11 +1148,11 @@ static void xive_source_realize(DeviceState *dev, Error **errp)
>      xsrc->status = g_malloc0(xsrc->nr_irqs);
>      xsrc->lsi_map = bitmap_new(xsrc->nr_irqs);
>  
> -    if (!kvm_irqchip_in_kernel()) {
> -        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> -                              &xive_source_esb_ops, xsrc, "xive.esb",
> -                              (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
> -    }
> +    memory_region_init(&xsrc->esb_mmio, OBJECT(xsrc), "xive.esb", esb_len);
> +    memory_region_init_io(&xsrc->esb_mmio_emulated, OBJECT(xsrc),
> +                          &xive_source_esb_ops, xsrc, "xive.esb-emulated",
> +                          esb_len);
> +    memory_region_add_subregion(&xsrc->esb_mmio, 0, &xsrc->esb_mmio_emulated);
>  
>      qemu_register_reset(xive_source_reset, dev);
>  }
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 705cf48176fc..82a61eaca74f 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -191,6 +191,7 @@ typedef struct XiveSource {
>      uint64_t        esb_flags;
>      uint32_t        esb_shift;
>      MemoryRegion    esb_mmio;
> +    MemoryRegion    esb_mmio_emulated;
>  
>      /* KVM support */
>      void            *esb_mmap;
> @@ -215,6 +216,11 @@ static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
>          xsrc->esb_shift == XIVE_ESB_4K_2PAGE;
>  }
>  
> +static inline size_t xive_source_esb_len(XiveSource *xsrc)
> +{
> +    return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> +}
> +
>  /* The trigger page is always the first/even page */
>  static inline hwaddr xive_source_esb_page(XiveSource *xsrc, uint32_t srcno)
>  {
> 
> 


