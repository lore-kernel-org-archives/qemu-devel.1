Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 03:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9DD206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 03:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9DD206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB8nt-0002ta-4J
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 23:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1kB8nN-0002TR-JK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 23:41:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14667
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1kB8nL-0002Wo-S1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 23:41:49 -0400
X-IronPort-AV: E=Sophos;i="5.76,358,1592841600"; d="scan'208";a="98604731"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 27 Aug 2020 11:41:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id B2A6748990D8;
 Thu, 27 Aug 2020 11:41:32 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 27 Aug 2020 11:41:32 +0800
Subject: Re: [PATCH v2] virtio-gpu: fix unmap the already mapped items
To: Li Qiang <liq3ea@gmail.com>
References: <20200821104708.4632-1-lizhijian@cn.fujitsu.com>
 <CAKXe6S+5M9Ue=y-W+oJDecYuya7oRbfJsVXg_ZkHhkE2jyz+og@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <e2fff625-c6a5-5aa5-9adf-59cac79300ef@cn.fujitsu.com>
Date: Thu, 27 Aug 2020 11:41:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+5M9Ue=y-W+oJDecYuya7oRbfJsVXg_ZkHhkE2jyz+og@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: B2A6748990D8.AC44A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 23:41:38
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/26/20 10:54 PM, Li Qiang wrote:
> Li Zhijian <lizhijian@cn.fujitsu.com> 于2020年8月21日周五 下午7:34写道：
>> we go here either (!(*iov)[i].iov_base) or (len != l), so we need to consider
>> to unmap the 'i'th item as well when the 'i'th item is not nil
>>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>
>> ---
>> v2: address Gerd's comments
>> ---
>>   hw/display/virtio-gpu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 5f0dd7c150..e93f99932a 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -656,6 +656,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>               qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>>                             " resource %d element %d\n",
>>                             __func__, ab->resource_id, i);
>> +            if ((*iov)[i].iov_base) {
>> +                i++; /* cleanup the 'i'th map */
> Should we also reset (*iov)[i].iov_len to 'len' so the
> dma_memory_unmap has the right size?
Indeed, good caught, thanks



>
> Thanks,
> Li Qiang
>
>> +            }
>>               virtio_gpu_cleanup_mapping_iov(g, *iov, i);
>>               g_free(ents);
>>               *iov = NULL;
>> --
>> 2.17.1
>>
>>
>>
>>
>




