Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C75C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C705820730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAPegndC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C705820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfEJ-0001aU-Vu
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfDP-0008Nc-Ix
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfDO-0001wt-Ei
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:20:59 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfDO-0001tT-8N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:20:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id w15so6682929wru.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DUVPfj0Doeo1oaIiHPJS4+xEoCsIB4ACDpNMnv0yaWE=;
 b=QAPegndCpsbpg/ghhVdB9yR33j9mH+HN+jItd66lg8uQPS7G6zU0wVVv4xCOvq0xyP
 dvOWp1RwR+yUREY4b4LJRIlRGw127M6D5P2G+Z51x7f0wWrOfwZHb6MN9X1a8YBEcfrc
 En+MD2M7qcSkTYBF3rIPympL8zHRVcEiOhjgB6rgRh/TqXFEMinxpLkc+8ep5sObs4dF
 DHsWHZSxVQAMBK4H9OrUTYrXGy4qJVSwxrFy713xqwkp80vhvqGCIsjmsCTvUAhmuyem
 tfoduSgX8oEELTh1DPX7IPMNt7IDTfElsId6dTkdvoPtzNTSH5xZ48ssaklagVXoCC6w
 KbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DUVPfj0Doeo1oaIiHPJS4+xEoCsIB4ACDpNMnv0yaWE=;
 b=lUyyqoiAZiWKSh6iUii5NzMFHuI6VP9ln9Md0hHAhlED16uynwwsmw4GM7F5Kg36Ql
 pQP9h4GhG/b6Kqd1i/bGAdW6xvMoM4MlDHKfdcG/j+uN1zOxCTy8MFNzl8yqEZOcW4I0
 WlhXMZmS/HC+02jeL5b+HtbxF4Me7cOl+5/KmuiH0TZngpLjfjVpYwWYa6dfKE2DDYSR
 7hhy9+vgoYwpGMqZVy8hd1kVUZeHfb6ceGqPmQMOK9NlXCzFzOS3ZCAb1b3My9ASDZyi
 tgQc7YZACeqy8eXV+cjDtTRQxl7Gr6CuzrYIsTAJswsThaY4jdsXg9jQpuOkwpqs9RKI
 prlQ==
X-Gm-Message-State: APjAAAX2cgfkO2XoT+pGa7DM9pNAojZu7kn3cWfcHYeSxbdgaz6W/6b4
 Aj8DVbfoa/602jVrGlrq7cMotQ==
X-Google-Smtp-Source: APXvYqw+UUklzJNwoTL4FxDiA37aoKExeHFoItXJou+3HUojmICWQk5tJ+rr9UW/kQaM7mL9cLAzHA==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr3302102wrn.245.1580988057130; 
 Thu, 06 Feb 2020 03:20:57 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id x7sm3720499wrq.41.2020.02.06.03.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:20:56 -0800 (PST)
Subject: Re: [PATCH v6 13/22] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200205171031.22582-1-alex.bennee@linaro.org>
 <20200205171031.22582-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e13f013-b251-aa65-ff11-2c981ac0c965@linaro.org>
Date: Thu, 6 Feb 2020 11:20:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205171031.22582-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:10 PM, Alex Bennée wrote:
> +    case 51:
> +        return gdb_get_reg32(buf,
> +                             sve_zcr_len_for_el(env, arm_current_el(env)) + 1);

vg = vq * 2.  Need the multiplication here.


r~

