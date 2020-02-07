Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46BC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D922820715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vh1hggbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D922820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Lp-0006kX-Lq
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j02KR-0005VR-Su
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j02KQ-0004qs-2g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j02KO-0004pY-MM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so2345925wrd.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IkXdX3jqdzZqpQ5BvV+KV+8d39GBQpKyYclb//73NFU=;
 b=Vh1hggbQMf8o4JDmsv/89oxq709arjDZwo64IMg2FnWg1r9TnWbaB74tP0lwcBquj0
 rdCmvfQ8PN01EhoPl5fasNik7hsZS7IWGgWxOBO96e3tTduyDEa25HB/rVhrhXvPyfGg
 z/3tKVbj064nlJDCLG+HTpIzw8OfXjnSIMQeLUPTzClfNl4FLQQ2Xx7ERTSyxT6nwly1
 LeBu2h/1EGMRxpQVf02iOv471ENJmzW+pVVEH4P/SAcwO43qpbXI+SBNYfs2Xj7D7ZoE
 YEMYzpNwUeh5yNJGc78tHU+GzIHLJYQS1dH46UVPJWuniRVnEA6W7WgGBIRkO2AeycwD
 K/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IkXdX3jqdzZqpQ5BvV+KV+8d39GBQpKyYclb//73NFU=;
 b=gHYMN1jWtY1ivozKppJhu6sFsLF5+weinjQcQ4EtIsfmqIq182Nsry2mBc1QsIW4Fz
 oK2lMNLnv1vmAJpeU5iLoDU2U2HvuIapPDMO+i0Ty1RzSWKEZMP9EWWWCqkXkuY5BZa5
 E0T2Gu21S082AoV8cnIV62eC6866KiUZqs8Hpb7rkUrgUcnnCShet6xKdrvxvIPYrWaB
 B7QepoAs+UfLKG79r1AeMKftDYcegi6kxf6u7vNaeh6NRGmcE/tDqfJ/Tc9Fuwdxn6om
 cXuoouXC5b+v43WDRtTXPUmTguoS7ro/OeiHMvKOSH1HwornPO+aRaRdd84ppG4VckXf
 TV6Q==
X-Gm-Message-State: APjAAAUnqylOyOxMaSvShRSGpvagCkhszePsVR1oEcirOIK+WhkIlh/e
 SPZhPBGuRxT0Nbth4LDz4THn6w==
X-Google-Smtp-Source: APXvYqyGDTtn3Go75gAnI1MweyIvg6Q1Z8WseWzwfPKCPGLFqw+g+j/fZLDRtwylYk1rvPtlNpN+Ng==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr4328120wre.404.1581076903615; 
 Fri, 07 Feb 2020 04:01:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t131sm3218448wmb.13.2020.02.07.04.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 04:01:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A82B01FF87;
 Fri,  7 Feb 2020 12:01:41 +0000 (GMT)
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-5-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 04/14] tests/vm: give wait_ssh() option to wait for root
In-reply-to: <20200205212920.467-5-robert.foley@linaro.org>
Date: Fri, 07 Feb 2020 12:01:41 +0000
Message-ID: <87k14y7gii.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/basevm.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 4de358ae22..a29099f6f1 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -314,7 +314,7 @@ class BaseVM(object):
>      def print_step(self, text):
>          sys.stderr.write("### %s ...\n" % text)
>=20=20
> -    def wait_ssh(self, seconds=3D300):
> +    def wait_ssh(self, wait_root=3DFalse, seconds=3D300):
>          # Allow more time for VM to boot under TCG.
>          if not kvm_available(self.arch):
>              seconds *=3D self.tcg_ssh_timeout_multiplier
> @@ -322,7 +322,10 @@ class BaseVM(object):
>          endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
>          guest_up =3D False
>          while datetime.datetime.now() < endtime:
> -            if self.ssh("exit 0") =3D=3D 0:
> +            if wait_root and self.ssh_root("exit 0") =3D=3D 0:
> +                guest_up =3D True
> +                break
> +            elif self.ssh("exit 0") =3D=3D 0:
>                  guest_up =3D True
>                  break
>              seconds =3D (endtime - datetime.datetime.now()).total_second=
s()
> @@ -333,7 +336,6 @@ class BaseVM(object):
>=20=20
>      def shutdown(self):
>          self._guest.shutdown()
> -

Stray line deletion. Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

