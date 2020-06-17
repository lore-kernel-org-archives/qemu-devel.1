Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA24C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E572C208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt+A7sff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E572C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbsM-0000CC-SJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlbrR-000834-08
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:28:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlbrO-0004An-Lb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592414905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GyrI2hXGGDk/nItpMreJctdwovT6GCMEcxyqiVQFox8=;
 b=Xt+A7sff+chVmNmaA3lcUaCrDrsdyoGsr8hBcg4LnBSrLDk9n6faPjv6RCMDrVmvRfmYOc
 I5IG/sN/l6FutuKkkBMuoQoQEb9WTe8oIW95YELjEwgipk2M0QP7aGCd0M16GMwPsFV57u
 2+FqHlZ4O8Do0FFc7wxx13yW5uXYpPk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-eEFZk-eTM8-a3BnEk7Jr0A-1; Wed, 17 Jun 2020 13:28:24 -0400
X-MC-Unique: eEFZk-eTM8-a3BnEk7Jr0A-1
Received: by mail-ej1-f70.google.com with SMTP id b24so1429737ejb.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GyrI2hXGGDk/nItpMreJctdwovT6GCMEcxyqiVQFox8=;
 b=QsA3MRUBQpael98DCnKUPDo82uD4QBZSWPi4/er31n7+rETcd9vy56zoDo0WgxQcSY
 T7TkmiNGNMhb5BIhLP4UJFF/2Uz52ZcAj114FRaYlmUTyRkltnQ4zyWvAUDX+tKXymLV
 2g+GSyY36pfc3OtFF14Yfkv4r1Czg/b2a/Blz+xm7/91HxyII15qS3+Gp6SBR6UVXS3l
 IQJq/vQ443+r9APUWV8nmN11z71+Yb1rYSaHn0DMBB9Gey9o/WCjdcHd8fjNPcx0nU9n
 EiCuKqI1o9t3q/mZcmREIk6jGrul2S70OXrVbnBxslNea281GqpOfH/WGC2fmYOEWQYk
 GWpg==
X-Gm-Message-State: AOAM5336JqZdfkpXelMx7QdCKoCiKE1XuAGvJEfyjGTL5ZlFbYNI0tZJ
 0UDa8/iExCvNTdMQEneuDmR7ahv3sYF3kUfTx/4spEEUtWK0bBDD2DhIUap8GHkjhv5wDk3i/C6
 zaq4Ns+QLhzUCKQI=
X-Received: by 2002:a17:906:f203:: with SMTP id
 gt3mr224781ejb.77.1592414903066; 
 Wed, 17 Jun 2020 10:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl69O0CqpzTgS/a+gJOV9YuemCFHbUiiIuBQn/ayVCzs/vUd4ZcMd4Ea4JKahtLyS24/cCgg==
X-Received: by 2002:a17:906:f203:: with SMTP id
 gt3mr224750ejb.77.1592414902878; 
 Wed, 17 Jun 2020 10:28:22 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u17sm408875eje.74.2020.06.17.10.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 10:28:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] hyperv: vmbus: Remove the 2nd IRQ
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200617160904.681845-1-arilou@gmail.com>
 <20200617160904.681845-2-arilou@gmail.com>
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
Message-ID: <736b16e7-375a-d646-dd4c-63cf2060367d@redhat.com>
Date: Wed, 17 Jun 2020 19:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617160904.681845-2-arilou@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rvkagan@yandex-team.ru, imammedo@redhat.com, mail@maciej.szmigiero.name,
 vkuznets@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 6:09 PM, Jon Doron wrote:
> It seems like Windows does not really require 2 IRQs to have a
> functioning VMBus.
> 
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  dtc                              | 2 +-
>  hw/hyperv/vmbus.c                | 3 +--
>  hw/i386/acpi-build.c             | 4 +---
>  include/hw/hyperv/vmbus-bridge.h | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/dtc b/dtc
> index 85e5d83984..88f18909db 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
> +Subproject commit 88f18909db731a627456f26d779445f84e449536

Probably unintentional change...

[...]


