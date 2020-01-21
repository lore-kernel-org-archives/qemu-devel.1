Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D65C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7506C2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgCGKjqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7506C2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itv5q-0008J7-8t
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1itv45-0006wh-S6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1itv41-0005MZ-HT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:03:37 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1itv41-0005K9-8h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:03:33 -0500
Received: by mail-lj1-x242.google.com with SMTP id u1so3121857ljk.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TzqKfwD/PW+oYsUJMo1neA0G+XqzarcdrQtmMVi1wCo=;
 b=DgCGKjqCKB5rbHARnsMEggvpTOMAikb1wKkNSQBcwXfGEVkV2tLkSoQWemvBionkT2
 P158aK5mQ+MeTyShUxmmQCThjelBpvPCwF7FY9PjXp6auRctgoIAe7HAUzHiuw5BPCpq
 6GAPJwOjtZoguNY+BUzbaRYf+Jqs5gAZGh4kW5Dx0ArLIb0TG0Yt72PBi216rmSDebNm
 Y4nlTDrGx37VPh/jZCFOkntcm0g2mvPbj5HoQACcd8RJIbZWMeTQTlFmk62n44FOZQ4O
 Dk3e4ui9cfjnINbGf4XidPMMc9io6bWdWPkzc6BeQIxX2byvlqzBj3Dq3khHkj8TH9xO
 PCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TzqKfwD/PW+oYsUJMo1neA0G+XqzarcdrQtmMVi1wCo=;
 b=oJrNCUC2dVqXs66jdDSmkOc3sd08KPE+ti7rNo6qfluSPCy31/1ywknMVbbQtZlALC
 alkXiaKqMH5y1r5UUh8W4CuoYJLJlgub00WgjQhXoDKYQtEdcvxjWNJEN+rms5jdjim9
 dIzrkSqt+WfKwDOqKZCJ7idR2i7DfNPDxNUiZuE9mzj3mlrYmakue2dLpg5QCocE1fLd
 W8+dZXHc48mQSBLtoLsGUStaoLno1fzUYfMDMT4wRy3XmBJPlFIWCxPtAeQyTYhYxDID
 8x1doqTWt5tfSYcfWCwNVz89lUaYXClfAsviP/iuXzeUnuT8gU39BX4ebG1V79aKX3uh
 Z6wg==
X-Gm-Message-State: APjAAAVa/dp5A015Ao5CmNXtJLJAGJbE90lTBp8yuns3D86LzmJH47D1
 0pDo+FWtWzWgVftBlQw4vm6/mbV18dDsKhQ3Vsr5fg==
X-Google-Smtp-Source: APXvYqwXC26EqZbhCD4fWWYVZPWe9S/Jh+QXCAeTZ0gwRzyFAHBRXA4lg3aN84Xx5M7btRKoOMaQlaZQW9Iwnbn1JIU=
X-Received: by 2002:a2e:b61a:: with SMTP id r26mr2893853ljn.72.1579619009516; 
 Tue, 21 Jan 2020 07:03:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598240.git.mrezanin@redhat.com>
 <63b0fcedf7dfe799c8210b113e5dccf32414a89d.1579598240.git.mrezanin@redhat.com>
 <14ba746f-97c3-1ae3-c836-ad2e3e213756@redhat.com>
In-Reply-To: <14ba746f-97c3-1ae3-c836-ad2e3e213756@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 21 Jan 2020 10:03:18 -0500
Message-ID: <CAEyhzFuJoFYy_aE6fq1ieHcEcgWQCUkwHmGNQ0gJiazusH3BAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-logging: Fix -Werror=maybe-uninitialized warning
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, mrezanin@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Good catch.
Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Tue, 21 Jan 2020 at 04:58, Thomas Huth <thuth@redhat.com> wrote:
>
> On 21/01/2020 10.28, mrezanin@redhat.com wrote:
> > From: Miroslav Rezanina <mrezanin@redhat.com>
> >
> > Checking for uninitialized variables raises warning for file path
> > variables in test_logfile_write and test_logfile_lock functions.
> >
> > To suppress this warning, initialize varibles to NULL. This is safe
> > change as result of g_build_filename is stored to them before any usage.
> >
> > Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
> > ---
> >  tests/test-logging.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/test-logging.c b/tests/test-logging.c
> > index 1e646f0..6387e49 100644
> > --- a/tests/test-logging.c
> > +++ b/tests/test-logging.c
> > @@ -114,8 +114,8 @@ static void test_logfile_write(gconstpointer data)
> >      QemuLogFile *logfile2;
> >      gchar const *dir = data;
> >      Error *err = NULL;
> > -    g_autofree gchar *file_path;
> > -    g_autofree gchar *file_path1;
> > +    g_autofree gchar *file_path = NULL;
> > +    g_autofree gchar *file_path1 = NULL;
> >      FILE *orig_fd;
> >
> >      /*
> > @@ -157,7 +157,7 @@ static void test_logfile_lock(gconstpointer data)
> >      FILE *logfile;
> >      gchar const *dir = data;
> >      Error *err = NULL;
> > -    g_autofree gchar *file_path;
> > +    g_autofree gchar *file_path = NULL;
> >
> >      file_path = g_build_filename(dir, "qemu_test_logfile_lock0.log", NULL);
>
> Right. The glib documentation clearly states that "the variable must be
> initialized", see:
>
> https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html#g-autofree
>
> So this is the right thing to do here!
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

