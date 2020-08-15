Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BBC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 19:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEBB23C83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 19:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEBB23C83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k71S7-0002Tv-9j
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 15:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1k71QK-0001G9-3V
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 15:01:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46132 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1k71QH-0005Bt-KU
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 15:00:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C9C8DC3958F9013A0153
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 11:10:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.46) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 11:10:35 +0800
Subject: Re: [PATCH 12/12] test-util-sockets: Fix a memleak in
 test_socket_unix_abstract_good
To: Li Qiang <liq3ea@gmail.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-13-pannengyuan@huawei.com>
 <CAKXe6S+Oc=DaNE=JXW850xoUVmRWv9423NtDVvKd25QfurAgzA@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <61e5f585-82e0-2fa4-d115-3a9cd8a6f12f@huawei.com>
Date: Sat, 15 Aug 2020 11:10:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+Oc=DaNE=JXW850xoUVmRWv9423NtDVvKd25QfurAgzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.46]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 14:01:48
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
Cc: kuhn.chenqun@huawei.com, euler.robot@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/14 22:50, Li Qiang wrote:
> Pan Nengyuan <pannengyuan@huawei.com> 于2020年8月14日周五 下午6:18写道：
>>
>> Fix a memleak in test_socket_unix_abstract_good().
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
> 
> Hi Nengyuan,
> I have sent this two month ago:
> -->https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00809.html
> 
> seems the maintainer forget to push it to upstream.

Yes, it's the same. Let's ignore this one.

Thanks.

> 
> Thanks,
> Li Qiang
> 
> 
>>  tests/test-util-sockets.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
>> index 261dc48c03..5c4204a130 100644
>> --- a/tests/test-util-sockets.c
>> +++ b/tests/test-util-sockets.c
>> @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
>>      g_thread_join(cli);
>>      g_thread_join(serv);
>>
>> +    g_rand_free(r);
>>      g_free(abstract_sock_name);
>>  }
>>  #endif
>> --
>> 2.18.2
>>
>>


