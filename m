Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6717C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FFA2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX9N3rsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FFA2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPcC-0004mL-Nn
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnPbM-0004Al-07
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:47:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnPbJ-000077-4r
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592844435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=juAVvUIzyXni73krAXQGWCdU82IZVVNicili/GTJSxE=;
 b=WX9N3rsiruugRZOMBkf/by/zZcPVemhZPkJDhx57poxcmQMYvZZGAEev/+pdiqGoi3xrHG
 Td+UmGxaPOQtZ5eOScFT5DGek5C8DnVOfRVk2PjAbt15mi3N3F5gYlpnrmmwrpTarKLnjn
 c1sTq29866rhKWXiRqXCCqG138gRCcE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-YqqU7WQfMtqKttHZtqBeaQ-1; Mon, 22 Jun 2020 12:47:07 -0400
X-MC-Unique: YqqU7WQfMtqKttHZtqBeaQ-1
Received: by mail-wr1-f70.google.com with SMTP id j5so8764270wro.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=juAVvUIzyXni73krAXQGWCdU82IZVVNicili/GTJSxE=;
 b=rbKoTYcVrw63upE20rNlgX8aKsXUo5ImyUgW7C94VOa2ouxFotK38zlFu5vyoCZn9Z
 Ekec7od8zLLdxV/Sfdh04HbSFWtrt3/pan2JwjkqjfEANQjA2VcSH6qEbTyaUmVryxa1
 3o6l4rt458g9JWNQeDBpsEkRWmH/3OZbwM2drd1r4pnmGuutkB80NF8/4RombSGfRVF2
 jCkQzRBPC0OG6AUJxgMD27nanpRXiOagwBMevQjrUYfSuHovWfLPwiqtyOOf8FAaZ4hv
 lxFK42LmP0FImrtrOb9jhqGGiyWtdgxhf4kBavAzA/xsmYh4nz+86K9Kj9CPZJaQlDWU
 NiCA==
X-Gm-Message-State: AOAM533GOym317K+mirR/xIniWsRZDq/wVeSTKu8LN1zG5osQgq3T5+F
 D3D27pxmazHyKZBRVf1FwYKFv6KEvlMkddVBH3p1kqnjG4qzaNiqU/sIUTMrPHH9uxrm8T+ROY3
 NkCag+kllSioOIGE=
X-Received: by 2002:a05:600c:2313:: with SMTP id
 19mr20357340wmo.51.1592844425742; 
 Mon, 22 Jun 2020 09:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTNaM7zL/AWhhDPZaRjFT0E91MXpy2Zr4UWZTQmJZDWxR9n/FiiFLjhwF+CELfNaoSDaIGow==
X-Received: by 2002:a05:600c:2313:: with SMTP id
 19mr20357324wmo.51.1592844425477; 
 Mon, 22 Jun 2020 09:47:05 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 125sm155500wmc.23.2020.06.22.09.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 09:47:04 -0700 (PDT)
Subject: Re: [PATCH v9 00/10] accel: Allow targets to use Kconfig
To: qemu-devel@nongnu.org
References: <20200618123342.10693-1-philmd@redhat.com>
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
Message-ID: <5332815d-49d7-21da-e752-c39c5b35adc4@redhat.com>
Date: Mon, 22 Jun 2020 18:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, haxm-team <haxm-team@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 2:33 PM, Philippe Mathieu-Daudé wrote:
> Missing review:
> - 03/10 MAINTAINERS: Cover the HAX accelerator stub

I forgot again to include the HAXM team...

> - 04/10 configure: Generate rule to calculate base arch of target
> 
> This series include generic patches I took of the KVM/ARM
> specific series which will follow.
> 
> - Update accelerators in MAINTAINERS
> - Add accel/Kconfig
> - Allow targets to use their how Kconfig
> 
> Since v8:
> - Fixed typo in patch 10 (Stefan)
> 
> Since v7:
> - Generate base-arch() (Alex)
> - Do not deprecate HAXM
> 
> Since v6:
> - Fixed typo 'startwith' -> 'startswith' (armbru)
> 
> Since v5:
> - Fixed typo in patch #4 subject
> - Added David R-b tag
> - Stripped --- comments
> 
> Since v4:
> - Addressed rth review comments in rules.mak
> 
> Since v3:
> - Fixed base-arch() rule (rth)
> - Dropped 'semihosting: Make the feature depend of TCG'
> 
> Since v2:
> - Addressed Thomas review comments
> - Fixed problem when including TARGET instead of BASE_TARGET
> 
> Since v1:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
> - Drop HVF MAINTAINERS patch (merged elsewhere)
> - Kconfig-select SEMIHOSTING (bonzini)
> - Drop user-mode selection patches
> - consider m68k/nios2/xtensa/riscv (pm215)
> - reword Kconfig SEMIHOSTING description (pm215)
> - reset some of rth R-b tags
> 
> Previous RFC for semihosting posted earlier:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html
> 
> Alex Bennée (1):
>   configure: Generate rule to calculate the base architecture of a
>     target
> 
> Philippe Mathieu-Daudé (9):
>   MAINTAINERS: Fix KVM path expansion glob
>   MAINTAINERS: Add an 'overall' entry for accelerators
>   MAINTAINERS: Cover the HAX accelerator stub
>   Makefile: Remove dangerous EOL trailing backslash
>   Makefile: Write MINIKCONF variables as one entry per line
>   accel/Kconfig: Extract accel selectors into their own config
>   accel/Kconfig: Add the TCG selector
>   Makefile: Allow target-specific optional Kconfig
>   accel/tcg: Add stub for probe_access()
> 
>  configure              | 19 +++++++++++++++++++
>  Makefile               | 15 +++++++++++----
>  accel/stubs/tcg-stub.c |  7 +++++++
>  Kconfig.host           |  7 -------
>  MAINTAINERS            | 14 +++++++++++++-
>  accel/Kconfig          |  9 +++++++++
>  6 files changed, 59 insertions(+), 12 deletions(-)
>  create mode 100644 accel/Kconfig
> 


