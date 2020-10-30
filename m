Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8458C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154B02071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1LbVVsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154B02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW1I-0004hb-PL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVkj-0001PD-Po
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVkh-0003yS-Kf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604069499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtKS7lwN7u0IFjDWDyJXAKW2kgHV62xxsRXwVFZo75k=;
 b=U1LbVVszwAD+ch8lzlgjIHjkJb60DCSbLH4+csvVCc3PIg1weSW2CmuB21mKaCoAC75rUj
 bOrC4jZrep/kh+31RtLCZDVbG3/EZe5zNQqonLYAdDx8lTiQ1hAF3O7IRfajTKvdbA0VTP
 SUVFSMyeU84nirzXeb4a7LjK5UlDEGk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-lsyfkeyNMamNxJqQCQGRlA-1; Fri, 30 Oct 2020 10:51:36 -0400
X-MC-Unique: lsyfkeyNMamNxJqQCQGRlA-1
Received: by mail-wr1-f70.google.com with SMTP id m4so2731051wrq.23
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4YgAyreCt3RuIM9969z4u8MrkWopdCD8NoBNXd05d50=;
 b=bSozcGNGmFiGvLMWLDqwia54GPL6HP8NKm/qxz66QeP+iBpTNAcEpQFUB5WfZAJh79
 MVRfIWRyQ6fAaU94oqGZTkBJVHoHWs25OHqf/uVJuikHU2qPyg1w9iDw15ZgNcQ4IFCO
 fjposJHDZ++5Z6MapSvuSWMYsTcN2Xwz8lnzfncLeeuGxEjPNiduaSYxpuT71D4r5iJn
 G9uR/gnwRR4yglNvPTc0jfUKWbjcFvWfx1E++BVkO1dFVUkPtZlqmR9+ZYkExcltx/r7
 a6EOR/HdDKSVAntJ1+9EA0AnOZ6HE21DkT7kENtwIz6vmblSBEDq2yHEnsv0uTGk960M
 x9Lw==
X-Gm-Message-State: AOAM531C8yyH+VhdO5jmnvXM1GbjKkc9znQ5O0wcjpH8LDuutBxZ6GMj
 HaLAOXGg7Fc3WCRhOlDWsAYzwS5CzN89A5mCKkAbNWsLHfKE9o9tTMeoNfRMDU+xOo8Y1CaA6Ri
 YLUKk2pCgzw546cU=
X-Received: by 2002:a1c:2096:: with SMTP id g144mr3228747wmg.79.1604069492404; 
 Fri, 30 Oct 2020 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Hqd7RA6M3JomYKztOBfJM28ECAf1epVuxaU9Oj5AFHMhREwhtjA8hhWvF9CMkbml26q/TQ==
X-Received: by 2002:a1c:2096:: with SMTP id g144mr3228720wmg.79.1604069492193; 
 Fri, 30 Oct 2020 07:51:32 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t5sm12254702wrb.21.2020.10.30.07.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 07:51:31 -0700 (PDT)
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
 <20201028151633.GH231368@stefanha-x1.localdomain>
 <d2e9983d-066d-e721-55ca-5d7cdbf35dbc@redhat.com>
 <43f09633-dfc6-289a-f138-32e32afd69de@redhat.com>
 <20201030114626.GH307361@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f697299-996e-12ba-c5f4-8d59b9d800f2@redhat.com>
Date: Fri, 30 Oct 2020 15:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030114626.GH307361@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/30/20 12:46 PM, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 10:02:37AM +0100, Philippe Mathieu-Daudé wrote:
>> On 10/28/20 7:24 PM, Philippe Mathieu-DaudÃ© wrote:
>>> On 10/28/20 4:16 PM, Stefan Hajnoczi wrote:
>>>> On Tue, Oct 27, 2020 at 02:55:35PM +0100, Philippe Mathieu-DaudÃ© wrote:
>>>>> Rename Submission Queue flags with 'Sq' and introduce
>>>>> Completion Queue flag definitions.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
>>>>> ---
>>>>>  include/block/nvme.h | 17 +++++++++++------
>>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>>>>> index 65e68a82c89..079f884a2d3 100644
>>>>> --- a/include/block/nvme.h
>>>>> +++ b/include/block/nvme.h
>>>>> @@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
>>>>>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
>>>>>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
>>>>>  
>>>>> +enum NvmeFlagsCq {
>>>>> +    NVME_CQ_PC          = 1,
>>>>> +    NVME_CQ_IEN         = 2,
>>>>> +};
>>>>> +
>>>>>  typedef struct QEMU_PACKED NvmeCreateSq {
>>>>>      uint8_t     opcode;
>>>>>      uint8_t     flags;
>>>>> @@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
>>>>>  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>>>>>  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
>>>>>  
>>>>> -enum NvmeQueueFlags {
>>>>> -    NVME_Q_PC           = 1,
>>>>> -    NVME_Q_PRIO_URGENT  = 0,
>>>>> -    NVME_Q_PRIO_HIGH    = 1,
>>>>> -    NVME_Q_PRIO_NORMAL  = 2,
>>>>> -    NVME_Q_PRIO_LOW     = 3,
>>>>> +enum NvmeFlagsSq {
>>>>> +    NVME_SQ_PC          = 1,
>>>>> +    NVME_SQ_PRIO_URGENT = 0,
>>>>> +    NVME_SQ_PRIO_HIGH   = 1,
>>>>> +    NVME_SQ_PRIO_NORMAL = 2,
>>>>> +    NVME_SQ_PRIO_LOW    = 3,
>>>>>  };
>>>>
>>>> There is also:
>>>>
>>>>   #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>>>>   #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
>>>>
>>>> These macros should use the new constants.
>>
>> SQ_PC is bit#0, NVME_SQ_PC is "bit SQ_PC set (PC enabled)",
>> SQ_PRIO are bits #1-2 (shift by 1, mask 2 bits),
>> NVME_SQ_PRIO_xxx is the enum of these 2 bits.
>>
>> The NVME_SQ_FLAGS_X() macros extract the flags.
>>
>> So the macros can not use the new constants.
> 
> I'm not sure I understand. Does this mean the header only defines the
> flag values but not the bit shift constants?

Yes.

> 
> It seems like hw/block/nvme.c and block/nvme.c are expressing flags in
> slightly different approaches. Can they be unified instead of
> introducing hw/block/nvme.c- and block/nvme.c-only constants in the
> shared header file?

I suggested the hw/block/nvme.c to unify the style.
Klaus agreed (at least to have a look). Any change will
be for 6.0 anyway.


