Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F3C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D481206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCVSEb8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D481206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53657 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huce9-0006OG-Np
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hucbF-0003xx-5h
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hucbC-0005mZ-BE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:00:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hucbB-0005l2-Ee
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:00:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so85206622oth.5
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JSXKW26RRjToQrMXr0cGo5UwSoNkaZ00j2Gju1SdXb8=;
 b=SCVSEb8UYJKGi86WLmjFauB2Cb/5TTM1Xxba4660jl2etjyXAZb/Arb/dLvAqbO+BO
 dMpq7u5aJmYhQvrPJEzME0jRJ4XmHGEmTmW9kS7oOf7WbisoBW2uExjh6+lJLpc1hu4S
 8qeuguQJ3XbygAtARDMCwTrOX9cq/NcQZwlsbmHPIwrgQqqej+x/cMB/skpt2AYYqx8p
 pmTthuPCSfJdGuWKMasag4pMJIaKZqW6/+xZFH5cKHtKzpF7sJAr6AzjSsq/keJUC6zm
 zsODkjU6znpWpbre13H4hVJED9Ykagp8hEwa0Zw2LxEaihf/o/stuWeHfp2RrwCfL+sp
 4vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JSXKW26RRjToQrMXr0cGo5UwSoNkaZ00j2Gju1SdXb8=;
 b=Q4kbJhQHj6tmBUP1wficVEty12vGFEjlcbDqbOkpH2iqzRCvkslpH5YYjFg3pqgrfF
 dCxch+P7fyrpraYNpCkQGbUZ4odI4l3JHikQ4Am837z916P5vHgCIfIpRM6BFioXjgcy
 z81R2+wRZgrcNLsYwaJi5V3MtF2BI8DxEy+NgS0VKNQ4mgSPyDPRf1q8w6EviIc5/Eub
 AO6HZDrjafxaQ/6fs8VxsF8uC7ndTHqWm67XQGEhBQZSi9q8Wt5od5O4M6aGvhJ2sQ7u
 vEQ11ARR9XAoP2RvuqTGhzjWNIWjT/0ScXerOrzdphuclxyXElH1Wo27T4MuipJuupvU
 GbyQ==
X-Gm-Message-State: APjAAAUXmIUMJZ7p4+nFWQjSDYFmW4Z1Kg2G5pdD1/y1YI3pIbx2KbSZ
 tcoy3htpQ+mjao/Rdwn3rbG485Rodu1S4NAr2FJluQ==
X-Google-Smtp-Source: APXvYqxSGA8eyKSo6iuGOKYk9JbH6F+XEPLplD0ge1pB+QnZv5eTDPcmZfZ9iS198SuiHMBe3NqH5n73kHdSqQc97Mw=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr55273442oti.91.1565010024099; 
 Mon, 05 Aug 2019 06:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <350c3150b25e0c44e24e0a3bd15dacc7284684c9.1565009145.git.mprivozn@redhat.com>
In-Reply-To: <350c3150b25e0c44e24e0a3bd15dacc7284684c9.1565009145.git.mprivozn@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 14:00:13 +0100
Message-ID: <CAFEAcA8BfOw5Q3L8zqsw16C7askG7bdNVPoJT-aAE2Tr6-a=3Q@mail.gmail.com>
To: Michal Privoznik <mprivozn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] Makefile: Drop $(DESTDIR) from generated
 FW paths
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 13:54, Michal Privoznik <mprivozn@redhat.com> wrote:
>
> The way that generating firmware descriptor files work is that
> for every input file, every occurrence of @DATADIR@ within the
> file is replaced with $(DESTDIR)$(qemu_datadir). This works as
> long as DESTDIR is empty. But in some cases (e.g. on my Gentoo
> box), compilation is done in one dir, then the installation is
> done to another dir and then package manager copies over the
> installed files. It's obvious that $(DESTDIR) must be ignored
> otherwise the generated FW descriptor files will refer to old
> installation directory and ignore --prefix given to ./configure.
>
> Steps to reproduce:
> 1) qemu.git $ mkdir _build _install; cd _build && \
>    ../configure --prefix=/usr && make && \
>    make DESTDIR=../_install install
>
> 2) Observe wrong path:
>    qemu.git/_build $ grep filename ../_install/usr/share/qemu/firmware/*
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index cfab1561b9..85862fb81a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -881,7 +881,7 @@ ifneq ($(DESCS),)
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
>         set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
>         for x in $(DESCS); do \
> -               sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
> +               sed -e 's,@DATADIR@,$(qemu_datadir),' \
>                         "$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
>                 $(INSTALL_DATA) "$$tmpf" \
>                         "$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
> --
> 2.21.0

Hi -- this looks like a duplicate of
https://patchew.org/QEMU/20190530192812.17637-1-olaf@aepfle.de/

(which Philippe has put in a pullreq which I guess is
destined for 4.1, though I'm still waiting for confirmation
of that, ie that it really is a for-4.1-worthy bug).

thanks
-- PMM

