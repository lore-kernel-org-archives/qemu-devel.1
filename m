Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3314C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A15C22BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlIUCoNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A15C22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiU2-0004gy-Py
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hqiTr-0004In-2D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hqiTp-0002zh-Ev
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:28:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hqiTp-0002zI-8O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:28:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so23738270plt.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sCb2ZySoaBwzNGL5Y7EZmLryLmi+dhTHRUYv4xnU3/A=;
 b=vlIUCoNKfaD4NxCHCaP3s5ZBQKDlgs+XDU/2SkKz0KA1Y/GuALHy+TsTYCu6FGc8SI
 MgbQGYCquqsO8xQ6raFNc5OkeWuCgN2clHgDRwMrRgFOjUBuUfEz6oa2/kJr9rxluiPP
 RDZ4wnEV1WobeDBDp8W3LwjVjvfrpIg5xnVGqW/bcoP28n+3W3jBd00gXvcl+9ktd1L8
 eWFBRXd+6VUBXf5JoQWVIIpX+4LueBXYAkJlSVsMLXd465U9qknMmH5LmkAQSHi+9uZg
 +8YsmutYydP33XaBws96gsLxWH1ryZLkOQx7Y+6SiRLR/Iu19eLUaGIavKj94umQPS0j
 toYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sCb2ZySoaBwzNGL5Y7EZmLryLmi+dhTHRUYv4xnU3/A=;
 b=rw10qrYsXGSAuTGbu6ZhsSc8Vvbl15l1tVfyZeuvFLX6jwAcIOZF4EjH3MmBmQL3DI
 VvTkTELFNjtwBrgY1gG4t4KU+chhW1lJ1jCc4bhP1GbKfGz3yAWtRXFrb9TX5Oc9O1Hr
 5ibpDHMSOcN5vSmtzo9vuxa9zMxxTLxpsWmO9GixZxWU9SAVbFN9QZ1XYmajF2P2+JUv
 vnch8vrLP5grpY7xtJn/z6BjigaJa2tfCfS8iKQA+LG03UPSypAHA2aF4GHsf7uNi7Gg
 6tAxazcV2ZuqDtT2sguoJ7JcxrGWVXtXK/QPveuwpxSt5W4k5PwcrD2YwMp8meyKAFwt
 kqZg==
X-Gm-Message-State: APjAAAWBnckFbPxD35vBJs/qH0Z2vZGFbYsi4+kIK3H36xfbb+sKPemE
 EMNZSmAd1QFN/67+f9z5/z7BVg==
X-Google-Smtp-Source: APXvYqyzmnLSTtRMNCupKoviBxbdfeHRXK07ycbPnWbEOp3sE9/6jhYzKoUfsfia5ZAYZvfS3azdTw==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr91483370plc.2.1564079320012; 
 Thu, 25 Jul 2019 11:28:40 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id v63sm52360799pfv.174.2019.07.25.11.28.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 11:28:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-17-richard.henderson@linaro.org>
 <87v9vqyuji.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <679a72f9-55ef-8e21-dbdd-07f2598000c3@linaro.org>
Date: Thu, 25 Jul 2019 11:28:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9vqyuji.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH for-4.2 16/24] target/arm: Add
 regime_has_2_ranges
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 8:59 AM, Alex Bennée wrote:
> Can you elucidate what we mean by having 2 ranges?

Both positive and negative virtual addresses, with the hole in the middle,
controlled by two translation tables.

In the current (E.a) manual, see D.5.2.1 page D5-2516, in the (sub-)section
titled "About address translation and supported input address ranges".  It is
summarized in table D5-1.


r~

