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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C2C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2A62070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMylPGzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2A62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TKt-0008QS-Jp
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TIs-000762-Bk
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TIr-0004ZQ-FX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:41:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TIr-0004ZG-AE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:41:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id l21so11903116pgm.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rnbUqtrET0mEwZKK3nZaQC+mnCf7Kc7qMkhgYjo+EZY=;
 b=EMylPGzDfWjqTb0IQEU/K+J7HsO0W/3+bt9zstWcHMIDwcQM769v69AL6fGMx58PkG
 pmInMUEm7XEsYqIudkGSMy/RCdy0TQA74p9pxO2GWrkQvaXfMSt5hX7MgIbI8E/S2+cU
 kI47zP0U8LWjpyl846SoSewgL0w3ZtNg4lg2TsRttCVIVn+YBn2dbHLrYduH+XzeWbiJ
 bfqXVZMK1vGIcKZsUN9VyS6NAB3aFWfGlZYfXClbhUQy4LhcKZAqWRX70UC24dSJm/wV
 dus9/G5y8x7xtODG30GN+nG/0EfQR+YCfJWjRG2hJ+ynDWWr/MuJph1xFz2NnKErcxvx
 Mg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rnbUqtrET0mEwZKK3nZaQC+mnCf7Kc7qMkhgYjo+EZY=;
 b=lKb4Zwn+dcsNjvd3CVZWIRG+torj8byN6jNAMrLuR3uL+e5kR4hG/nzyJz5yTyxGtv
 IHCTXUZR20+mwi9xARXfOJx0Yle8G7oSBD8d4ZBjT1EdVWtvJOYngVyC3bS52YP+Wx5a
 Eqz+tRNfWgX32LkL0R1TPK/GLLxk2RNmUNci/AvCr9tRXPjrihYM6Wugm8nYqJ830Urv
 mueMBXIvUEemKZtks8XrKVTbHN+fwe8z2eRe3KyYQrOJYiaTbRAQBPCa5T2CRTSe37fz
 oCCcMn+qBsc80cJFvZFQy78twz27jnH74bQy8u5LgDIvGGPky31f1TipZ+C9gNDr11qM
 vtwA==
X-Gm-Message-State: APjAAAV95Tc81N11Zfg7u04VdNhRUOnGxX7v1ieQLY91JnKUYEg6Of/6
 UpL2RmcJJzhGchEBfwy5i1wjssHN
X-Google-Smtp-Source: APXvYqwgXu7+fSSdpuBAqupzUa0xd1X6GWFZ5Ag588xdRjQSc1UzXrt8TqDskZZd65G1rFw1XHbSng==
X-Received: by 2002:a62:db43:: with SMTP id f64mr24910895pfg.38.1566880916429; 
 Mon, 26 Aug 2019 21:41:56 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 i14sm14470287pfq.77.2019.08.26.21.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:41:55 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:41:54 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827044154.GO24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-11-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 10/13] target/openrisc: Implement unordered
 fp comparisons
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

On Mon, Aug 26, 2019 at 05:07:42PM -0700, Richard Henderson wrote:
> These were added to the 1.3 spec.  For OF32S, validate AVR.
> But OF64A32 is itself new to 1.3 so no extra check needed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
 

