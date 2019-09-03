Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B63AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462292173E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYoNY/sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462292173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i53cv-0004ur-Bp
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i53cE-0004T1-Uy
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i53cD-0001X3-8Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:52:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i53cD-0001WN-3B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:52:37 -0400
Received: by mail-oi1-x243.google.com with SMTP id b80so5179181oii.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7rD48YKbMLYWbOexXf6kX9UvUExMP04mDDzX030rfYM=;
 b=PYoNY/sm2bCbnFzOLjaBmgN/nmlAuUtQk28YAxJijaqBO73TRM+eR4OnoZyJllGDOX
 aCKItboJvKg8h7/77jdzyfNwRhHZdQ97BdAvq1Cr3gfu9k/r2dS1nGWanGQWFUXKd6i9
 RVuTUQWcYK8zoRNLK3mu2DwEZikBiYNZVhdb6OHcM3MdmCvpBUxqUld7BidFpmvHjk2a
 bdtqloDkfe3rgWCsMHi29apIxOOvMOGR6j8auev1iagkQxUxQN7eW55qtOXIzRbtkajr
 y4eqHtnq/8NLowhz9blJJoK6to2SVFNfvDvw3J9jEtPk8EtjrfV7zi5o7jqEKDO3B6IC
 XKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7rD48YKbMLYWbOexXf6kX9UvUExMP04mDDzX030rfYM=;
 b=BUi+stEQuuMFpp1/ETY8Z6oiRbRy+x44H4UDvhhDUgiw0UoFBqDssg2sYqrHs71Seu
 /IsLEABOpP+eNZW/n3D5LDeKwgcBhQT1zDA1nNFHNvsZGais92c5p8jGchnCqtXKjSJm
 Ki6rD1YWB48nX4qxcZIUSevdOxKOR/S+IKRvSS/h0DFWUxeQ9Vy5QR+UetA9rnALPu2B
 +ckPLHqOPECsVbSXPQQ+yQqFkhwF/nYOmuI6/2BF8MSNX1IjmLKS/Vrpr8DjlIA0y24y
 iUOiST5RUrS6QkXTojSOxBVDsmYWDYdCOKuxZv+Q6Z4bRIkbYn5SFwe3gO/wpE8Q+a3g
 U3dw==
X-Gm-Message-State: APjAAAXCgh0Q+C7S3EGwTDx/PUFg+UD8K38mknBKcC1p+ynzdjW0Eus8
 x0/IadJ9bIQgWInmWkj4el8mOxnpdU7DGGSNvZzdtQ==
X-Google-Smtp-Source: APXvYqyNXutGg7cKfZoOZPKFuIwE1vtBqp4LmBjduh0/nld2cfzvkyDghRVOpnDUB7BychXaqZ7xSSxxGnPTGVee+4I=
X-Received: by 2002:aca:4814:: with SMTP id v20mr21746233oia.98.1567497155048; 
 Tue, 03 Sep 2019 00:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190827140241.20818-1-marcandre.lureau@redhat.com>
 <20190827140241.20818-2-marcandre.lureau@redhat.com>
 <e3b0333b-848f-62b6-f12a-23b6a83afb0e@redhat.com>
 <CAFEAcA_a8xShCR_owqC_QhZU=iGaG_E0fLH8GciTpdk66HRVHw@mail.gmail.com>
 <87o9036n7g.fsf@linaro.org>
In-Reply-To: <87o9036n7g.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 08:52:24 +0100
Message-ID: <CAFEAcA_eP=zuQnk8p_q9jshC2gW10qkW5bth1CzsS=nr+wscSw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fix modules-test with no
 default machine
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Sep 2019 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 27 Aug 2019 at 15:46, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> On 27/08/2019 16.02, Marc-Andr=C3=A9 Lureau wrote:
> >> > Fixes: eb062cfa733 ("tests: add module loading test")
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> > ---
> >> >  tests/modules-test.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/tests/modules-test.c b/tests/modules-test.c
> >> > index a8118e9042..d1a6ace218 100644
> >> > --- a/tests/modules-test.c
> >> > +++ b/tests/modules-test.c
> >> > @@ -1,12 +1,14 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "libqtest.h"
> >> >
> >> > +const char common_args[] =3D "-nodefaults -machine none";
> >>
> >> "-nodefaults" likely does not do much with the "none" machine ... OTOH=
,
> >> it also does not hurt here.
> >>
> >> >  static void test_modules_load(const void *data)
> >> >  {
> >> >      QTestState *qts;
> >> >      const char **args =3D (const char **)data;
> >> >
> >> > -    qts =3D qtest_init(NULL);
> >> > +    qts =3D qtest_init(common_args);
> >> >      qtest_module_load(qts, args[0], args[1]);
> >> >      qtest_quit(qts);
> >> >  }
> >> >
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>
> >> Peter, will you apply this directly as a fix for the travis builds, or
> >> shall I take it through the qtest tree?
> >
> > I'm happy to take it directly (assuming patch 1/2 doesn't
> > have anything too big in it -- it hasn't arrived here yet.)
>
> I've been testing this in my testing/next tree and as you're not back
> until tomorrow I can have these sitting in the PR I'm pulling together
> now if that's ok.

I just got back and found that I'd put the patches through the
merge tests but hadn't done the final 'and push to master' part,
so I've done that now. I assume git will cope with them being
in your PR as well as in master...

thanks
-- PMM

