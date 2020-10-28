Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9ECC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D28247AF
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+pnOQE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D28247AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqAS-0001dQ-Lu
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXq7z-0000T3-MW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXq7w-0007cK-Vn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603909490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L5pkX1NeJo/IFwiRZFQ0fKnXXkJe/9sZ8PzKdEvUtM=;
 b=O+pnOQE5iyPYIO+rWvzJ1LL3s40rOa+2OtqpJ0VwbP2ZuNq/iUsXSHXtBxM+jB0/HAQ1W1
 J0zOE4FP6azXBVQykXiaa00bcU8LNwa/EmTeRxJSXXf9GHQYVXQBGzF5xs2T/daNarQmbV
 wpu0bdDWuZ27burxNhfHREaUHdVLqdI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-bGMgbFE0Mg664NlNfVcNdA-1; Wed, 28 Oct 2020 14:24:48 -0400
X-MC-Unique: bGMgbFE0Mg664NlNfVcNdA-1
Received: by mail-ej1-f71.google.com with SMTP id x12so156847eju.22
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pnr9Aovs/SIAWUs63+1k97Zezrm4R0rM5HC71GDf6lc=;
 b=UnO+fsSWosh6N7n9FL1xYULklRmjyilstPmqUlkPUC4YpJRz0aSqJUWClowp+Iw0o6
 X7lE9m0Ny0oN1WThN9h3f0cVJWpFsmKE5a2Ui0eDL7IRfxNGlKEq+RDBp9ruPH7/w++U
 n2qvAaaxeU86IAsnswul6hM4psqC8+5qTo56iJ7ntINsSVuA9oaTtKqxs09iRUalJzbQ
 yQ17/z9p3BxCxzvmyYSJjJJiT7e5RSU/+fWT9fspLiLc+1QYLf0hnr6BJ/ZCtRUpgJYS
 dK2D8sxyMmFSArPkVwAgXTlPorGGmKzGgkoauPdyqG5ciN/86uOWQGvzuiA1aRpjeF3i
 sn1A==
X-Gm-Message-State: AOAM531R4KSx+c2AvI1naI4fKWiC2pAig3UqM6Ubx2TqrabZU5YQCGTd
 +Fj9cV4nloyHRUDXtUhKg+P5GDRnFe4OJ4c5EzSMx9Hwr1l+F7Vlcd6OvhYrb2IhDOlST3BSv63
 aGH9S7fc4BG9nWzo=
X-Received: by 2002:a17:906:934d:: with SMTP id
 p13mr339823ejw.245.1603909487205; 
 Wed, 28 Oct 2020 11:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbViEytMMIaIsIoxwOyFTinui44DQy+Mj+RYDn/KUmkb4jxQXsAzYdDRjRBAx/kyvnWIiY6w==
X-Received: by 2002:a17:906:934d:: with SMTP id
 p13mr339792ejw.245.1603909486821; 
 Wed, 28 Oct 2020 11:24:46 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p1sm187804ejd.33.2020.10.28.11.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 11:24:46 -0700 (PDT)
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
 <20201028151633.GH231368@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2e9983d-066d-e721-55ca-5d7cdbf35dbc@redhat.com>
Date: Wed, 28 Oct 2020 19:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028151633.GH231368@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 4:16 PM, Stefan Hajnoczi wrote:
> On Tue, Oct 27, 2020 at 02:55:35PM +0100, Philippe Mathieu-Daudé wrote:
>> Rename Submission Queue flags with 'Sq' and introduce
>> Completion Queue flag definitions.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/block/nvme.h | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>> index 65e68a82c89..079f884a2d3 100644
>> --- a/include/block/nvme.h
>> +++ b/include/block/nvme.h
>> @@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
>>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
>>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
>>  
>> +enum NvmeFlagsCq {
>> +    NVME_CQ_PC          = 1,
>> +    NVME_CQ_IEN         = 2,
>> +};
>> +
>>  typedef struct QEMU_PACKED NvmeCreateSq {
>>      uint8_t     opcode;
>>      uint8_t     flags;
>> @@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
>>  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>>  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
>>  
>> -enum NvmeQueueFlags {
>> -    NVME_Q_PC           = 1,
>> -    NVME_Q_PRIO_URGENT  = 0,
>> -    NVME_Q_PRIO_HIGH    = 1,
>> -    NVME_Q_PRIO_NORMAL  = 2,
>> -    NVME_Q_PRIO_LOW     = 3,
>> +enum NvmeFlagsSq {
>> +    NVME_SQ_PC          = 1,
>> +    NVME_SQ_PRIO_URGENT = 0,
>> +    NVME_SQ_PRIO_HIGH   = 1,
>> +    NVME_SQ_PRIO_NORMAL = 2,
>> +    NVME_SQ_PRIO_LOW    = 3,
>>  };
> 
> There is also:
> 
>   #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>   #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
> 
> These macros should use the new constants.
> 
> I didn't check if there are additional magic numbers in hw/block/nvme.c
> that should be converted.

FYI we discussed with Klaus and might convert "block/nvme.h" to
use the registerfields API during the 6.0 dev cycle.


