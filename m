Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65168C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C936206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo8bdmnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C936206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Tf-0000ic-C9
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j95Sx-00005p-Ft
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j95Sw-0005dD-K4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:11:59 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j95Sw-0005cT-Ef
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:11:58 -0500
Received: by mail-wr1-x444.google.com with SMTP id z15so3843125wrl.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 03:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZH6Wnv2a5SQINbnqOVG5FwVAtErtVjPlKlWP/i7XncI=;
 b=Bo8bdmncuTQMjHlC1eEVNCFH+WHdlhSGQ5cXSNMPvE9PplIl3UL8n20bPcEsrW/5x0
 sD1SvWyB4nyU2AqDAHqZPdxv0GrizRsrkNngT4tyMTLhbch5aLMLShCqWlJyG2RcY//Z
 zQAAc6tk91iqeT/owCRd/En2ewCxCJb9pG97PuVRaLNA8L3VJ6l+mfY7TEl9X8LodqjF
 AGGhlzS7m2dtNON6eiIb9R7zWTlvbU8WEddU82gX0yZBQ47R5WiBrm1VBhuOep2WVwra
 oSD5m+iSa8RaxvnJUA7pE89w8nCFAViHUIqeam8UjtWwi3IlYKgivbBkwpGymLSsSq7r
 yBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZH6Wnv2a5SQINbnqOVG5FwVAtErtVjPlKlWP/i7XncI=;
 b=NLB5kz9i/+nU+2SNHZKkXgUGs9cGDTn8fz33yO4pquWSIwjpk15n/obGJzPGegvOfb
 BBwo7lMSbMZxxt5x4ZLR9J/dH8/v8gBqZ0j6snvG0cZS3HlC+yotRAQ9zDwz9ct3JhsT
 rZkX8PVcp3mN9lvHbqls3t4vtDA5heKIG8Pc7gcNBdI8ahofDOMLbzpXalCPKwDUY/fr
 qfDyK4ed1/fttrV/WAU6ZNqQbNFlXBgznWGLc5EpseFUQyz0LfSYAfeukZvzyYdfH7wB
 pbEVZq+XKUoMo/uXviGZ2v+Pm17OiAv3usM5RwgzPYtiBUAf3NjM5wfu5PgcTTEjkFlh
 sWRg==
X-Gm-Message-State: ANhLgQ2SQeNluTIkzaGvqtJaNWjbPEljFbLgbyORCPF+EeBuNA/ZjtQU
 6XiwpRE296AF4jqsqtNUXbn0c7/TYpw=
X-Google-Smtp-Source: ADFU+vuU6kZq4FaNeDP4YFWGlFZed04nZYldDM7+COassso8FVx8S1v18iKBuUJoo1tpAnJZJsXxdA==
X-Received: by 2002:a05:6000:ca:: with SMTP id
 q10mr4920355wrx.78.1583233917316; 
 Tue, 03 Mar 2020 03:11:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t187sm3629324wmt.25.2020.03.03.03.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 03:11:55 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3EA201FF87;
 Tue,  3 Mar 2020 11:11:55 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-5-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 04/18] hw/arm/allwinner-h3: add USB host controller
In-reply-to: <20200301215029.15196-5-nieklinnenbank@gmail.com>
Date: Tue, 03 Mar 2020 11:11:55 +0000
Message-ID: <87mu8x7kw4.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> connections which provide software access using the Enhanced
> Host Controller Interface (EHCI) and Open Host Controller
> Interface (OHCI) interfaces. This commit adds support for
> both interfaces in the Allwinner H3 System on Chip.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

