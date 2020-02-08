Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F314C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C63E21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVbcH3dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C63E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PuD-0000Gs-IU
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Ptc-0008Jf-Ar
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Ptb-0005Ru-Bj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:11:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0Ptb-0005Rk-7M
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:11:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id i6so1980579otr.7
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dmcl3i0AuOwfv/pDVAsZFz0ZACKzUQMR06iDD6LJ/So=;
 b=eVbcH3dF/N22i3yX3qPPMSczCWbALLcigWs+LIGVkYmTNVZNdOpMXbSV81itDwv6Vm
 7HQHu7vQEFPDBr9RcqXErHJeOF8YKf9Tc8Ek2lEZ+BONVD4BwIxsI3FpVeZsQ8G2wlV6
 7AvwRunqO0gslC7VNXwIM+djx/qaa6G/nu7Je2YLRJZFuz5bE/OHxcqFFQCl1IWqvJXH
 bKUN+6lS5ntNHXyOItWCceTYygKPEpyMaR/MSfFnfYgJRi0g8dnHJtusWylaTsP/oJYr
 ApZ5bESd+JiWcRi4GZDGQbY9slj8Ge2G6Gw5S1q+K2KQ5G640yuYLPemE/jJ4Lwqptdd
 nDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dmcl3i0AuOwfv/pDVAsZFz0ZACKzUQMR06iDD6LJ/So=;
 b=LGHagDlQHZJlhLcPXWOzY8wSjBkvAFa/fapG819CGqiokpvbrTeUiTdz6sJL8y21qq
 afqTUSakonxJ5UyDPCcHtR1gPEsok5Vz7EMlRCbNtkBm3cplVW8pnfEBkiM9vXufUp1l
 utunnZdARmUdA023r3MNnSEz3dNX7hv1yM4RFdH3km0tzzPaqGHcSMCRMe3+p3EPofgV
 HFmToPdo+Y9AmEwoufKoky+/H+rDfuJX6+jT2mqzjGmtYQRnNZGqxod21OVOfxroKtBk
 jTEea3zdqFE1iQpNix1VmzUYYMC7jZJwOA4dctnm2i/tjdO5y412iXnGeYyPiIxcvjdY
 pbiA==
X-Gm-Message-State: APjAAAXGzZx/8A4NdY3JGxDCrEUrtM8Ab8KikK0WhHlahziUiwLobPq0
 /92ydYdQtQEp8TH028fKu93UHaG+1NvQVqKg0R2Sglv5
X-Google-Smtp-Source: APXvYqwesybK5ix86Le0VzOv8F77zYEIdSLug3LN0WMvdnmuTmJuKfVuZtuX125lwDbRkX94k2A1jFdWcicuS1MGWAI=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr3466651ota.232.1581167497317; 
 Sat, 08 Feb 2020 05:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-3-peter.maydell@linaro.org>
 <875zgipe1n.fsf@dusky.pond.sub.org>
 <CAFEAcA90qHdHvozNhjX0d5xzoOiFb6oTVdXWf9u9aRvV=YHw4w@mail.gmail.com>
 <87d0apldpa.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0apldpa.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 13:11:26 +0000
Message-ID: <CAFEAcA-esuGOKsE27jSZ=2QxYSn-FuK5bAd_+OgoLTxEqsCRsw@mail.gmail.com>
Subject: Re: [PATCH 02/29] configure: Check that sphinx-build is using Python 3
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 07:51, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > It might be sphinx-build-3 on RH, but on Debian/Ubuntu it's
> > just 'sphinx-build' assuming you installed the python3-sphinx
> > and not the python2-sphinx, or you can run it directly out of
> > /usr/share/sphinx/scripts/python3/sphinx-build, or (like
> > me) you might have a locally installed 'sphinx-build' which
> > is using Python 3. My assumption is that once the python2->3
> > transition has faded into the rear view mirror most distros
> > will just have a /usr/bin/sphinx-build that's a Python 3 one.
>
> Defaulting to sphinx-build-3 if it exists, else sphinx-build would be
> nicer for users on some common systems, and wouldn't hurt users on the
> other common systems.  It's what we do for Python.

Feel free to send a followup patch :-) I have no systems where
there is a 'sphinx-build-3' at all.

thanks
-- PMM

