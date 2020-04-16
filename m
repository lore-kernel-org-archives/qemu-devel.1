Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522EC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6068921973
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGpqu9hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068921973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP3ho-0005U7-JT
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 08:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jP3gR-0004mV-T8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jP3gQ-0000i2-Rl
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:31:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jP3gQ-0000hF-Dh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:31:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id d77so4393510wmd.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lE/JroP4XWtFM6qeG6OSaw5rLd3663TauUL5q2SZ5Q0=;
 b=dGpqu9hwfIV3N4WHDGO0jCmOGaUUI6m3rrqSP2YDSBkUtbytuP9AnJBlV9pqcGAQqX
 NIiSF3yPUuru09KGJpAZavvean6MgJCpWy4SKazw2bofADIaPLklHzdmIdVrnRz9xPLw
 QJnmmx4KT3L+IbI9id3E7zm3SIqbU7tY8sNrGwxMsK1YduVAgYc/lF5v+e1zorQyOPFG
 ROibBMuCDiH8+CGDkeZ2ADVLXlvDUgt0LCDA0C3K+8FA0KC8h7MAEkBpsVsdwVFSWEm/
 CrMnP27K2sPxGAvY2Gd/o4GwXmLWSA4UZP6arM5iAI+yhxggrFp5uiZxcyQvS76KogvW
 j22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lE/JroP4XWtFM6qeG6OSaw5rLd3663TauUL5q2SZ5Q0=;
 b=Adk7NEmupI9jW+HS2c/IP+eWTKeiLYWRlgqP7t27JL3cgJhYU7YSjOrt98M/g35L2g
 PqKi10EHgOx5M5248xorEOllbDWhlJP9kHXU+SyieM9YttUCsKwP6a6vQ5yhWe+LUGGt
 qvWHpkdR5/fqXbuE233s7EvZK5rBNc6zf0WhdKcQeKpdjefi/7moHqPNl0zThKQCVRBh
 GdmQ+hj8//nJl9noro5v3gqGVzpgXN3zK3RGc9CDb3ZgTmgMhlPO9SbMwSVoL77GW4IQ
 N2KUyUKTOQBWQ+zdSlzeRVjjga+WSwyVFpRuri3PwT1pzRhDG8AutOX6KbfP7gk4nMeT
 kGkA==
X-Gm-Message-State: AGi0PuaZmoQ17vcWLa+8wv7X8jsSTRdxpdX9FZZD9SoNkM8CqKLBYOu5
 6kAXqOySAPmkvUAqP4jx2KrvXQ==
X-Google-Smtp-Source: APiQypJRO2DMxuEW/vhQALc2ySYrgXY8ruVCUh+wucReOxkhrRbjPXkku+YGHgE7mXEIc/C3AXvT4w==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr4540956wmi.98.1587040313054; 
 Thu, 16 Apr 2020 05:31:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c18sm26808155wrx.5.2020.04.16.05.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 05:31:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F7A81FF7E;
 Thu, 16 Apr 2020 13:31:51 +0100 (BST)
References: <20200415173329.4920-1-jsnow@redhat.com>
 <CAFEAcA-ipjVsGuzTWhEq59SvSSSiO+ufcqdcx9JYDOZMLLfPfA@mail.gmail.com>
 <17333d73-f5be-b43b-0087-22529f985a50@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC] configure: prefer sphinx-build to sphinx-build-3
In-reply-to: <17333d73-f5be-b43b-0087-22529f985a50@redhat.com>
Date: Thu, 16 Apr 2020 13:31:51 +0100
Message-ID: <87lfmvfw7c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 4/15/20 1:55 PM, Peter Maydell wrote:
>> On Wed, 15 Apr 2020 at 18:33, John Snow <jsnow@redhat.com> wrote:
>>>
>>> sphinx-build is the name of the script entry point from the sphinx
>>> package itself. sphinx-build-3 is a pacakging convention by Linux
>>> distributions. Prefer, where possible, the canonical package name.
>>=20
>> This was Markus's code originally; cc'ing him.
>>=20
>> (Incidentally I think when we say "Linux distributions" we
>> really mean "Red Hat"; Debian/Ubuntu don't use the "sphinx-build-3" name=
.)
>>=20
>
> I'll take your word for it :)
>
>> thanks
>> -- PMM
>> (rest of email untrimmed for context)
>>=20
>
> My only goal here is that if you are using a virtual environment with
> sphinx installed that it prefers that, so non-standard names need to
> come last.
>
> There's probably 10,000,000 ways to do that, hence the RFC.

What's wrong with just passing --sphinx-build=3Dsphinx-build in your
configure string? It will override whatever we auto-detect AFAICT.

--=20
Alex Benn=C3=A9e

