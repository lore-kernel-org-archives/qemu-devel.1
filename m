Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD7CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622BD206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="m6zPJuCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622BD206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYZK-0003mn-JH
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jYYX8-0001z5-BM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:17:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jYYX5-00014F-FA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:17:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so16507446wre.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WCmG8NceZRyTKj/xY60V7+ftAOxSguGIXh/rAYmdL/c=;
 b=m6zPJuCD1+RjnqmeDQMCw5QIY15OSj+E18XmWlEU+019ct63MFCyXeAfPegrq0CdP1
 GlbxwqxZBhDj0yylk6sB361+QNIXHFkEB2RFRhIQK0hB/rmhPqPoLIRKa5m+pY7vF+Dw
 xnWbj5Pr3jo+73DEoCrU55YyZYPBpejxWAcRSH/X1khr5rZscpR/d2y+0AFot5wogWvE
 GuynbDDYDgUoGWaJbOdz9rhtX9TkIXlW+qUsFDohrlsbebfVJdGVHxA7yTI4YdDfs4VN
 WTFD9ThWwnyh0Js46Zs1LhBXAN3RHZbt/KHugL3jbCctreUhL0VfKT2FHdgomzEpUnBL
 UEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WCmG8NceZRyTKj/xY60V7+ftAOxSguGIXh/rAYmdL/c=;
 b=F4okq5uXg6HrCAdjWk1C7vr1UNjjc9bh7UxRmfBTOlrkSQgrAa+FEu5/fa7k126Xup
 rcYu7wOi76gpcoFgMoXzKJcLHls9saY+Z2ls4s9N/Jz8nOQkUD45n+PwDWDa9sbJcAg5
 DLVw0ZO+QnPgSBv4L1flLxOyepCE22Mn0oGHi191YFlGDEH7kP4/qolhPKAnaz1G368h
 hMmy2tilJed7BXEF9TAgX4IABG17E99eBET46AV60Ba+i9AcNAdX9I9FrkEt7RDuq67O
 BPsjAVcmo7R2d3OmepJmmev2nomIr+ZzajtRoGkYTovUk+lHloJcQMeSEBDsrikyRxoh
 ZNIg==
X-Gm-Message-State: AGi0PuabGmNlfi7WW8YhV/zFDxXSjMH/wcXq7HkpXYNh9tp+Iyad7PhN
 oLM6yZbRqh9pPRM5BqyJoW7csQ==
X-Google-Smtp-Source: APiQypK4JD2EpQz1GF0khQRG1gJ1B1TTLWPN6/bEJMGZRMDSahYAP0Vf0uevoBmNKll2LvDkMxdOuw==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr14015145wrq.261.1589303848055; 
 Tue, 12 May 2020 10:17:28 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id a24sm32185404wmb.24.2020.05.12.10.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 10:17:27 -0700 (PDT)
Date: Tue, 12 May 2020 18:17:25 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Radoslaw Biernacki <rad@semihalf.com>
Subject: Re: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
Message-ID: <20200512171725.GN21486@vanye>
References: <20200512170704.9290-1-rad@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512170704.9290-1-rad@semihalf.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 philmd@redhat.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 19:07:04 +0200, Radoslaw Biernacki wrote:
> My Linaro account is no longer active and stop forwarding emails to me.
> Changing it to my current employer domain.
> 
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>

Acked-by: Leif Lindholm <leif@nuviainc.com>

> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..668da447e3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> +Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..a9d6893036 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
>  F: include/hw/ssi/imx_spi.h
>  
>  SBSA-REF
> -M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> +M: Radoslaw Biernacki <rad@semihalf.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Leif Lindholm <leif@nuviainc.com>
>  L: qemu-arm@nongnu.org
> -- 
> 2.17.1
> 

