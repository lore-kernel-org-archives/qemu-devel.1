Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6377C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2B4206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2B4206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3x2Y-000385-Tx
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 03:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3x1w-0002eU-Se; Fri, 07 Aug 2020 03:43:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4167 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3x1s-0006YF-Ql; Fri, 07 Aug 2020 03:43:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8F69BAF8AB191D929C21;
 Fri,  7 Aug 2020 15:42:47 +0800 (CST)
Received: from [10.174.185.104] (10.174.185.104) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 7 Aug 2020 15:42:38 +0800
Subject: Re: [PATCH] qcow2: flush qcow2 l2 meta for new allocated clusters
To: Kevin Wolf <kwolf@redhat.com>
References: <20200805023826.184-1-fangying1@huawei.com>
 <20200806091326.GC17753@linux.fritz.box>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <1c2447af-1265-c45c-6374-f20d482f51be@huawei.com>
Date: Fri, 7 Aug 2020 15:42:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200806091326.GC17753@linux.fritz.box>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:13:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/6/2020 5:13 PM, Kevin Wolf wrote:
> Am 05.08.2020 um 04:38 hat Ying Fang geschrieben:
>> From: fangying <fangying1@huawei.com>
>>
>> When qemu or qemu-nbd process uses a qcow2 image and configured with
>> 'cache = none', it will write to the qcow2 image with a cache to cache
>> L2 tables, however the process will not use L2 tables without explicitly
>> calling the flush command or closing the mirror flash into the disk.
>> Which may cause the disk data inconsistent with the written data for
>> a long time. If an abnormal process exit occurs here, the issued written
>> data will be lost.
>>
>> Therefore, in order to keep data consistency we need to flush the changes
>> to the L2 entry to the disk in time for the newly allocated cluster.
>>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
> 
> If you want to have data safely written to the disk after each write
> request, you need to use cache=writethrough/directsync (in other words,
> aliases that are equivalent to setting -device ...,write-cache=off).
> Note that this will have a major impact on write performance.
> 
> cache=none means bypassing the kernel page cache (O_DIRECT), but not
> flushing after each write request.

Well, IIUC, cache=none does not guarantee data safety and we should not
expect that. Then this patch can be ignored.

Thanks.
> 
> Kevin
> 
> .
> 

