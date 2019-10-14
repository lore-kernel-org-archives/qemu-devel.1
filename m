Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F10CECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA8120873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI4A41YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA8120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1d4-0006eA-1h
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK1ZZ-0002sG-0d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK1ZX-0008LL-Rd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:43:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK1ZX-0008JX-JK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:43:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id u12so8096032pls.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=paKtNlRZ7hmE9+8cTD9FyDY4OaDKN9g0GMkoc4hnIC8=;
 b=GI4A41YE/HjCzMYHfc2LeR35XbQmZ9TQbrHLUa7JATdtoRwTPU3KMI42GgSvhzf8wt
 +bSD45fUEtt2kYF9mKSthic0oUB1EX8CL5vljPdXbIJZhQ9DLjjztaIzV/9WpSIWC3Hl
 3ocHB+tzx8qXvWfY0q0eGDN9rLL74pwD100/G6AThSPvPJ9oIacnwB3ZWLz5pw2NK7lJ
 i/NpyU47O8oCDUVfmDAbVxdrypF/iCrx0krHIDgRnBnK/U/DsIo4pRZLc0vJ+X+8snxn
 rHWZhGTAcLqhepUyWmmMqO1s2b416DckLhIo46g5ypU7QzDYmIEAGKF5z6DpeR8Nzedx
 oIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=paKtNlRZ7hmE9+8cTD9FyDY4OaDKN9g0GMkoc4hnIC8=;
 b=QF88cARyUKmL2jNjVz4nO63tL+dQCt3UaRFHbfHtzJ5SPGnTwskx2yRxXIyw5o0jFI
 Eyyn77eQcnnX/lkx8THu5AS5mH2EDTlHP27PkIybkZ55W6mfcKw3dMzuwge7AtlikyRF
 SpFzuUO25FQCa0GxQogXG23Yw8BBOlXNlm4VzzqOTZEkZW+QYcE0ghjWn6+/B5L1dE4A
 mQnuK5DXLx8ZUEkE3FqWZrrk9ZCSPS0asvssAhGZRTYU3OBiGpmJ+l5RrhJ/c+w/y+BC
 sIqTO2wX80fo3pSeZMGvqGvM/9Z5mrWdCmJ5DSBeEh5af7GwV7jzgaj+vD/3wrKSP/hW
 jS8Q==
X-Gm-Message-State: APjAAAWknMvKPQiw/PZHtXHNISdu/aB2juFLhzWPgYAWOegtQ6yhY2z0
 mIHygxa2eHCck0QbevMrHtviLQ==
X-Google-Smtp-Source: APXvYqwCOkM/nBcL9/1gUWrmt0G62N8nbR6RX/X67wuXIM0Vfjuxqr8j4RI7DdfWU6Xm++PY2Ejz7A==
X-Received: by 2002:a17:902:22b:: with SMTP id 40mr88172plc.176.1571063750679; 
 Mon, 14 Oct 2019 07:35:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d10sm20994432pfh.8.2019.10.14.07.35.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 07:35:49 -0700 (PDT)
Subject: Re: [PATCH v5 01/55] trace: expand mem_info:size_shift to 4 bits
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <580c188d-8a80-4ed3-2559-e906a3c30ed9@linaro.org>
Date: Mon, 14 Oct 2019 07:35:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: robert.foley@futurewei.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, aaron@os.amperecomputing.com,
 peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:48 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This will allow us to trace 32k-long memory accesses (although our
> maximum is something like 256 bytes at the moment).
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: expanded to 3->4 bits]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>   - return the tweaks to mem-internal.h
> ---
>  trace-events         | 2 +-
>  trace/mem-internal.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

