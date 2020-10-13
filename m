Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05705C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E1F2068E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8MYqXGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E1F2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFqW-0004dF-A0
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFp1-0003OD-Jh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFoz-0005A1-W8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fv6Fa/S+yjMsgxTeLF/dgikbc6nPa/7K1ehD4HJtvw4=;
 b=D8MYqXGVaBGaVBIcXMi6ytKqO7y1ryKOvM2qj7a/N7Xkc7edg76PsE0Lu+4FFCQIuYP31T
 ++y1aNnNGCkQkRr3/WE6xSG2C8A6fIMni2qB1qftdm+uD+3cXPiY9KEMwL8rz7yI5OrW50
 oSwz8EiXc9hzJQ0yJOZ2qOScflFqiMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-5PlEz8JuN3uKFGtgcGi6_g-1; Tue, 13 Oct 2020 04:38:11 -0400
X-MC-Unique: 5PlEz8JuN3uKFGtgcGi6_g-1
Received: by mail-wm1-f70.google.com with SMTP id r19so6489103wmh.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fv6Fa/S+yjMsgxTeLF/dgikbc6nPa/7K1ehD4HJtvw4=;
 b=hVnURWJ31/C6ZQHpvDNWLQtmjDCBYOpdQPO6EZ4sAQysnXI42R+tcXLa5ZdrSK9xDA
 x0kOhmPKFzNkYsklmhyP8WDr+vx0f6DQcgykGm//4ZQ0dO8yB9uxhKRekL9I+6FBWzIC
 ZzlFJJ1T82TDdONUufC4L8ovO0Amv7vMs/FCFfWM//xgl7XK4srgvUx0GLerBFVsqfPz
 T45epS/ZXQpCWPDCc0L3z8ueqV6Z6Ji8nNdWW0AdEkiKV3xk14EZhlqHWOhkrhiQ+C/K
 rh4wDy3Lq+dcU+YrIH9K5W7RSDcgF6yJYHTZAzl+Ecdhfx4jQazENzU4pCq+dVV9cvVR
 Pm1A==
X-Gm-Message-State: AOAM531crD5dinN6Z49mERF/F57CEdVYd1VcNtzq2tfuSKt5GOSh7gQE
 mX3zbHk0zwXDXMwldtuv3Z4O6a5uuZ8/728hnhch2XxOG230I2XedeJFNPny473LmJ5BsE26L2f
 f4x4w4yCup3PH+7Q=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr34691054wrn.52.1602578290436; 
 Tue, 13 Oct 2020 01:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzKlJf/dy+7ovm3eN2P8LmhOBQuLlfdbrFX0/PiwCSjfFv02l5PAhcG3C6oAyHaIiIXZGtJw==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr34691028wrn.52.1602578290212; 
 Tue, 13 Oct 2020 01:38:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v3sm29254399wre.17.2020.10.13.01.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:38:09 -0700 (PDT)
Subject: Re: [PATCH v7 2/4] gitignore: ignore a bit more
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201012233740.190-1-luoyonggang@gmail.com>
 <20201012233740.190-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7431126f-cc78-57d3-fd78-bd21c5785927@redhat.com>
Date: Tue, 13 Oct 2020 10:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012233740.190-3-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:37 AM, Yonggang Luo wrote:
> Enable the creating multiple build directory at the source root.
> Ignore /meson/ and /roms/ for better search experience.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   .gitignore | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index b32bca1315..f78ee9f297 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,5 +1,5 @@
>   /GNUmakefile
> -/build/
> +/build*/
>   *.pyc
>   .sdk
>   .stgit-*
> @@ -10,3 +10,5 @@ TAGS
>   *~
>   *.ast_raw
>   *.depend_raw
> +/meson/
> +/roms/**/*

Why?


