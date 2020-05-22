Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206ACC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D652C2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoEdOL2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D652C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAmD-00005D-2N
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAlU-0007LZ-KS
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAlT-0003BR-Jy
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOPhXGABg2pHwA2+uVSi1hYUlTSZulnccrxk2TcKRmA=;
 b=AoEdOL2zg0JgrgQsHxP8BwuNz7HX5zoevvhF5+iejhiLp8Bg0B56rw29Xa3YaOnDsdRxUB
 AxAyWzx1f4eWT20/o7ciZZwE4ZPBJqyPnoK10/zbu3WeaxSRUrA32gppFAe4P7DiFJyWcO
 Vk0JMuoDLC795frZTlLTRkRUcyS8RG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-iQlCCnaPMSa4gAEPoEps_A-1; Fri, 22 May 2020 12:43:11 -0400
X-MC-Unique: iQlCCnaPMSa4gAEPoEps_A-1
Received: by mail-wm1-f72.google.com with SMTP id t23so2874475wmi.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eOPhXGABg2pHwA2+uVSi1hYUlTSZulnccrxk2TcKRmA=;
 b=ADVyclCxxmqf0l621JyYAncR+OwQHH0oCMztnR8KHznWYbr/hclPD6TtRcAXL8+++c
 Cnfx3hrb8GqOoI4xIDC07H89GdQUtKsJAIT3xg+5MmPuWNnkL6G1OHk5MP0vtO81sOh+
 GTGgGv8u9qJS74/8ZBJbFqzX47rADfxc/dVB3yHjMFQQYfy+vwy7cANNIiEB33cfjdVy
 IJ3doybHFb0m6oPDd85Cp0iSTwsZraXA+9kkLCZSfHN3kandRVOitWGzA4EqHT8QeMSD
 V7I91L0NKmEjWSGNnayGhni8QsBtbEDg30g00LH/T90O5HN+nYmhevB/6cibjynN+PAX
 6ljQ==
X-Gm-Message-State: AOAM532t0XszEBTmd/zii3ercnnFVhRsX7o9g4/9RLrFGW6m++bmJbIC
 DGegR/J+WK1OMHBbOJt7Fq3b/Zud0V0m6J06gra1HAYoI8KP5TwPFnw0gA8KUN0fDn+hmujLI/q
 C46Owkm6pBLJC5Qc=
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr14907582wmj.140.1590165788432; 
 Fri, 22 May 2020 09:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvYlAbWSzlgpnYTD9vgSAmDmZGIYh5hbT1soCokV793YaHEXdOYujYxv3gzxGEJ8FTvy8txg==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr14907563wmj.140.1590165788237; 
 Fri, 22 May 2020 09:43:08 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h196sm2170262wme.22.2020.05.22.09.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 09:43:07 -0700 (PDT)
Subject: Re: [PATCH v4 03/11] MAINTAINERS: Add an entry for the HAX accelerator
To: qemu-devel@nongnu.org
References: <20200522163759.11480-1-philmd@redhat.com>
 <20200522163759.11480-4-philmd@redhat.com>
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
Message-ID: <12bbc931-5c1f-26d0-c8a9-bbb6d39c5f9e@redhat.com>
Date: Fri, 22 May 2020 18:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200522163759.11480-4-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Palatin <vpalatin@chromium.org>, Hang Yuan <hang.yuan@intel.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 David Chou <david.j.chou@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Colin Xu <colin.xu@intel.com>,
 Yu Ning <yu.ning@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tao Wu <lepton@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 6:37 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Vincent Palatin <vpalatin@chromium.org>
> Cc: Yu Ning <yu.ning@intel.com>
> Cc: Tao Wu <lepton@google.com>
> Cc: haxm-team@intel.com
> Cc: Colin Xu <colin.xu@intel.com>
> Cc: Hang Yuan <hang.yuan@intel.com>
> Cc: David Chou <david.j.chou@intel.com>

FYI Hang Yuan and David Chou emails are bouncing.

> Cc: Wenchao Wang <wenchao.wang@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7ee0c77f1..0377978201 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -426,6 +426,12 @@ F: accel/accel.c
>  F: accel/Makefile.objs
>  F: accel/stubs/Makefile.objs
>  
> +HAX Accelerator
> +S: Orphan

This patch has been posted 4 times, first time more than 2 months ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689009.html

> +F: accel/stubs/hax-stub.c
> +F: target/i386/hax-all.c
> +F: include/sysemu/hax.h
> +
>  X86 HVF CPUs
>  M: Roman Bolshakov <r.bolshakov@yadro.com>
>  S: Maintained
> 


