Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CAC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B0F2072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mgvjonrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B0F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG9H-0006cj-DK
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaG8V-0005on-3N
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaG8T-0003qS-Ki
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604486125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGNT/70qolte6mM+NlqyT3dkRNj2S7oGbGFpEZAnCIE=;
 b=MgvjonrzKdqRhFRPilerBoO3D922Ww+5UKeisSavGPfGdl2xLiyZQZFY+Nc1E/Yx/ISoFo
 O9TuR5i+l0TtRsGMhjpe/1V6LQUt9oJ8DP3mwM8kyqjUTr6Sif3kSViIETgd1Fh/sAh3BG
 GhuygevhCDdagDLbZVGcbrwjer8HHgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-lf8fKModNfeQ9npmm_wcow-1; Wed, 04 Nov 2020 05:35:21 -0500
X-MC-Unique: lf8fKModNfeQ9npmm_wcow-1
Received: by mail-wm1-f71.google.com with SMTP id 3so1032833wms.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 02:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fGNT/70qolte6mM+NlqyT3dkRNj2S7oGbGFpEZAnCIE=;
 b=CZPsVErIPtf9e4VcpCnInF7W9S1zcvR320APqfBzqneZf57FQe0F9l3ljkWI0YJn7M
 ci/56OoU3L7sOzq/oRfBQ016jTQqJQLXvMPKsA/e3c6MgTJMw/mrYTCLcyaFyhvQXg3U
 WK6RknO7b/oEIOQSPloOGC0aDN1zu0sbahjiizOeBvqFbHuzerxhbSL98+q57uo1QGvM
 TbIPyAjm9hp6Ci5TZxHZeA60GzXkkgEg8n4Di9mtspJnzKfzmGUqVZAX6+vL1S/fDJvN
 FndB2rdZaCnS2jcecsClSf7Mrk9X75u0NuJ/MFL83EYLxGnJWgg6okdsrS+fA3eW8GUY
 FgMg==
X-Gm-Message-State: AOAM531G4YkJr0juHR57fG6vDMtrJOUnyyIys07jZT46BX2sRc1epcjr
 v4y61MjrwHIMxiUftYFx8tXjonNI+9u3xhRRYygv2RLhbbFBi+WMhpED3G+kIG01oJdycn+IHC8
 ooJSpVVJEKIcYzMs=
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr3786839wmj.74.1604486120366; 
 Wed, 04 Nov 2020 02:35:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjFsPRuJ7TmX1jh4dq3QENCF4lS5GZuFQOCHm7K6DUFUip3FI9Pg0c8bPMjN0/Z9Mj6d2g9w==
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr3786824wmj.74.1604486120209; 
 Wed, 04 Nov 2020 02:35:20 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g131sm405687wma.35.2020.11.04.02.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 02:35:19 -0800 (PST)
Subject: Re: [PATCH] hw/arm/Kconfig: ARM_V7M depends on PTIMER
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20201104103343.30392-1-drjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <612eaae4-6e05-568e-01cc-a191bbb7c835@redhat.com>
Date: Wed, 4 Nov 2020 11:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104103343.30392-1-drjones@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:33 AM, Andrew Jones wrote:
> commit 32bd322a0134 ("hw/timer/armv7m_systick: Rewrite to use ptimers")
> changed armv7m_systick to build on ptimers. Make sure we have ptimers
> in the build when building armv7m_systick.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


