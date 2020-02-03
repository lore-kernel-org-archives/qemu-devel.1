Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63737C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B4C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQWgm/eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B4C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaCk-0005SL-7Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaBs-0004Ss-Ll
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaBr-0003F1-Kt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyaBr-0003Eb-GR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:46:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id d62so14375533oia.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hWdIbneKWtU0pa7URkdGEGtM50y4Y8uyYEdwSKFJkhk=;
 b=wQWgm/eTjIsmjOzPNp5HEXgYmMaBvJzMy7YtlmC1KuBAcKfprbJc4RqFIRFk972a8n
 K7LmnQsSY5MnpN3Kd2JnV8G8PHmXq8xNOD7JiwSP69GOML0Lat7afPnsEHn5lKB2aJBQ
 9FodpCe2cwXRb4E/+6kNd2Yz8ME0RmpAR/xHT3J1Z7rngTrEfgJbGq1zE+FAUMDYJreJ
 owQ/By2NnrscvUR8vjmlR9EcTwTZ+O09Mqme6FiAi2mjA/AfLi1beyiEUXjsRsU64XQr
 c1gOoSy6EsJlPlpnStEVS3hdFOlWOZwWORtlt9+ux8GngA3w4BxMlGhGfq/MuGBfB1ub
 eGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hWdIbneKWtU0pa7URkdGEGtM50y4Y8uyYEdwSKFJkhk=;
 b=BK5IfogHHm6Tf61OmBxPo5l/pO6yQX6oYHAoU0PFVOed5w+JChQmQaCSh0Pc0ITR1o
 m0VPZMI3P2MRbN4DdfnBpUG4+iy3roiYA8+SI4PDkqanDlLlLQjQz30Ic+wW7l/o9wBn
 KekDT0g9qfnMfRDVxdRYnkcR/4XNBXoe/TGPV61KfT3TwGL8kkwFqQPKJXgy6KGGXFsF
 6ijFJWI5nl/UuXq1PvpfVHRRdIe8UUOLTNVYZhb70SKvEsgQCCB6UKVXa5rK2BwwrU3o
 acRe0CIezIFBGzoYt3/b/20+dnDtHQaOOx6BdhThMtrGcgW8VqTP+aN1t3QSCmQ3sSy1
 Ggxg==
X-Gm-Message-State: APjAAAV/XqMO1CqNmB1q2P2ktmpQVf0lgRFclUjv9VTnV8Rd2SL+m5bY
 XvRyR0XheUsfEbRHh3aIe/SE6mkLLKgNMDci2kYnQQ==
X-Google-Smtp-Source: APXvYqw8QPdKUdW7zzgOsZx6j1UsYER+XlKhg6oP2RuPwTKdUowEEUlNddwTddaU47PwoHGI8Di32turZmrxeDgOedQ=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr13871605oie.146.1580730414653; 
 Mon, 03 Feb 2020 03:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
In-Reply-To: <20200115111042.GA163546@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 11:46:43 +0000
Message-ID: <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 at 11:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The qemu.git/master docs are built nightly here (index.html is now
> visible!):
> https://www.qemu.org/docs/master/
>
> qemu.org's docs are more useful at the moment since they include the
> user documentation in addition to the developer documentation.

Our top-level documentation page https://www.qemu.org/documentation/
still points to https://qemu.weilnetz.de/qemu-doc.html -- should
we update that now to link to https://www.qemu.org/docs/master/
instead ?

PS: do you know which version of sphinx-build is being used
to build the docs for qemu.org ? We should check it's a
version that's python3-based, because I'm planning to tighten
up the configure check to reject python2 sphinxes (both for
consistency with our general Python version requirements, and
more specifically because the upcoming qapi-doc sphinx
extension I'm writing will import stuff from scripts/qapi
which needs Python 3).

thanks
-- PMM

