Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87956C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E196022281
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiU/z5Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E196022281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQzt-0001qw-Mu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXQyG-0000G7-2h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXQyD-000202-TI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603812788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DW2ajBHQOXz486WaaIBfB0Ct4yWGSZDqouiMTaeW2kM=;
 b=QiU/z5Fg0VUGRaBk72gK2buob6T6DB6uKaSgF+8EHe2piZ8D1J/1Gs2hg7K5AiBIITxbrz
 P3j6Jzwo8HKGt1+PSTpSV9XIusOlr99QJ1JpNhU6clVRmjpf4scWpvTH21GcH2olBzJteh
 uJ4zXFgtioZ3VYTgbllsVENdnb56+bE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17--OrtR_3tNs-GgSUyOPHErw-1; Tue, 27 Oct 2020 11:33:05 -0400
X-MC-Unique: -OrtR_3tNs-GgSUyOPHErw-1
Received: by mail-ed1-f70.google.com with SMTP id w24so856835edl.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 08:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DW2ajBHQOXz486WaaIBfB0Ct4yWGSZDqouiMTaeW2kM=;
 b=JJtMq4MGXwd18ecO6KMKOKiqjnXs634tNEppjBMfp93xhOcmihsL6Xcc/AqI+KlKSd
 5OhtrtOBlXh8a3rmawcOOzVgBLInPXzDfT6+Ojq6Hre0IKnMKQvKs232cBclWWxrkAye
 SANpBeTNyaW+Ve4ZgFRwtw+4BF3UgkWoW1uLH612P1VrZOjd8SwKY3a2V8nBhHh4A7+1
 LlEjv+SbeU4Dx5/g9Z94+TyNhpMpAFhmB4PUd1VNXp6krCsRde/7x/I7hDIjRoB7l7+z
 Uu+KreZLyR3dfVvj5hXFQH0B3+fOHLX5x923r9tn6wTPqUWeMNexou+MKqeR8lgCF4oo
 AbIg==
X-Gm-Message-State: AOAM530VWLWwYBp9gin6cdn4bwZnz8VZ/Tp3qPqseJsfApDm1pd6jOKp
 2gCiioYSv3zy2Krk1jkgxJ5+Phkmq1qZB0bDEYNSYe2UKpEE2RAUFgSz4PdUjfw2OozSPKXO5Ca
 I/G9wq3fMNiJMyvw=
X-Received: by 2002:a05:6402:2050:: with SMTP id
 bc16mr2934234edb.246.1603812784408; 
 Tue, 27 Oct 2020 08:33:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIuyMp7UfQ+SUpcAc00yT4A4lw9haoomTh+8Kmf627+96HkMhqMl/arlcyn9RbVHzAdd4PYQ==
X-Received: by 2002:a05:6402:2050:: with SMTP id
 bc16mr2934201edb.246.1603812784069; 
 Tue, 27 Oct 2020 08:33:04 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u6sm1197198edy.16.2020.10.27.08.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 08:33:03 -0700 (PDT)
Subject: Re: [PATCH 03/25] block/nvme: Report warning with warn_report()
To: Keith Busch <kbusch@kernel.org>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-4-philmd@redhat.com>
 <20201027144523.GA1942271@dhcp-10-100-145-180.wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa645922-e424-a45c-adcc-46eddc99fa92@redhat.com>
Date: Tue, 27 Oct 2020 16:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027144523.GA1942271@dhcp-10-100-145-180.wdc.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 3:45 PM, Keith Busch wrote:
> On Tue, Oct 27, 2020 at 02:55:25PM +0100, Philippe Mathieu-Daudé wrote:
>> Instead of displaying warning on stderr, use warn_report()
>> which also displays it on the monitor.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 739a0a700cb..6f1d7f9b2a1 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -399,8 +399,8 @@ static bool nvme_process_completion(NVMeQueuePair *q)
>>          }
>>          cid = le16_to_cpu(c->cid);
> 
> Not related to your patch, but it stands out as odd that this is treated
> as an endian type. The field is just an opaque cookie, so there shouldn't
> be a need for byte swapping. It in fact looks like this is broken on a
> big-endian host, as the swaping on submission uses a 32-bit value. Won't
> that truncate the relavant bits?

You are right, thanks for having a look and catching this bug :)

I suppose we never tested on big-endian host yet.

> 
>>          if (cid == 0 || cid > NVME_QUEUE_SIZE) {
>> -            fprintf(stderr, "Unexpected CID in completion queue: %" PRIu32 "\n",
>> -                    cid);
>> +            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
>> +                        "queue size: %u", cid, NVME_QUEUE_SIZE);
>>              continue;
>>          }
>>          trace_nvme_complete_command(s, q->index, cid);
> 


