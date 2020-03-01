Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E00FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBEF246B7
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLampV6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBEF246B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8SsT-0000zu-4C
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Srf-0000Qh-GD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Sre-0003Ei-Jg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:58:55 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8Sre-0003EQ-Ce
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:58:54 -0500
Received: by mail-pg1-x541.google.com with SMTP id t24so4213643pgj.7
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iAWv6LM87Bsw6cBMylrOKGFMgug9eK+rPqjr9mDSqiM=;
 b=HLampV6YM2YIZHGGCsbXPcY6UFSkNeIxNNXqJDMaPLw2SURLTzYEodRoAj+kvwZTS+
 A644r0wdr7eEI6e1TfzKzajZByRGXkgdXAJKuYAH0ane85UP9wT9dNbMO5StJF0ZxaAV
 mhMy6uAKeGmvOuHy2agB9HQSwZXS0P5S+0J/jg9N/dT/TLK1INTkVk3U3Fd7G8G04QTz
 k0bhWWOGx+Jej1JtQNfikXA0QwzHQOfaz91PFXt6i4+ntjm2bV+/nFlo2MzLw5Hk5RqV
 k6Q61hDdvfE5sSWVtnXoxCsNtEr7obrhnM4gcIno/UpABavzk2+euwAbZy5XhCko72SK
 ORWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iAWv6LM87Bsw6cBMylrOKGFMgug9eK+rPqjr9mDSqiM=;
 b=qjfl9mSRJrWa/ZPGy0byRPZwoRCKrO2Chsa6TyTCgwx3MStF2vK7oTsrFd1bcwNTri
 Knd8XngIfwth4Fsiw0KvTleSWEU8Jet/E9wylpZybpmzO0nHDe99qW2/a2Wif9w2pRUq
 aLGH0KuYs9GGSHZmxEdgIXuRdrJOCI43Drj3wy0THYf9rlO3O/PBfCujYk9x3gh5TE4M
 JUsJSvcTB/9odoSY7JeVz3t7btRUWlVK2mDOrfuRQmPhcr7CfwlDXtCZxD4x0AHsnhuU
 fdU6blNYCR70wN7f0XrySZ9J1q9n+1uN7XZgD22lXV31WK265X+nKb24/BOtl+vctF1c
 6A+Q==
X-Gm-Message-State: APjAAAWEmci+Xp4CvsphGViK/7ICQuVNITbabABvBByqnlvlihGygcpA
 OeOlyfu7hRbXo3GNJ0r/aAZ6FA==
X-Google-Smtp-Source: APXvYqwx9HI2eHF4l7rOmmH0+IBq2I4B485DeEqMDXtyx35KdgnNa0K33xOgisL6wTV84T9VKAOqJQ==
X-Received: by 2002:a63:7ce:: with SMTP id 197mr15655740pgh.429.1583085533136; 
 Sun, 01 Mar 2020 09:58:53 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o66sm3654585pfb.93.2020.03.01.09.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 09:58:52 -0800 (PST)
Subject: Re: [PATCH v2 6/6] hw/arm/virt: kvm: allow gicv3 by default if v2
 cannot work
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-7-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eae4a0f8-3821-a0cc-1dc2-b54b05d6611a@linaro.org>
Date: Sun, 1 Mar 2020 09:58:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 2:40 AM, Eric Auger wrote:
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility.
> 
> This patch keeps the default v2 selection in all cases except
> in the KVM accelerated mode when either
> - the host does not support GICv2 in-kernel emulation or
> - number of VCPUS exceeds 8.
> 
> Those cases did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/arm/virt.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


