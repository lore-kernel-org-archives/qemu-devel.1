Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E43C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7B720873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9BTsaiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7B720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4RS-0007vU-E4
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3Y0-0003DC-Gv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3Xz-0001jo-E8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:50:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3Xz-0001jN-8y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:50:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id v4so10715534pff.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IBczEhJjYAWoJQ5WPXJZ87dpbU/WFLhab4iUN74E6hI=;
 b=U9BTsaiI6S9oXp7J8Rm34pGMSs5gyCPb5f05i/G0zQtkBIR9pDVNFTRhpPH/Sgtfcl
 muaAfaOKSh6yi6njOsogevwDXegIGREPc3TxC9Lg6AncPf2OUsqh1e6xzqs+tg4aZgUi
 xTJfcXVce8bpznT8R2L6ddmQPV7xG3ZlDSkAxoVS90dSbvNy4vQidsrG0xV7plFf4gzD
 dHgeUsGQ8b4AOodHjJxGDN75gDs9yf0ws2o+CEy/h75rtdqGKqSHIqThhFygvEvDH6xl
 wfQxyChYU5FCHZIhonWT3eYnGOsFAKUiPamGFjDKvxAkrK1cYHKBWZY9qar5Q1YrG78s
 eVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IBczEhJjYAWoJQ5WPXJZ87dpbU/WFLhab4iUN74E6hI=;
 b=aywJNYxCsoWJOOILfXCgiKw97rYt1rBmgS+rO3huy5M3Jh7X/B+EYU9j5P7S0wW3Xj
 xLVfbpEeClg03/yTTRgXFuf/eLh6f/dXFwb2/EQmdY7zGVEsJa7M+9rQ3+I4zy1hW4C9
 2I6IXau14b4KpD9ycafxlSqjFs1Q7qcH11ggK6RPIDnQutMhzv9o1vA8MFNy9yjv6p5P
 N5tUHBYXSSeGvZ6/+xR9+mayVKTR94NLDThRhTXs1L+11izrhV5S4obLvbZvGWHTfqP1
 X2gvQ4EQkG0gtPEsMeV9EOhPVFdxeQxo5cYVAe7jRiQyQwiq/DYr14bc+a5RHcv6N10T
 oDAQ==
X-Gm-Message-State: APjAAAWgIFFfP3xtodqd+oabgs9nLP9nOm/YvZcdNbSVdjGOFvW9gLLM
 qESHFhwK7d5OVw+/D0rA0qQIAA==
X-Google-Smtp-Source: APXvYqx+ZUkHom0tTa+4aabwQm11TIA7IMOQoc0gqa3iVaZp/OlGWf/oTuU+nX5rOWOV318WZ2wgDg==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id
 q39mr37235916pjq.119.1571071814177; 
 Mon, 14 Oct 2019 09:50:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v8sm50142650pje.6.2019.10.14.09.50.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:50:13 -0700 (PDT)
Subject: Re: [PATCH v5 47/55] tests/plugin: add instruction execution breakdown
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-48-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <de62b79e-0ba6-739f-6478-eda7c3c126ea@linaro.org>
Date: Mon, 14 Oct 2019 09:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-48-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, robert.foley@futurewei.com,
 peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> This gives a break down of instruction classes and individual
> instruction types.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>   - add a bitmap guide to the comment ;-)
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


