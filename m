Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E1C35E0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E9B2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrLaYGnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E9B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6gFo-0002dR-RG
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 14:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6gEx-0001z5-KZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6gEv-0000uM-Q3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:51:35 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6gEv-0000sO-H5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:51:33 -0500
Received: by mail-pj1-x1041.google.com with SMTP id q39so178314pjc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=wyVwMB/hyLoVg+u9AXLbRa2eBAo6y6nrIkdsAOfvrik=;
 b=lrLaYGnSIgq8sIB4JXDWrZpafaD1jGeyBJwUq2IfpUFEkjMh/cKi0FTw2CMnLrS4Td
 oj/h08ljYX4IGZMhfLakrUZ0BBUf9VVRH+UjhtGGFBH6h2/TPY8i4vVQcMUdDhXtq37p
 IDJnEtCiM1nEdrCIHpdKAVnBG37R3zCRAt9mll1xf7saJ5Rwd+TFCZafzGMcFsx7Fjbj
 EPJg1r1xyesYaPov8cTQ6cJ0nGUU8YKCHznUe/AchAOAr01It+dIp6UHI1pFvowaBufu
 6Wg+F34+7C0ZL/O0UDsNZ42E6Vud3ZqWLcDvG7OSNgEI93XrRqegp2WXJ9+zhPJutjAS
 1qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wyVwMB/hyLoVg+u9AXLbRa2eBAo6y6nrIkdsAOfvrik=;
 b=OLBUWOmMJfZoW3vqsTaPUKUJ5pthaFWXtRPcnzZvwr+YoVC6s6zhitGfSiq0YBw8ld
 9ZbGLp8VwpzvvNEJ011kHS7G30fHUGBoYMbjaVmTrwM5E2UqrzcQoE3UnN5B0HhG2VdW
 fpTHBbG+1wwO5uzj7aYsW87ACmP6UtEgaB7nQX6Dyn3mQkBI+ajroV5ndLkSNbfwWR7v
 OxidAjIFreBJtOg6rhnN8JIIPCPTujllt16cwxWzzUg4iIdOIiht2MlYOnRDw+3HuFA4
 suLZbRPfPgUZPujgMHILdHGugwzSAfQ66FFV73eW4qr965cjljvzJBubEdszxhhjZnNT
 9StA==
X-Gm-Message-State: APjAAAWp6z+cQ3HuhL3Fryn2zEplhgGo0pfRtITpjhl/uNdRF8uSOSKw
 Xv5JR3DYK/5UNIazPd2szL6I/VkwMGk=
X-Google-Smtp-Source: APXvYqwWjLJrhG6xJqsl4pdbv8TqUVVN1/cfDOWISizqKuDLsVCL6GX4J/IGOnF25oYUqwMhm/cuEg==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr693705pjw.3.1582660291488; 
 Tue, 25 Feb 2020 11:51:31 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y15sm17431225pgj.78.2020.02.25.11.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 11:51:30 -0800 (PST)
Subject: Re: [PATCH] target/arm: Implement (trivially) ARMv8.2-TTCNP
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200225193822.18874-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db9612a7-9354-2357-9083-1d923b4d11e1@linaro.org>
Date: Tue, 25 Feb 2020 11:51:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225193822.18874-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 11:38 AM, Peter Maydell wrote:
> @@ -705,6 +706,7 @@ static void aarch64_max_initfn(Object *obj)
>  
>          u = cpu->isar.id_mmfr4;
>          u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> +        t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
>          cpu->isar.id_mmfr4 = u;

s/t/u/g

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

