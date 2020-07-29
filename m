Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6796F2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6796F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0tzF-0002SG-O5
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 17:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0tyh-000227-7f; Wed, 29 Jul 2020 17:51:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:54593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0tyf-0006GA-4B; Wed, 29 Jul 2020 17:51:10 -0400
IronPort-SDR: TjIFteexEl5Cgu4Gkrnn3UuRQAM84Q/YimZkRLNdz+S9fjCJbQiXLlF2Jh4H4QESB89wNpNGYx
 uuXrYERrdoHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="215991135"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="215991135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 14:51:05 -0700
IronPort-SDR: WNVoyGq+GEWB+dVsHxQ3pz6/59oPB5fMJUjOA1cb22MA10YSGPTfkFfHp0vEVt66PmQCrn9vVw
 syoGrlg6Fo5A==
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="394783544"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.191.249])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 14:51:04 -0700
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
To: Klaus Jensen <its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
 <b5e82d6a-471e-8894-f418-73f7d99094da@linux.intel.com>
 <20200729212432.GA332974@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <ab06b5e1-4bc5-50d6-15cf-0d711b741be8@linux.intel.com>
Date: Wed, 29 Jul 2020 14:51:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729212432.GA332974@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 16:40:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 2:24 PM, Klaus Jensen wrote:
> On Jul 29 13:40, Andrzej Jakowski wrote:
>> On 7/20/20 4:37 AM, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
>>> use them in nvme_map_prp.
>>>
>>> This fixes a bug where in the case of a CMB transfer, the device would
>>> map to the buffer with a wrong length.
>>>
>>> Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> ---
>>>  hw/block/nvme.c       | 109 +++++++++++++++++++++++++++++++++++-------
>>>  hw/block/trace-events |   2 +
>>>  2 files changed, 94 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>> index 4d7b730a62b6..9b1a080cdc70 100644
>>> --- a/hw/block/nvme.c
>>> +++ b/hw/block/nvme.c
>>> @@ -270,20 +338,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>>>          } else {
>>>              if (unlikely(prp2 & (n->page_size - 1))) {
>>>                  trace_pci_nvme_err_invalid_prp2_align(prp2);
>>> +                status = NVME_INVALID_FIELD | NVME_DNR;
>>>                  goto unmap;
>>>              }
>>> -            if (qsg->nsg) {
>>> -                qemu_sglist_add(qsg, prp2, len);
>>> -            } else {
>>> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
>>> +            status = nvme_map_addr(n, qsg, iov, prp2, len);
>>> +            if (status) {
>>> +                goto unmap;
>>>              }
>>>          }
>>>      }
>>>      return NVME_SUCCESS;
>>>  
>>> - unmap:
>>> -    qemu_sglist_destroy(qsg);
>>> -    return NVME_INVALID_FIELD | NVME_DNR;
>>> +unmap:
>>> +    if (iov && iov->iov) {
>>> +        qemu_iovec_destroy(iov);
>>> +    }
>>> +
>>> +    if (qsg && qsg->sg) {
>>> +        qemu_sglist_destroy(qsg);
>>> +    }
>>> +
>>> +    return status;
>>
>> I think it would make sense to move whole unmap block to a separate function.
>> That function could be called from here and after completing IO and would contain
>> unified deinitialization block - so no code repetitions would be necessary.
>> Other than that it looks good to me. Thx!
>>
>> Reviewed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>>
>  
> Hi Andrzej,
> 
> Thanks for the review :)
> 
> Yes, this is done in a later patch ("hw/block/nvme: consolidate qsg/iov
> clearing"), but kept here to reduce churn.
> 
Yep, noticed that after sending email :)
Do you plan to submit second version of these patches incorporating some
of the feedback?


