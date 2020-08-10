Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3702206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDEnyeQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3702206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k53mG-0001v8-Gu
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k53lg-0001VT-TJ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k53ld-0006RC-Re
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597050411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eD2BOAqbMc4LT5jfmiEnSaucfrIo4bhHVOQ/HkMoBzU=;
 b=KDEnyeQ998i7dP+zTnfTEWqfoElPQAO49D6EvVZuVV1CLKtuQ9GVMqwLo3DwObktZXSpSC
 qtseanALsuHlQ4fvgCXSkjNCgSFxcLOA3l81laqqxwuIHnX0i/s/MFW33Un34VwBCstj+T
 cta+GsIzpQUJ+FKUtWuZb8KlrlsgehI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-TWoWkHHnMTeb9agdrwIZ7w-1; Mon, 10 Aug 2020 05:06:48 -0400
X-MC-Unique: TWoWkHHnMTeb9agdrwIZ7w-1
Received: by mail-wm1-f70.google.com with SMTP id d22so2650062wmd.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eD2BOAqbMc4LT5jfmiEnSaucfrIo4bhHVOQ/HkMoBzU=;
 b=ENpsfriENJBGrXXvfnKfHQS9PK5xkylPFVJkQoYCX+AGE7SC9na7mnrrP0/C97FIhI
 eKL9or/yUxbbl0LgLgmMdSDnABpac6c01RvJR4NK85iEcAA7Fwuomdx6Wy+CoHrF4Y3t
 rNmWgABolmv60zpeNPgEcvbzQHdFP6r7z8c3aaBOOlhoJ09jlhvVvJlN6KS4ouxLHlZ3
 uxyHO21iXS98As+TLc5ae1hkvstEzqYe32jUGUDzwZAZzKXlzIz/Dq5/lZ5gVjVW2UVZ
 xgNrb5mCk2ykhjgI2z3m43j3RM05K2c4UEvJ4/X0hOPwCGMXIDQbUeUq2wmWYVwfSUx7
 sDMA==
X-Gm-Message-State: AOAM53206bs8cvnSnoRLLjc2BnCiAPSGxfjwDRU8Lh6j8xcDKJgo5Az6
 uKqsOBRGGcz2lVIkpdXLj47Mitn5ORuBya35z/VhTVXjvWLoCDMBFA3IHWJPTNZmHM78SPM3Psz
 qUQ82GXs0CePiiBc=
X-Received: by 2002:adf:f488:: with SMTP id l8mr456812wro.123.1597050406919;
 Mon, 10 Aug 2020 02:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyTdvceIdQP0npEoZ86D1ubrgHyha/5+Y9zaRdjikxVmc0SiUa0IiQN+LNyyfyVP3P6YfWiw==
X-Received: by 2002:adf:f488:: with SMTP id l8mr456796wro.123.1597050406707;
 Mon, 10 Aug 2020 02:06:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y24sm1228087wmi.17.2020.08.10.02.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 02:06:45 -0700 (PDT)
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
Message-ID: <13b3586c-4d0e-76bc-4716-b6ee88e9686a@redhat.com>
Date: Mon, 10 Aug 2020 11:06:44 +0200
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 12:37 AM, Paolo Bonzini wrote:
> The kernel and initrd hashes seem to have changed for the Bionic
> aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
> to fail.  Correct them based on the latest.

Thanks for reporting the failure.

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

The 'bug' is this link is using "current" which will be a problem each
time Ubuntu update the installer (latest update was last Wed, Aug 5).

Acceptance tests should be stick to a particular set of binary, knew to
have worked once in the past. If a new set works, I'd rather see a new
test added (because it might have a different QEMU coverage).

I'll send a fix of the binary path for these tests.

Regard,

Phil.

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


