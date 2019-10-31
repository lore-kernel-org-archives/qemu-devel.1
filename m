Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3671CA9ECE
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20642083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBREAAOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20642083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5VX-0008Dt-Uq
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ5Ta-0006rM-G3
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ5TY-0002i7-EH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ5TY-0002Va-71
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:06:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id 6so5995034wmf.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BbwrnMX9JtWTbR/3U6krBIhdo19di9JBayZPJctdb4Q=;
 b=aBREAAOrD6RFobSeAaGwhSQ2NS6Yyz1wMY3YqBH4CBWbg8QoZ3GA55dt6bs1z+1wTx
 UCK46ezf5CeafZO7l777DtUWe0nV+sO9sUP/PlJ98Hx53Bn0v8599cYl72vpJ/rSkyYn
 f6Lj/sDZk8KDTKtrIGzNdWQyLR3rdf7e5FPEyc2G4xhzRuXLa9Do+mumLz+ZVf4RzP3h
 qHxF74PpVbQQqo5yOHEywu/VcLfuT7s3VflEx9vHWgMIi6CA0flqU8FZ5+RVOP+xsADF
 P4wqBZZWeIoo4VNB88eLAEwrQnuYt92c6tXvZHipj7ZBlJhlRo7Bij1QP4KkZHxGxQSD
 j07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BbwrnMX9JtWTbR/3U6krBIhdo19di9JBayZPJctdb4Q=;
 b=KSfudmtqFCojfE3s2j9A/CVWFdAiiJ6V4ZfhOvgcVzUBjLuwhDj2PNdLCxUtVouId1
 ziOXcLU3GgAj8YugI6tnX9mvCbxkMi75Pju47qfM7EHarzjxkqQRwZ1u9oHzX4o1VBge
 KHA9Z9rt+sfDakb1cxiei4loWUACJ+PsqgvqDeXNM6V+K0CU0Z5aXtcK6jB+gWRWntN0
 DyfLDQeUqECsHTxuHTDZ7LF7qP5UkD/KfulAkJTN91ooVgo6pCXJ/gGIikKvGuOxQHmM
 IzEepySo7+uJM9iYgcw9UTKuCyIigDagwZ4XhkMAvYsoTKXIVrozUvo7GqwNCWGpknIN
 SE9g==
X-Gm-Message-State: APjAAAXMb6OeGEyBAtvaoAmXIG/9WmuGw2uV7O5D/KZtphQTjpUx6EBP
 J6Uu5Li2y5zjEAGTdVjuJJRYFA==
X-Google-Smtp-Source: APXvYqw7Q89oPo0ag7y+YmOD5JKTnySX/IYiLoaZ4EAMl+B2P92Utikf/h2exi0VQs54Dm5yD75Opg==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr3574395wmg.98.1572509193230; 
 Thu, 31 Oct 2019 01:06:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 6sm3286988wmd.36.2019.10.31.01.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 01:06:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A8B01FF87;
 Thu, 31 Oct 2019 08:06:31 +0000 (GMT)
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <20191029232320.12419-3-crosa@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] Acceptance test: update kernel for m68k/q800 test
In-reply-to: <20191029232320.12419-3-crosa@redhat.com>
Date: Thu, 31 Oct 2019 08:06:31 +0000
Message-ID: <87bltx8hko.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> There's an updated version of the Debian package containing the m68k
> Kernel.
>
> Now, if the package gets updated again, the test won't fail, but will
> be canceled.  A more permanent solution is certainly needed.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/boot_linux_console.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index c439fd90fc..8f676d8e92 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -385,14 +385,14 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Dmachine:q800
>          """
>          deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
> -                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.u=
deb')
> -        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
> +                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.u=
deb')
> +        deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>          try:
>              deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>          except OSError as exp:
>              self.cancel(exp)
>          kernel_path =3D self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinux-5.2.0-2-m68k')
> +                                            '/boot/vmlinux-5.3.0-1-m68k')
>
>          self.vm.set_machine('q800')
>          self.vm.set_console()


--
Alex Benn=C3=A9e

