Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF25C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6C42173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGB58Zi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6C42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kCK-0003tH-Mo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kBb-0003Rq-QK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kBa-0004AB-Kt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:28:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8kBa-00049m-Dj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:28:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id v4so12320620wrs.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lU8h1U41KnhgyLyO1dz7HwccZDbQs7P2OXeA0PXlPkg=;
 b=MGB58Zi+gRurzVkv4kRRFX06IpA5Nv9pYLgSuWJ57E2EXyHO4xoOyLF/llbJTbNhh4
 xM9claTb0jAwv4ZOCajeO1nOweVEAlfDbbOujwx5soCI+7vp16FIYcTwXs/HyXE+GNPh
 PNXM1khpa4Om0NJN405JxcnFcrEq2yQwZCq4I0ldZMmXzX89j7XxjrQjCbCSl7tihi2x
 JJF1gec9gM6qHWP1iaWwn3uR0Wr3dmJq3BkJH+q6to0JJTNsmc2Y+FZxfGBEnn6JxRVs
 rXXMaNoDv7io7mBbs7e3UiZB+ZkRWJ82Q9JnsAo1tfmY8tein6OvgA+EYObGdvabm5On
 K28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lU8h1U41KnhgyLyO1dz7HwccZDbQs7P2OXeA0PXlPkg=;
 b=EIi3itZHAKW9rkmZhE7IPX8zLTO83ZFj5MkThbYTSt8dRQTM3K/DRuxNciy4htG6zG
 cdx2XUDGYEQW+OHK+T8NbwXSB9aCEpRCBm2E7SXVKpuGUGTSC4ehRv5Wm28REPpW/+bv
 Al3FEFbGrYfcaBs50OOnmcq0ixfjT2X8+GDXh8xzprjXocOrFjLia+qGMWgLo37SKEIi
 1paLy6lWTqqv3MxOwpKhT1zGcNHTtkQm+rQKsk7tBvQb0jWSQU1ZosLTSvwAtQ1xv0PN
 qS+IQMeiop8LHYwRYb8m//5TMpkSyT/YatqzuL53rAHiJEV/j0s+qZwVGe9d/vRKb9uj
 c4Ew==
X-Gm-Message-State: APjAAAWfe6ZZTzKCFxyncSdzZH9aUWwdWHdfP34jVrOSvndb8bFF8gRw
 dJ+E4UKtLDqAuKtI8HCf5eGuHQ==
X-Google-Smtp-Source: APXvYqwYilnYoc9nYxsnMlexDrrOAAFYEgJ6z1pSHvneBQaJFm26m4HMkwISal1djQ1ao01pbIDskw==
X-Received: by 2002:adf:de09:: with SMTP id b9mr21869245wrm.160.1583152116243; 
 Mon, 02 Mar 2020 04:28:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y12sm28140362wrw.88.2020.03.02.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:28:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A93841FF87;
 Mon,  2 Mar 2020 12:28:34 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-31-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 30/33] ui/cocoa.m: Update documentation file and
 pathname
In-reply-to: <20200228153619.9906-31-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:28:34 +0000
Message-ID: <8736ar9c0d.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We want to stop generating the old qemu-doc.html; first we
> must update places that refer to it so they instead go to
> our top level index.html documentation landing page.
> The Cocoa UI has a menu option to bring up the documentation;
> make it point to the new top level index.html instead.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

