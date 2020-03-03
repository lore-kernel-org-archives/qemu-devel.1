Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99094C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A04B2072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfeBj9e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A04B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9CST-000314-Kl
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CR1-0001Y5-Lw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CR0-0002lA-QX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:38:27 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9CR0-0002ku-Lk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:38:26 -0500
Received: by mail-pg1-x543.google.com with SMTP id m5so1953972pgg.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=k+7tOhEXwdjozauRtLq+EcVaLKO1erWvppheX1SzlHM=;
 b=MfeBj9e8VfYJaEHtFu3Ha+EjwE2bDlFu7jip1NyiferRvIVbebthIde7mRaBMJYR4s
 g/rcPOSu3cTuaGNDuWLwCP0OHueMhpIR+TmmxU7x6MAJ/VonAfgFF04T9V7QsWcloYN4
 vcklidFSbeff7YhK06v7qzD9tEGIpFMJG2v8tB6CRyRAI8sgmK51V1FtLsL6h+ToDABZ
 7gFx4/lE9v60WXwx74wzYyWXFXGXIPDyKL5EQM0uw4sNv+uowr9esj7HlyW3TzJNkVM1
 oy5B0XqZRLNCSUsaGmRzkL2n5hmcZuKA+45VCnIMdtrIhykqRIZ8G2lVeCMCT76Y5cTw
 c+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k+7tOhEXwdjozauRtLq+EcVaLKO1erWvppheX1SzlHM=;
 b=ATIdglWX/dgrAl/ISUXpPc67eZyUvotlByIocq+yF8DATQSyeMrhf0OF/q4/OxOgAg
 l5cGe2xgVNRYRgsZd+dui3zFz2JBLKSefmMNv+DWEQg2KJxXJH1+v9FGkpkjrh2FdSi+
 R55fN4/XyEI21Z63pPgvC57fXKJLAWg0Q8ilzY2x0i0EggCikxLhpLQW3yBYyyW42oPt
 sPvd9kG/r3P/AH1S3Mm4Ijj6cUzBJ3lzdWhBmA0WSMuAqXU1bvVdjVllD/6hVEik4qdV
 /Ud1Ai+MD5joOHoOlIEpna4Yp4QWcYgZODwfLyU2cIRJd3MrAqnDBtNxSlY2lzJbVhKu
 D0MA==
X-Gm-Message-State: ANhLgQ0dTnUQnVk54QdYszSG1phOrdK2/25ez49ECagnQBQvBabnHgPV
 M9gHubNVyn4nm/I2TY0ofMAQl4oqTuc=
X-Google-Smtp-Source: ADFU+vvwEc4DD0aChy3mBYZoKWMCmz3fPD9N7T59G/MOz853mC2v4uf5TGRmlf79i4PWcEtaw5js7A==
X-Received: by 2002:aa7:8545:: with SMTP id y5mr5475285pfn.185.1583260705381; 
 Tue, 03 Mar 2020 10:38:25 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c3sm25518463pfb.85.2020.03.03.10.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:38:24 -0800 (PST)
Subject: Re: [PATCH 4/4] target/arm: Fix some comment typos
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200303174950.3298-1-peter.maydell@linaro.org>
 <20200303174950.3298-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a61e270-7116-eb2e-7dd7-e847f56d9614@linaro.org>
Date: Tue, 3 Mar 2020 10:38:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174950.3298-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

On 3/3/20 9:49 AM, Peter Maydell wrote:
> Fix a couple of comment typos.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Noticed these while writing the other patches...
> ---
>  target/arm/helper.c    | 2 +-
>  target/arm/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

