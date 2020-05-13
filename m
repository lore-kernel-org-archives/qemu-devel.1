Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A232CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360F7206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIX2w4U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360F7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYx2w-0008F5-FU
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYx1a-0006lV-1R
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:26:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYx1Y-0000CT-7u
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589397995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiDCUZs+l0Rg/JAgb8VOuxHm4Ngrkiq2aSr90AC+Ii4=;
 b=NIX2w4U6sF6mRVYC1UaJLnGMg67Fmzu2m9+X90+TB4N27up/9WfNJJdjMUv3CkcEAMmijw
 AAfdFzVRE3YMrOJNMvjFGb/Hcl78zz4Ut4ydzxA3tHC/TKvbSlHnR4aKC0PordRo07N3X+
 5HMuf4BF+T6gRf3QEivfOgNsLTDP3Vw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-ZYs9l2rLPs2SVYnYon9qZA-1; Wed, 13 May 2020 15:26:33 -0400
X-MC-Unique: ZYs9l2rLPs2SVYnYon9qZA-1
Received: by mail-wm1-f70.google.com with SMTP id w2so12174505wmc.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 12:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uiDCUZs+l0Rg/JAgb8VOuxHm4Ngrkiq2aSr90AC+Ii4=;
 b=daxfAxb24+6Yo6S2yK5Z8cSh0cM4IzeFACI3oSvuCvo3j+ErV7kLMF5loitR0XijNb
 UFnoeXimlm36xnD2Gsqe9XEj1oPaPT5oNUznP2xVzUnwr62jthL3upJjxVnWkp4NUrVu
 uXsWqdzixSLNGyVRdaogmjEaJdR2XJf+8RKfLe/DxQocHIV7hpip8WTy3Gi+ISyMqeFr
 DZDB/tjyG9Ma6+k/nWSxCn8TVy3POuAd0uZlm5BAwcwa0P5aYf/FiZtoRhgYUkBJ85D1
 1RODLyBk68RvRNiusfSVyvTOKiXreILE/bMoSa3lzCCYMk87SP4RFvEjf43jPh5Uezn2
 vnww==
X-Gm-Message-State: AGi0PuZ0nTA8s1jd0QbNTUp2fYQ5KDhTJ5LiJ39GbPoFsb1PSsniwmvi
 O+wlMlBfdqAmQ9XMwQSdGjvswdMaSNSsL5jg5rJotwp2+L1BkrtD7DdBQjqOMQ9LDPJmQXPfj5o
 /tkH7VPJGm0NJnqc=
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr46870910wme.140.1589397991934; 
 Wed, 13 May 2020 12:26:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypItzw2iA/0JIfwYsXGbd1cJYg3rMUovycGKpN5qoTuj4xsjQYA1pksArU+4tXv6F5Z+Y6E34g==
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr46870897wme.140.1589397991758; 
 Wed, 13 May 2020 12:26:31 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g184sm23367689wmg.1.2020.05.13.12.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:26:31 -0700 (PDT)
Subject: Re: [PATCH v1 4/8] MAINTAINERS: update the orphaned cpus-common.c file
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c4429b46-d5f1-1cf0-77cc-da9287c49e7a@redhat.com>
Date: Wed, 13 May 2020 21:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513173200.11830-5-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 7:31 PM, Alex Bennée wrote:
> We forgot to update MAINTAINERS when this code was re-factored.
> 
> Fixes: 267f685b8b
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c6..cfe71898d2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -115,6 +115,7 @@ M: Richard Henderson <rth@twiddle.net>
>   R: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
>   F: cpus.c
> +F: cpus-common.c
>   F: exec.c
>   F: accel/tcg/
>   F: accel/stubs/tcg-stub.c
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


