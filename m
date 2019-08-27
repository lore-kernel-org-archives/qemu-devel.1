Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34FFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93A321872
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1e6orx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TEs-0002lG-KT
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TAe-0008Iz-FX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TAd-00010z-Ca
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:33:28 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TAd-00010b-6w
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:33:27 -0400
Received: by mail-pf1-x443.google.com with SMTP id w2so13254614pfi.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7gTt3/gVPOsWwnwWxSBRpBhAFfVeYOpEluck8DqlXuE=;
 b=P1e6orx54C4mWsRkwHExuk9e9/qBi9eQizE8lb5auKdxV/6cGkKDJyEBla6vhGGsEt
 zXR3tZySuqgyAIjp/OyvHtVzsLljDzaRv+loLilrwY2cCzZAWJzQLCm8zSu+7HL1hJ2J
 Zrhufv1dgViwBC4zqsuKFPI6Oawx6K6fu7w7rPcPxPXFn0jbWgpA3TOp+eoxh95eHN56
 RK8Cq5GRU1ImMqTwkq95FQeiTCxsgNekzhRdo6pcgKZQ5JhXMVcKTAWv6zVzH3ydv97N
 eUuJzIRXDWt5KzAJ7mL8aGBoe8IW8BqKhZwQaS6tTUDglyzei4tNb8QSRmJOfXJOt6XK
 1j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7gTt3/gVPOsWwnwWxSBRpBhAFfVeYOpEluck8DqlXuE=;
 b=Z2ZustMxAhNWfbQ451XlWUMowlLcSkoLpX+1equRKiKiojkFe9pGQvNmiuzzuW+4m0
 hWiZjeZsT6s7qP/nKmUuZyq2tIugdkrp7f3KHGpXo8UMavML11QDljZyyCgWO9c5JGxZ
 kiFEfQ103kov6VQPO86jMPzt4gKYqEFJdajmbP+rtThU2BRTMsWcjHHl6SQVeDZEhnh1
 roNuBDL2m1h8Ymy5UJdpgdMZefiNMKqLY7NMCK6hnZnrfPF8W6iLKXdFJNUuLPEynZqt
 puU3gFw2sqZ2cTGhpzuwX5donxHRVoBaUe+6729DigaIRe1uwDRAMqWwuQl2bEgsScZO
 ekeA==
X-Gm-Message-State: APjAAAWc2ac6Czm+sRaGT4IZjUkDc271eHDakU09m21x0JOlHpN+V2z5
 6YwC0NG6CiXtbYzcybf3yrP73IZ6
X-Google-Smtp-Source: APXvYqw7d38n5kota04YO6w5v6h0oY690tj7CGwoYfdtE55zeuM4YYmJ5iN7ZoQqnhL8YbgQgNm94A==
X-Received: by 2002:a63:de07:: with SMTP id f7mr9452010pgg.213.1566880405913; 
 Mon, 26 Aug 2019 21:33:25 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 v66sm20618516pfv.79.2019.08.26.21.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:33:25 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:33:23 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043323.GI24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-5-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 04/13] target/openrisc: Make VR and PPC
 read-only
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 05:07:36PM -0700, Richard Henderson wrote:
> These SPRs are read-only.  The writes can simply be ignored,
> as we already do for other read-only (or missing) registers.
> There is no reason to mask the value in env->vr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

