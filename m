Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA6A221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhZZ5TTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6A221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIoZ-0002Yh-O5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvInn-0001g0-Ug
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:08:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvInm-00066C-52
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2Tb5yy+AaFBduB9gSLxlzRxUOTIxBwfFea+WIj9QeU=;
 b=bhZZ5TTzNfc61CvVzminqB47Kucij0Uvgt/2zDqHeJ8cQEdLugGJjflR/H9N5qapY3gK/T
 hyYaYa57qqnXiz0cdhK09/64gE1e2KDfxPtFtaQHN4um/nBX6mZsJlEd06Vtjnido8y2XT
 YLb8iiCnEt6F9gxghdJdauN0mzHlaJA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-UebiSlQ2Px6dwtMB7YPPVQ-1; Tue, 14 Jul 2020 07:08:41 -0400
X-MC-Unique: UebiSlQ2Px6dwtMB7YPPVQ-1
Received: by mail-wr1-f71.google.com with SMTP id i14so21151108wru.17
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=l2Tb5yy+AaFBduB9gSLxlzRxUOTIxBwfFea+WIj9QeU=;
 b=ab8G3f0VBdw8McP9+Hu2PmGgXOWGuFPG5jCWvmJOFRYc0oJXCkxR8tS02TPX+c/Wik
 zEG+hr04V+ImEsYroein54KccpW1iiFdCm2cxrk1Nx0LEZdHPS1zbdxibjB6HTZZgPhE
 b4TM/GN62jx+UgM0Kbv9D+u98tMgs9bia8ZQuhkorlNueD7pqaI4wqlJU5A84MnqXigC
 9m1J56l59wh0VdTdPh7WYf8TUY8BNAUShwtza99oD69QdesLsM+HRXk7bazaX0ULixiK
 PBhbEEsBxmqVdj5BUeepmmN6Er+DJUnS0ondg9KPpvh6O8O+2Lnf8Yclksd85w/byIuK
 a0uw==
X-Gm-Message-State: AOAM5331MALb2HFvwgglV2TRjijmqeKHENLTpla3kg+bxgvR0EQMIiPC
 0/XuENCb8Us8xpLXPIZYQduKYvNinbovHD3YxVdHtkMc1ThE79eiM2SVc60efbV6rLXjqLuGftM
 FmSmhvMuMrJ2atSw=
X-Received: by 2002:adf:aace:: with SMTP id i14mr1852227wrc.236.1594724920644; 
 Tue, 14 Jul 2020 04:08:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfLXS6bPRWKcP+czOr3iQGLZkmLI5fpcywuhUdrSmQbPuSbk7URWdZ3MQCpPy51v+wJbqE9Q==
X-Received: by 2002:adf:aace:: with SMTP id i14mr1852200wrc.236.1594724920455; 
 Tue, 14 Jul 2020 04:08:40 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 12sm3784661wmg.6.2020.07.14.04.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 04:08:39 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.1] acpi-pm-tmr: allow any small-size reads
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
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
Message-ID: <8e8185a0-3b7f-53a8-15cd-adefb9ed0881@redhat.com>
Date: Tue, 14 Jul 2020 13:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714105113.32603-1-mjt@msgid.tls.msk.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: Simon John <git@the-jedi.co.uk>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 12:51 PM, Michael Tokarev wrote:
> As found in LP#1886318, MacOS Catalina performs 2-byte reads
> on the acpi timer address space while the spec says it should
> be 4-byte. Allow any small reads.
> 

BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247

> Reported-By: Simon John <git@the-jedi.co.uk>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/acpi/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> v2: fixed bug#, use the right form of S-o-b, and allow up to 1 byte reads.
> 
> I'm applying this to debian qemu package, need the fix
> faster in order to release security updates for other
> branches.
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -530,7 +530,10 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_tmr_ops = {
>      .read = acpi_pm_tmr_read,
>      .write = acpi_pm_tmr_write,
> +    .impl.min_access_size = 4,

This is correct.

> +     /* at least MacOS Catalina reads 2 bytes and fails if it doesn't work */
> +     /* allow 1-byte reads too */
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,

This is a quick fix for 5.1, but I don't think this is the correct
long-term fix. See:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04639.html

>      .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> 


