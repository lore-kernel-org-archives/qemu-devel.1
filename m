Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A460C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23F3246B7
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKx2T4oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F3246B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Spr-00082o-0i
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Sp1-0007To-9s
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Sp0-0002Us-5J
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:56:11 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8Soz-0002TJ-U4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:56:10 -0500
Received: by mail-pl1-x644.google.com with SMTP id g12so1232629plo.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Uuh+GFYVp2AKms/X/74SNIcmqthqr2SugXQsxqRaKqc=;
 b=yKx2T4oKV5bt4cSjwjkX6qfNcyljvW4xtrMuXYCq+GG+8rDzO9GrJEtKqV+a73CcR2
 AIHkDGIEJJjCvjc4D1Wy789hxwCw0xmXiilylTMhdH0jhmLMaYLQaOc3MJH7fYZBQ20m
 BKC41FNOJEqBIT5oD9khbut1erH58ebFNW/oVXNyQmPRWM4xdagHmN51mnt+HRFCz+Gv
 1+l24ZNUzCGl4MXitmMqNcz/X13dZDmA40FQlz9oavAZ4G8CgElRfoNJofMf5EzjfQTL
 nctGmwVpdm3I80obiKHtIZApB8j7D0VLB6zBWbFJi0Thb3KoGUsJzjzfihTQDGEELh2+
 07yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uuh+GFYVp2AKms/X/74SNIcmqthqr2SugXQsxqRaKqc=;
 b=o4jr+ti+bNOE64hObkc6Mg9ljvUCfnKH+AcKS+oHFBwc3tZ/2UKAO35wEI6lZWsmuN
 QsI7Mf53wC7dNrYOiWO7NlVethcGV19uoErdkcRgDWJ4cRUxxe+z0vXCzObGDTeWqxVM
 yzLoL2yQVnII6evdolcrOx43lcxBlWAbBb3XvAwJI0Fq/Pm4B5Bgqu//ulGWqqaQ0iFt
 EmkOGzPKV0MQoXUunIctOuG14KTMZT2Sy4n8V84BKDgam19mti82gdmnnhbWQxKwTxql
 AlRouiD8P1zgl+CuuzFkhNcunPLNrK0/PdUB3d6h7jn4mOrdNjRBnQkqL+dDyRilUNzK
 lUAw==
X-Gm-Message-State: APjAAAUapzU/3V4m+LW3nkTPOrkO93c8xhvnvtrtZoGpfKH4aR9J9wKo
 RZftUYWjXV8vFOB8TtJRcYweSg==
X-Google-Smtp-Source: APXvYqzziJGwUvUZ/bGycbj/l1BTRSJaoLO5G174NnxS+NQq8ub4ESeowccPeg1D3hfN3DDd53RFyw==
X-Received: by 2002:a17:902:be04:: with SMTP id
 r4mr13963086pls.315.1583085368554; 
 Sun, 01 Mar 2020 09:56:08 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r9sm18228685pfl.136.2020.03.01.09.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 09:56:07 -0800 (PST)
Subject: Re: [PATCH v2 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-6-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30b6269e-e22f-347c-8e42-5af964bd14b7@linaro.org>
Date: Sun, 1 Mar 2020 09:56:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
> +        /* Check chosen version is effectively supported by the host */
> +        if (vms->gic_version == VIRT_GIC_VERSION_2 &&
> +               !(probe_bitmap & KVM_ARM_VGIC_V2)) {
> +                error_report("host does not support in-kernel GICv2 emulation");
> +                exit(1);
> +        } else if (vms->gic_version == VIRT_GIC_VERSION_3 &&
> +               !(probe_bitmap & KVM_ARM_VGIC_V3)) {
> +                error_report("host does not support in-kernel GICv3 emulation");
> +                exit(1);
> +        }

Indentation is wrong here.

> +    case VIRT_GIC_VERSION_HOST:
> +        error_report("gic-version=host requires KVM");
> +        exit(1);
> +    default: /* explicit V2/V3 are left untouched */
> +        break;
>      }

I'd prefer to just list V2 and V3 here explicitly, instead of the default.
It'll be nicer with gic_version changed to an enum.

With those changes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

