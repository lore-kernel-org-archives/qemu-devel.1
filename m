Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D705C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD40921D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN7s+sR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD40921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5ss-00069F-Qx
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT5rM-0005MM-UC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT5rL-0004bT-9G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602778325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81ROXOxapOUMvgzejlcmV7SQ/vlrijnKFJikNXfO0Co=;
 b=BN7s+sR5SBv9EYv9t14IiEwgmqmAx/cd+xIaqhR4ZJlVTZTnrom8Y5m6X2XYojfe8rsXJr
 2IwiEWDaGokWyJgWeW7R0g7Gny8LWekq4m8faT7qQ+n8BOHYAC5bUYrmtQzTbhzDr8WlAb
 ycLc4cNBz8bn6Ayl+PgWY4Yfh+PVkww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-J3wGt6WxMfuMbp9EI4xjJg-1; Thu, 15 Oct 2020 12:12:01 -0400
X-MC-Unique: J3wGt6WxMfuMbp9EI4xjJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2DFAF9A0;
 Thu, 15 Oct 2020 16:11:59 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD67519C4F;
 Thu, 15 Oct 2020 16:11:57 +0000 (UTC)
Subject: Re: [RFC 1/5] block/nvme: use some NVME_CAP_* macros
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <20201015115252.15582-2-eric.auger@redhat.com>
 <ca512856-40a7-01a6-ec82-3a5b8c81b52a@redhat.com>
 <e479e77c-9061-22a4-eb57-3997a3a4910b@redhat.com>
 <4787ed29-8659-b578-c804-8b27d4551212@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a071c2f5-3571-293a-31a3-ead0012d2142@redhat.com>
Date: Thu, 15 Oct 2020 18:11:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4787ed29-8659-b578-c804-8b27d4551212@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/15/20 3:36 PM, Philippe Mathieu-Daudé wrote:
> On 10/15/20 3:32 PM, Philippe Mathieu-Daudé wrote:
>> On 10/15/20 3:29 PM, Philippe Mathieu-Daudé wrote:
>>> On 10/15/20 1:52 PM, Eric Auger wrote:
>>>> let's use NVME_CAP_DSTRD, NVME_CAP_MPSMIN and NVME_CAP_TO macros
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>   block/nvme.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/block/nvme.c b/block/nvme.c
>>>> index f4f27b6da7..e3d96f20d0 100644
>>>> --- a/block/nvme.c
>>>> +++ b/block/nvme.c
>>>> @@ -728,10 +728,10 @@ static int nvme_init(BlockDriverState *bs,
>>>> const char *device, int namespace,
>>>>           goto out;
>>>>       }
>>>> -    s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>>>> -    s->doorbell_scale = (4 << (((cap >> 32) & 0xF))) /
>>>> sizeof(uint32_t);
>>>> +    s->page_size = MAX(4096, 1 << (12 + NVME_CAP_MPSMIN(cap)));
>>>
>>> Are you suggesting commit fad1eb68862 ("block/nvme: Use register
>>> definitions from 'block/nvme.h'") is buggy?
yes I think so. Sorry I messed up my rebase and failed to grab that patch.
>>
>> Buh I wonder how we missed that :/
> 
> Since your patch doesn't apply anyway, I might fix as:
> 
>         s->page_size = 4096 << NVME_CAP_MPSMIN(cap);
1 << (12 + NVME_CAP_MPSMIN(cap)) matches the spec text so personally I
would keep that.

Thanks

Eric
> 
>>
>>>
>>>> +    s->doorbell_scale = (4 << ((NVME_CAP_DSTRD(cap)))) /
>>>> sizeof(uint32_t);
>>>>       bs->bl.opt_mem_alignment = s->page_size;
>>>> -    timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
>>>> +    timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>>>>       /* Reset device to get a clean state. */
>>>>       s->regs->ctrl.cc = cpu_to_le32(le32_to_cpu(s->regs->ctrl.cc) &
>>>> 0xFE);
>>>>
>>>
>>
> 
> 


