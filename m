Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20592C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D817320881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ermIpKER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D817320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibaWm-0003zN-1t
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 20:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibaVn-0003U3-4m
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibaVl-0004Eb-UC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:28:26 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibaVl-0004EF-OU
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:28:25 -0500
Received: by mail-pf1-x443.google.com with SMTP id y206so9016697pfb.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6nY3XtNRl8CoTJCpgstxdfnul0aq7KhZZJ0PhEJkkyw=;
 b=ermIpKERYD51MTG1bed+6/HjIoumZTJcpH46vRGpblTobaEv5DsaRWqqJjkJYp+65q
 l87vPNlzGH51l9OG9AGFytJ2iMLXOUuaKVC856Px04+JqyLVbRcuLpkTpNe3SIfoooOM
 3aX+Fl5Qa1WfYnudcVHXaO4vEUclJ3Z+oVKurv7X4vt945ZV4BEARaZj1Tb7H5oipWF4
 wqIbd3vBleQXdwXjMHYmQ2j+r3wzLlmEjjgd9ONcxeQWlUgDrx+mmZUmYKjHfGKinhyc
 eVhw4LM6QviTmXix0UqQkntL3o3JzSVcAdWvjKs91Hw58CRYl468oDBStYXGyKgE0NIq
 CqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6nY3XtNRl8CoTJCpgstxdfnul0aq7KhZZJ0PhEJkkyw=;
 b=Jtz+L2DaaYVCScun25Bevvz60TENh2/DyvhP+OLcBZx7PBGxBuq2jpkIkAKzLZ40mw
 PjSffmNQ6PsG3l26AKu0e/tiCDc/sLmtfLLW1kDg1jbiKh/w0vMQjEad9lKdyIGorEBO
 nVuiiByDuQISbkl7hLG5ILTCsYAah3KySdkVKq6sbnEiTBBC6Lt5U8hXrK2uH08f5dux
 XfNnUeeQuCM0EKpERmCyRW+yLawdBxah/3sEuxOfhsZr8TzRLaedqvBuRI128jSKm9oa
 Q7jc3IdJPgeUxtIBMxfi9QNSU2MT+HfJC6U+giSnAz4KBgAh7IinREpB1HmnNAI5aUq+
 6ETA==
X-Gm-Message-State: APjAAAUXnFV5yBkDFY//QSA/cMUeN/+8IH7UdeuFcUR15XyoMz4zxy/K
 L4UjM5p6e1FoDRPb5bx0YVLo6g==
X-Google-Smtp-Source: APXvYqwpYbjEFHLv3hFJ/W7HprVy14wZWR/kt9DYNJKbl8FWfzKaJWMeHWLnmukJI2EFss5VFtypSg==
X-Received: by 2002:a63:e14a:: with SMTP id h10mr28307060pgk.74.1575250104701; 
 Sun, 01 Dec 2019 17:28:24 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u9sm32168654pfm.102.2019.12.01.17.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 17:28:24 -0800 (PST)
Subject: Re: [PATCH v1 5/5] linux-user: convert target_munmap debug to a
 tracepoint
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191128194603.24818-1-alex.bennee@linaro.org>
 <20191128194603.24818-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d038735-556a-1977-6011-f633c5da8309@linaro.org>
Date: Sun, 1 Dec 2019 17:28:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128194603.24818-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 7:46 PM, Alex Bennée wrote:
> Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
> last remanents of the #ifdef hackery.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/mmap.c       | 9 ++-------
>  linux-user/trace-events | 1 +
>  2 files changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


