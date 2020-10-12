Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EEC2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw1iq87J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EEC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuwU-0002m4-Mi
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRusY-0005qM-C3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRusV-0004r7-IW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602497786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPJMsgV60J5M/rQYgOCknD3vdd9ba8Qf/zt4IWt5gRs=;
 b=Iw1iq87Jdp73mJtZprxwBDRt4zP4aH/+KtnAaoeinitGMBxnfjZyI15v9G1xTZxh+RcpA3
 M8raYC4LfnIEfTQg4bznLLzcOmggOZ+z+n1zKifF1LF50F2TVuiFVbfuExm6MizBj3BXHY
 Hq4LEm5p+GA1JNkTcjykkUelL3pHRCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-vWOsfTz2NUCgmkK3qa6vZQ-1; Mon, 12 Oct 2020 06:16:23 -0400
X-MC-Unique: vWOsfTz2NUCgmkK3qa6vZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 73so5068630wma.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dPJMsgV60J5M/rQYgOCknD3vdd9ba8Qf/zt4IWt5gRs=;
 b=GV0pNFAHeZOPGB38N0IHDRj1c1nhEJ6vFEi0dH7BnzzogFr9G8iifrtI4ffYvlakEb
 Bxpv2flEBkU6uk1x1+grRLYvauwc2JS6Z8jvsdgU2dwyUC1dZLpC3nL3Jas/uamvl0wN
 HxZqYrHLfZKuPycz8K6LVenVPCbGj56PxijolRZ6wS9pLVyAv8OSZzPMq9P4BjecQSgy
 2xMmZaqm5bnZCx6dpKuz+RlmEpDo0MC2o0No4BMJX5GCNrR8Wj2MXJ+ZIoj4k+gUxnTp
 /Ae1ozoTDZa9j4TyJciKJnh92FnhkfvCUCsdMy8dB4oRWjtKPlqi9F9hM+oyruj4ru4o
 uO5Q==
X-Gm-Message-State: AOAM532q1Nsehlwaesvncj87cXFK5IvwFGKAMXx7ZToIHfCDZ2EXqmKI
 aqlMb84hRq2Ny8iGFwGMGizjVHB2FPxAzG8GzCv3NcUl2WKfh3J5sTEFERs6DEMAt6WUOs3aXT8
 uH5H5Brl3OxVdJjs=
X-Received: by 2002:adf:eccb:: with SMTP id s11mr29460980wro.135.1602497782329; 
 Mon, 12 Oct 2020 03:16:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfODP6HbX52S1QjA/Nocfdo42njlw3NNy2gPyW/ujqhlkmD2/lD1IvlzX6hup9FkMsMcsxuA==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr29460949wro.135.1602497782103; 
 Mon, 12 Oct 2020 03:16:22 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a3sm15101718wrh.94.2020.10.12.03.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 03:16:21 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: push error reporting into bdrv_all_*_snapshot
 functions
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-2-philmd@redhat.com>
 <8f2e2439-4100-a64d-b52e-c03d439cb743@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a77479f-5ce5-d89a-bee1-02bd2a521495@redhat.com>
Date: Mon, 12 Oct 2020 12:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8f2e2439-4100-a64d-b52e-c03d439cb743@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 12:07 PM, Max Reitz wrote:
> On 08.10.20 19:48, Philippe Mathieu-Daudé wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> The bdrv_all_*_snapshot functions return a BlockDriverState pointer
>> for the invalid backend, which the callers then use to report an
>> error message. In some cases multiple callers are reporting the
>> same error message, but with slightly different text. In the future
>> there will be more error scenarios for some of these methods, which
>> will benefit from fine grained error message reporting. So it is
>> helpful to push error reporting down a level.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   include/block/snapshot.h       | 14 +++----
>>   block/monitor/block-hmp-cmds.c |  7 ++--
>>   block/snapshot.c               | 77 +++++++++++++++++-----------------
>>   migration/savevm.c             | 37 +++++-----------
>>   monitor/hmp-cmds.c             |  7 +---
>>   replay/replay-debugging.c      |  4 +-
>>   tests/qemu-iotests/267.out     | 10 ++---
>>   7 files changed, 67 insertions(+), 89 deletions(-)
> 
> Looks good overall to me, but for some reason this patch pulls in the
> @ok and @ret variables from the top scope of all concerned functions
> into the inner scopes of the BDS loops, and drops their initialization.
>   That’s wrong, because we only call the respective snapshotting
> functions on some BDSs, so the return value stays uninitialized for all
> other BDSs:

Indeed, thanks for catching that.

[...]
>>   int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
>>                                BlockDriverState *vm_state_bs,
>>                                uint64_t vm_state_size,
>> -                             BlockDriverState **first_bad_bs)
>> +                             Error **errp)
>>   {
>> -    int err = 0;
>>       BlockDriverState *bs;
>>       BdrvNextIterator it;
>>   
>>       for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>>           AioContext *ctx = bdrv_get_aio_context(bs);
>> +        int ret;
> 
> And one final time.
> 
> Max
> 
>>           aio_context_acquire(ctx);
>>           if (bs == vm_state_bs) {
>>               sn->vm_state_size = vm_state_size;
>> -            err = bdrv_snapshot_create(bs, sn);
>> +            ret = bdrv_snapshot_create(bs, sn);
>>           } else if (bdrv_all_snapshots_includes_bs(bs)) {
>>               sn->vm_state_size = 0;
>> -            err = bdrv_snapshot_create(bs, sn);
>> +            ret = bdrv_snapshot_create(bs, sn);

This one is not needed.

>>           }
>>           aio_context_release(ctx);
>> -        if (err < 0) {
>> +        if (ret < 0) {
>> +            error_setg(errp, "Could not create snapshot '%s' on '%s'",
>> +                       sn->name, bdrv_get_device_or_node_name(bs));
>>               bdrv_next_cleanup(&it);
>> -            goto fail;
>> +            return -1;
>>           }
>>       }
> 


