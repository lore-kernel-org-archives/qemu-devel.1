Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C338C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CF920720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvI0keKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CF920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06Yu-0006GK-8n
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j06X3-0003Qd-H5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j06X2-0000vc-7w
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:31:05 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j06X2-0000t0-1M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:31:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so2698001oty.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A0FH83oh7ENKUjuXubeD3BNm6HJpW6vKnujDArV3+eg=;
 b=kvI0keKP0K2ncWB/Dy+Grj3GdMCgyjYkQdeAtHHSr2giE4vGQTFcUhnF1qfSxoDQ8J
 7kM/oX3QmQo8/E1JIp/1iJadaFLu81OHZji5X+TTX7SoMb7soO/9ZeHKXxpZSz/JujWv
 7jwKHdtMYaV5mzoWiNVG0OB5Tu7YAy6JUjcaYejUOaoylC66DfF93fHRVWzuS/HcUHB8
 8cgVAmbXB2oRZrfH63p8kkt46QZm0OBNBTmyYwyp/0LfWyIWeI3MZf9wWjukJjDFHSu1
 rPpyLozsu9I8KJG3fBT/t/2lZVajTAIoIdzeKiVhmlsixprXgZFQXL+h9WABpMdlmzbX
 Ndpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A0FH83oh7ENKUjuXubeD3BNm6HJpW6vKnujDArV3+eg=;
 b=ufD1n6+5PIFybMPX2/RbiaDvhyrX7aprzZrCub+9j4JeFhyWiVtLLzWGcJMm5o3eMb
 sXeXgzMtRCfB10haY3UKYcKbk2E51swtnnkOcWl4DVWPAnP6zuedS72CrHvRSX394ZeF
 r+SH9DE9249klUV3ZyLXqajiqKprTnQJ5CkRJfqiDbhP23uu4zuABca1m6tUpviqHA4N
 DOirWgwda6noIFcjTezDiWGVT1CcE3N5NNQmYnd9d0ZcG/47am3BOv68m7a3KBVbFqgH
 zKwD8lEglC3W+x/8cl3iLXdSRMoua3IrMFNAZ/hOnJrLgn4g+i6G78oar2/s8gdy03n9
 m5SQ==
X-Gm-Message-State: APjAAAU4mAuSpv280LICfdr6IT2EDUk3ZuF3B8nHklmTiRf+/ylsPfZ7
 zOh01BXAfAYF8nJMsOO6KZzFqw0DwQbHISEtUm4d7Hm6
X-Google-Smtp-Source: APXvYqxpzNBBfDGuUkAnpRpU8S+j0eDhzniGT6ODi5fD3ipsIwia6OAHXBFxyIZRvH6z9TK49lRKX2d+vS5VbiriofU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr161339ota.232.1581093063008; 
 Fri, 07 Feb 2020 08:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-3-peter.maydell@linaro.org>
 <875zgipe1n.fsf@dusky.pond.sub.org>
In-Reply-To: <875zgipe1n.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 16:30:52 +0000
Message-ID: <CAFEAcA90qHdHvozNhjX0d5xzoOiFb6oTVdXWf9u9aRvV=YHw4w@mail.gmail.com>
Subject: Re: [PATCH 02/29] configure: Check that sphinx-build is using Python 3
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 16:18, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Currently configure's has_sphinx_build() check simply runs a dummy
> > sphinx-build and either passes or fails.  This means that "no
> > sphinx-build at all" and "sphinx-build exists but is too old" are
> > both reported the same way.
> >
> > Further, we want to assume that all the Python we write is running
> > with at least Python 3.5; configure checks that for our scripts, but
> > Sphinx extensions run with whatever Python version sphinx-build
> > itself is using.
> >
> > Add a check to our conf.py which makes sphinx-build fail if it would
> > be running our extensions with an old Python, and handle this
> > in configure so we can report failure helpfully to the user.
> > This will mean that configure --enable-docs will fail like this
> > if the sphinx-build provided is not suitable:
> >
> > Warning: sphinx-build exists but it is either too old or uses too old a=
 Python version
> >
> > ERROR: User requested feature docs
> >        configure was not able to find it.
> >        Install texinfo, Perl/perl-podlators and a Python 3 version of p=
ython-sphinx
> >
> > (As usual, the default is to simply not build the docs, as we would
> > if sphinx-build wasn't present at all.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > ---
> >  configure    | 12 ++++++++++--
> >  docs/conf.py | 10 ++++++++++
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 0aceb8e50db..2c5cad13edd 100755
> > --- a/configure
> > +++ b/configure
>
> Any particular reason for having $sphinx_build default to the
> indeterminate version sphinx-build rather than sphinx-build-3?

Because that's the binary we were using before this patch.
"Allow the user to specify" shouldn't be tangled up with
"and also change the default".

It might be sphinx-build-3 on RH, but on Debian/Ubuntu it's
just 'sphinx-build' assuming you installed the python3-sphinx
and not the python2-sphinx, or you can run it directly out of
/usr/share/sphinx/scripts/python3/sphinx-build, or (like
me) you might have a locally installed 'sphinx-build' which
is using Python 3. My assumption is that once the python2->3
transition has faded into the rear view mirror most distros
will just have a /usr/bin/sphinx-build that's a Python 3 one.

thanks
-- PMM

