Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87261207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yic4ajdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87261207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVAU-0004dH-N9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itUu1-0007Fj-AU
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itUu0-0004h8-7A
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:07:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itUtz-0004gh-VX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:07:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id w5so14473542wmi.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6aAQgYqsH+S1uG/+DB1Ku3IfLwrK6c2Lmk2fj97fPgM=;
 b=yic4ajdKomiVW+QsR9mHeTS0yuYerI4RfuP/QvromypNlcBcwwJI4LZo/tVfPamZF+
 6Jp5v/zgo8JHsRXObEYRKCA4xBhiUKdBLUhI1ClnHMXTczmeiPts5xQcoB8ehoXB3PdB
 rY7CVVHZXNmU2+r9hZ1fGc9vjGVCqBWUS3s4dvofOLs0WxV832umfo5Em8NXLiPKXa7G
 YULjyddgPFqfzXuZy/GHzo6GQOp6FajZ95P9+BlDPLeojjuBcnFRjvqQtuT+QJcemSS/
 MJx4Jxr9e2NTwwUWpw9cboj9BCMsh352JmGrcCCvw0VzmesnuU5HpFVJrccYX2aDq6Mc
 4Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6aAQgYqsH+S1uG/+DB1Ku3IfLwrK6c2Lmk2fj97fPgM=;
 b=WGEsGEn3hZmAYG38y3LkiT1j0wZ8HnPPgfuKboPS7bBAqel8/EnwIKwxMNExVyHhsb
 e6LG4nCfptDnBVWb8agGJO7q/J6H6zGpZQMK0iszGueNlbR6YkoMlXcmAo4Q+O9eLVFh
 h8ot9hc0uGBxH0U5Qy8lK/CE+PTma5iolstQwnbXJGXGDYAN4XDzUunqXAtROn4ZpXvQ
 WEJNDCj166QQzYd0hiaWG6rVHAjaestb/8QOYDiAIoCaLx5h2aMD6LYXhmDy3VPH6rj2
 IGpYf5HrtgR8dXdlCFABcDjic9gueDQZjgI6s2fv09McxY6V4aW5habuVbJeMjeIoZjW
 DVQg==
X-Gm-Message-State: APjAAAWoA3Bsg6+fRzKS75DNvo7Flqnnp+EfAi8O2z/Bdk3Y3mFDyCDA
 5W8McfxZVgcVEdoudQTDf9GSUg==
X-Google-Smtp-Source: APXvYqwwBZ3qht93UIhmi/D7ZFWhF7OymciD13XDYX2Q/UHucF8YJv/WZl6eAsiWYcy9HT25XHLKyA==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr18640864wmj.33.1579518446875; 
 Mon, 20 Jan 2020 03:07:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm44186198wrp.4.2020.01.20.03.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:07:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD0381FF87;
 Mon, 20 Jan 2020 11:07:24 +0000 (GMT)
References: <20200118140619.26333-1-philmd@redhat.com>
 <20200118140619.26333-6-philmd@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 5/6] hw/core: Restrict reset handlers API to system-mode
In-reply-to: <20200118140619.26333-6-philmd@redhat.com>
Date: Mon, 20 Jan 2020 11:07:24 +0000
Message-ID: <877e1m4c9f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The user-mode code does not use this API, restrict it
> to the system-mode.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/Makefile.objs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 0edd9e635d..2fea68ccf7 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,6 +1,7 @@
>  # core qdev-related obj files, also used by *-user:
>  common-obj-y +=3D qdev.o qdev-properties.o
> -common-obj-y +=3D bus.o reset.o
> +common-obj-y +=3D bus.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D reset.o

This seems a very minor tweaks as far as it goes. I though the only
thing needed in hw was hw/core/cpu and everything else was system
emulation?

However it at least moves the needle in the right direction:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>  # irq.o needed for qdev GPIO handling:


--=20
Alex Benn=C3=A9e

