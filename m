Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E9C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ADB214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWN/+6rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ADB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Fu-0008Ti-A4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw2Da-0005TW-IK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw2DZ-0006OV-Aq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:06:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw2DZ-0006Ly-35
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:06:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so2787645wmh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0brxlos2dAT+TZz7MuM6STQmpKPKhSVrrcuFK/NGZVU=;
 b=XWN/+6rxNKiywveyCAzvFkBAM03FBn7GVm1+2rF7nU4KxnegpSH2V3sBL450dS6uO8
 doi68BWx6L6fafPiyFphmN1l0wfBGMmKvWM4pyozNtGQHbyBM7KROafbpM/8LakZLCQB
 vlmc/F09/ciTXY/vBzJTstYzU6VBiWT6guszHeqPXugnyCiZq9ForYtJwZqiCmfUZKIG
 JvbKgyVJMHcDH6Vy21Xx6j+ykyVT56hkh2LJw2Jmft2RNl76I1GSfEzdbQ3O3JDSxDzu
 psgWQo4VHZQVBggv8ehtwEWYzRFtHzKOy7UM7emWzfGDSnjhsoBKgbdVqR+A0VPQyuSP
 CBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0brxlos2dAT+TZz7MuM6STQmpKPKhSVrrcuFK/NGZVU=;
 b=MjYDjQYFN9jC+PzpW/wdhFKsq7BvCISuVhcvMkT/htVZY0FYwrJ9YxqcO+YR2XWZkz
 8ziAuBAuwCqsfSsjqmJYGMaFsuR7DO4Vw4P1HC+erq7fAbQ+ckDRn9kNBeQTW6TiwN7N
 PhxyFCgmbSoo/xyIPDocEHhSKnu1O5hd1IWTcFGIooHFF229mWpD+9ZanXtvONFRmaZ+
 uY2Wvu5wJu4Yrip8WRIx6wORDt6mribhWST5EWI/2dna4yutE65fQ/a3ZWA05Twtjdx9
 IE/C2T5FmBB4BrCwkG7Cdc9Otzx96P+/ERU5KkgIfo0qVLYBGdXP+mLmmVkI4Tz8BZW/
 C5sw==
X-Gm-Message-State: APjAAAVGikQHwsjE3gkxq6WDsNmR8d3eagHyB/hwIPN2ZZ7VKIp3qGhK
 RrC3pTmwnKBvA0H3HOEEsy1z1A==
X-Google-Smtp-Source: APXvYqyJ5R7NCqrstGS3SctuAfrxnnjsJjY2kXslnE/WUzpmO0568J+y3xjgIaq1vT9PNhPgq5Km4Q==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr13119567wme.186.1580123167043; 
 Mon, 27 Jan 2020 03:06:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w26sm8941579wmi.8.2020.01.27.03.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 03:06:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D2C31FF87;
 Mon, 27 Jan 2020 11:06:05 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-4-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 3/8] tests/vm: change wait_ssh to optionally wait for root.
In-reply-to: <20200124165335.422-4-robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 11:06:04 +0000
Message-ID: <87v9oxf9b7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Allow wait_ssh to wait for root user to be ready.
> This solves the issue where we perform a wait_ssh()
> successfully, but the root user is not yet ready
> to be logged in.

So in the case it's the root user we care about...

> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  tests/vm/basevm.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 86908f58ec..3b4403ddcb 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -310,12 +310,17 @@ class BaseVM(object):
>      def print_step(self, text):
>          sys.stderr.write("### %s ...\n" % text)
>=20=20
> -    def wait_ssh(self, seconds=3D600):
> +    def wait_ssh(self, wait_root=3DFalse, seconds=3D600):
>          starttime =3D datetime.datetime.now()
>          endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
>          guest_up =3D False
>          while datetime.datetime.now() < endtime:
> -            if self.ssh("exit 0") =3D=3D 0:
> +            if wait_root:
> +                if self.ssh("exit 0") =3D=3D 0 and\
> +                   self.ssh_root("exit 0") =3D=3D 0:

...why do we need to test both here?=20

> +                    guest_up =3D True
> +                    break
> +            elif self.ssh("exit 0") =3D=3D 0:

Is this simpler?

    def wait_ssh(self, wait_root=3DFalse, seconds=3D600):
        starttime =3D datetime.datetime.now()
        endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
        guest_up =3D False
        while datetime.datetime.now() < endtime:
            if wait_root and self.ssh_root("exit 0") =3D=3D 0:
                guest_up =3D True
                break
            elif self.ssh("exit 0") =3D=3D 0:
                guest_up =3D True
                break
            seconds =3D (endtime - datetime.datetime.now()).total_seconds()
            logging.debug("%ds before timeout", seconds)
            time.sleep(1)
        if not guest_up:
            raise Exception("Timeout while waiting for guest ssh")


>                  guest_up =3D True
>                  break
>              seconds =3D (endtime - datetime.datetime.now()).total_second=
s()


--=20
Alex Benn=C3=A9e

