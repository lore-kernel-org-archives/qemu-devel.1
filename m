Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A21C38A2C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156CF20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+Eo7Snv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156CF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOTIp-0007qp-A4
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOTHz-0006wm-VC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOTHy-000825-Rl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:40:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:55115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOTHy-00081U-Ku
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:40:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id np9so5870564pjb.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+YdJ1eItjRB7ItTRPS1yzNOPMwATBGKtFqeGB8AgldY=;
 b=h+Eo7SnvIra0gg12SjTsJNQK7hUY+z1MG5p0nKh/xlrWsdcbkSQRExUNzO/QuF5LBq
 nK+gerPPGcDw1dky7bWHAqeQp8QM3oxsP2k5TFzYVWzZkjJvZT9B0G623T5XtGX6sISR
 AsOK2k9fq0tA6tc8Xrq91NmtabQMcdJr3WLFXjdE/qGCKZCOnri3+Ys0GnKZt3ZYg1g5
 KvE9GdB3QSSzSziY7/SdTZZfBh1MYelqsMXUNXL7f1BUMIfWIGiSP46OQMHEcZENFaZt
 OK716l6AJ5iNivPu5/aXilPD2ztEdkBYE4E+00VClFsmzjbpDFgWdZnftHI0I4QwhcQt
 l1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+YdJ1eItjRB7ItTRPS1yzNOPMwATBGKtFqeGB8AgldY=;
 b=JTiHNE4t5O0EmwJSJeu4Z0Ps1/ko/cQ3za1dWIJw+ZXBCUWE8JKoltE0aOVffr2Uob
 BffLR1fUjxTunZ3+D0iUOxdlhqTIV/OXPkUV+bfglCmSFJGKo/HOCQ/QbV0c76iuEOTe
 M6o8/3lsZFHEuvmqSDvxFulE79Pg6Q5NS+UU/31XGEZEPK6o7Gwi5g0oPrEUTuCeR1jN
 Ej2bmU7ksW35M4GbPRGYYGNvC3X6gW3k6lKjjyrAQt8z4j0IWzA70LusWW1Vt/vHPJjC
 hS7hcpblumjTHWmFvvSUavFtRvkuICtoS31uRhU9Ss/UzwRN/CTFAb80uFzL3NivtQ2M
 Y+tg==
X-Gm-Message-State: AGi0PuafYf9bY8nSvYGNCqzRPfYN8nDLHpA7avQp6D7MU52DOzW6Lq9l
 fkB3laxEMd+fipck1Xv07zfh5Q==
X-Google-Smtp-Source: APiQypJH6XQewev6YQtlp+dBP1DIMMkffzfDkFrLt+FaPiM0Gp4zPaFkO3wCEw34bPMGeI/wlc0ovQ==
X-Received: by 2002:a17:902:8d8d:: with SMTP id
 v13mr1951273plo.260.1586900413217; 
 Tue, 14 Apr 2020 14:40:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a136sm9012385pfa.99.2020.04.14.14.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 14:40:12 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 0/3] various: Remove unnecessary casts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200412210954.32313-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1478503-cab3-df6a-1aae-50b262e9121e@linaro.org>
Date: Tue, 14 Apr 2020 14:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200412210954.32313-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/12/20 2:09 PM, Philippe Mathieu-Daudé wrote:
> Remove unnecessary casts using coccinelle scripts.
> 
> The CPU()/OBJECT() patches don't introduce logical change,
> The DEVICE() one removes various OBJECT_CHECK() calls.
> 
> Philippe Mathieu-Daudé (3):
>   target: Remove unnecessary CPU() cast
>   various: Remove unnecessary OBJECT() cast
>   hw: Remove unnecessary DEVICE() cast

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


