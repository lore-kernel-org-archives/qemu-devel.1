Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E17C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED612074A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNnoMf+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED612074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMXe-0007Re-Ta
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:40:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMWf-0006Ol-TF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMWf-0007Xh-Aq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:39:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMWe-0007QB-T1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:39:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id o185so4030657pgo.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9Lfb6fl65+m9OpZgd0SnqULuyiqYMXw+U6I2a5N+7EU=;
 b=TNnoMf+Eo0W2Wr9DzH9GR5eyz/OSeJeZ+w68bNqAbkeIXx/VOK1AH6r4W2m8afgwtw
 9dgm5jqDDM+woimFpZBSo7AO1bCSdgQMSBtqHZiK2VjB2kiB1czIde6DjP1ov/QQAGho
 zHFmVtoy12rBaUCPRsRMUhdGrAma2F82IdYO+V+XwvsahTFpWupdDIIKxxV7aQ67/BiT
 Pt5vdlsyAl4YLVc/QJ3vD55hA4lQFUaZL2QYJQeV0sgzLreDBn7G74YcTC/U0OwRAvRO
 OA2cG1P9HT+H77ehZ3SapVbw17FURBSwn6i9HxxZGofee+JqUpv9l3JiMrJQhtvQ2qxx
 KWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Lfb6fl65+m9OpZgd0SnqULuyiqYMXw+U6I2a5N+7EU=;
 b=VNMuBsRrluDyM9ONdt8DzaJT0BdbfIHJbuY1F11TTGCog0cab2HjTq9HbSubmiFbZA
 +g2mlV0qST5euSG0CVhzw6cdB3DlPqeEBVxf7VegXI0OySX5izT+ImPJVfnhMNA37rtz
 f/PqXaee+0obPdH09O3qMWR79ULcmypj/0zsOGikRXRXPRTNC7rIKlMcy9njGsKuW/w5
 JwH5yBj3Da2SDnu/5k7bb42sRawHGOsACvrR61Pk0ALvYGBSVrmfE5CyTQMxT7xXFPV+
 XoyoRvstArWMJgdRQVt43NodurdS9oa+1vb0WUi2uhF/TplFF1h4ZRAYiQe41+y06CQc
 ijMg==
X-Gm-Message-State: AGi0PuaSkI8qp95KoHU6oqcIMLeJDHvT4d9o+y3HGgNVHJRJKo3OfwBv
 t3aRvr2Zx6AbyAEiTwIIQcPli69AyBs=
X-Google-Smtp-Source: APiQypKRpPpxswhu+Th9BR9KlmNzjc8rLmgpTiyw03e3ICKhhRXBTd4VwwLnSdp8b6ZyfFsggqpoSw==
X-Received: by 2002:a63:1d46:: with SMTP id d6mr2361300pgm.236.1588304382464; 
 Thu, 30 Apr 2020 20:39:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g10sm1013012pfk.103.2020.04.30.20.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 20:39:41 -0700 (PDT)
Subject: Re: [PATCH 29/36] target/arm: Convert Neon VPADD 3-reg-same insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-30-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d278d90c-7f2f-d886-7c0c-2d46e10ce1ef@linaro.org>
Date: Thu, 30 Apr 2020 20:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon integer VPADD 3-reg-same insns to decodetree.  These
> are 'pairwise' operations.  (Note that VQRDMLAH, which shares the
> same primary opcode but has U=1, has already been converted.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  2 ++
>  target/arm/translate.c          | 19 +------------------
>  target/arm/neon-dp.decode       |  2 ++
>  3 files changed, 5 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

