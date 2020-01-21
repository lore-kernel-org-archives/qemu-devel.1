Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73CBC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C13624125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxVUVD+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C13624125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1VS-0004zu-K9
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu1US-0003lj-Sg
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu1UR-0006Rj-Dn
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:55:16 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu1UR-0006Ql-3J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:55:15 -0500
Received: by mail-pl1-x642.google.com with SMTP id c9so1939198plo.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sx+MiEwtnhiVxdImjEurz+XYYucKRCLAKzscIzsXco0=;
 b=dxVUVD+z9T6581urTWiosHsqPRbfeii6QUvFsGmkVzW+0k+8nwHWJk4TEbdfWavqxp
 yDxj+A0d+YWQavxMGTIYEg22nCRvogI/Idzfd6OQct0j2CL+c85rxC+5dVkM0iH9FTll
 2pqp6ebJZnl6AJpQSIYYLcJjodV1mAQy1SgMIDLeZ4wz5vpAYV6HvemMmitAzMI+DRN1
 7CXn1ZQKWRCckJDPrnqEOCHfZb+gP7WNIqgl9n8mDEF6G0U/qQOzgg2sqMyLwyciCdoB
 bfzn2/N9H1Q4MEK1sSMYoUz1tTyjmOcePYsQKQFZk+c6SGTGuvoDZAFRh37f+DQnLiUS
 9AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sx+MiEwtnhiVxdImjEurz+XYYucKRCLAKzscIzsXco0=;
 b=rsN2EbYQg7qgrfcjpieS+Ojw93bCRF9TeMz7BD0dmQVaRYxU+U3jnOyjlxdpRQd0Xw
 7kFppFuJbLzuRmMvb4xPrDqRM0oxEXd1W+cSBN0tKyUEwcvhJAKOIPWnKybZx6F0nmkm
 1xCgHFrbfeaP6g7+ReO6shrZQ5XE8Bb6EPxLVFFn3QYd3ZvwPYOjveTIyzCmevUM3lC5
 nNwshM+lhyO5TP5YyK5BbJ68uXQui8P2XCd5GaSieDXcQkTGrjK2WrxeRhzgW3owdPOM
 /7K0iR1qeGQj26lUwYNetBPRBCJScTmMwWDAWhMJtb1p+sUQbf6Wvu5vrzaGEfJGRf81
 uyjA==
X-Gm-Message-State: APjAAAUTfyc0GRyirgIgKEVK2HrJUq7HsArIf6+9ojBvKIjqJKxAax6k
 wyxp0X/C3A8Vapi1aArgHQl4oA==
X-Google-Smtp-Source: APXvYqz1OWNTaLYPdU1VPIZgfiv0A6bI82T1sNrKH4EcAqn1ZujDGPbe1uFmYkkBnEAQisgNndflHA==
X-Received: by 2002:a17:902:6b82:: with SMTP id
 p2mr7759646plk.259.1579643713046; 
 Tue, 21 Jan 2020 13:55:13 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id u10sm42627421pgg.41.2020.01.21.13.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 13:55:12 -0800 (PST)
Subject: Re: [PATCH 3/5] qemu-img-cmds.hx: Add rST documentation fragments
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc709e37-6cbf-de95-0981-08f046440af1@linaro.org>
Date: Tue, 21 Jan 2020 11:55:07 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121191033.28195-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 9:10 AM, Peter Maydell wrote:
> Add the rST versions of the documentation fragments.
> Once we've converted qemu-img.texi to rST we can delete
> the texi fragments; for the moment we leave them in place.
> 
> (Commit created with the aid of emacs query-replace-regexp
> from "@var{\([^}]*\)}" to "\,(upcase \1))".)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qemu-img-cmds.hx | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


