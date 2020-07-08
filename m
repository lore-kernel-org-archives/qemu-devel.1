Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD5C20739
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4AP+7Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKRQ-0003U2-N3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKQT-0002vf-HI
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:28:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKQR-0008OT-OG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594254511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iJb9fYNjkzSr5Iw2KwRMMG4vhKWK7vZpwj58aUzwXeE=;
 b=K4AP+7Z13cs8DK2gOITx/LgfWOsMLgtixSgf+2K+/Fo2z2tltYY6dJyHjfDCo747+thY+m
 8eRa/tC/bLJ0NTegDafaXwRbA78ZIXtIOQxQ0+PEiZBIm6S742Y3vORGiw0c36HOtqdC/G
 PmX+yn6DzfX8VMJgJ26pWytwnVshABQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-FGSLnO2OP9eSx7muN2dVcQ-1; Wed, 08 Jul 2020 04:25:41 -0400
X-MC-Unique: FGSLnO2OP9eSx7muN2dVcQ-1
Received: by mail-wr1-f71.google.com with SMTP id g14so51213263wrp.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iJb9fYNjkzSr5Iw2KwRMMG4vhKWK7vZpwj58aUzwXeE=;
 b=htDvvbqyuAdMZ7nO6LEK6Fn3D9T99bAu/pGDnieB7y7qE6REkK/r5WbdT7pm2+x5c4
 zIuhYSwlv39GOTrVR0JufpMAxf5Lx5L/Jej6Sltv69doHI2MnqCpcXWWFXLfIIKQwDuM
 VfWIAV2yrNBy0pyVAs/rVPLaCoTuGK3CNJR4PXOiBfEpu3TyKfdhOKg4QlwGZAJj9EYT
 XC9EaR9tgDbZcofIryBqD+ij9l6V7KtrBp5aqtCsoGBajDvkGzp8/lMRI1bOJL/R467I
 Hj10vJmzakDOiwW3D3xvSAIE6kmY/vOvtO2ShPU9in3PT3TUkC3SgH9bPGAUhiIsDlXq
 ScJQ==
X-Gm-Message-State: AOAM531A5W/I4ncHWaZR92Jv5KFb1LeOrSp4YXg3bNWfBwwUU+767ibx
 GzLUp4P8tSQep4GdCnDmxnJFXJ6iZ9phW39mRQKHsJVWg+vMnA5s0TTEUuQ1fPZjw1oYW/IXEKI
 xqHhqydJRyQ0zNi8=
X-Received: by 2002:a7b:c841:: with SMTP id c1mr8654625wml.25.1594196739688;
 Wed, 08 Jul 2020 01:25:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybU0ywWLmOQfgLIPLfsr9yDxP6OtgbXsz3CbQ9xqRopwFP0ewVBKsGfKLP8RGoUNrTkS6W9w==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr8654606wml.25.1594196739454;
 Wed, 08 Jul 2020 01:25:39 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm4482571wrn.76.2020.07.08.01.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 01:25:38 -0700 (PDT)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
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
Message-ID: <90266035-b1f2-b448-0df8-5b38a22588ff@redhat.com>
Date: Wed, 8 Jul 2020 10:25:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 8:37 PM, Peter Maydell wrote:
> On Mon, 6 Jul 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>>
>>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 80270507070ec73ea82741ce24cb7909a9258ea3:
>>
>>   scripts: improve message when TAP based tests fail (2020-07-06 12:14:25 -0400)
>>
>> ----------------------------------------------------------------
>> * Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
>> * Fix PSE guests with emulated NPT (Alexander B. #1)
>> * Fix leak (Alexander B. #2)
>> * HVF fixes (Roman, Cameron)
>> * New Sapphire Rapids CPUID bits (Cathy)
>> * cpus.c and softmmu/ cleanups (Claudio)
>> * TAP driver tweaks (Daniel, Havard)
>> * object-add bugfix and testcases (Eric A.)
>> * Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
>> * SSE fixes (Joseph)
>> * "-msg guest-name" option (Mario)
>> * support for AMD nested live migration (myself)
>> * Small i386 TCG fixes (myself)
>> * improved error reporting for Xen (myself)
>> * fix "-cpu host -overcommit cpu-pm=on" (myself)
>> * Add accel/Kconfig (Philippe)
>> * KVM API cleanup (Philippe)
>> * iscsi sense handling fixes (Yongji)
>> * Misc bugfixes
> 
> Hi; various build or test failures (5 total):

> 2) aarch64 and aarch32 linux:
> 
> /home/pm/qemu/target/arm/kvm.c: In function ‘kvm_arch_init’:
> /home/pm/qemu/target/arm/kvm.c:248:29: error: passing argument 1 of
> ‘kvm_check_extension’ makes integer from pointer without a cast
>  [-Werror=int-conversion]
>   248 |     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
>       |                             ^
>       |                             |
>       |                             KVMState * {aka struct KVMState *}

I was sure I tested that on ARM hosts, so I double checked and
this code is new, merged last Saturday in 1711bfa5f5 ("target/arm: kvm:
Handle misconfigured dabt injection"), so an unfortunate merge race
problem.

> 3) PPC64 had a failure on iotest 030 (though I think this may
> be an intermittent in master):
> 
>   TEST    iotest-qcow2: 030 [fail]
[...]
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
> found"}}"

So this is now more intermittent, and this has been reported on:
- Linux/x86
- FreeBSD/x86
- Linux/ppc64


