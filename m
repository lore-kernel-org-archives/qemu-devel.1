Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB07A206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6tN46Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB07A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYkv-0007sS-0d
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixY00-0007VU-Ho
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixXzz-0002k1-4Y
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixXzy-0002YI-Ru
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:23 -0500
Received: by mail-wr1-x442.google.com with SMTP id k11so8995196wrd.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F5Kal3QYgjGCbr6y7XeoXy166XSqtRMEalK7GQ3CG4s=;
 b=c6tN46TiXLtwT7HEw3z+Nz2KZxQrD3nG1Y1uO6eWHwJx6UICueUy10UCip1Vot9/4p
 q7F7wBJtiy8n4nMxsHvbcBz26Maza784y+qqb5aCok0ayqWmFthTHoYaquodW/c8E+Iq
 hrH/AL9knd2e39JyDButKqXpPtvxotzveqEz6zskflNcorMgxxMffEOxllSG/llNBrtZ
 pf6QmRlkZOqHMycVAhf1cw0z6bLbQ3bRTSTezxCSeEZKI4zQHnr169VMj8AGyXaodjRO
 V7/MfsZqfMazkVKfx4SsNYc7enombaT+5VxVTC5EmAgs3AE9K0eWgNqH2cyuwE+aZmOC
 UQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F5Kal3QYgjGCbr6y7XeoXy166XSqtRMEalK7GQ3CG4s=;
 b=VVXkJ1g1zorT7ppTY7hRGcBUR5r4+kOp4QtgUe5GYWe3WVMuTrzdG/upDqxJgl3Zvq
 aMP6yMWoIwV2j30t+RlrUZ5yygM1YagChE9Refj7PHBtRzTty+9uAirHPBREGr3yJEpL
 MYc67lXuVT1UhEoaRRu4flzO8BwHHcup1x61h3BnhC4hxyOscVUmdVPa+PiN7DPenEzo
 Av/0y/Le1QrcpWetELtQtiyBFbWVhYAGFCeJskW+Mw4WkTFeddspGHagSjPUD+pZzHer
 cwn0wrgnjBQzv1Tc4VBBAUpXeYGSA0ZGmqoKUiX65fjAXSzGN1kYmC88ctIL2OjgDGC7
 ZcGw==
X-Gm-Message-State: APjAAAVvqjYA3m3G4jeK2xaYyJmiIVwc6S+751V8jI7QR+LBkl21vNT2
 Q7PVvbYCsGUlJtG1YgHQcZo0PQ==
X-Google-Smtp-Source: APXvYqwMrCAfGJsAp/2E0L1j3zCKVyJBsJzFMOrutoAqdwpld3Bl39xTpw+cprjOFD4SXCJSDFLmmg==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr13182309wrw.277.1580483661168; 
 Fri, 31 Jan 2020 07:14:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h10sm10466551wre.3.2020.01.31.07.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 07:14:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55D711FF87;
 Fri, 31 Jan 2020 15:14:19 +0000 (GMT)
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-6-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/8] qemu-img: Convert invocation documentation to rST
In-reply-to: <20200124162606.8787-6-peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 15:14:19 +0000
Message-ID: <87h80b8xpw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The qemu-img documentation is currently in qemu-nbd.texi in Texinfo
> format, which we present to the user as:
>  * a qemu-img manpage
>  * a section of the main qemu-doc HTML documentation
>
> Convert the documentation to rST format, and present it to the user as:
>  * a qemu-img manpage
>  * part of the interop/ Sphinx manual
>
> The qemu-img rST document uses the new hxtool extension
> to handle pulling rST fragments out of qemu-img-cmds.hx.
>
> The documentation of the various options and commands is rather
> muddled, with some options being described inside the relevant
> command description and some in a more general section near the start
> of the manual.  All the command synopses are replicated in the .hx
> file and then again in the manual.  A lot of text is also duplicated
> in the qemu-img.c code for the help text.  I have not attempted to
> deal with any of this, but have simply transposed the existing
> structure into rST.
>
> As usual, there are some minor formatting changes but no
> textual changes, except that as with one or two other conversions
> I have dropped the 'see also' section since it's not very
> informative and looks odd in the HTML.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

