Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2680C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2FB206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="S/mxOHEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2FB206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRWw-000456-QK
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leif@nuviainc.com>) id 1isRVm-00039Z-HP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leif@nuviainc.com>) id 1isRVl-00026W-7b
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:18:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leif@nuviainc.com>) id 1isRVk-00024F-QM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:18:05 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so7565359wmi.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=KpZ3QLKUbQJ0Z3RVINWucb9Ndt3JDsMoblKjT9M/9xA=;
 b=S/mxOHEormBkphE4gQVdY3OX/KaVy/+i1P3gpd1rJKWGtxnz18jzsh4lIjEtadcZkn
 jZgwdL1xocWEfYj4B/ISgXwo7SBA0ZNW3mJRG33L84OoHQnOP85CJijBqGnr/1gmhwFC
 rY5rCiJpdhmRNip7fH+La69ZGwxRUfL6830ZYQM/nV1Hn5wV8XZsqvZptRyd34QArBPG
 tP7NW7/3+1jIOVnja7QtqBS7tw1RxC90IMccEmxp6h3inrbuBwR8te2If+KgNaoVox7W
 S8A/49I5lw61IdVxDzBnuQKpLf31QAhS1FvcTP17jV8ND3RdNANN4he8WqPbMJzGq2eH
 Pqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=KpZ3QLKUbQJ0Z3RVINWucb9Ndt3JDsMoblKjT9M/9xA=;
 b=dQ9nP67RL4JvOJLWoYbcMJ2DqqlJCt1PariBYMmxOiJBcfwIzirdDnKoZdI/9HdzH1
 hxQAm7qTK3aQqlAZbQzoOMswthQsJqr95FsWfmAbIcFtKVyx2VV/JFdEFOyqyZUG98ds
 ys260dCc911eyX8nJDMrCNqiPJumV0ifznsTCgOuUyX9HayZCN0B7f8nSp+ITKmfK9Dw
 gMNRyLDUg+VRHXeGeyF7Jolmp5Xv1yIClYd5kN8jqfJjDH2pvjxgFPRK8+72NCgoY5wS
 CwFS22uh5GFsR45gMuKiyqlY5Bdv0gpLJQiGYUf0JfTKYEZ4n7Edk03MCI0FgtFRLsOR
 99GA==
X-Gm-Message-State: APjAAAUpDKIzvMSGapNZItC8dSzO9q7hiuy3NJd6Ne8hTm+aDPZFu/EE
 Z0ovCP6SrUXiSNp/Ls736Fn7xw==
X-Google-Smtp-Source: APXvYqxP6ogyZEM4spiJJH3kHcGuQ5hKm2NpfgskB7SMQO7rdL0xqW/uPSzBtdoOjBV5V9vMVWAusA==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr4498500wmj.168.1579267083496; 
 Fri, 17 Jan 2020 05:18:03 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net.
 [2a00:1098:0:86:1000:23:0:2])
 by smtp.gmail.com with ESMTPSA id a9sm7986389wmm.15.2020.01.17.05.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 05:18:02 -0800 (PST)
Date: Fri, 17 Jan 2020 13:18:01 +0000
From: Leif Lindholm <leif@nuviainc.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH] MAINTAINERS: update Leif Lindholm's address
Message-ID: <20200117131801.GI15141@bivouac.eciton.net>
References: <20200116174226.4780-1-leif@nuviainc.com>
 <a2fc8a4f-0b56-7868-0e52-51c2abfd97f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2fc8a4f-0b56-7868-0e52-51c2abfd97f7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 19:25:52 +0100, Philippe Mathieu-Daudé wrote:
> On 1/16/20 6:42 PM, Leif Lindholm wrote:
> > Update address to reflect new employer.
> > 
> > Signed-off-by: Leif Lindholm <leif@nuviainc.com>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 483edfbc0b..3c8653f26f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -735,7 +735,7 @@ F: include/hw/ssi/imx_spi.h
> >   SBSA-REF
> >   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> >   M: Peter Maydell <peter.maydell@linaro.org>
> > -R: Leif Lindholm <leif.lindholm@linaro.org>
> > +R: Leif Lindholm <leif@nuviainc.com>
> >   L: qemu-arm@nongnu.org
> >   S: Maintained
> >   F: hw/arm/sbsa-ref.c
> > 
> 
> You might want to add yourself a .mailmap entry too:
> 
> -- >8 --
> diff --git a/.mailmap b/.mailmap
> index 3816e4effe..a521c17b44 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -44,6 +44,7 @@ Aleksandar Markovic <amarkovic@wavecomp.com>
> <aleksandar.markovic@imgtec.com>
>  Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori
> <aliguori@us.ibm.com>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> +Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> ---

If that use of .mailmap is common for QEMU, that sounds like a good
idea. And the comment for that section of the file indeed suggests so,
so thanks!

> 
> If you ack this snippet maybe a maintainer is willing to amend it to your
> patch :)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Leif Lindholm <leif@nuviainc.com>
(The other guy agrees.)

