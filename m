Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AC1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E74206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ylj6i/to"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E74206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrtm-00086n-3Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLrsy-0007bw-OD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLrsx-0007sa-IS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:19:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLrsx-0007ri-9D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:19:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id k191so2016357pgc.13
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PNylrjfu1mrKqfMIxTGCOq8Y7UKW4PglfOblTpKd9b4=;
 b=Ylj6i/toGEdvjLclBftQAQkgIi9GgMEZ1Mh6v6kqD4NjL/ohPIriyHN0yA1WtJ67Lw
 sDtZyckUNE+MhHDPV8h2h4GgQz1v0bEBhJJiC5lVqvbPaylsXBxX4nTEKlM9AGmpfr2H
 IfjbZDAHJXHoZLOZoljoXqYkzT0XNHPP2RhuCiOTOQa54IPlAtPSLbtBBfWSCsC6oNCF
 9Ru5+tb6O7eTQIqgwNEXQA4cBXeWwgGcOTF952F11IgQzfgPskGvS0/cHIAK/r8nAg03
 Af9e8mgNhoRWFizqITYMmNGL1giaTcmAOFP6KfgJHj6Ss5XU0jm4afhG9MrgKGgs8NKe
 2HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PNylrjfu1mrKqfMIxTGCOq8Y7UKW4PglfOblTpKd9b4=;
 b=CwLGrZ4M2mW97IL8R88vjhUrXwvKPxZKdw5ve6YwXFYixPzkjRMeORe0Y+AdkOdiV4
 3qJhqCm3sHShJKzYZLFQg0wOZ92aiTu5EweC7MidCnxrIqf/UqsOtWKLHqI9iXuZXSp1
 hpyxjPTQ8l3ruvOUp5+tzHgAFNe/vIhHSveWeAgWbPYpMfAiBxYLxPAUPVimDNjhYelm
 VTh3tyi1Y25MWKDuPx2xHK1tZRGKYI7ICPDb/G+TVsZvDh9sb3GehwuMj+F5QKsI9BML
 zg5v4bH7pYWK5aOh4wO5JKiqgRScG/zv0Efn/7l94MaIrzMmpeMg+XEu0KIAGOqxJgrg
 lG4A==
X-Gm-Message-State: AGi0Pub+n9F+Zwtg494cbLkJjweexr9zHVNa+m2+dZyeyzG2DsyRCpm8
 yEXY36jE65uDtkFO/XlVF1qGDA==
X-Google-Smtp-Source: APiQypJTF8lisHSvlRLkhL1YgBEnKA5HW/fKPbV+XkJTRIxKXlUyAr7J6sevJ8Dtx62vjuHkEZljhg==
X-Received: by 2002:a63:344d:: with SMTP id b74mr2975010pga.6.1586279978005;
 Tue, 07 Apr 2020 10:19:38 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id ep21sm2152853pjb.10.2020.04.07.10.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 10:19:37 -0700 (PDT)
Subject: Re: [PATCH 3/5] rcu: do not mention atomic_mb_read/set in
 documentation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200407140746.8041-1-pbonzini@redhat.com>
 <20200407140746.8041-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <104818b3-beab-ec05-c074-bcfda7436731@linaro.org>
Date: Tue, 7 Apr 2020 10:19:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407140746.8041-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 7:07 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rcu.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

