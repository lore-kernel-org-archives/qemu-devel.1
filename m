Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4CEC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C4620759
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw8uiqmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C4620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvue-0004ES-3e
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvtA-0003C8-PV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:08:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvt6-0007PT-2j
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:08:24 -0400
Received: by mail-pg1-x544.google.com with SMTP id y14so3714562pgf.12
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rM+/xjKh8pQWkH+e2bV8DBfeGhKdu9fMUgIPcAz+dUk=;
 b=Vw8uiqmZOVzTa4+fjEyoBe3iZA9/HT/DN5RoKEmISovoyDAo2TqBD73muierXA46gq
 32EqPvMi/QV3FI5y6ybY65iFljrGc5fonxkcz1rquGQTWFMQDP6LnZLX7me5ln5zsMlR
 JT0ywKI9gILtVBPoGiytKts8zPMoK4eKvhaCXE3M4dtCTcMChranfw4XALNLERQVkYJG
 /eF0BN/Vp9k/9371lgYd4HYKpZ0YlMTQptcHTT+txQAU8b6pzegJ2BX5qLNeFPEbzFr+
 ie7HtChR3lC/yjI+aLlQOLc+zPnp7RUrWPq7CUJavqvLa2698su/W9oef33lSun/SZhL
 845w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rM+/xjKh8pQWkH+e2bV8DBfeGhKdu9fMUgIPcAz+dUk=;
 b=jqa1N41j1bCEOEWMHVw2Dmvqkx+e2zOXRP7C/Kqd/BPzK6Mux/0qALgWqNZVKnk/fz
 GIuAOFPph+inb6DXbgwljZP2gs4gjRyugh0n2YBs4i/25Zu5xNmr4txTEYqfDeR7AMof
 KmFDc59OuEvD3QgYfbUbviMHJSYfwC0J/RD/AKC6dzzDFQOf8jz4xoWUGiXP6qXui44b
 Uxk12UbR/WXKty1h2TUl7P1iuuDf0ooKyguAH2sJQSxlA3twaRsZaZinf7oYI6PYxinP
 /8JUJ7lZqlZS4Lqwq3I82Se2HMkCvWvXj2KXyLuaCl9DBUT5It9OjN7f6FM0fGIRe7Zn
 yp+w==
X-Gm-Message-State: AOAM531KaV6LoxgQh/3tnvmPqBl7fY17FWj/ZHJeE2JhMMLvSgYI6UZF
 YthAtwu2hLOK+xqVYq7+gYlZHA==
X-Google-Smtp-Source: ABdhPJyy8IL4zk0nhqYHtlu9dj0wY8Y0mtNKWQ4pidggA3EV4qiRljkEbi001YIzBveySitgYPXFyw==
X-Received: by 2002:aa7:9817:0:b029:13e:d13d:a139 with SMTP id
 e23-20020aa798170000b029013ed13da139mr1165130pfl.33.1601071698601; 
 Fri, 25 Sep 2020 15:08:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm3563512pfe.208.2020.09.25.15.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 15:08:17 -0700 (PDT)
Subject: Re: [PATCH v1 7/8] s390x/tcg: We support
 Miscellaneous-Instruction-Extensions Facility 2
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f09b1638-a62d-d97d-d3f0-fd3c5092d8e1@linaro.org>
Date: Fri, 25 Sep 2020 15:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> We implement all relevant instructions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


