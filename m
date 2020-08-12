Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799ADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431CF207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl3WNPSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431CF207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5pgj-0004oL-Ei
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pg8-0004PQ-VK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5pg6-0002KB-94
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597234580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zWVd30pRUJXbWHQXiVEkgYWrdWCHXP+OUR1sN+Wzfj4=;
 b=Fl3WNPSLWkcuXq0Chp8+XZUYNl5DhSq/C1u5Ec3EfrHKo0NUPdZNV0CSms3DO8TUca3/Ft
 f9ZEKn5i9iGquJG10b829nMzDJT+OCIhAyCe6bKyJpR7vFjUopPGYrOuI9yfENOnrQnejA
 EMKPSqfq4aZwbnDCvou02lxCFMYVfgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-KHtToaahMu2KdZyALZydpg-1; Wed, 12 Aug 2020 08:16:16 -0400
X-MC-Unique: KHtToaahMu2KdZyALZydpg-1
Received: by mail-wm1-f71.google.com with SMTP id h205so833132wmf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 05:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zWVd30pRUJXbWHQXiVEkgYWrdWCHXP+OUR1sN+Wzfj4=;
 b=M1O5h6XuXa2SLmYyYxF+kd/AxpCZjty6/NUzjFU2fVz5r8rvZgv8X138ZKK9sgyymq
 LfoZXaAx11CtiVOykZ/kjzjK8DWnUJW6mvu1TYy3YQbL0XQRFi0+ugAkdiDeuXmeNcSu
 TOS58qeFJH67D3kZC2Va794J6mHwEwe7SDJNNC7A5DIL2vk/dxW14G0lV+i4P/+MUbWj
 NsgGRxVqLjJLeCQlzutr1RYZ6MQy39h7c/NX3WqZbgxuq+qqdFHe0LJe9VGvJUSl3aaC
 39/qgJw94u9/hYdepl8q9zmBg6iB4MWIvr1NpFSiW1NUoRzdky7p7k9x6CW1bozHN7HT
 yorg==
X-Gm-Message-State: AOAM532X1INCr5/yg0vzQZpIN4cHHlx30dtH5AACRCbJ7R2JaUqykym+
 P7NY43rxAB3OeSNLg9ExrCdbjICDpkvbcgroRYq7ctq+r9gUku8himuTDzszQBEPNIG8ShIrae3
 6KeMi+Dqj4tpaoEA=
X-Received: by 2002:adf:fa09:: with SMTP id m9mr32973838wrr.130.1597234575379; 
 Wed, 12 Aug 2020 05:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySnwrYIRXcN0I1LoqMp3DnQWXh9yLnV00xZWgFT/g2gxE952etQ1a9RZR3eeOc5Wv8Ztvs+Q==
X-Received: by 2002:adf:fa09:: with SMTP id m9mr32973820wrr.130.1597234575114; 
 Wed, 12 Aug 2020 05:16:15 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o125sm3629182wma.27.2020.08.12.05.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 05:16:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] acceptance: update asset urls for the Bionic
 aarch64 installer
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200810093050.28744-1-philmd@redhat.com>
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
Message-ID: <62ccb64d-458c-9148-ded7-1241af0c60ba@redhat.com>
Date: Wed, 12 Aug 2020 14:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200810093050.28744-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 11:30 AM, Philippe Mathieu-Daudé wrote:
> v2 of Paolo's patch:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg728610.html
> 
> Do not update the binaries (and their hash), update the path to
> the current tested binaries.
> 
> Supersedes: <20200809223741.56570-1-pbonzini@redhat.com>
> 
> Philippe Mathieu-Daudé (2):
>   tests/acceptance/boot_linux: Extract common URL from xlnx-versal test
>   tests/acceptance/boot_linux: Use stable URL for xlnx-versal test
> 
>  tests/acceptance/boot_linux_console.py | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

First patch applied to my acceptance-testing tree.


