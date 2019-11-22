Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF01A2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifcDPPI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF01A2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY48Y-00024V-SD
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iY47L-0001YK-EB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iY47J-0000cE-Lw
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:16:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iY47J-0000bi-9F
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:16:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id n1so7460916wra.10
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 00:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xIvlJLVnyuosn0Xyuz1iTqDV2kRALY67l7GQ4budr40=;
 b=ifcDPPI5I3OC45+MkkLZp303v+j7pEJ6vw25DgM4ndvJDrQMwgim+0sD1av+sutlbk
 Foxq0gvRH/0qUuuC3c4fuDiIP81xd8VhxPNZEqYWj8NRHGtErAIGFSf4uz4KbWDoP8m+
 jirSiGoVVes6AuAsXUsPKebZp6dgq9DmyaL5KxBXDNLhu3EI2l3fO2ggmRM1d3PU6Y4e
 DdGU2gm/OlJ3Cr6nUnZK2jlkC2JWSF18Xd9Y7l36tPQOfru8BU/XF1gK5q9TFK52uLiK
 gZtMIClcylZeI4dxrx0IG2jcnQwOkg8u9MF/MW60nr48xVA2KcGDCWC4gfzA2n2VvpaM
 KL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xIvlJLVnyuosn0Xyuz1iTqDV2kRALY67l7GQ4budr40=;
 b=mY+ibPavminVqPKtfbNly1/1taYEDQNAhgsAEQ7XpD9/35RAO0/PWLTS+6oF4S7q/R
 ikV/0A9DQbzNGWI+BKCOFWxITbpuKC4ZAoR9zqjcgcxMV5nrLG9g+VIYolM52/Vo4rI4
 0J5H+MOt7SUZYXdygI9XfVNeea8Z7E23GgmbOJDhCBYY0eu+hUa6YQ6JtfpNglX91OLc
 xNcgTLFUVj3B7+w45Tm1QD23xlGtu+uxyC0Tt3QmWg7uL8A2kJQagNjrk4zeEhfbVxxQ
 1thyXbF876DT8yvU8GqwxVmZ90V3jlOYq+3OlQK+oOxZPYgYFMTOiEvw3Z3QKl6ayRlz
 lq8w==
X-Gm-Message-State: APjAAAU2/eCNc60bHN6UwgyzIfbvVPQYyDsFlgBhHt2EVe/+HLKQvXDl
 ZGHuPfvA7XoQrlXXIJpVlvu9Ng==
X-Google-Smtp-Source: APXvYqzBSgj9jGIJf6ejQlNr/iWWOwU1dxv8qlsKctE6Vi+rUnM/BM4EpwZmJcb9qe1NXYFbI4BoxQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr8176112wru.220.1574410596103; 
 Fri, 22 Nov 2019 00:16:36 -0800 (PST)
Received: from [192.168.1.143]
 (host217-43-132-120.range217-43.btcentralplus.com. [217.43.132.120])
 by smtp.gmail.com with ESMTPSA id b14sm2570979wmj.18.2019.11.22.00.16.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 00:16:35 -0800 (PST)
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <99f18b89-67c3-e31b-e982-f7b8e1b64f44@linaro.org>
Date: Fri, 22 Nov 2019 08:13:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122080039.12771-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fangrui Song <i@maskray.me>, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 9:00 AM, Markus Armbruster wrote:
> From: Fangrui Song <i@maskray.me>
> 
> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
> @value to 0..INT64_MAX:
> 
>     qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 'double' changes value from 9223372036854775807 to 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
> 
> The warning will be enabled by default in clang 10. It is not
> available for clang <= 9.
> 
> The clamp is actually useless; @value is checked to be within
> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
> 
> While there, make the conversion from double to int64_t explicit.
> 
> Signed-off-by: Fangrui Song <i@maskray.me>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Patch split, commit message improved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

