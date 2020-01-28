Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65AEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22D620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjcc36Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22D620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQmP-0000Lo-Kj
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iwQlO-0008LI-Oa
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iwQlL-0001wA-4O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:18:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iwQlK-0001tb-9F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580217517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE8O1fBMADzUxlEiEYtnzqosR8LPwnW5auawy182Nv0=;
 b=Rjcc36WhBpiWTLkuvh7DU1Ezigj0MJjpefU3MoMdG2VhQFBCKPwY6B5YMHfPUoHcBI+B3L
 9I5UIeDOXHPfOUecx6XRB2FQ9lkBcQYcUKjrUrEqhVCo9G4dB13I3RNfAro8ML9lzracgr
 SaLDOzOIMohrSHa/6+eSXrU1zc4tRIU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-xnVuMGDNNH-HOuP2-1etQA-1; Tue, 28 Jan 2020 08:18:24 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so7989720wrs.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 05:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rE8O1fBMADzUxlEiEYtnzqosR8LPwnW5auawy182Nv0=;
 b=VTGBNxGL1e+vFEpD6xLPLBlKMWVw4Da6NEj+ehBezyK+70oIbWczz8J45XrCQ3HjRG
 C5hepNvCt7wbq1DKOdOJKioYuFO1iVgX3bNdzPDGMEVEIbeM0iCtaMjpiJjcDEI2+jQF
 Y0srKZXMCuB8shoJ2fW6AByw4lvbkE2SSc+SvQ1ESJqSzSJ8DjZhe4Y6G6r8y7N6PFji
 Fmj9ls/KWBemdQOtIzYp7j4ep9CP0l3emq25yWXTcnv4tUIN85yVKmOTALzpmTwO01Iy
 r5UuBlI0vP41Bk6Gc2k1DuC8ZVrRjm/t0DsJ/z9utvcXvzuSBko5GHWG4bxTWIFxmbCV
 qRXQ==
X-Gm-Message-State: APjAAAVOSAeBvAk+R32Zhx2ZJcDzhUxqNgorv0CmafCyWxeHbCP33i/w
 kQzt1NNrWdIFQxnEhq30Q99ddeYJfIvsnxKL94uTCcHiTA1Sc/sPi74zFKyDZ/sOVGxHMlRDugO
 Ubuh2XUvB1B81BqyDGAwqZABu4qEmIIc=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr5234332wmd.39.1580217503829; 
 Tue, 28 Jan 2020 05:18:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJucAbk0tRT38PVCHnjdxtSXcsBo23zXnvYjBG4mUy0A9aOVNw7PPUy3skhzrqmymhWjn8lpgR4mfdeYFN1yk=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr5234304wmd.39.1580217503522; 
 Tue, 28 Jan 2020 05:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
 <874kwfg2qh.fsf@linaro.org>
In-Reply-To: <874kwfg2qh.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 28 Jan 2020 14:18:12 +0100
Message-ID: <CAP+75-U0XZe31+QSv7t3oDwmy9fPxgQ7U165w=HU0UN_h2Jc5Q@mail.gmail.com>
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-MC-Unique: xnVuMGDNNH-HOuP2-1etQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 1:55 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Thomas Huth <thuth@redhat.com> writes:
> > On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
> >> The NAME variable can be used to describe nicely a job (see [*]).
> >> As we currently have 32 jobs, use it. This helps for quickly
> >> finding a particular job.
> >>
> >>   before: https://travis-ci.org/qemu/qemu/builds/639887646
> >>   after: https://travis-ci.org/philmd/qemu/builds/641795043
> >
> > Very good idea, correlating a job in the GUI to an entry in the yml fil=
e
> > was really a pain, so far.
> >
> >> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs=
-within-matrices
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  .travis.yml | 101 ++++++++++++++++++++++++++++++++++-----------------=
-
> >>  1 file changed, 67 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 6c1038a0f1..d68e35a2c5 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -94,24 +94,28 @@ after_script:
> >>
> >>  matrix:
> >>    include:
> >> -    - env:
> >> +    - name: "[x86] GCC static (user)"
> >
> > Could you please drop the [x86] and other architectures from the names?
> > Travis already lists the build architecture in the job status page, so
> > this information is redundant.
>
> Hmm for me the Travis page mis-renders the architecture (on firefox) so
> I do find the arch in the text fairly handy.

This might be a font problem, I can't see the architecture on neither
Firefox nor Chrome:

https://pasteboard.co/IS3O358.png


