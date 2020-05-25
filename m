Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287E92078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287E92078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBya-00067L-CL
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdBxV-00050p-Dq
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:11:57 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:50804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdBxT-00010W-56
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:11:57 -0400
Received: from player715.ha.ovh.net (unknown [10.110.115.139])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 19FDA214757
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 14:11:50 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id ED116127DE8EC;
 Mon, 25 May 2020 12:11:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002b8f4e54f-72cb-440c-a4f6-15cec5f0909e,26835B9205782E90874D777227A1F0DDBFD0E061)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 4/9] ppc/xive2: Introduce a presenter matching routine
To: Greg Kurz <groug@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-5-clg@kaod.org> <20200520191701.21dd0525@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b3b7c9b6-f370-84a0-3d8b-b15385947c4f@kaod.org>
Date: Mon, 25 May 2020 14:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520191701.21dd0525@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13116170966218935104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.124.17; envelope-from=clg@kaod.org;
 helo=20.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:11:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:17 PM, Greg Kurz wrote:
> On Wed, 13 May 2020 17:11:04 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> The VP space is larger in XIVE2 (P10), 24 bits instead of 19bits on
>> XIVE (P9), and the CAM line can use a 7bits or 8bits thread id.
>>
>> For now, we only use 7bits thread ids, same as P9, but because of the
>> change of the size of the VP space, the CAM matching routine is
>> different between P9 and P10. It is easier to duplicate the whole
>> routine than to add extra handlers in xive_presenter_tctx_match() used
>> for P9.
>>
> 
> It's a bit of a pity to duplicate this routine. What about turning it
> into a helper with some extra arguments and come up with dedicated
> users for P9 and P10 ?

The size of the context fields have changed. It's not sure it will
be better.

>> We might come with a better solution later on, after we have added
>> some more support for the XIVE2 controller.
>>
> 
> Of course if you envision substantial changes that would prevent to share
> enough logic, you can ignore the previous comment. The duplicated routine
> looks fine.
> 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive2.h |  9 +++++
>>  hw/intc/xive2.c        | 87 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 96 insertions(+)
>>
>> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
>> index cb15487efdb6..4aefca4d96f1 100644
>> --- a/include/hw/ppc/xive2.h
>> +++ b/include/hw/ppc/xive2.h
>> @@ -60,6 +60,15 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>>  
>>  void xive2_router_notify(XiveNotifier *xn, uint32_t lisn);
>>  
>> +/*
>> + * XIVE2 Presenter (POWER10)
>> + */
>> +
>> +int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>> +                                uint8_t format,
>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                bool cam_ignore, uint32_t logic_serv);
>> +
>>  /*
>>   * XIVE2 END ESBs  (POWER10)
>>   */
>> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index 15ea04cf1822..1ce9d995e990 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -20,6 +20,11 @@
>>  #include "hw/ppc/xive2.h"
>>  #include "hw/ppc/xive2_regs.h"
>>  
>> +static inline uint32_t xive_tctx_word2(uint8_t *ring)
>> +{
>> +    return *((uint32_t *) &ring[TM_WORD2]);
>> +}
>> +
>>  static uint8_t priority_to_ipb(uint8_t priority)
>>  {
>>      return priority > XIVE_PRIORITY_MAX ?
>> @@ -212,6 +217,88 @@ static int xive2_router_get_block_id(Xive2Router *xrtr)
>>     return xrc->get_block_id(xrtr);
>>  }
>>  
>> +/*
>> + * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
>> + * width and block id width is configurable at the IC level.
>> + *
>> + *    chipid << 19 | 0000000 0 0001 threadid (7Bit)
>> + *    chipid << 24 | 0000 0000 0000 0001 threadid (8Bit)
>> + */
> 
> What about introducing:
> 
> #define XIVE2_PIR_TO_NVP_IDX(pir, width) \
>     (1 << (width) | ((pir) & ((1 << (width)) - 1))
> 
> or any better name you can think of and...

yes. This looks nice.

Thanks,

C. 

> 
>> +static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>> +{
>> +    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
>> +    CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
>> +    uint32_t pir = env->spr_cb[SPR_PIR].default_value;
>> +    uint8_t blk = xive2_router_get_block_id(xrtr);
>> +    uint8_t tid_shift = 7;
>> +    uint8_t tid_mask = (1 << tid_shift) - 1;
>> +
>> +    return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
> 
> ... turn this into:
> 
>     /* We only use 7bit thread ids for now */
>     return xive2_nvp_cam_line(blk, XIVE2_PIR_TO_NVP_IDX(pir, 7));
> 
>> +}
>> +
>> +/*
>> + * The thread context register words are in big-endian format.
>> + */
>> +int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>> +                                uint8_t format,
>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                bool cam_ignore, uint32_t logic_serv)
>> +{
>> +    uint32_t cam =   xive2_nvp_cam_line(nvt_blk, nvt_idx);
>> +    uint32_t qw3w2 = xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
>> +    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>> +    uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>> +    uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
>> +
>> +    /*
>> +     * TODO (PowerNV): ignore mode. The low order bits of the NVT
>> +     * identifier are ignored in the "CAM" match.
>> +     */
>> +
>> +    if (format == 0) {
>> +        if (cam_ignore == true) {
>> +            /*
>> +             * F=0 & i=1: Logical server notification (bits ignored at
>> +             * the end of the NVT identifier)
>> +             */
>> +            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\n",
>> +                          nvt_blk, nvt_idx);
>> +             return -1;
>> +        }
>> +
>> +        /* F=0 & i=0: Specific NVT notification */
>> +
>> +        /* PHYS ring */
>> +        if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
>> +            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
>> +            return TM_QW3_HV_PHYS;
>> +        }
>> +
>> +        /* HV POOL ring */
>> +        if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
>> +            cam == xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
>> +            return TM_QW2_HV_POOL;
>> +        }
>> +
>> +        /* OS ring */
>> +        if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>> +            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
>> +            return TM_QW1_OS;
>> +        }
>> +    } else {
>> +        /* F=1 : User level Event-Based Branch (EBB) notification */
>> +
>> +        /* USER ring */
>> +        if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>> +             (cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
>> +             (be32_to_cpu(qw0w2) & TM2_QW0W2_VU) &&
>> +             (logic_serv == xive_get_field32(TM2_QW0W2_LOGIC_SERV, qw0w2))) {
>> +            return TM_QW0_USER;
>> +        }
>> +    }
>> +    return -1;
>> +}
>> +
>>  static void xive2_router_realize(DeviceState *dev, Error **errp)
>>  {
>>      Xive2Router *xrtr = XIVE2_ROUTER(dev);
> 


