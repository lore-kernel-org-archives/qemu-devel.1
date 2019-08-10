Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7088C31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 00:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DACF2166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 00:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5q7+dYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DACF2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwEta-0002Mw-PK
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 20:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hwEtB-0001s0-Tg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 20:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hwEtB-0003oO-09
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 20:05:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hwEtA-0003o6-Pc
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 20:05:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id w26so1587535pfq.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 17:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KuOmabyGayKaxdTh8IaiojNUoRqfmhsr1PHH3EYV+d4=;
 b=r5q7+dYYLIX0Vdl7lbg1ZZNbRhMdSgWp/GmIN/nGQ8Qpper3WuLjuOc1xAExaynogb
 jHvSt/0clHXfNF/gIbcTUzfM2CU+UM+A+HOnc29TjA/zt0BtWWecax/gCvnvCsEeietZ
 9Doc26lyU1INTiGO1vR63IUTudB0KqjfwpAVmdIZXcxGfuILuKPxy4fgk0jfaJc2QGTe
 j4Sgso+E20rwBthwR+Ezv7DuAI60aN6IrGP+EoTYlsoyFQrng37KvuN98msJAszdB3jd
 fZbBDIXbpdbMvsL1OdFrGw1aNGoAsVhBZ5sCY7LX31mY/L5iYeMBN6J+QnACDXnU1pHW
 jMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KuOmabyGayKaxdTh8IaiojNUoRqfmhsr1PHH3EYV+d4=;
 b=pczHa6BnjBHj3U7SQWwQVb49HfDqJicD/crVO9hruWfWqxr1e8uMPY8eQ7gJzYLhGQ
 wKlKkO0sHeHbjkBqDhRXGC2rqQiFovSqFIKeOQnwWYv3JisWN0eMcCBCVS7JR9LGK2ud
 DqG0MM+t+Bg73zFnHmzIebtx4vDjKQ4ZX0tUVi/qcnd+9FSezICA61r/DuFo1EmzrR2D
 2MIHxdYEg6tjk9KO6wb02tN6rsHF7h2dvanGUvtp/zxCoxxxO68Xj4WS8HRFWAtsZlG9
 c5LppOSUyLjfICTpDfY+Uv2MBBYpVlvGyLuiTeFPmKcUOTGX7hnzzxef54OsR29O/rep
 GN2A==
X-Gm-Message-State: APjAAAVuVdMEfdudm483FYE5SbSzwnzlEGlk5aksQss0x4KPUYH9gh0F
 mNKafN6tGCkixRaTYhYhawZPUg==
X-Google-Smtp-Source: APXvYqxc3l/K/l8KKQ7p7Rd3uqPpaor2OSBV0MARctmVeN5tTArpuv75M+sAdXAgOVTSIVawcfUDVQ==
X-Received: by 2002:a17:90a:9f46:: with SMTP id
 q6mr6749833pjv.110.1565395539309; 
 Fri, 09 Aug 2019 17:05:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y11sm107505702pfb.119.2019.08.09.17.05.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 17:05:38 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-b7c59cf4-b345-4805-897a-bf6a1c2c7c99@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b45b234d-d367-941e-cb61-1d2dc76725e1@linaro.org>
Date: Fri, 9 Aug 2019 17:05:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <mhng-b7c59cf4-b345-4805-897a-bf6a1c2c7c99@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 3/3] target/riscv: Remove redundant
 declaration pragmas
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 10:43 AM, Palmer Dabbelt wrote:
> Acked-by: Palmer Dabbelt <palmer@sifive.com>
> 
> I assume you're taking this along with the rest though your tree.

Yes, that was my plan.


r~

