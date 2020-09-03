Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2506206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggCZBIYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2506206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDosm-0007Lk-PX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDos3-0006uC-OR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDory-0003sA-D2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599138097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1umDLvIsNJPVg3qk2wYhrwXtbTdMmq0TBWVQ8ktjNuY=;
 b=ggCZBIYaNGrxnL661kYvGAkZu6NmndEzQdr086o0Uz/OzqpnlJXjVTyePVzwMsUN1FdQYg
 fqiTIVbKyf3WA0keGJUp/JqzmfFxMKwvWi1NAhn1zTE0258+G8Gf2Eio5gz8K82tESrKFR
 iZ06fCTB3+fwF2lFLhWl/XRfdPo7M3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-gzMe0FK9PFmMiGZrgSefRg-1; Thu, 03 Sep 2020 09:01:36 -0400
X-MC-Unique: gzMe0FK9PFmMiGZrgSefRg-1
Received: by mail-wm1-f72.google.com with SMTP id a144so931097wme.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1umDLvIsNJPVg3qk2wYhrwXtbTdMmq0TBWVQ8ktjNuY=;
 b=tMOTrpGYmLtaO96uWcTsd7eRTpixBhR/D0OhCraqb9VgLrowtpwXfUR5LKYhqxAC69
 onIrZJm88ibPVRwceYzjyqLRySYgxzAkVBsKO0cxQg4Njt3hjJczgc645v+NSS7OOFi9
 /KKWhcOQZj3kxP9oRAhgxLmTG0qUNGlV+dzesbHP+KB265nwDbMhwPgTi+dJt3qJpI1G
 6ilFENDMkyPo42i26e20+uZ7WQj4V1dPhD8juIFlLf+gl9t2GQg1cf4hBaL29ydQ/Feh
 ZvqVUBWlsBIllg1/JszPSB9tyqF+RW30y9ZcbiieqGObI2OqtWVZiGQcIHBws0zWJ6f3
 euSg==
X-Gm-Message-State: AOAM533arIaCgLCCA9QPGWKS+H9rexuNx72pJju0ycyFsGPjSxI8Yo2t
 8XdgX1vLU/6KXicrBTN6DKlnclHH45Q7pN28rr6vhaQM8X+hEtiyzg4OocIsdPg4vKKCgIMMu/A
 W2Vz+4zuACKVxWr4=
X-Received: by 2002:a1c:b703:: with SMTP id h3mr2366047wmf.131.1599138095258; 
 Thu, 03 Sep 2020 06:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVpSrEbzGvkKITfW1BHd/QjNlbx1lJjt0KZHGmju+LJ2ybpX2714WMuvgCrBTX5xNocU+0cA==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr2366016wmf.131.1599138095025; 
 Thu, 03 Sep 2020 06:01:35 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k84sm4430117wmf.6.2020.09.03.06.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 06:01:34 -0700 (PDT)
Subject: Re: [PATCH 39/63] esp: Rename ESP_STATE to ESP
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-40-ehabkost@redhat.com>
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
Message-ID: <469af456-1ad7-0355-1470-798679fa7268@redhat.com>
Date: Thu, 3 Sep 2020 15:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-40-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, berrange@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> Make the type checking macro name consistent with the TYPE_*
> constant.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/scsi/esp.h | 2 +-
>  hw/dma/sparc32_dma.c  | 2 +-
>  hw/m68k/q800.c        | 2 +-
>  hw/mips/jazz.c        | 2 +-
>  hw/scsi/esp.c         | 6 +++---
>  hw/sparc/sun4m.c      | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
> index f281625dd5..20800dbf5b 100644
> --- a/include/hw/scsi/esp.h
> +++ b/include/hw/scsi/esp.h
> @@ -67,7 +67,7 @@ struct ESPState {
>  
>  #define TYPE_ESP "esp"
>  typedef struct SysBusESPState SysBusESPState;
> -DECLARE_INSTANCE_CHECKER(SysBusESPState, ESP_STATE,
> +DECLARE_INSTANCE_CHECKER(SysBusESPState, ESP,
>                           TYPE_ESP)

"ESPDMA" would less likely clash with eventual 'ESP' definition.

My 2 cents.


