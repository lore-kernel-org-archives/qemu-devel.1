Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2438C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D70206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAf3tGDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D70206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDoX-0006k8-7B
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51961)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htDkh-0004Rw-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htDkf-0002eU-Ry
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htDkc-0002aV-Ny
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:23 -0400
Received: by mail-pg1-x543.google.com with SMTP id n190so3031999pgn.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mKYQQJitvHs58Ru+xI6B0zwLulsD5C5/4x2qUXMhjpA=;
 b=UAf3tGDinZTBayLKASPJYOrkhGLd2yF9iQqP9/4sPa/7fiUXk8IpNjXGfAg0DQZzVJ
 IklDYlAfJEUHngkfYVezEhTeCZDFwYyrtecYixdmHRccJLjm3V3vDvLpFV3mNQwdZDvb
 zICHlgAb16TZ1kG+esEzIEZMXvMwdMxfMXD3heXX/uxVrUlX8J4DkEHA5pGN7aHQv/Tl
 lagiW1FVSDeI75eFDCU4LivHBZcQsmRm6/3zvqBuSuvCa2WnEiSyeyrGq0U1xZ/x4o23
 9ffdYERtsxj+yqWEilHbtLmTxlNQ8qqdlTwyQIXEKzTnd9ftTf1iFta1RdcpNBx+Ngcz
 tXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mKYQQJitvHs58Ru+xI6B0zwLulsD5C5/4x2qUXMhjpA=;
 b=sNr2CUlA5yYgk1BE96+S9F3i4wmLTMRxQUuYueaniZl77zZJE5Hp9W1z0+LX164tPp
 dUlggVtkcsmIk/dqFbogWdr2Wi+IrAaqPsGz1PD5xDgQvKvhB+MDjSFP8x5iuMQn/y8q
 s8V4jcDnelSoamuH8tfU4dKJ1BkEdImuRZyAMsQJ1y4eiCq1Gl9PqGYrM/TDzRyQEVoV
 XtpikTve2n0ZPMLlNGvH8tFCM/j4x5KEgF7TUkuTzAwl1rxFuhSbomfOdmnE+L8ZSIGj
 9KsfidnSxrmbn9MIa6Jbq6Zin5bLHV8cZAJib3yOwliZDrPHmZ0Um1rUkj+EMufEkWEQ
 NxfA==
X-Gm-Message-State: APjAAAUXMGzZly2PwJP5RRkXJ7exm96C6+5Mlyu7rmwHuVbVIf4T4/Pf
 rvBiBZutiDY1PiVzGPJMb8DLTg==
X-Google-Smtp-Source: APXvYqyEgR3GnaoIzWzU6xNd0QCLJ1MEEEVpZ2fKgvGmEUrJBc9rVLQtIYFRLBZ3EbECITV/cLJqCw==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id
 w12mr9111723pjr.111.1564676171778; 
 Thu, 01 Aug 2019 09:16:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t6sm2419505pgu.23.2019.08.01.09.16.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 09:16:11 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9c2e5aca-3a0d-0a5f-f969-b95b823c11dd@linaro.org>
Date: Thu, 1 Aug 2019 09:16:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v4 16/54] queue: add QTAILQ_REMOVE_SEVERAL
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This is faster than removing elements one by one.
> 
> Will gain a user soon.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/queue.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)


