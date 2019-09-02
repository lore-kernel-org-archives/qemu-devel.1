Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC509C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B887D217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vP3oyCLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B887D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4j0O-0002wr-TV
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4izJ-000202-ED
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4izI-0003rb-1X
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:51:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4izH-0003qO-Qy
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:51:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so11984891wrt.13
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=boxTdfILFpg2zK/e1WRqUW6AdH2c3p1NAxzrh6tLK50=;
 b=vP3oyCLWEhGq0amlsl8/edIGvpgcLg4YlAgTms8R/2idV3vlenyEP5mtWaOSjqkVBE
 l4B3Gd3eS2T4N0rbuvVah4r2XY9sj24Eg4QonLR2M6SYvjLDERtbQqzlz/zMhaaomhgH
 w4sV2mEZa3fO5bE7LXH89iJWFjX/V83II9yWBGrNZP6HoU1zRp8b+qUPQZBVbSnQcy6z
 T7zrbceCxyHfd+Ln8xf65uN7FJvnBaXWlhL2OV7WpIBAnXJciVic775t7RRsnvqA7Odk
 w97K6ZrF4L4VAmOQJlnMkxqzrKj8Tfh0OO6PTsg2tMYM+NeX/JdFXv6ply2XIdibNg4n
 d03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=boxTdfILFpg2zK/e1WRqUW6AdH2c3p1NAxzrh6tLK50=;
 b=CZkG36OeQ3/NkjQvinq/2deWNUlNXcMp3GIIM+nxKxzLdmJwyr392aOGIiO+bfaNqQ
 viVsSF9kKmb8Ihp5bO9dNaQH73H2BBa4qKwRdqfdlNxHU2z0u66z52oB0S6xASCbtB9K
 Xf5vMW2fL21AsXbkQL4j3uVPtVg4EiZ8kTgQAPgAHQNmis8GMeJpOnZjcT5Dwr+ZHorM
 W601pk9QDdl8hYjFZfPGwy5EoO4j0Da2RMQ04RWLrGAgRjCCVtghXxP0uPlQVhHUaznV
 KyqKY3D0DttwIk8UrotlOCqokKf2St/qhkYvptG/sVtlaPOsBiyG8pQuhdN7jUvwv+dv
 QoAw==
X-Gm-Message-State: APjAAAUtixEVcKNjIVMI/fsvyqjSH/lDVUGNAHvcB8fTvyBlbs2fuz04
 gyCSR0pFPgkm5ORDDwXjpcREtSQFyCQ=
X-Google-Smtp-Source: APXvYqwzDzT/Pq6pb/oawYsVblLjXYm96RrD7y7p8+AZPPHwdbDqwCn09kJNYpjulSy8TUwYcTznfA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr34367184wrq.321.1567417860907; 
 Mon, 02 Sep 2019 02:51:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f186sm18645998wmg.21.2019.09.02.02.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 02:51:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 548F61FF87;
 Mon,  2 Sep 2019 10:50:59 +0100 (BST)
References: <20190827140241.20818-1-marcandre.lureau@redhat.com>
 <20190827140241.20818-2-marcandre.lureau@redhat.com>
 <e3b0333b-848f-62b6-f12a-23b6a83afb0e@redhat.com>
 <CAFEAcA_a8xShCR_owqC_QhZU=iGaG_E0fLH8GciTpdk66HRVHw@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAFEAcA_a8xShCR_owqC_QhZU=iGaG_E0fLH8GciTpdk66HRVHw@mail.gmail.com>
Date: Mon, 02 Sep 2019 10:50:59 +0100
Message-ID: <87o9036n7g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 27 Aug 2019 at 15:46, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 27/08/2019 16.02, Marc-Andr=C3=A9 Lureau wrote:
>> > Fixes: eb062cfa733 ("tests: add module loading test")
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/modules-test.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tests/modules-test.c b/tests/modules-test.c
>> > index a8118e9042..d1a6ace218 100644
>> > --- a/tests/modules-test.c
>> > +++ b/tests/modules-test.c
>> > @@ -1,12 +1,14 @@
>> >  #include "qemu/osdep.h"
>> >  #include "libqtest.h"
>> >
>> > +const char common_args[] =3D "-nodefaults -machine none";
>>
>> "-nodefaults" likely does not do much with the "none" machine ... OTOH,
>> it also does not hurt here.
>>
>> >  static void test_modules_load(const void *data)
>> >  {
>> >      QTestState *qts;
>> >      const char **args =3D (const char **)data;
>> >
>> > -    qts =3D qtest_init(NULL);
>> > +    qts =3D qtest_init(common_args);
>> >      qtest_module_load(qts, args[0], args[1]);
>> >      qtest_quit(qts);
>> >  }
>> >
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Peter, will you apply this directly as a fix for the travis builds, or
>> shall I take it through the qtest tree?
>
> I'm happy to take it directly (assuming patch 1/2 doesn't
> have anything too big in it -- it hasn't arrived here yet.)

I've been testing this in my testing/next tree and as you're not back
until tomorrow I can have these sitting in the PR I'm pulling together
now if that's ok.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

