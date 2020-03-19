Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A23C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12D52072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGY6gY8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12D52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEydG-00086S-Sg
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEych-0007gJ-Sv
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEycg-00065H-16
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:06:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40469)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEycf-00064s-T9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584637581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYUgtx9vBxFQRdBV/0S41Vz4vYBuP9QA3WwfgOFi8vI=;
 b=dGY6gY8iyx0aaMRj5BvBC0xx627K7vWCWd/r0qxaNMIIF6YOmz9XwyVQC9+hmJM+v/AgcV
 5wrQ5zt5/tH3k722wgWfNweuMvG55WqAvKRDeaCSx9k8AcaK6BSWkdPprqh3uYMeaP47+h
 DGZ5983Cy0vsx1sCIuCXGVnlnSzUhIQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-iNRasbpAM2KDicMyc7rONw-1; Thu, 19 Mar 2020 13:06:20 -0400
X-MC-Unique: iNRasbpAM2KDicMyc7rONw-1
Received: by mail-ed1-f70.google.com with SMTP id i10so2542820edk.13
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BYUgtx9vBxFQRdBV/0S41Vz4vYBuP9QA3WwfgOFi8vI=;
 b=e55Hflk36pCWwnwr8/T+1Tvuy211ugWsxR7iNOX0e4u4YsIX0puxnm64nl2GAumaYW
 rbbypRX9RRonQEa3gg0n7UxY0CCTfJ2nqFGnV7FwZiXnvfY1fTd6zFprvtvcCNWGH+k1
 Sk/NhnVu9U1WCeRtiPLJwE0Xsvb20j3qW1SOU+g2tq3dOFXyDGU/7VWOQEPrPZCQeVKr
 8FnANi4gzE9jvxBOuV3ReCCZIsfvEWsP7Gu5CWBCTN5L/UbJwTylwEcwDhE0AsUKi3+4
 EaPq7x9D/ijkIUq5qas6Rla+/tclsfMv1r9Nf50yLyqytMozgIbqa0xWw5DFFtnbcw7E
 LAVg==
X-Gm-Message-State: ANhLgQ3NXAQlZF2wNT2d2eBpOjbdf23XYoSrlZKqchIEziZU9u/QOQ/G
 uyE539IRf1ujksTsLG2OsQWx7JS4S7GW+W/5xA+KmIL3xoGwvsWZ6KPTKhjp0cmZAAvEA4LO408
 +4dSjdWdrofreBN8=
X-Received: by 2002:a17:906:4ac5:: with SMTP id
 u5mr4322572ejt.306.1584637578511; 
 Thu, 19 Mar 2020 10:06:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvL7HyArudd79bcx8PsNksp6aBN0TRCGXTcUmR7tSo+qhBAV2TdHM+4T7dLFOIFFZKXCsGoWA==
X-Received: by 2002:a17:906:4ac5:: with SMTP id
 u5mr4322524ejt.306.1584637578198; 
 Thu, 19 Mar 2020 10:06:18 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id g19sm171193ejr.65.2020.03.19.10.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 10:06:17 -0700 (PDT)
Subject: Re: [PATCH v3] MAINTAINERS: Add an entry for the HVF accelerator
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200319135520.80901-1-r.bolshakov@yadro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70dac67d-8cb1-466f-fe1f-6be4af7c8aca@redhat.com>
Date: Thu, 19 Mar 2020 18:06:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319135520.80901-1-r.bolshakov@yadro.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 2:55 PM, Roman Bolshakov wrote:
> Cameron signed up for taking HVF ownership.
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Patrick Colp <patrick.colp@oracle.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Heiher <r@hev.cc>
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
> Changes since v2:
>    Removed myself from the list of maintainers, added Cameron from Apple.
>    Status is changed to Supported again.
> Changes since v1:
>    Status is changed to Maintained instead of Supported.
> 
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7364af0d8b..ab4dc2816c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -406,6 +406,13 @@ S: Supported
>   F: target/i386/kvm.c
>   F: scripts/kvm/vmxcap
>   
> +X86 HVF CPUs
> +M: Cameron Esfahani <dirty@apple.com>

 From the other thread discussions, I'd keep you at least listed as 
designated reviewer:

R: Roman Bolshakov <r.bolshakov@yadro.com>

> +S: Supported
> +F: accel/stubs/hvf-stub.c
> +F: target/i386/hvf/
> +F: include/sysemu/hvf.h
> +
>   WHPX CPUs
>   M: Sunil Muthuswamy <sunilmut@microsoft.com>
>   S: Supported
> 


