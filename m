Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82FC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91E421534
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jdl0Vw8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91E421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVsCD-00064w-Ta
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs9P-0004Ge-K0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs9M-0007ZM-An
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603440611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJnyBOJ6zoWjwUG7XHlGx83imSSMH82CN/Cjp3bGd14=;
 b=Jdl0Vw8bQu7gKUCAywY0HmwYWO+Eqjjz4YJ+0m9GGpc6DytoF2AvB7zPGs8yOP4wESKJFZ
 xWQM5K9nxRIEVb1r4/o7Hcyg+28RksSLmY7jOTwwNiejGI59C9CIyV5LopljffmWr2qvh4
 +I4o0FcDSp+zA23i7moqSODcxcOPVsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-bCANlo0-OfCbVeSO-TRDMQ-1; Fri, 23 Oct 2020 04:10:09 -0400
X-MC-Unique: bCANlo0-OfCbVeSO-TRDMQ-1
Received: by mail-wm1-f71.google.com with SMTP id o15so155460wmh.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DJnyBOJ6zoWjwUG7XHlGx83imSSMH82CN/Cjp3bGd14=;
 b=kQ92PFxe/bFxrweIL/F2/WLOCn2XarW5dADgOp9341dR9CJuktHUJzdVqKaPnDWS8n
 w6WVI2BT726ZHrQaDNZk67hI/7bb0BJmHdey6qAInWFYkX+oNOHd1ZF4XV0yZFiLIkEH
 Tx9eq05ZqW85IB/sDKJRirs0HgEtV/HbodR5Ghdfd7T4IRfyDpPInpbaQbfaSeW7XhXH
 DtDPsMnloK6QYvrAb0EIx2iJSV4rCMybEXkehuQpnv3bmhi3JeK//1geV+y4mNX8xXi0
 XHxFafrlAk4dgEsfwmZ2r91IJo1/4RKuorTA+/MX0C5NGrEFZAY58/0QK48yKxBWAdxA
 bX+g==
X-Gm-Message-State: AOAM531F0bTA5icqRto9h3LzDwmUIAewbHrW9H+sLKh8FlfTv2sSNazV
 kSikN96TWQGSXWESLeo5byC235bgjImOLQdQz6IQ3Ub24WuJMfqiDljXJqWXylxHrOG1PJPhgIo
 Jq/4g6CXDWfIgdHw=
X-Received: by 2002:a5d:4088:: with SMTP id o8mr1324057wrp.2.1603440608655;
 Fri, 23 Oct 2020 01:10:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZGkfaZ7bDm3/vmhwPtKJdy+pwJ5ZJzPRKzbssoltw1mCryTnOqwaXSu+8BgaU/EMbCPIwjg==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr1324038wrp.2.1603440608474;
 Fri, 23 Oct 2020 01:10:08 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x18sm1914227wrg.4.2020.10.23.01.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:10:07 -0700 (PDT)
Subject: Re: [PATCH] cpus: verify that number of created cpus do not exceed
 smp params
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <160343848141.8350.10469322440262034340.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a4ef7ec-47e8-909b-d724-f3db2ca69379@redhat.com>
Date: Fri, 23 Oct 2020 10:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160343848141.8350.10469322440262034340.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 9:34 AM, Pavel Dovgalyuk wrote:
> Machine definitions may miss some vCPU-related parameters.
> E.g., xlnx-versal-virt missed min_cpus and it was set to 1 by default.
> This allowed using -smp 1 command line argument. But the machine
> still created 2 vCPUs and passed all checks.
> This patch adds one more check that does not allow creating
> extra cpus that exceed the values specified in machine/smp.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>   0 files changed
> 
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 47cceddd80..da74794e09 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -603,6 +603,11 @@ void qemu_init_vcpu(CPUState *cpu)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
>   
> +    if (cpu->cpu_index >= ms->smp.cpus) {
> +        fprintf(stderr, "Machine definition error: trying to create too many CPUs\n");
> +        exit(1);

Shouldn't this be an assert()?

> +    }
> +
>       cpu->nr_cores = ms->smp.cores;
>       cpu->nr_threads =  ms->smp.threads;
>       cpu->stopped = true;
> 
> 


