Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B7C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9912067C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkbQgNg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9912067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0lM-0008OP-VN
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0kh-0007yS-Fl
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0kg-0007bM-C3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:58:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD0kg-0007YZ-4S
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:58:30 -0400
Received: by mail-pj1-x1041.google.com with SMTP id nu11so2280344pjb.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FOYnePfOZroSwWiU9+9xYCdY+xwg+fq7VM+eaNOh5AA=;
 b=EkbQgNg/6r8r8BaexZgXkC81RTy0zDe8IXsCISR7f7hNrDBFGdvqQIi+gYVbfvMujl
 TMR+Ut2v8FgCSxTH9Y3aAF/944C306MsIxtJyjGUR02HzOcKqcnlemeaTiS4Oo3wIFdi
 2DBqkfNblI3yV/df6J19B2aB9fbX4ws6Ae1I+dzGcIuCKnDaRPZdL+/YA+jmeNWqUlR2
 Re1LSlzZQcflWDieY4U0B/cNjz+Hk+h4Gru+LJodr5Ai1d+I+Mdd+uBlrMkyuTQYdg4l
 o+eQm8QeI27mHBAnptZ+d14AZkA/U4YtjwGWdTLuzQcVmoXi+amDstV/35RRNZi4SqHM
 H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FOYnePfOZroSwWiU9+9xYCdY+xwg+fq7VM+eaNOh5AA=;
 b=QShBUiB8yDYOi3hXiOw8GdFboGntu0VzuWBZLZE6WdGwVnGc4/9f7Fgj79ycMqyHUn
 MRQglvJLLetUij2hFclbZoRKHUfN3oPZKvo+mTIW05cte+Ngodqo45GvZ4NVjKON3KkD
 dNCp3DTC658mPbQ/OoPFTVGoNYKyxBVFcIHB1XRGfXdXcQQv0ELMdxnfSGRGTAr2Nx0z
 /F+1kU11Dh6xoCyklh6Abke6WCdKqqhbcIJdb8A34cQPQDyc85Ern9+tIqgsGaPH0lvT
 U9DOlX+NZW3LvfbvTiMRj7BN6JD9ovW8m3GogTG25t2esswlTHgYTJVnCinwSdKXf0J5
 ioVQ==
X-Gm-Message-State: ANhLgQ06cdOb5oYmh4lSFzWstaRSeM1H+lB71ETOMPQxu7uB3Tz2/ki3
 1BKZKvNAukNwlAlsaJ7sNjiOBw==
X-Google-Smtp-Source: ADFU+vvfdx1ZoYGTP0G5g31PpOsLz1vvgIMorga05IgGZfBijxUUF8MI/ieEkjOtdgMAYvAU/VYibQ==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id
 d21mr13825673pjw.27.1584169103556; 
 Fri, 13 Mar 2020 23:58:23 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m26sm13134137pgc.77.2020.03.13.23.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:58:22 -0700 (PDT)
Subject: Re: [PATCH v5 18/60] target/riscv: vector integer divide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-19-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ca87eef-19aa-eb01-c150-9ddbf5b02827@linaro.org>
Date: Fri, 13 Mar 2020 23:58:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-19-zhiwei_liu@c-sky.com>
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   | 33 +++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
>  target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
>  4 files changed, 125 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


