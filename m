Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3337C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68DB20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJVK7Kbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68DB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAKZR-0001th-FX
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAKMr-0002oy-JV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAKMq-0004x5-GP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:46:33 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAKMq-0004uO-BB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:46:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id d22so2032135pll.7
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uQw5OJrvYCNNXPWj1yzUVyYhxJJIoxjlHlisR6JaWec=;
 b=AJVK7KbwC5IPF4lAb3tWKd64qOf9iQ/Yl5KI1L/cTOuCNs6iGmct+sTCPyNcnhcMv1
 gS/S0z5+9we+SKviIDac6rOesA+svRGnZAKZnMXMXnGtRzayaBKSL/2nXKhb7srqTckS
 FPE6eygzaS0Opct+Wt20NbaZhcyXzmemIb1vilsXIKg/PlfKJB2MM4ZU5E9/kqfBRaf3
 XFV4o83PCtcJEgeMWU1v+CebrBQ9TysI8KXAvlPZKUEGDrM41873ENL32SaOiuK8ayX9
 b8pJ/AkW89u/9/+w8WYWrBp6yeoed20SpAoUGIr9doQlsLuth3AZne+dXruOCmwWCqn8
 bd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uQw5OJrvYCNNXPWj1yzUVyYhxJJIoxjlHlisR6JaWec=;
 b=uGV08tvnKaCcWLopMAOuny/h2BzSEoid91MowkZdGvnob5bd6gEJFUw9sscc7r6+PR
 Yofxqx7DP0Wcd3a/oZ5418DMBpypPQh9i/8bb1jt6JOmGyBA2WdNt3CAAJy1QPzaVw3N
 Dsh6BEWWwCl+UjLkYgb/llQIsfkEhsMDBOqmlqPVmE+y9Arwo0CMR8IzwNXJbmnd0jGG
 XZIO7QWQfqdU6vP2EF0UGFoMB6a353k2dAVQFEWovLo1+891lYISgZZTAVmdPwGWSVoM
 GGWAtt+ZpPL2XPaADGlAvbfypsArrcKH1wgXuLsj5yWCcu441+GkAa82kEGmjdD2CIg9
 G1AQ==
X-Gm-Message-State: APjAAAU9yp6z/OD2fvewMymn5DcsL4Gm6OVZHc19u628mNs2EjBogCn0
 3KM2jBJXTyj+YI+EJ7RLXiuqgdIsrcN3Fw==
X-Google-Smtp-Source: APXvYqzfI7gDZj/TQmPDmMO5cYg2HkUWQJYxnyu2FNSwNviZUT0TFYeX473Q+43I0DboddqSKTBiNg==
X-Received: by 2002:a17:902:8c8a:: with SMTP id
 t10mr591941plo.109.1568753191249; 
 Tue, 17 Sep 2019 13:46:31 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v18sm2911537pgl.87.2019.09.17.13.46.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:46:30 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568653344-16881-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77049b6d-92cd-014f-6151-fb8dc4b032c9@linaro.org>
Date: Tue, 17 Sep 2019 13:46:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568653344-16881-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ppc: Add support for 'mffsce'
 instruction
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 1:02 PM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffsce' instruction.
> 
> 'mffsce' is identical to 'mffs', except that it also clears the exception
> enable bits in the FPSCR.
> 
> On CPUs without support for 'mffsce' (below ISA 3.0), the
> instruction will execute identically to 'mffs'.
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> v2: no changes.
> 
>  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
>  target/ppc/translate/fp-ops.inc.c  |  2 ++
>  2 files changed, 32 insertions(+)

Didn't I already give a
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for this?


r~

