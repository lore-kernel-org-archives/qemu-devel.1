Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE73C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6432120872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2S6XWcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6432120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bhO-0007WH-HB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bg4-0006PM-ST
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bg3-0004Jh-UY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:39:08 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7bg3-0004JO-Q1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:39:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id h17so13399974otn.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/HoPYcMogw327nagFlNNZ09LdP5503wlfRniz413Fc=;
 b=c2S6XWcY2iJdcUhMaIQSJc2XjMsAHtDSnMYi21ym/eMf2mNo0yZ4ScrwiAS6a9+Lhe
 u+qEZ9piU6wU5eex7p4zGcfJXCdfPNC4UQ9ugZdaQUYODy6U9EtQqAqaciN8axtPJzVI
 aJm58VObSpoNHR6x/iP/WbRVP+JyTbWh9a+k//lIXbFQ4MZiyiYv7Ix7APGt6E6PpxYc
 WSoCfrFvt/QF/7ieIaji0SRyWIYQ/CZzvp7+xq4wcKasJMgFFQ2PlmKP/ZelPi08lmAA
 OrQc/tTHHid0h2C8Rt1ByItD3j/UHmYOb0zEy5IPT912cEMe65+Ru+/bGc6n71uYbpdp
 /JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/HoPYcMogw327nagFlNNZ09LdP5503wlfRniz413Fc=;
 b=BvYKjYjOEt/Vw+Ez80y1JCr1JrJF+UshDdHlAlj1DB07cbaMfAUObds6gN1dQ/nAc2
 wffxAzeQhh4pXuMxEQKCWLGs8ZuiK78GEMSy5QR4oSUdwBb0uggq0a4F+d0RE+/Ymk7L
 kUlFKxn2axEMVssaDDwdQVEpkGVr618SwqoQuYotoan60P9Un2PjJtDXHceDbJuDty1L
 xNClHEStk6whOR1vnPjZ2MLcamKLHJMom7pJPyJjqai3Fb3EukORg9WNSirnRAzGEcMR
 4TGRNyEhO0lVVZxejNgKEJXs68tug5f3X5T+pbfZYVnwC69KAlTiD4ovmLAqTX/9Eyd/
 TF3Q==
X-Gm-Message-State: APjAAAXSf4u41BpRXrvyqZ9IKrig20C2SdNW2nIz2nqXnXTOmmaNN00R
 kahoKH7KG3msco7xzx1xSyTEAm0nZVjFggzY38j2Ww==
X-Google-Smtp-Source: APXvYqxUkzZgKGRWpuJXPdPTeYCGed9JfdiaDPXlpe9kdIeTCKfHQCfJiW13n/D3yfVrevZGW5nGIBGFuia5WtGsdT0=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr23399134otk.221.1568104746768; 
 Tue, 10 Sep 2019 01:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190904005218.12536-1-crosa@redhat.com>
 <CAFEAcA_TB4c6T2ZGu8xCx_H2Uzs8j2Jcs9ZbASTgXfv87KdSwg@mail.gmail.com>
In-Reply-To: <CAFEAcA_TB4c6T2ZGu8xCx_H2Uzs8j2Jcs9ZbASTgXfv87KdSwg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 09:38:55 +0100
Message-ID: <CAFEAcA_tPYRmCW+2u4Ae883iKGXoo1eJVTTmDohhku04DmksPw@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 09:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 4 Sep 2019 at 01:52, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> > from tests/acceptance/linux_initrd.py, is currently failing to fetch
> > the "vmlinuz" file.  The reason for the failure is that the Fedora
> > project retires older versions from the "dl.fedoraproject.org" URL,
> > and keeps them in "archives.fedoraproject.org".  As an added note,
> > that test uses a Fedora 28 image, because of the specific Linux kernel
> > version requirements of the test.
> >
> > For the sake of stability, let's use URLs from the archived and
> > supposedely ever stable URLs.  The good news is that the currently
> > supported versions are also hosted on the later.  This change limits
> > itself to change the URLs, while keeping the fetched files the same
> > (as can be evidenced by the unchanged hashes).
> >
> > Documentation and the "vm tests" fedora definition were also updated.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
>
> I was planning to apply this to master to fix the Travis builds,
> but it doesn't apply -- conflicts in qemu-doc.texi. Could you respin?

Ah, never mind -- Alex tells me he's already picked this patch up
in a pending pull request and has done the rebase and fixup there.

thanks
-- PMM

