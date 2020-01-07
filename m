Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61954C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED34207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="difeiYM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED34207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionTU-0003Ct-He
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iomGe-00077V-1S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iomGc-0008Up-VS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:39:19 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iomGc-0008UA-Oc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:39:18 -0500
Received: by mail-wm1-x342.google.com with SMTP id c127so13890460wme.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=083p/YJcb2cj3fsrtAL/N02jVsHsBhdOeQ/BfG6pu1g=;
 b=difeiYM8yKCvzr/jI7IstNIyKU3CmB8gwcPOwvMJhK5RiT+9ehMvkNCbZN+WPlbncs
 n+rWA5g5MjYPnYXJQIn0FiGS/+t4GTAZ2LxU/DhtSAWoshr+1ej5+TBFtUYGMPPmaQ8+
 hr+EV1D31zviZ8t/AE4rS0uvj8sXPKQiaAhyiRNwW0mPDJBtD3G1zN8wnKHthIw8klIS
 SjoFl2qJE+7FTTpfBlroaUUn4RuvJnTab1wUKa8npwv2/I5ns28iAiVGBolt5qgRzx1D
 8/CNZkJTm9QEGAk0OEUFhaJ0Tepwz1CqauTqV29ZRDioIcdguSbELVfhQD4DNIWhVwj/
 AhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=083p/YJcb2cj3fsrtAL/N02jVsHsBhdOeQ/BfG6pu1g=;
 b=QjAsE8wuUqf7aa/pk9BjWcedUAGwMwFjUlAAmLFW+vZKemezx0UhhtBjIPvrCajYX9
 HJthsiEOUX6YgVD4GDdZW/LhipJ8fzDK1YsyevYWMUSVlwPDmElNqPBvEU0KwLF87K8V
 GQ6YXHSQ+qaDCGzwFwJWAq9RzXbTpI17wMPekiwxVxT+1v9zNKSxEEJYEgIdWoslcB0k
 NFmtTYLxm+G1P3OcZudfsIJHsQnY6s/AJB9k5HRzssHuVHNHEtGB4x6mkYFHyhfd4RLq
 +8fyUaj8r1psF8RyZPxGcwsZduAGfM0lLuVoShjTmKWppLVWZQvdT+auv4EqS9zsyqMV
 4GyQ==
X-Gm-Message-State: APjAAAVtmOkvjhvj85mw1JThOIFyzJjA8scH2yz7x3f4uyfa6/NBnWh3
 KrU2jldM93iuU4nhmrZUm4gx1w==
X-Google-Smtp-Source: APXvYqw3DJIigc3c127/+WyirN10btzB1c49XyDLqkfd36tZMSu5f2upzC5Y5tiJhMoHTIdnhTOfzQ==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr38723186wmj.165.1578393557443; 
 Tue, 07 Jan 2020 02:39:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm74535039wrl.17.2020.01.07.02.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 02:39:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57C851FF87;
 Tue,  7 Jan 2020 10:39:15 +0000 (GMT)
References: <20191230082856.30556-1-philmd@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] scripts/git.orderfile: Display decodetree before C source
In-reply-to: <20191230082856.30556-1-philmd@redhat.com>
Date: Tue, 07 Jan 2020 10:39:15 +0000
Message-ID: <87blrf5z58.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> To avoid scrolling each instruction when reviewing tcg
> helpers written for the decodetree script, display the
> .decode files (similar to header declarations) before
> the C source (implementation of previous declarations).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  scripts/git.orderfile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index e89790941c..1f747b583a 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -25,5 +25,8 @@ qga/*.json
>  # headers
>  *.h
>=20=20
> +# decoding tree specification
> +*.decode
> +
>  # code
>  *.c


--=20
Alex Benn=C3=A9e

