Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6309C21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mrn7CLIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6309C21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRw6-0003p9-KA
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 17:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaQGi-0001xh-Oy
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaQGS-00056B-Nj
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:19:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaQGR-0004pc-Hy
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574972384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sduL7II40w/cS2ue0sJWFIoxWVRAF6DHrBU2iCFbRA=;
 b=Mrn7CLIflA9SNmpkyuA8/8ryVvu5IudROrakRIRkTX1xXnpiopgzaYyzBHxnYdRK6OW0xW
 AqpdxBUgRpz3pkDZjS0mTpdNmXg63LMNkjSWOyrirFCXukAh1RRHoJeKGDkU06MKJYaC92
 sdF7CswOnn3HOSmuUwacwWDngfdPazo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-yI5mYEVyNHS7Qq6qkaqLDg-1; Thu, 28 Nov 2019 15:19:41 -0500
Received: by mail-wr1-f72.google.com with SMTP id 92so14382378wro.14
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 12:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5sduL7II40w/cS2ue0sJWFIoxWVRAF6DHrBU2iCFbRA=;
 b=e5DkR0FieiveVhxQsumr0+uNkhuL9yq4vpoZslOs3wd55lhR0LX8+qnqkvappAbMgR
 lLer+LgUmouyX11r/IgSPRV7cjj33+Uw7expqzQGG52GrW9Cem2CjU265Gtb1LuIJjQ1
 5ih+EmP+MOY5Y8J5GZtgC/m8B1ebH+zFwZTZvq29UT2RBy/vTWq+XX1khd8vl2oifLbP
 6oadfEVpEbuwnYMh0vjwp0QS2SDDgarKet/0fAmFxd4mOOLqMFBmUVmb25JVEX6O9aP5
 2o9iTSvVhJMqhFiPCINikVJLU53uFy6/eYvptzNPqsEXlHaB88pE0Py9CRP4BgVA4x3f
 PmKA==
X-Gm-Message-State: APjAAAULUJ5JA/YtJD6nYU5XR+ldoM9AIi/KL1gWyIOzecgEbylwBUxu
 s7kMKXLJcgBebDxD9NU2FCWbZlbxn1s3NlEbL1dyjsdNlS5CwNUUXBygvyuvzErjBBx4aZ5bb0Y
 u5kmr9QtCEfJtIw0=
X-Received: by 2002:a05:600c:2410:: with SMTP id
 16mr10667842wmp.36.1574972379989; 
 Thu, 28 Nov 2019 12:19:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxD1SikqTfQnRZ70id3xincedWHw20WQ3bYfFDnUXyXcp7I8YOqLrX2H7hJ78gFguC6v5XP3g==
X-Received: by 2002:a05:600c:2410:: with SMTP id
 16mr10667835wmp.36.1574972379781; 
 Thu, 28 Nov 2019 12:19:39 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e16sm24685543wrj.80.2019.11.28.12.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 12:19:39 -0800 (PST)
Subject: Re: [PATCH v37 17/17] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-18-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c5e57667-cedf-ac3c-b753-8b46fb99c71b@redhat.com>
Date: Thu, 28 Nov 2019 21:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127175257.23480-18-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: yI5mYEVyNHS7Qq6qkaqLDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 6:52 PM, Michael Rolnik wrote:
> Include AVR maintaners in MAINTAINERS file
> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   MAINTAINERS | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..d7bfb62791 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,17 @@ S: Maintained
>   F: hw/arm/smmu*
>   F: include/hw/arm/smmu*
>   
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +R: Sarah Harris <S.E.Harris@kent.ac.uk>
> +S: Maintained
> +F: target/avr/

^ This is the architectural part section

v This part should go under a new 'AVR Machines' section.
   (See 'Alpha Machines' for example).

> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +F: tests/acceptance/machine_avr6.py
> +
>   CRIS TCG CPUs
>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   S: Maintained
> 


