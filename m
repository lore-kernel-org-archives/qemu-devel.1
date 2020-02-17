Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE5C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D0B20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkl0jEyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D0B20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3iBh-0004oS-7z
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3i31-00037N-0W
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3i2z-0002sz-2u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:10:58 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3i2y-0002qj-SV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:10:57 -0500
Received: by mail-oi1-x244.google.com with SMTP id b18so16990184oie.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TLC4/TmGytB6kwgRnJTzTWnino8fMQb4GQzNqdWbZi0=;
 b=mkl0jEylC7oq81cToLOvKyoy++W6p2eB23wzXUYI6gSF+kD9zzc+FzavwwOTs835k7
 ff/G6zw/AcHYEbx5w1isr668gMMpUIJ8Pu8zp60p0ebC/6vD7eFbCDHMiaCyHnP/HVTG
 GTk00YCTpIeu3FFawxLIUCJuQKTXzBPxLejO2jECTLtoQTFheUdblGt1NvobSe78OJpx
 TveFvC3OFbwzEF9RbTSdwHXwuuulWY726CJ+5RlyMjaR2ttob6NpUS1PEF0iOce0Hfiu
 +AT3SfuJncBL23cD9mfdSxcIbsp0/acW4bYhoCJb3P6E5ou49i/wfQKh4SDmqShBkL6D
 LUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TLC4/TmGytB6kwgRnJTzTWnino8fMQb4GQzNqdWbZi0=;
 b=BKe50LHnYN830rP1W4xko4JmOxegqei+qoIeS/9SpBioStmlwlrGbHJ+QAA2Vpnqp8
 m5PMp4lKUm8QWptPtp6iGf9Bn12uklB2Qb7q6LztuYtzQxA+5F5qRMq/fvbHrOcMsf4C
 LXUhbGJcpFTLSHfjTt3vnCGHA2OOuETPOMxSNGV/Hk5f3b+eKg5lRgagRq+zF02Y7Lsy
 KrPkPRVnNtVQGvRVf/Cgin7snbp3FzAplrnEjN7AvGA2jNQIFVVudLqOeqURYfEvvfGt
 tVFnkjisN9h2e8tIfSAdgimWrENEB9vr9D3GnWedtk4siWgzMZ3nUQrc4exkGZPFGwKX
 1n0A==
X-Gm-Message-State: APjAAAWPDsCGbEqLUePYmRa5ovx/OuhSpsjIiDpnInJ1GbrZodt2o1VM
 AiTYXw0cHSeE7rvkur+q3zmbmkzGNM75hPeP9kGYrIxo
X-Google-Smtp-Source: APXvYqzC3H7L6O733HLOzHINzAVYwQ1uPPYliewoANFLflxth4brj7s56QEum/Pwg5RnF28sIXB0Z8Cix6OPQJOxdio=
X-Received: by 2002:aca:b2c5:: with SMTP id
 b188mr10394594oif.163.1581952254271; 
 Mon, 17 Feb 2020 07:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-27-peter.maydell@linaro.org>
In-Reply-To: <20200213175647.17628-27-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 15:10:43 +0000
Message-ID: <CAFEAcA-YesGodYaJuqdCMPerYBX5CH=rrkLKTCGo9zw=kKu8MQ@mail.gmail.com>
Subject: Re: [PATCH v2 26/30] docs/interop: Convert qemu-qmp-ref to rST
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 17:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Convert qemu-qmp-ref to rST format. This includes dropping
> the plain-text, pdf and info format outputs for this document;
> as with all our other Sphinx-based documentation, we provide
> HTML and manpage only.
>
> The qemu-qmp-ref.rst is somewhat more stripped down than
> the .texi was, because we do not (currently) attempt to
> generate indexes for the commands, events and data types
> being documented.
>
> Again, we drop the direct link from index.html.in now that
> the QMP ref is part of the interop manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This patch is missing this fixup chunk:

diff --git a/Makefile b/Makefile
index 687a17dc0cb..8b719e10a85 100644
--- a/Makefile
+++ b/Makefile
@@ -1046,7 +1046,8 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call
manual-deps,system)

 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-ga-ref.7 \
-       qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
+       qemu-img.1 qemu-nbd.8 \
+       qemu-qmp-ref.7 qemu-trace-stap.1 \
        virtiofsd.1 virtfs-proxy-helper.1,\
        $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/qga/qapi-schema.json \
        $(qapi-modules) $(qapi-py))

which tells Make how to actually build qemu-qmp-ref.7.
Without this you get build failures doing a build from
clean. (I think I must have accidentally lost this bit
during a rebase, and not noticed because the old .7
file was still hanging around in my tree and incremental
builds worked fine.)

thanks
-- PMM

