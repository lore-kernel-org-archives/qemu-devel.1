Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A7CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17EF20678
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy5x2BeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17EF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRIm-0000mG-DI
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXRI6-0000Cd-2b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXRI3-0005ID-9h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603814017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moFCITaKKL5ruFzOiJoou+0zMEh3FTr2+PXXsLvylxw=;
 b=Gy5x2BeNYauuH9f5TiA09Os+x9pTpACPHusdxpzYjw+7O1g/ZgdBeElv/TolvJRvBbJOB+
 TKLZj5VcEBoFKc9yrWyn82HuHP8SLL7OVhvB2ml3z2eiIiDeXcpkrVZfcGzgM4a7fuami8
 p8d1ZeKF/YXFE+rF9e2QP5WdlRB0U3I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Fq8WPWwNOWKuP_H7-kpIwQ-1; Tue, 27 Oct 2020 11:53:35 -0400
X-MC-Unique: Fq8WPWwNOWKuP_H7-kpIwQ-1
Received: by mail-ed1-f70.google.com with SMTP id y8so880903edj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 08:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=moFCITaKKL5ruFzOiJoou+0zMEh3FTr2+PXXsLvylxw=;
 b=Yr0wqlH1kN6WBsxfAT0R8kWtsw4N8ezZoi9Pta1rckQJdTQtoKsFMpwWpARCNEBOPx
 cCIRixskFhLKqX9OmXD5sfuNsAdDicoUVQIhgSNWqteaXwsvu6bKWOwWoL+hELTAHj2t
 Y0rmoHFy76lHk/PTSZK+Hcg3XAZJU0X8EFZi1nYk7r5wP4YrLsQnWX2W38gCEZmh96vS
 DiT2DrtMfIzSqicbkq0+4rsEfZ/26wMN8+FYkAKxtXaG1EL3KIQWoCJLdrFCZRav1Rhx
 KidxXEKM/CC2yvtz6BTWe459ZCazSUmlbJJoSrZ9dDwOGvsahRoa5V8VTIX6bm+zNcZo
 0h/Q==
X-Gm-Message-State: AOAM531R+AAUyeMQqBpL+NEZuGWsLwQgBGWFY/KfHSheFNqNLkHpG2aU
 kUS3GR2obsKvV5kt0PL8sBDl/DfGxluPeTL/YZHcbpGae6CFzd6S/Ev68Z6zMxcPCRdDVXzzz5v
 PjSCJ9PI/WL9cs4U=
X-Received: by 2002:a17:906:1189:: with SMTP id
 n9mr3214760eja.190.1603814013948; 
 Tue, 27 Oct 2020 08:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBNX5x04uPQz6eS0Cj6TuZRKwAvhTySuErpUQPodtoArRjq6hXNgfQNgGhVpUcXOfBpLKh4g==
X-Received: by 2002:a17:906:1189:: with SMTP id
 n9mr3214738eja.190.1603814013726; 
 Tue, 27 Oct 2020 08:53:33 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p1sm1298543ejd.33.2020.10.27.08.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 08:53:32 -0700 (PDT)
Subject: Re: [PATCH 08/25] block/nvme: Simplify device reset
To: Keith Busch <kbusch@kernel.org>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-9-philmd@redhat.com>
 <20201027145831.GC1942271@dhcp-10-100-145-180.wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bb84312-1c78-7e1a-058b-4ff6330076b1@redhat.com>
Date: Tue, 27 Oct 2020 16:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027145831.GC1942271@dhcp-10-100-145-180.wdc.com>
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

On 10/27/20 3:58 PM, Keith Busch wrote:
> On Tue, Oct 27, 2020 at 02:55:30PM +0100, Philippe Mathieu-Daudé wrote:
>> Avoid multiple endianess conversion by using device endianess.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index e95d59d3126..be14350f959 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -755,7 +755,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>      timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>>  
>>      /* Reset device to get a clean state. */
>> -    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
>> +    regs->cc &= const_le32(0xFE);
> 
> This doesn't look right. The 'regs' is an MMIO address, correct? Memory
> mappings use the CPU native access.

cc is little-endian uint32_t.

on big-endian: const_le32(0xFE) = 0xfe000000;
so: regs->cc &= 0xfe000000.

Anyway this is an example of unproductive patch, as it makes
things more confuse to you. Let's ignore it.


