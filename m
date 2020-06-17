Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1EF20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnAVwR4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1EF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlWm8-00049u-Iw
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlWl0-0003Fp-1C
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:01:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlWky-0006Kj-1k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:01:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id t194so1694066wmt.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NOgiKf4Mv0GuWvHokdutkHJKN20A3Rm92E9QJVfJNio=;
 b=lnAVwR4fi9s5cs+6ew2hF8nQQVtOGo2zwdanF5Tp9FmN69vrL4C2yXlUuCjKRuX4VX
 3uvxzavEABvNxGnYm+WpbHVefgfQ27twflFAiMCPpqDjNPHV0JtNsE9mhCjIGiLACLBw
 JrZVl7fCmpWJx/+bBCdr7DsoyTpkd/P+4U8sgOBgkzDOcIp4E0abwYfyJDd13B1Sf+0c
 CxPi5WA8kUHmf+Eg0QVAFRQWUzLF6bxBeHudj6RMWiK1GnAl7JNo3ummGZ2p+xW83yJS
 FlOlbvA+Y5XDObVZ70A4l1kGoPgH7o9WHyfQDAzEO/Qpbc32l6GS+Vng0ye7FLyz2fM+
 cHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NOgiKf4Mv0GuWvHokdutkHJKN20A3Rm92E9QJVfJNio=;
 b=Rj8IKRYCzKD/44K77un7wL0KbOqgUMis4jIbriSqAPq/pVysgz/uJ2KBSyIPaiTtjd
 +Ryc92IoGd1UbkAHCxv2Y+wHEFjLtotL+3zDapzxXN0jpLNeK0h/q1NZLz7AfqbdrxVl
 /eM7MBLgUgvOOErSXoINzHWyQm9H80MuJW3BnqT4nE7KIxSxR2K8lkeFUNzAVQZRcXhC
 TMTSJKVhxxFQVY2Th0iT0nmntJ5HkBDjPMCN+AnCnm2viDKeJ1tJIMbXB5diKXBt0KwY
 PT+gN29TgmiM3DhVRCkGjGUKqxq8vb1wpb2lEn31ckRTQtu/2EY7IpfNdPFplb8C8JK/
 l2OA==
X-Gm-Message-State: AOAM533EmkEJ4B8Wp3dwDn/zzNJORh/OCGNN8R1HuSczh857LnA1fh33
 Jgdzt6hg/XBwepD+5ZD3YqE0rA==
X-Google-Smtp-Source: ABdhPJwTRd+n8jZHx+FLQv0zE7mccJjgY29HJF0TDS61b8/cZl18oJyzTHR2Ry3/djwn0pSVzeHf8A==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr8669918wme.13.1592395286103; 
 Wed, 17 Jun 2020 05:01:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f11sm31610391wrm.13.2020.06.17.05.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 05:01:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39B631FF7E;
 Wed, 17 Jun 2020 13:01:24 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Add 'Miscellaneous' section
In-reply-to: <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 13:01:24 +0100
Message-ID: <87a711yk8b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, crosa@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> This new section includes the 'Performance Tools and Tests' subsection
> which will contain the the performance scripts and benchmarks written
> as a part of the 'TCG Continuous Benchmarking' project.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 955cc8dd5c..68f668ae2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2974,3 +2974,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: docs/conf.py
>  F: docs/*/conf.py
> +
> +Miscellaneous
> +-------------
> +Performance Tools and Tests
> +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +S: Maintained
> +F: scripts/performance/
> \ No newline at end of file

Personally I think this fits under "Build and test automation" but
whatever:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

