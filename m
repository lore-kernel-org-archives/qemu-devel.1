Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ED8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF262080C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQRFyjJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF262080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Bq-0007qK-KJ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j95BB-0007Ej-Md
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j95BA-0005Iv-JQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:53:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j95BA-0005Ik-CL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:53:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id z11so3694024wro.9
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vUZGN9nas1z3IOlddykTTfVvNsUtmPQwbKj4DiOisD4=;
 b=ZQRFyjJMEJeGMV6QQxW7crjbpso7cLd90T2eyAMU2YnCbB8GFUud+eHe/MDb6cj3/h
 gTq1A/Wmobi6+hrkaNau3I7ke+0OlTBRuH3wVr7XnWVIpkAnibnL9tSGkekGx+jRLJKb
 EZymDnnHyiLMy4RmFr02qDrsnvz2bPU+ex1HysBfOWdoGZwrluidobz7kDbQmpFbizf4
 BaSg8gN0IqFDhFcDRhUxU49JoQ79zJVV24S7baQoclLfGyZdJ16XosWGcQwAWnLWvYxp
 G1lxpKqY2SXeJ7OA+zVgexe/sszMvDLiQimq+3zIvj9j87Nj2feybW3jf7RBDTB0Emxp
 C94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vUZGN9nas1z3IOlddykTTfVvNsUtmPQwbKj4DiOisD4=;
 b=a0ggkx9//93OsP0TcBQl459xeaTcmcw+h2/77iuEJHGvyjVpos2jclANXdenm5CB3O
 u1/DnjegtFRY/N6ExX/Fvlw8tlwl4r/7c8XmMtVxds7ZxgOWNSF0gL+M9bfrgsySBFAP
 18i6vfPHoNOEHoGqSgRrwqItyxphEANSqUrBdjzFjN3AAQ3apqHovSGQKtbYjb8MViuE
 DuyRWIj2NqOKyaHl4EuPp4hcFrFhK+kQkeJexQKbLlKtT8pXmsQ3PGgvOeyYmVfiRCvV
 hxH43MOx7No04dmQjmDg1GmuwflkOPBVZ0zd9t+H6fzTyAqWaMa/t6naexxI42C6mW/n
 oUpg==
X-Gm-Message-State: ANhLgQ1vfCxeHuVJPxyw7y+Z5q+pfr8JMKn2B2Q/+6Vph1kNKOrGSKvY
 wJOj6UqzUhTzxFRsotfE8WWsAQ==
X-Google-Smtp-Source: ADFU+vuBv/6xY3lM9UhouOVS7tRkZ8dIserQTvfO/QL5BUitANPVh1AKvheYiVWaWoGPAzGfe3KZ0w==
X-Received: by 2002:a5d:61cb:: with SMTP id q11mr4874147wrv.256.1583232815048; 
 Tue, 03 Mar 2020 02:53:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c14sm17655649wro.36.2020.03.03.02.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 02:53:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 867D31FF87;
 Tue,  3 Mar 2020 10:53:32 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-2-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 01/18] hw/arm: add Allwinner H3 System-on-Chip
In-reply-to: <20200301215029.15196-2-nieklinnenbank@gmail.com>
Date: Tue, 03 Mar 2020 10:53:32 +0000
Message-ID: <87v9nl7lqr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> processor cores. Features and specifications include DDR2/DDR3 memory,
> SD/MMC storage cards, 10/100/1000Mbit Ethernet, USB 2.0, HDMI and
> various I/O modules. This commit adds support for the Allwinner H3
> System on Chip.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

