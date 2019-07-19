Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9EC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F0D20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F0D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRGd-0004xH-Qz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoRGS-0004YY-Kz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoRGR-0006Wj-9o
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:41:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoRGR-0006W6-3V
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:41:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so18368268wmc.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2scEJYKpuY9wEwtDzlbHd5bZy8XbHD8Qvjd8QA6omHw=;
 b=QCqe0++tkpvCa2mwV40cwXIu4n95v/jsAx0B9nKPVisilTYtg2/c7V0/B/BGMrTXks
 fqLZW07mZeR1AHWM0mEpyz5hPQBCiODXWheEasvvxMj7bQdD/vVWrpALvKRW+F3Nv8nt
 rU4TX3nutG+/TZ7T7LbBu4QeKHzVdzhOvj7Jh+/iT1rNZAub4oLh7BqAWWGTeOMgQ4Dq
 xZNTfpTlihEilGZ435AIrTZLZWREupdx1JL8xnNSOH2KO5U7weLjmljnqG5cOyJsoW3H
 aswRPLeqJ+7jSHK7d7Dn32xdjDAC00ajZtUFu/lLdOyHMgjmJm7qgnm6y9ZnV+XINxcK
 Sytw==
X-Gm-Message-State: APjAAAUe/CRLCdz9d7ZSFVWVkYUsqdfFU/A/xTdD1sWVL26dcat27BA/
 y9G5VEMW5Z/LOk52sm8YUv46dA==
X-Google-Smtp-Source: APXvYqxMHH6msKbBzM1AW3wRXscDuml3xKA446Ih1+E/0fKPhYmXYRV3H0eQycVcxuA6Uauz4bpEmQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr48215988wme.47.1563536485991; 
 Fri, 19 Jul 2019 04:41:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id y10sm26094328wmj.2.2019.07.19.04.41.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 04:41:24 -0700 (PDT)
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
References: <20190719111222.14943-1-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <065e5788-3dc5-4ec9-237b-60541baf8a3a@redhat.com>
Date: Fri, 19 Jul 2019 13:41:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719111222.14943-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 1/1] i386: indicate that 'pconfig' feature
 was removed intentionally
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 13:12, Denis V. Lunev wrote:
> pconfig feature was added in 5131dc433df and removed in 712f807e196.
> This patch mark this feature as known to QEMU and removed by
> intentinally. This follows the convention of 9ccb9784b57 and f1a23522b03
> dealing with 'osxsave' and 'ospke'.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 88ba4dad47..b801f56354 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1083,7 +1083,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "md-clear", NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL /* pconfig */, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", "stibp",
>              NULL, "arch-capabilities", "core-capability", "ssbd",
> 

Queued, thanks.

Paolo

