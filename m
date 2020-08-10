Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BDAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEDA206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0toDmJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEDA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54Wz-0002B7-TU
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54WE-0001Qv-W0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:55:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54WD-0003lj-2G
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597053300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KExH1lqPKQbttTV4MMBnRwY0aNPPxuFDVD8iHyoRcz4=;
 b=D0toDmJn/i83VQGwIEjeoaLPbz1ElqAcaIPpusQz1mlsPNFHgZOVA5L0w3YadJqUxEMFNq
 /hv8dPj4mv4AcarjqFpOATp0POZ+0wAFo6pAJV+gN5cjGJgWdcnYtBJ2Mr+gCh0d3wh2aO
 TJJ1KHmAjqZOE2hpGTEgwtn4EB3UBck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-NRO2IP0APEGZaMSYWss1FA-1; Mon, 10 Aug 2020 05:54:56 -0400
X-MC-Unique: NRO2IP0APEGZaMSYWss1FA-1
Received: by mail-wr1-f69.google.com with SMTP id j2so4013683wrr.14
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KExH1lqPKQbttTV4MMBnRwY0aNPPxuFDVD8iHyoRcz4=;
 b=pDHzl0GHOzQbhc9MfkSi4R6gOBQ0W/wEVYWOzLGGh7USktJuqgdh+qozDQNEDbIVD2
 HEIYCZjtUa6eavWw97MphokRNdVTpHQcUd5kYbF3gN2y7Wpcb1YwxlgBSl1/QS5aLfmU
 b/b8rXQ+4B4fw4aJmQnFOXSmVSxiSRoq2NXzF7YLsACd7O7DekXXbtZLMhuoLTnPuSuO
 x/GUbxo2C0eABzQmKmExAlbDQvo3EP9h3jwhk8o3/9Gs0z2IdfBygDtFgMal/k6D7Oz3
 xOFCgJY7dvL9CCh5tVOB2aNftF2Of8hJGHixCCr4TVUv8UBItPjYgqv5OFpg+mF49Uir
 aNqg==
X-Gm-Message-State: AOAM531det2mQi5ESiTCR3AH5nZJDW4S/9+SRwWDo06goC0U7t6cFuO/
 575WfsFDftt5+Rpmo6Kgm5UI7Fl/7Kqq3erNU/az6eqVgo+Exy/PRvvFRy60UlODwJZLaX3SFna
 lL1xRFsYfUnmMcV0=
X-Received: by 2002:adf:e504:: with SMTP id j4mr24522333wrm.205.1597053294959; 
 Mon, 10 Aug 2020 02:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw24vfFwnbbHQGygbTAJJWuPgZYgPw20MvfmwzYIq7+8zxZ28EBU5RyKE+g31KVJ5ECiIY2ig==
X-Received: by 2002:adf:e504:: with SMTP id j4mr24522294wrm.205.1597053294290; 
 Mon, 10 Aug 2020 02:54:54 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z8sm20209187wmf.42.2020.08.10.02.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 02:54:53 -0700 (PDT)
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
Message-ID: <df9a675a-0aab-48af-2310-79470047d25e@redhat.com>
Date: Mon, 10 Aug 2020 11:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200810092941.154911-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:06:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This one fixes a problem,

>                        'netboot/ubuntu-installer/arm64/linux')
>          kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
>          initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
> -                      'bionic-updates/main/installer-arm64/current/images/'
> +                      'bionic-updates/main/installer-arm64/20101020ubuntu543.15/images/'

this one too,

>                        'netboot/ubuntu-installer/arm64/initrd.gz')
>          initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
>          initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> @@ -822,7 +822,7 @@ class BootLinuxConsole(LinuxKernelTest):
>          :avocado: tags=machine:clipper
>          """
>          kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
> -                      'installer-alpha/current/images/cdrom/vmlinuz')
> +                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')

this one fixes a pending problem (as described in commit).

>          kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


