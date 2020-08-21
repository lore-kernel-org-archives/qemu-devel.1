Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE6B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE6B20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Ik-000362-RF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1k94MO-0002t5-1b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:33:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23111
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1k94ML-00031N-PF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:33:23 -0400
X-IronPort-AV: E=Sophos;i="5.76,335,1592841600"; d="scan'208";a="98388208"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 21 Aug 2020 18:33:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id E386648990CE;
 Fri, 21 Aug 2020 18:33:15 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 21 Aug 2020 18:33:17 +0800
Subject: Re: [PATCH] virtio-gpu: fix unmap the already mapped items
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200821084945.5264-1-lizhijian@cn.fujitsu.com>
 <20200821100723.vbyo5bpxwrmjqdyp@sirius.home.kraxel.org>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <e6cab032-531a-eee3-bfb0-69bff23a8353@cn.fujitsu.com>
Date: Fri, 21 Aug 2020 18:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821100723.vbyo5bpxwrmjqdyp@sirius.home.kraxel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: E386648990CE.ACFFD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 03:09:06
X-ACL-Warn: Detected OS   = ???
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/21/20 6:07 PM, Gerd Hoffmann wrote:
> On Fri, Aug 21, 2020 at 04:49:45PM +0800, Li Zhijian wrote:
>> we go here either (!(*iov)[i].iov_base) or (len != l), so we need to consider
>> to unmap the 'i'th item as well when the 'i'th item is not nil
>>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   hw/display/virtio-gpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 5f0dd7c150..1f777e43ff 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -656,7 +656,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>               qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>>                             " resource %d element %d\n",
>>                             __func__, ab->resource_id, i);
>> -            virtio_gpu_cleanup_mapping_iov(g, *iov, i);
>> +            virtio_gpu_cleanup_mapping_iov(g, *iov, i + !!(*iov)[i].iov_base);
> Cute trick, but the code should be readable without having to dig out
> the commit message which explains it.  Can we have something simpler
> along the lines of "if (iov_base) { i++; /* cleanup partial map */ }"
> please?
make sense !

Thanks
Zhijian

>
> thanks,
>    Gerd
>
>
>




