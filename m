Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C67EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260BF2067B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="AXOSJLjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260BF2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcamt-0002CQ-Cm
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcaly-0001Lu-QR
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:29:35 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcaly-0004A7-6o
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:29:34 -0400
Received: by mail-qt1-x844.google.com with SMTP id m44so11122504qtm.8
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tK3EAXKMZYGQzGAccHzfYD98mQ3z8greaYJzCGG2jx4=;
 b=AXOSJLjLF5HjiPwGo9sILT/IWlXvb7mSpdHSLde4zkiabsNe5BfIstzyp5H4CNLnut
 o1dStn/Tz35kGw7yyKoKOKoZ8aiw4XeAcigIC6ngiQLxSxxdfmxQwT41Saqll72A0EMH
 P9YoI49cq3mFTP1pnH0xlgtL/FgAwLmhu6Fem4pE+5O1WO3fS7M+zg8NIhoXEeSWq9JP
 r2uLKaLvGC7fCB+BJLU/Hafx7uXLTd9N8lozGd9PAS5b1k2GgpufKKidIh0I0+hbHuTm
 YIJJyEmxqIywAOAFtRXq/nMszCl1umhSOgYDIl52MMMN0X2rhmZ/x9Agmlas/yGBt5t1
 pdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tK3EAXKMZYGQzGAccHzfYD98mQ3z8greaYJzCGG2jx4=;
 b=iOXAi3uig+JZkw6pdyiKHhi00ifsD8B7YH8ZuHsouIC40wAstRKErg9Blvm6a+II3s
 G8RLTpt1YZPH+/yyF/Ak5zpbdDcmB9dCCl95MAC3Y4TM/RMl46knXhd/wDVv4dgTy/x0
 sJxRtzd8KACuXncUfQAG4Q+h3HDaVckQbRfyjyo7VAkXTnAYddWs9CCUK5xrFcqPiVXM
 PJR2//sLn+rJUA7kG242auSPGMNrBzkILOW/+U2/CzxjD7rvkxmhnhd7hhAO0BXL8CXx
 vHjE1u1QSSXZJyKE9V6FI/l1pwFQL0UcitckugIj9SgZH/2Ge0znYjhsJ2krr4CjkEAE
 pEsA==
X-Gm-Message-State: AOAM5332zlvukdufb4XXLCeBHMx3edFIYlkMuchpvLFpo4WL7NHKudZX
 UluIKFRfVoheEqPIaXW59QRIrA==
X-Google-Smtp-Source: ABdhPJzIoxeBEiSOTT1xWHkUGHQiu5FbnEFdASGVBKLFR8acOqyxHScHgFsnLei54Hu2gMbbrw5/FA==
X-Received: by 2002:ac8:f94:: with SMTP id b20mr22246898qtk.291.1590265773189; 
 Sat, 23 May 2020 13:29:33 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id l9sm27512qki.90.2020.05.23.13.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:29:32 -0700 (PDT)
Date: Sat, 23 May 2020 16:29:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 19/19] docs: Added details on TSan to testing.rst
Message-ID: <20200523202932.GH382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-20-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-20-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::844;
 envelope-from=cota@braap.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:55 -0400, Robert Foley wrote:
> This includes details on how to build and test with TSan
> both inside a docker and outside.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

