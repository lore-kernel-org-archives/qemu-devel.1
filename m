Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B938C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E077A21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXcBfQUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E077A21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLie-0004jr-QF
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXLhA-0003ZF-Rx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXLh8-000726-Vk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603792509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lL+r/OPB9ALvrHvqiF29YjYihy0yeSapKR0Yz/ZeKR4=;
 b=WXcBfQUnqIvh1IySA2PwbG5U093sRiBMtmUvTk6Noiw3KbkIdAqYA1jHfFMvibix7jAZnn
 2Src3TOiTMnHH/pWHwcxzbYZYRKl2GtQRwR54pZjYY/V+l71HAnXt8SVYpY5wdyJACg16R
 +7t+rf4j3uZVZP+DxNmQug/tHnO40SY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-M3ywZ2ZINHuhI5ONQ2vnsg-1; Tue, 27 Oct 2020 05:55:07 -0400
X-MC-Unique: M3ywZ2ZINHuhI5ONQ2vnsg-1
Received: by mail-ed1-f70.google.com with SMTP id t7so483138edt.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lL+r/OPB9ALvrHvqiF29YjYihy0yeSapKR0Yz/ZeKR4=;
 b=AGHZY67N647KbTqEU214R4tLDdJxdumNmlOLfMJPpKPZm02l9asK/9I7hA/b6xNnA6
 bOhdBTpdpdl72iV5f2dEVjHGJwAZdasCzwBU85SkxIS42MNaYg4AjAT802grnQ2Jqj+t
 kqBCJDr0TRxXRmyn8QnFVw7L0JHRJHdVrqV3I6TfWvc42ZJG7nIVFdD4rIdpg2ctb/y0
 YnmAOVjf+sGUXnLDchYgr3I5nKxpWLjL+2yauF9+Im9Gp7z4jOrZ4i+DwbaK2DfMfj93
 bphQc5IjtF4uA3XfROclnsVD8FOtXFUxi3ilr5agT4DtLs432O/+DW8UfiFXrNAkAxXW
 e3qA==
X-Gm-Message-State: AOAM5335lgsJjdlRe0n8RYcPejNsi5W0PBes762kxUNdEtaSPJpbNlJ5
 DHKDxxFRBc/e/lVFydLbHpwc1eTC76N/vj+3HXL0lNtzJfjfufT8AXjQM/tZQE8kDrxNOudeS8N
 6da49ECQnPse2iO8=
X-Received: by 2002:a17:906:3a49:: with SMTP id
 a9mr1599910ejf.95.1603792506369; 
 Tue, 27 Oct 2020 02:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9e02dw+lXxJxjdRFIYfEThYJKTebTx5tMY+NBfhynnXxn5b3aThMiKw8SbVuWaBMdH7B4oA==
X-Received: by 2002:a17:906:3a49:: with SMTP id
 a9mr1599886ejf.95.1603792506105; 
 Tue, 27 Oct 2020 02:55:06 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z26sm686499ejr.95.2020.10.27.02.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:55:05 -0700 (PDT)
Subject: Re: [PATCH v2 18/19] block/nvme: Switch to using the MSIX API
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-19-philmd@redhat.com>
 <f07fe7f6-06f7-781f-4c09-f8a5d4066cd1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc9d66c5-5777-8f92-0721-32c071c02e71@redhat.com>
Date: Tue, 27 Oct 2020 10:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f07fe7f6-06f7-781f-4c09-f8a5d4066cd1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:32 PM, Auger Eric wrote:
> Hi Philippe,
> 
> On 10/26/20 11:55 AM, Philippe Mathieu-Daudé wrote:
>> In preparation of using multiple IRQs, switch to using the recently
>> introduced MSIX API. Instead of allocating and assigning IRQ in
>> a single step, we now have to use two distinct calls.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 46b09b3a3a7..191678540b6 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -693,6 +693,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>      size_t device_page_size_min;
>>      size_t device_page_size_max;
>>      size_t iommu_page_size_min = 4096;
>> +    unsigned irq_count = MSIX_IRQ_COUNT;
>>  
>>      qemu_co_mutex_init(&s->dma_map_lock);
>>      qemu_co_queue_init(&s->dma_flush_queue);
>> @@ -809,8 +810,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>          }
>>      }
>>  
>> -    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
>> -                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
>> +    ret = qemu_vfio_pci_msix_init_irqs(s->vfio, &irq_count, errp);
>> +    if (ret) {
>> +        if (ret == -EOVERFLOW) {
>> +            error_append_hint(errp, "%u IRQs requested but only %u available\n",
>> +                              MSIX_IRQ_COUNT, irq_count);
> This message can be directly printed in qemu_vfio_pci_msix_init_irqs()

Good idea, thanks.


