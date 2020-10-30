Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B08E20728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g84bd8Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B08E20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW5H-0001IY-1f
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVn1-0004eq-9c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVmz-00049i-J5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604069640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3o6J6vsahCakv4o8Pybg5UVMpYmW3t8OYeYO8IYlTE=;
 b=g84bd8Sei6+yDWQDR2XKeSzuSZyh+EhSR8XSdKo9+h/p585qpb3eZ6CWtg0yVBb42B/jMH
 /MF3IR8xH3T0H8kJnSGbwTezK+XssadWNP63/jwf6Yt91tTc5In7jRI8o1BqbIWm/wCkFs
 JJrdXy9c0rn/CvO0bCfFSokQMh1qLeA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-gtlr8PhFO6aOvE94BNh7FQ-1; Fri, 30 Oct 2020 10:53:58 -0400
X-MC-Unique: gtlr8PhFO6aOvE94BNh7FQ-1
Received: by mail-wm1-f70.google.com with SMTP id l23so708216wmg.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xHwmkqKaV0F4XscYAD/NaNtP/v9PSwzHGOLyeLfGJjQ=;
 b=Yf3VoGmdzRDPh4J7bfQaaVEkLOG+t7jc8uiAjUfApq77y3nI8hSaNBa82XfL54oXq9
 wWWgDtOF3TMw4kyWRgFOxZbr8fbZcQKAmjvr9pN1LgbXlbPLh+ELvirxvixYGoIFqsS1
 9ZxHC6/9+xSzO23+iJ7Ax2hyDxMwkRqgjn68aq/yTW4aVp1RI0cSjRlXRUvT3d6tBOhz
 OkGhJkr51snr4x/lzzBt7PwE8E3gyT9Jb7f197WtRuNqvPLlH5Ki/D9xnY1/jT3D2aH3
 P5EW0PP1mzlxxbiXVBz+okD6MT2E+mHiolM/GNe+i9FPz7t+vdKglQnX+HS1O1ciI8H4
 yntg==
X-Gm-Message-State: AOAM530pfvAyIWCFrVmTr8hvBkt5K8MeurUs0FSUYKllAKX8RFRMQ+bs
 zmnfvF/7cUj4HuTiEN1HJvX4OksUYJMPx1xK1ChRz6ErJ0olKb/ZgnFQzMb6Alise+DS4RZc/h2
 e2HyoMQSXuT9nuUU=
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr3505619wrx.4.1604069637191; 
 Fri, 30 Oct 2020 07:53:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhCPQt/3ZcJUy31HCtNtZjWLPzkZA5ZLY5LdVbAdSbrHCv6bz2L3WUwwM966s5g5rRNobjFQ==
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr3505597wrx.4.1604069636925; 
 Fri, 30 Oct 2020 07:53:56 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m4sm10736320wrr.47.2020.10.30.07.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 07:53:55 -0700 (PDT)
Subject: Re: [PATCH-for-6.0 v2 25/25] block/nvme: Simplify Completion Queue
 Command Identifier field use
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
 <20201029093306.1063879-26-philmd@redhat.com>
 <20201030140002.GB330921@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f46d3622-7fc4-7d98-c6c4-6a70d7fdb79a@redhat.com>
Date: Fri, 30 Oct 2020 15:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030140002.GB330921@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 3:00 PM, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 10:33:06AM +0100, Philippe Mathieu-Daudé wrote:
>> The "Completion Queue Entry: DW 2" describes it as:
>>
>>   This identifier is assigned by host software when
>>   the command is submitted to the Submission
>>
>> As the is just an opaque cookie, it is pointless to byte-swap it.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index a06a188d530..e7723c42a6d 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -344,7 +344,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
>>          trace_nvme_error(le32_to_cpu(c->result),
>>                           le16_to_cpu(c->sq_head),
>>                           le16_to_cpu(c->sq_id),
>> -                         le16_to_cpu(c->cid),
>> +                         c->cid,
>>                           le16_to_cpu(status));
>>      }
>>      switch (status) {
>> @@ -401,7 +401,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
>>          if (!q->cq.head) {
>>              q->cq_phase = !q->cq_phase;
>>          }
>> -        cid = le16_to_cpu(c->cid);
>> +        cid = c->cid;
>>          if (cid == 0 || cid > NVME_QUEUE_SIZE) {
>>              warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
>>                          "queue size: %u", cid, NVME_QUEUE_SIZE);
>> @@ -469,7 +469,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
>>      assert(!req->cb);
>>      req->cb = cb;
>>      req->opaque = opaque;
>> -    cmd->cid = cpu_to_le16(req->cid);
>> +    cmd->cid = req->cid;
>>  
>>      trace_nvme_submit_command(q->s, q->index, req->cid);
>>      nvme_trace_command(cmd);
> 
> Eliminating the byteswap is safe but this patch makes the code
> confusing, as I mentioned previously.
> 
> Please use a comment or macro to mark this field native endian. It's not
> obvious to the reader that we can skip the byteswap here.
> 
> Otherwise it will confuse readers into adding the byteswap back, not
> using byteswapping in other places where it is needed, etc.

OK. (This patch is for 6.0 anyway, I included because it was
following the previous patch in its previous version).

> 
> Thanks,
> Stefan
> 


