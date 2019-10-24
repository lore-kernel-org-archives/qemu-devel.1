Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD8ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381E020679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381E020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbOJ-0007bm-Kb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNZXo-0003Hr-Gc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNZXn-0007Oq-2o
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:36:36 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2083)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNZXm-0007NU-G9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:36:35 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35db170871dd-484ca;
 Thu, 24 Oct 2019 17:36:07 +0800 (CST)
X-RM-TRANSID: 2ee35db170871dd-484ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.149])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85db17086662-6f7b6;
 Thu, 24 Oct 2019 17:36:07 +0800 (CST)
X-RM-TRANSID: 2ee85db17086662-6f7b6
Subject: Re: [PATCH] hw/audio: fix a memory leak in OPLCreate()
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
 <20191024082500.q3t4fmsc5crxp2yc@steredhat>
From: xiajidong <xiajidong@cmss.chinamobile.com>
Message-ID: <4d1304f5-6b8a-f260-e7ff-127381c0fc4f@cmss.chinamobile.com>
Date: Thu, 24 Oct 2019 05:36:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191024082500.q3t4fmsc5crxp2yc@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/24/19 4:25 AM, Stefano Garzarella wrote:
> On Wed, Oct 23, 2019 at 05:53:40PM +0800, Jidong Xia wrote:
>> There is a memory leak in OPLCreate(),Should free allocated mem
>> before return.
>>
>> Signed-off-by: Jidong Xia <xiajidong@cmss.chinamobile.com>
>> ---
>>   hw/audio/fmopl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
>> index 9f50a89..ca9825b 100644
>> --- a/hw/audio/fmopl.c
>> +++ b/hw/audio/fmopl.c
>> @@ -1112,6 +1112,7 @@ FM_OPL *OPLCreate(int clock, int rate)
>>   		opl_dbg_maxchip++;
>>   	}
>>   #endif
>> +	free(ptr);
>>   	return OPL;
> 
> I don't know this code well, but I don't think is correct to free 'ptr' in
> the success case, since it is the pointer returned by this function that
> will be freed by OPLDestroy().
> 
> Does that sound right or did I miss something?
ok, I understand it.
> 
> Thanks,
> Stefano
> 
> 
Thanks,
Jidong Xia



