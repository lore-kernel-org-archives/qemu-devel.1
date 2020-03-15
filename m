Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09537C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C792F205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOUB3kik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C792F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDNoX-00088D-Rm
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 03:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNnH-0007cD-Lm
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNnG-0000n3-Gc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:34:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDNnG-0000fw-8T
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:34:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id w65so7967862pfb.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UcVIDaZFTGg8yD62yteC6TS+hauFRwqPFO8BBLmGTuU=;
 b=eOUB3kik56bFncRNsgORN/9sDXwAs8MZqUzZD7SX1pI9vkBAJBOFvICaYs7JJnNCsS
 LRcr9ht75Uar2qy7nXjEG9YIGmBmz5DEuSDrnK63T1Y6SzwUs6WLJUgiV9A+hVcH5b7M
 tT0MsMFqZ3saI0XT8P4Os3v1+bOdqF9MewTlrjDCRXnUtT0IowAMHVn4HYktbkLEQ0DR
 MCzTq21WkCIZGap6zWOMinqfWfue/hXPUhisrnV3lygHF4zoBjAeUd+591eazucce1w1
 qqjqLOeR1jUz6LXohqvkq492msUIiQ6/qBcEoaY8ENFx2Q2rJ+LyJGp/Ed8X24HV/5W5
 Rzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UcVIDaZFTGg8yD62yteC6TS+hauFRwqPFO8BBLmGTuU=;
 b=k3G6lyTylLzHtFWGBqe9ZmUDjnOU78DZ5EuDwDQuDaxJXKjb/OdueXb+WlvNUacIDX
 UkNz6r8MTy31yBgmYdovIy8EMMPqzdKmMX/2mU1E+uEsoo757H1GXVBMwojFc7Rhw22Z
 QLrIxuajJUEz/zAzoVMC1B9T1bJ+1f+qoFC6C2WttOJOXGsLX4sRyL1bS1PsILmKkSe9
 f2cLwfyGlVmkUjviBw1DJY/L0dNu8aWDjiIOmT4ExUxLdBkD/IPOtzWZINqvgDjFwnyD
 3pQFTNqxBVk0wxAshywOcp4nRaYqrP7HTS72bbM5I/ecO7PEqhnacfB4v97wFatg/ALb
 HHVg==
X-Gm-Message-State: ANhLgQ01s6X2uas5DUGafwe/SXXTZS3sVzrHaygxBdiNQD8JVIW7EZwD
 5qVDRKFDArFyQJQpiw1jSkgEYw==
X-Google-Smtp-Source: ADFU+vs7Wrmbcy3Dcuc30/sZV5nyyNA7J4WjfdVsXLc3jthRJjMIXcJbkhlpl4NGYlVdGywq+8BikA==
X-Received: by 2002:a62:2ad0:: with SMTP id q199mr23343148pfq.48.1584257681050; 
 Sun, 15 Mar 2020 00:34:41 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 19sm23983161pgx.63.2020.03.15.00.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 00:34:40 -0700 (PDT)
Subject: Re: [PATCH v5 59/60] target/riscv: vector compress instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7b6a820-1ca9-f895-4599-f306d4ceaae1@linaro.org>
Date: Sun, 15 Mar 2020 00:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ The patch didn't make it to the list, so reviewing

https://github.com/romanheros/qemu/commit/f46b8c8bbbf0acd78746a49fe712306d7c05c7e6
]

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

