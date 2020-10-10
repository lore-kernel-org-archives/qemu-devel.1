Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE82207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqh8AXab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE82207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAul-0005bm-UI
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRAtw-00058l-TX
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRAtt-0006mO-K8
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602321048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUD056AcC16uOe9mM3yzx/7f7/aADVx1iSW1NzoyA1M=;
 b=aqh8AXab7Wap1PgOb/Gj59MGr9BMYVVWAeZZ9JLccLwIkdtCMOBCtsgP9YSm0cRr0+fXsO
 DtsPO2D0DeM7/IL2jAOIetLHFC8dLxDYDGk0FTGzAmJ12fZDxamwD+WhylcgZRbLigKe0/
 mBiLm08rtkO0h8xD9pBwIj0K5aNC4Zk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-pvUNbh97MR-M5bQB3Mg65Q-1; Sat, 10 Oct 2020 05:10:45 -0400
X-MC-Unique: pvUNbh97MR-M5bQB3Mg65Q-1
Received: by mail-wr1-f71.google.com with SMTP id t17so6311865wrm.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 02:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jUD056AcC16uOe9mM3yzx/7f7/aADVx1iSW1NzoyA1M=;
 b=Le0OUeejVmrhBYAQTWxBF3mmzH04PjpDL0UbRFD7on54VN/5iAABkGrucRiavQRD0N
 qj2hVN8lxbIsbeLIpK13Hs6EfAJQHEBgMcOTF/0eZ8BRRqD4/zQ7n9xwtnnlUZG4pFjh
 Tsfx1bZMQKe/lEhMs3zw7Uoj9gAMOdKAd0KVTPByoKYzwnGz+B+tu0sPma0KyNxuh8Qc
 PAHgBOchToIHPawaoF0MT5vkZxAiUvcgNHOrFoVeYK2+caZA/Zujy8JtqNF08PPPLf17
 gqtvaJO3Fo2QlPdP8Wa2e5dM/CBpp49lX0fTMMS1ngkeDSmL7Nvl3pfEYvhIC8m8tkFx
 V6jA==
X-Gm-Message-State: AOAM533M91HHejQAdq2HpgbXrvPvEHBrH3itkfQDS/i86whRZidDNv3o
 +ie9+2NHTzsiafQ+xg36M+FyOH+7tn6w0Ef0DSnPrS6qp9n0aW1WsBMfFheePLs6Ve0Nv9XsApy
 4/E4PTJbNhy2MnPc=
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr19723735wrw.252.1602321044041; 
 Sat, 10 Oct 2020 02:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz98ZZHhoxfsOq5ceWLprBy3INMWh6XSIxIHGWJmQ6kBNi2q5XqsRggs49HDx+QF2lq9Yk75A==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr19723713wrw.252.1602321043805; 
 Sat, 10 Oct 2020 02:10:43 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm14468349wmh.27.2020.10.10.02.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 02:10:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] Acceptance tests: do not show canceled test logs on
 GitLab CI
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0de238c-cb86-cf86-10e5-4a8ef44c3136@redhat.com>
Date: Sat, 10 Oct 2020 11:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009205513.751968-3-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 10:55 PM, Cleber Rosa wrote:
> Tests resulting in "CANCEL" in Avocado are usually canceled on
> purpose, and are almost identical to "SKIP".  The logs for canceled
> tests are adding a lot of noise to the logs being shown on GitLab CI,
> and causing distraction from real failures.

Thanks, big improvement!!!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> As a side note, this "after script" is scheduled for removal once the
> feature is implemented within Avocado itself.
> 
> Reference: https://github.com/avocado-framework/avocado/issues/4266
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a51c89554f..bed5fe6161 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -63,7 +63,7 @@ include:
>         fi
>     after_script:
>       - cd build
> -    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> +    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP", "CANCEL")]' | xargs cat
>       - du -chs ${CI_PROJECT_DIR}/avocado-cache
>   
>   build-system-ubuntu:
> 


