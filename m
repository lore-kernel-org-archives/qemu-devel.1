Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8552FC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5CE22253
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCksQHxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5CE22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs4q-0006q1-H0
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs3p-0006Q5-3T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs3m-0005kH-UY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603440265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0gPf/H102mlrXQ5WMwe1IFY4EX5QLpSZgrgyTsfu3Y=;
 b=eCksQHxTfZj4WDb0nOk7Hxdhx409SshGgXhzZ7QDgDJ0829qa2Mx36Bde+hqg6/HZT4R0V
 B+W+MhyaNUFcyFnqhYmJOvpS5v+TwgcnIlFpApafQdHWqHxNnJrrWGxRfwJYqDbDAgfyyO
 WHzM9d100IPtfl3ELIomWKYbsJpoDFE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-1xV3VsR6PcCc71xYs-Ne5w-1; Fri, 23 Oct 2020 04:04:24 -0400
X-MC-Unique: 1xV3VsR6PcCc71xYs-Ne5w-1
Received: by mail-wr1-f71.google.com with SMTP id f11so293207wro.15
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V0gPf/H102mlrXQ5WMwe1IFY4EX5QLpSZgrgyTsfu3Y=;
 b=W0uwUikyDsjCIjRT3RxKXiUhxY6QAtRFv7Nd2Dy/GO3tnuMdT7s4Cr3ngaBMbas/4y
 Mh3Ig9usehcqbgwtOEG52NO+zK2yQsyqsrnuAiSyU4Jerg9dGWaENsAm0GNECRNuX2Xm
 8Cy8z3s9Ks+Lc+R35OuYDM4Z1ITotdhx8unlik3/4i3exBF0n8eOp0yjojdXudUuJ3BI
 We29BSXsD8uh5s1scBUqgkbazF1O4t98HurmrP+ZQ9fx0tZpesVPHjXx/kpJVcrRZ6F/
 rA9NIjyoaG4ykY2/UxolERF2oNTgkF+yjnL64XpUt8xMW313iDwe37IYOw9uYKQE/4i0
 h3BQ==
X-Gm-Message-State: AOAM533xBWpYfj49hizeHdqnbCfUlNTj4UimlrJm+/2atPGg5/ydPdpJ
 C853isyar+0E2lAi0v8w7aaP7M/86FnPjFISTZCEGeCNoCYDPXE1V6FWsD4OAyuoR7Y7r2o1/te
 CSLwcw5ndbLIniTk=
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr547271wmf.174.1603440262925; 
 Fri, 23 Oct 2020 01:04:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziIJshgrrELmq0wknioEz3TcfV8fDOu2UUW8+A0wkPrj2/izflk4hadlF7aSMDKqPtF614yw==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr547241wmf.174.1603440262690; 
 Fri, 23 Oct 2020 01:04:22 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y5sm1655083wrw.52.2020.10.23.01.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:04:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] accel: Remove _WIN32 ifdef from qtest-cpus.c
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-2-jandryuk@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c555cfb-9260-4218-88b4-dfefdcb8a998@redhat.com>
Date: Fri, 23 Oct 2020 10:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-2-jandryuk@gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:05 PM, Jason Andryuk wrote:
> dummy-cpus.c is only compiled with CONFIG_POSIX, so the _WIN32 condition
> will never evaluate true.  Remove it.

I disagree with this removal, as you are making this a generic
accelerator out of QTest. I'd rather keep this and replace the
error message with "Dummy accelerator is not supported on
Windows" and not make it POSIX-specific. As Paolo already acked
this patch so I am not objecting to it.

> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> v2: New in v2
> ---
>   accel/qtest/qtest-cpus.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
> index 7c5399ed9d..db094201c1 100644
> --- a/accel/qtest/qtest-cpus.c
> +++ b/accel/qtest/qtest-cpus.c
> @@ -29,10 +29,6 @@
>   
>   static void *qtest_cpu_thread_fn(void *arg)
>   {
> -#ifdef _WIN32
> -    error_report("qtest is not supported under Windows");
> -    exit(1);
> -#else
>       CPUState *cpu = arg;
>       sigset_t waitset;
>       int r;
> @@ -69,7 +65,6 @@ static void *qtest_cpu_thread_fn(void *arg)
>       qemu_mutex_unlock_iothread();
>       rcu_unregister_thread();
>       return NULL;
> -#endif
>   }
>   
>   static void qtest_start_vcpu_thread(CPUState *cpu)
> 


