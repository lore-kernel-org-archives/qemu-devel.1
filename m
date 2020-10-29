Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C94C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 05:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DB820728
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 05:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DB820728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY0yV-0001a7-Cx
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 01:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kY0xX-00013P-Oe; Thu, 29 Oct 2020 01:58:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kY0xU-0004Y2-UZ; Thu, 29 Oct 2020 01:58:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMF9q4b2kzkbVB;
 Thu, 29 Oct 2020 13:58:39 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 13:58:32 +0800
Message-ID: <5F9A5A08.3090507@huawei.com>
Date: Thu, 29 Oct 2020 13:58:32 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH] vhost-user-blk: Fix two resource leaks
References: <5F997B84.9040900@huawei.com>
 <CAFubqFv0m9BeAvmCCkv9iEMvUXfHP2z+HJ8ffkOG4KONig2LHQ@mail.gmail.com>
In-Reply-To: <CAFubqFv0m9BeAvmCCkv9iEMvUXfHP2z+HJ8ffkOG4KONig2LHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:58:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/10/28 23:40, Raphael Norwitz wrote:
> The change looks good but I'm not sure I'd call it resource leak in
> either case since the failure case kills vhost-user-blk/scsi. In the
> commit message maybe rather say "vhost-user-blk/scsi: fix broken error
> handling for socket call"?
>

Thanks for your suggestion. I will modify the commit message in next version.

Thanks,
Alex

> On Wed, Oct 28, 2020 at 10:10 AM AlexChen <alex.chen@huawei.com> wrote:
>>
>> When socket() fails, it returns -1, 0 is the normal return value and should not return
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: AlexChen <alex.chen@huawei.com>
>> ---
>>  contrib/vhost-user-blk/vhost-user-blk.c   | 2 +-
>>  contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
>> index 25eccd02b5..40a2dfc544 100644
>> --- a/contrib/vhost-user-blk/vhost-user-blk.c
>> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
>> @@ -474,7 +474,7 @@ static int unix_sock_new(char *unix_fn)
>>      assert(unix_fn);
>>
>>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
>> -    if (sock <= 0) {
>> +    if (sock < 0) {
>>          perror("socket");
>>          return -1;
>>      }
>> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
>> index 3c912384e9..0f9ba4b2a2 100644
>> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
>> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
>> @@ -320,7 +320,7 @@ static int unix_sock_new(char *unix_fn)
>>      assert(unix_fn);
>>
>>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
>> -    if (sock <= 0) {
>> +    if (sock < 0) {
>>          perror("socket");
>>          return -1;
>>      }
>> --
>> 2.19.1
>>
> .
> 


