Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E10C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2913820672
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWx4oyGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2913820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqOx-0007uv-9E
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQqNy-00074R-75
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQqNm-0006WN-O3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:44:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQqNm-0006TO-Bg
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:44:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so13867321wrb.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=80hlV0Sh9Ka+anWigr63uCM/Wn3bkFpbqyYQySB9lT4=;
 b=uWx4oyGC5McPvO7ttrNerMAYOSghN+qV4XSGaKHw61UrnGGoAFHnxJ7oYC4m80s0hH
 RfGZhCz2bKXW5REGC1AAHkEhI/N2RGkTv1jrhMJOHVq/NUqc27p3ko1U0Jw/gh20wgDN
 IJAWN/E0nyOi7FJYMFpkKDzIS6sEuIv1HEeONQDj6qhLzZflRAo4nCFB8wrIPisXamSx
 gC4uvCBjhPXXkCwGZbrzC4PdGjPRITKSoQm1+IMaHoOOJp4ibj+cQpk36n1d2DzgNOiT
 WWBkWsz5yWunqqJfkD9faE7nCU1ePHWTCAKv66fEpT4qrlV2OoBpbYonLCBK4EFSmxzS
 Q8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=80hlV0Sh9Ka+anWigr63uCM/Wn3bkFpbqyYQySB9lT4=;
 b=Yz31gqRmofamvL1o69dxcV5q1Z0W4+usb78DEOABgW4l2Ha1c/rfDPhVaeYn9z0e5r
 AByLMxyik4Vyi+/57oIHMNQRSiv5uNwC/OX6jo4qLGei4/DI9kYKOFT1pAdx6uXTPL29
 Uzkb6UFeoW/BeE8O+TNPyT+PAIk/ruW2IXtEuC0a31/Jwbgbj/R6RRJROeV2J1zhSrRg
 KabCQXxzr8TuD1YmitUaX0h7MiaTVDvD69Tc/KQ2F/fdO/ko3f9ThlYBZI7ZSn1cPxkU
 Ls1TDNg1vFMfLTukqHfGBzf8LaDdGBXVZ9hQeh9bTDNIl4gCYaCJiHs11F3sKC5EKOk9
 2zng==
X-Gm-Message-State: AGi0PuZ2X0zqwYcLzLznDKpUREKY9Z8uh77gS3ENR9aNOtFN0P5ffF2G
 Jf3uN4hcPll1YvL/C7NuUuwVIg==
X-Google-Smtp-Source: APiQypIAujuEWun3HQ8G04MmS3vzXy1lUdVT7IxoAS6xdziWezOY6FSyK4ST8tqZ+Ggpyq4j/o2urg==
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr3024180wrt.26.1587465840943;
 Tue, 21 Apr 2020 03:44:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y9sm2865223wmm.26.2020.04.21.03.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 03:43:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A34A1FF7E;
 Tue, 21 Apr 2020 11:43:59 +0100 (BST)
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-2-f4bug@amsat.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/4] MAINTAINERS: Cover the GDB Python scripts in the
 gdbstub section
In-reply-to: <20200421094216.24927-2-f4bug@amsat.org>
Date: Tue, 21 Apr 2020 11:43:59 +0100
Message-ID: <87y2qpce4w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Keep an eye on these "same same, but different" files.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fac2b..7a7f2b9c31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2083,6 +2083,7 @@ R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  S: Maintained
>  F: gdbstub*
>  F: gdb-xml/
> +F: scripts/qemugdb/
>=20=20
>  Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>


--=20
Alex Benn=C3=A9e

