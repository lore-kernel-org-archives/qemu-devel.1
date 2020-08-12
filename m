Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7383C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C10207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVue6H7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C10207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5phl-0005gQ-Tj
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pgh-0004vk-9Y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pgf-0002N8-A9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597234616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fo1P9qCSHHcysDUd2m2+EdbNU1aorSvviYdjPrOGs8M=;
 b=MVue6H7hiKuPgpt9JRtFwxubP4MCLHxFUmQTEKtRxayTgfN/NAGwoRMUOlLRNAFofQ4cW9
 Mo310JVMqbO7btIz2KFfYCj26/E0k9gxqPAHtCrk+nXwM1L3xO9zQw0IYSTdskwOFdE5vu
 scxaNbMmnubeossc6PhLRdEdC8JQiAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-G_Jsr9ohMWasma0ruZeZeg-1; Wed, 12 Aug 2020 08:16:53 -0400
X-MC-Unique: G_Jsr9ohMWasma0ruZeZeg-1
Received: by mail-wm1-f70.google.com with SMTP id a5so825622wmj.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 05:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fo1P9qCSHHcysDUd2m2+EdbNU1aorSvviYdjPrOGs8M=;
 b=UZqAogBTVh0TpX6laKdsoTFAUqrlcUB4GJLhieAt90Tj5UnBw/peRCc4cBDPWgmumc
 Cn0+tG/9DaWWFRK2K1ogTS4963ONUbtGdRObDSrP5Qu/MWucyA978ke+s8T7B/+8D3DV
 G6HBiAdQSU7jBYHPgDRtfMlGyBu1h1tn9/vDCvwt6HB8qbGewfolhh+OQ2EXKQVTPlfc
 T9WS+X+vLDjL6VLRjkPuUn/XbRLcPIkOFK2kcmwO2ubB5TmVYZNppU6AVrPqvE5kRjRF
 wILKsXMuyNGKLxxeuoXO6RzQLktfCGXkSzubRCfJB3GunXaxgophQTH21EBcDqIhky1f
 /wxQ==
X-Gm-Message-State: AOAM533C7Rn+bmxVDKvpWhBSm2xIk+3paxSbakQIECu7Rh6+owuheZFl
 hNmmj+PvqoeDnBdoYLjqsxYGhpjhbu7hAoyWC8JO7uWXMZ7Hf9LLiohLkngG2ldne9bmfcqqK6H
 n0PTxOTh0+XEoC8c=
X-Received: by 2002:a1c:38b:: with SMTP id 133mr7959483wmd.153.1597234611817; 
 Wed, 12 Aug 2020 05:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAmkvRQPkAbUN2TTZsqiIWKOU4f2YsTBSYbILtT1wO9wL7U4xAA27RnId3Tj8nQ4riGh+hfg==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr7959447wmd.153.1597234611372; 
 Wed, 12 Aug 2020 05:16:51 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f6sm4995567wme.32.2020.08.12.05.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 05:16:50 -0700 (PDT)
Subject: Re: [PATCH for-5.1 v2] acceptance: use stable URLs for the Debian and
 Ubuntu installer
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200810092941.154911-1-pbonzini@redhat.com>
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
Message-ID: <e0a682bf-73b1-f11d-8a6a-52c7d5e5cdd8@redhat.com>
Date: Wed, 12 Aug 2020 14:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200810092941.154911-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:49:30
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 11:29 AM, Paolo Bonzini wrote:
> The kernel and initrd hashes seem to have changed for the Bionic
> aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
> to fail.  Correct the paths to use the previous binaries instead of
> the latest.  Do the same for the Lenny alpha installer for
> consistency, even though those are unlikely to change.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 73cc69c499..57ba6328de 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -336,13 +336,13 @@ class BootLinuxConsole(LinuxKernelTest):
>          :avocado: tags=device:arm_gicv3
>          """
>          kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> -                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'bionic-updates/main/installer-arm64/20101020ubuntu543.15/images/'
>                        'netboot/ubuntu-installer/arm64/linux')
>          kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
>          initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> -                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'bionic-updates/main/installer-arm64/20101020ubuntu543.15/images/'
>                        'netboot/ubuntu-installer/arm64/initrd.gz')
>          initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
>          initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> @@ -822,7 +822,7 @@ class BootLinuxConsole(LinuxKernelTest):
>          :avocado: tags=machine:clipper
>          """
>          kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
> -                      'installer-alpha/current/images/cdrom/vmlinuz')
> +                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
>          kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
> 

Thanks, applied to my acceptance-testing tree.


