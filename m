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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3691C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCDB217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLC5aqTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCDB217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TA5-0007fV-Lc
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2T9B-0007AG-5U
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2T9A-0000TG-3o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:31:56 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2T99-0000Sq-Tf
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:31:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so11903306pgc.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FYjy86ONKxyDAMQ7n2q8o/JpE+6tR1IVTvztWHKwYJc=;
 b=uLC5aqTkKrRTV/KNcXpBCRunTYt9FOUNqHOfzc5JArisE66UAmwDBA3j1LVfSFCQ50
 2DiTIULXoQdVgHuRbQKLEdw+430sNNH28lDSXzwq/gKo6WrDQR8+F4UwB4euSCESrFhJ
 gQe0VU4ShDAARyE6I6Ps907ypKfv1hiBzbbmJhBM6H0kpi+APq5uM8oO2th+xKsG+lUr
 gvyqsIl89cORT4Uc/WFtlvfMY2db4I6LTPoSy8ecavAsSRvyVbfiRhFQbUXv41cbibUP
 j1U2PAkyAJFkDOGZCkKRetBSPMtmqDWkcCsBmqbdqZElhzVlUtuAVGKBX+JBS/T/fXhj
 9uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FYjy86ONKxyDAMQ7n2q8o/JpE+6tR1IVTvztWHKwYJc=;
 b=PxmdkWuuq7E2BBo0smcvZ6VrbUu8j/bVa+0dFMMnUMbi5qkgby0SRyFBl5YcYm5qsg
 049DuQK8GD6aZNwAQvtLTvZqEqzZzSrQhT1YumX/ijHUlPkofUvK4w3JW+UopiNL7YUr
 CB+xAl3UDRxinFEnchXjQVZ5m/mFJtDgL0g8iAtu8gxgQXTx8Au6LCyDonvCKCHhUOi3
 FelqiFXrtBhI0Y6RiN5dDKcscT67jTd9dVLc1Vj0Peu6s46efpzcliXJ6tzIZybgG18d
 chRZi/SamLMMhp3n1I+eaMcPOJ0u9YthIdrhTo5kqrBKOVPS3P/thbKt1vLOwHvOuTC9
 Yodg==
X-Gm-Message-State: APjAAAXIhGTwltItDUNWn29EDJhUcvdlfUSow5x/gB2pOjioCUTSN8ZU
 B/KH1JNod92AMdRC9GZrOjg=
X-Google-Smtp-Source: APXvYqwi80YJGCue0SNkiV5wi75h5WUZBNcIZDgZatGcpH1ypBIdlPuw+ROil2Qj55bibKgDNQaUGg==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr19433892pgk.431.1566880314134; 
 Mon, 26 Aug 2019 21:31:54 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 a4sm14583743pfi.55.2019.08.26.21.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:31:53 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:31:51 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043151.GF24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 01/13] target/openrisc: Add DisasContext
 parameter to check_r0_write
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

On Mon, Aug 26, 2019 at 05:07:33PM -0700, Richard Henderson wrote:
> We will need this context in the next patch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

 

