Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7A9206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOlUq1WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54Ip-0005g0-PM
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54I5-0005ES-QY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54I3-00020X-Vr
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597052423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UwjiERdn/Uk5mRH+NSSswpKYeBpY2tjPzvDVZ7styeA=;
 b=TOlUq1WK0sJXoJGtye/wz74tuVkbRS7xT6g73h+C9LZra65O7SqdWQidqmqYxICh3sBQNM
 LZDLbsbLFAhwFA57exzQYfLJdlmmJcJ8M4nsj5rvvetJNtoxIBQfUArKU5scGE7KeKP0IX
 Yq+aZLg56NiqQgxmS4b0YFtCXg9VdNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-oj_fRovBPgeBkGvAppyoOQ-1; Mon, 10 Aug 2020 05:40:19 -0400
X-MC-Unique: oj_fRovBPgeBkGvAppyoOQ-1
Received: by mail-wm1-f72.google.com with SMTP id q15so2665844wmj.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UwjiERdn/Uk5mRH+NSSswpKYeBpY2tjPzvDVZ7styeA=;
 b=VY+aPizkyaaa2LI+L99C5AKORNndravCJ0a4X+FU+w63NUxSk4vqCRKks2VZH5PIkU
 6PV0uenW3yAd4h4vvbn1suP//sIt7vQx/SkiQG/G9yiV+vgl4xlPxTKwrY0alnbcQ9Dc
 JaX46mKomMRm3X2Oh89NjiwYEvZLnhT680npG9R0fwISbFpU8+FlLmNF03ndYC6j1YU1
 OnWfjOq/kEq24VbhYg1inGXFEzfpwbj7m3mU8l41XT+wcnVwQjnXnajviLNGsZQsKB7k
 lxea46CNuAFdHIh4CMZEwaj1OO27h1+D5NEQ1OFZRDXyNpGlDxba8z7nWyY0XVZtkhEY
 Gbeg==
X-Gm-Message-State: AOAM533zmWKvomNIXRnLdUHBWcur37RCbY1lpvoKvEgpJsKZveiHKVXs
 3n/VTnhz1FqWh/+t+WRptQWHlZAkGqG3bbQB4/UAm1ZKtQVlMIr4SzdkxVVIf+vHkc3NwRnyH1g
 PuA7z+PainFCJYSk=
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr22426681wrc.134.1597052418278; 
 Mon, 10 Aug 2020 02:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTx/To2NP8ahtuuu6JIPxpsu+O1qNbsuSl6UGoYg13PHkdc17BEz236bagbQY1A+hKsljClw==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr22426658wrc.134.1597052418040; 
 Mon, 10 Aug 2020 02:40:18 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm21411647wmb.12.2020.08.10.02.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 02:40:17 -0700 (PDT)
Subject: Re: [PATCH] acceptance: update asset hashes for the Bionic aarch64
 installer
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200809223741.56570-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <2eef5241-c3fb-79bb-59a8-271a6fadd5e7@redhat.com>
Date: Mon, 10 Aug 2020 11:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200809223741.56570-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:40:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 12:37 AM, Paolo Bonzini wrote:
> The kernel and initrd hashes seem to have changed for the Bionic
> aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
> to fail.  Correct them based on the latest.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 73cc69c499..1fcd154a7c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -338,13 +338,13 @@ class BootLinuxConsole(LinuxKernelTest):
>          kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
>                        'bionic-updates/main/installer-arm64/current/images/'
>                        'netboot/ubuntu-installer/arm64/linux')
> -        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
> +        kernel_hash = 'd6d17cc43d14f503493bd38e8277870f2b79132e'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
>          initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
>                        'bionic-updates/main/installer-arm64/current/images/'
>                        'netboot/ubuntu-installer/arm64/initrd.gz')
> -        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
> +        initrd_hash = '7363cd9211b572add76a68df086be24545813b5f'
>          initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>  
>          self.vm.set_console()
> 

I haven't noticed that because I have these files in the Avocado cache.

The only way to detect such problems is blowing the cache... I certainly
don't want to do that daily. OTOH a developer starting to use the CI or
Avocado locally will hit the problem.

I was thinking about running a job with empty cache for each tags.
Maybe it is safer to do that on a weekly basis a least?

Regards,

Phil.


