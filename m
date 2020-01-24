Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9002071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBpQDvjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9002071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv4Cr-0007W3-90
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv4C9-00074J-Lz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv4C8-0003VD-BN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:00:41 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv4C8-0003U7-3L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:00:40 -0500
Received: by mail-lf1-x144.google.com with SMTP id v201so1817691lfa.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TMOSvFyLCpcLQiGDexwQOGb8tdaJr5bI8TnhXQlrHwU=;
 b=VBpQDvjHmgkFEG3h8bkr+0BvpRgQ6+yQ9sqnl44JvgffK9yVapGsBjqCU2kQA8S2cQ
 amYw9bUc4NOyQUI9Q4LVFi2yU4LOdMvAwtaHeL0PxPCt18XgrJ5Kn78MZQ1Wj00voflH
 npLoxyA94OkFn5t7w0WhAdU8hH6FZWOlsy/NkkQlfwx5wraAhimR7EfGrh54qOzb/Msm
 RVkGSwcKzcBpOc556W3m5eZCqzMUovGe7u27XM8yNnUpIh+I3rl4zPBmsYumFT/oznl9
 Q6lM8g0gH3MTc7iw4PgIJ/UKjTBBGia4VYRes4gB148yz4h61eq5t8hVnNhfL3nIQWe4
 4vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TMOSvFyLCpcLQiGDexwQOGb8tdaJr5bI8TnhXQlrHwU=;
 b=nNYfUT8SRhgAhXF/2VtflYylwclmI7izj7cpI7RvA9bmoL2+AI7P1B7tiCeezpy7+a
 QU0zRsoaEjq8yZVo+D6hS2x/kd1p0uPRy1fA4CnIs/9yWpxoESJA1FhxE/ZZWhk80ESg
 b+r7BpwfUb2zntCc/mKIuIGfcTQYQ6DRRUwUbN2UFiXUOUiRI5aOzXD+YsBInSibROv2
 bZFMOYrMQnjXxF69dMd+TRStJchPklfSHaLV2uaRdyRZamC7IEkUQ4jNJ2oWgyhWEKsF
 Qt3hyYJ7sG8Q1YLKKLupF2iEjnVzGCpt9f8pCRVu0oD+f8DW8Pox+ZBPIMlKDgVAUQRk
 EBFw==
X-Gm-Message-State: APjAAAXjHxSUIibM6hZG+bTXAkycUc9tv/ILe+tyBx6KLu9XnVzx9GCJ
 tWGD9FAKfsBgcLguW52jqcG8uv6wqZizmgDfPGRuBw==
X-Google-Smtp-Source: APXvYqwV3dhw75EKsVgBw5SEvBjJG5jm/VV3idIWN5IuA82JOwcz1D5vSJCmzvGx+Jnz9EKMl/SFpz0IXWelTmzBys4=
X-Received: by 2002:a19:6445:: with SMTP id b5mr2023547lfj.187.1579892438510; 
 Fri, 24 Jan 2020 11:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-3-robert.foley@linaro.org>
 <075d1da4-f59a-489e-4c64-63e76265d5c4@redhat.com>
In-Reply-To: <075d1da4-f59a-489e-4c64-63e76265d5c4@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 24 Jan 2020 14:00:27 -0500
Message-ID: <CAEyhzFsqvjooH0SbmedKGAX51AUgGMvOfVdB3gcF7aziKUddOQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] tests/vm: increased max timeout for vm boot.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

> I once suggested "When using TCG, wait longer for a VM to start"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg550610.html
>
Thanks for the pointer.  This increase in timeout under TCG seems just
right for the case we saw.  I will incorporate this into the patch.

Thanks & Regards,
-Rob

On Fri, 24 Jan 2020 at 12:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Robert,
>
> On 1/24/20 5:53 PM, Robert Foley wrote:
> > Add change to increase timeout waiting for VM to boot.
> > Needed for some emulation cases where it can take longer
> > than 5 minutes to boot.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > ---
> >   tests/vm/basevm.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 991115e44b..86908f58ec 100755
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -310,7 +310,7 @@ class BaseVM(object):
> >       def print_step(self, text):
> >           sys.stderr.write("### %s ...\n" % text)
> >
> > -    def wait_ssh(self, seconds=3D300):
> > +    def wait_ssh(self, seconds=3D600):
> >           starttime =3D datetime.datetime.now()
> >           endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
> >           guest_up =3D False
> >
>
> I once suggested "When using TCG, wait longer for a VM to start"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg550610.html
>
> Cleber took some notes about 'kicking a expiring timer' but I can't find
> it. This might be related:
> https://trello.com/c/MYdgH4mz/90-delayed-failures
>
> Regards,
>
> Phil.
>

