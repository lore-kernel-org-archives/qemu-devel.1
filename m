Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46CFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9209C207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXCbb7I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9209C207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKmo-0008Fu-Pu
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKm8-0006qa-FL
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:12:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKm7-0004Fv-RJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589965950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmBTXrKZfzt1vRUc0Bxp4FN7eE83tA4uJfTjbMAA++I=;
 b=KXCbb7I5siuYeLaQYZ7WpWqwf3yAXYXv97TQChTdA5lKWQ+F67D5K/fvBXI/AgixtV7ZyW
 gKSgauxngthx/qLYMluLylWqli73I3thgMQaPa9Nv9fSkuKltLi2nzvjiwubrBCIjm1VF3
 J3AFVmrIYZlvYXNeuEs9+S4ELERoK/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-u8rAPu4NPwSwjvWq902QoQ-1; Wed, 20 May 2020 05:12:29 -0400
X-MC-Unique: u8rAPu4NPwSwjvWq902QoQ-1
Received: by mail-wm1-f72.google.com with SMTP id t62so968194wmt.7
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 02:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jmBTXrKZfzt1vRUc0Bxp4FN7eE83tA4uJfTjbMAA++I=;
 b=s7lNAfu6NlVsZ35e6uQAklhAfNd+W9OpJY7ddyZ9ilBs5y//KuKVWQ9T5jvecx8HTW
 Lna2ql/j+BXEC8AocxSi/b/OnDAIRxChHujuAEwLGRBozD6lOj5z88qG+xY29DXexJRA
 aqd/0gjzNS3vcF/WNMY+3NZ1X/wyNx31oBP9X390IFPbdQB2048cIJdSzasWpyE4bMLK
 LR+b+UzMjk90fURMIX3b0vykOjpGIoq0U+Mw8pWz/ChBYa+82vdvHA2EXrzbXolicKyC
 S9Nu2F3prs9rcr7zonyrwnCA/WPa4Bge8vLf3/duVHYR/tEar8zKVkyYfWlX+gcXBZCP
 cCZQ==
X-Gm-Message-State: AOAM533n1DaTcNs95sHmu98GZA1PlbGkpZRKpxZm4CMlBk76lCOx6h8/
 1XGos9NSPcT5cyULTdTexI3cnLedtB808yktEAyl44w+B/yqADWNwrwJpN5JAF0538ghV9myQeC
 0y+bKaYqt9BMtUZM=
X-Received: by 2002:a1c:df46:: with SMTP id w67mr3691640wmg.130.1589965947935; 
 Wed, 20 May 2020 02:12:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXwLkgaXiDtOOCB786bxn5r8nb0FgnixRV3Imb6qsTwIaSicCML2Z0B1RZJcMEj80AqTJS+g==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr3691625wmg.130.1589965947670; 
 Wed, 20 May 2020 02:12:27 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q2sm2105667wrx.60.2020.05.20.02.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 02:12:27 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] block: Assert we're running in the right thread
To: Kevin Wolf <kwolf@redhat.com>, Stefan Reiter <s.reiter@proxmox.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-4-kwolf@redhat.com>
 <4d2d9ecd-b921-c9e8-2eb4-066e092e6c1f@proxmox.com>
 <20200514143043.GI5518@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c40a0bee-091c-972e-1260-faaba5f4c03c@redhat.com>
Date: Wed, 20 May 2020 11:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514143043.GI5518@linux.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 4:30 PM, Kevin Wolf wrote:
> Am 14.05.2020 um 15:52 hat Stefan Reiter geschrieben:
>> On 5/12/20 4:43 PM, Kevin Wolf wrote:
>>> tracked_request_begin() is called for most I/O operations, so it's a
>>> good place to assert that we're indeed running in the home thread of the
>>> node's AioContext.
>>>
>>
>> Is this patch supposed to be always correct or only together with nr. 2?
>>
>> I changed our code to call bdrv_flush_all from the main AIO context and it
>> certainly works just fine (even without this series, so I suppose that would
>> be the 'correct' way to fix it you mention on the cover), though of course
>> it trips this assert without patch 2.
> 
> Yes, I think this is a basic assumption that should always be true.
> This series shouldn't fix anything for upstream QEMU (at least I'm not
> aware of anything that needs it), so the assertion could be added even
> without the other patches.
> 
> In fact, I'm currently thinking that committing just patch 1 (because
> it's a nice cleanup anyway) and patch 3 (because it will let us know
> when we mess up) might make sense.

FWIW applying 1+3 as no-RFC LGTM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Kevin
> 
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    block/io.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index 7808e8bdc0..924bf5ba46 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -695,14 +695,17 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>>>                                      uint64_t bytes,
>>>                                      enum BdrvTrackedRequestType type)
>>>    {
>>> +    Coroutine *self = qemu_coroutine_self();
>>> +
>>>        assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
>>> +    assert(bs->aio_context == qemu_coroutine_get_aio_context(self));
>>>        *req = (BdrvTrackedRequest){
>>>            .bs = bs,
>>>            .offset         = offset,
>>>            .bytes          = bytes,
>>>            .type           = type,
>>> -        .co             = qemu_coroutine_self(),
>>> +        .co             = self,
>>>            .serialising    = false,
>>>            .overlap_offset = offset,
>>>            .overlap_bytes  = bytes,
>>>
>>
> 
> 


