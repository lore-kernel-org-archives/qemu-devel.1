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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F047C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A07B2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSWN3+oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TCY-00013f-6S
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TA7-00082d-AC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TA6-0000pp-EY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:32:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TA6-0000pd-8o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:32:54 -0400
Received: by mail-pg1-x543.google.com with SMTP id e11so11891201pga.5
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8NmA8Q1+89tPYw2sZCFOrJl5qw3W/Le0NdVzuajMIzw=;
 b=mSWN3+oNSzRtrjLHEo3RdMf6bNpP03pqTauT7K5AdF6MaqeFk1GIXolnTJSFKU3lP8
 x4Aue+5xiaMJ5mbdf0C5D6rIMyLZg2Vd7VER/U0Aa7x3nLdL/wKbDyeo33w5PG4Oq+Ww
 MlpEHAnMPT8r5IDfV2+R37o1uleQCgH/ctC+f+76Y6TumI71Fg30spRzOY3kmNoU2ipZ
 OpNFduV9dKTvSd+zIZa9AvYHLpxw7pM1crC7KMnVOuzGTPnj6CcjtW+V2OxY5AXUUx0s
 CYNzk+cepNYhiAEM1C60vyOaYGr53YtzRuHaqSNuZ2/a7gS3Gh003cluGJJvndMli+Xb
 rK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8NmA8Q1+89tPYw2sZCFOrJl5qw3W/Le0NdVzuajMIzw=;
 b=SuZK6Y302xRCaVdIAUW5hiJYrUtuB+/dqgwE8H0RWAoYvEawZkT42gqEq+0+CSn6X1
 bhPG+WbZWqR+bIUwAS4yd/YLO7Lb+D7PU1N0aHYZr4OzX6lPtfI3eyaeSHkIJeyinxlM
 GBByBT0j6PTO4JwdbTXgwOFCShLbta+kKobnKwjck3QKUO2kde6xJlcvbc7CKsnkDgB2
 4iUUVc43qXmkzkGMiRnMb4We71I7tBU7S9g8rV4EdKHxa2Ae/1Tzgz6VBzG+sJLgsaSa
 FQDNDoYW8TmfuPA+OwTULRJgwE3FmmndkfA0/VpIMYJnr9ba1a2A9G+UTzeSJiXMiges
 Fs2g==
X-Gm-Message-State: APjAAAVn1g6dUc+vct7kSTNcnBmZWEhunJaPZPLZaAq9LWdFpvZ+fjT3
 hP5pAQPrw48Soln/J2UY/Dg=
X-Google-Smtp-Source: APXvYqz4N2uwgAE53WLPosW7J1maFUV2j0hlZqop4Jrnrkk6ptJv7gDnRHRfVY/xnVVIEcRP7IfllA==
X-Received: by 2002:a17:90a:b393:: with SMTP id
 e19mr7418097pjr.118.1566880373357; 
 Mon, 26 Aug 2019 21:32:53 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 e189sm12122304pgc.15.2019.08.26.21.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:32:52 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:32:50 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043250.GH24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-3-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 02/13] target/openrisc: Replace cpu
 register array with a function
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

On Mon, Aug 26, 2019 at 05:07:34PM -0700, Richard Henderson wrote:
> The writes to cpu_R[0] are now a race across threads, now that we
> do code generation in parallel.  Stage the change by introducing
> a function to return the temp for R0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
 

