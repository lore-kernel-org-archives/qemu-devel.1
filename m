Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC966C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21C82173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGU7mm5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21C82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jxo-0005hK-Tc
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jxC-00052q-LC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jxB-0000Uw-Oh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:13:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jxB-0000Un-Hl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:13:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id v4so12264083wrs.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RVFIcvBIZjLkY8s+suNe0y3bifbcWq93tR29Oci6vHc=;
 b=dGU7mm5RRpi8DyAoXgzHpKfArFY0V+qPh0D+kEhjyLYnkaavh0/h5e5dy/JvTIwRw1
 jklvGiTHbXweJGD1Mdl1uRXt7lJgan61wmtu3GdSYM+nMScr7WX1d5Gf+4W/uNoDkPBq
 Vbc6LyJ0uJHL9fyRFFt67ZhuCasozYc9MwJdcMVBTHdpylNdEXEI0DJStff7zn/bnERu
 X1w7X7yLNRfwYQLSzBD78vLuaVkf/5JSRdSF01XNo1FxZ7juDBEI8Lnemicb9HZSGhM7
 i1iu+9UhmtxtqlHBDDmgOYWCJ0rWHP+eyCibcMClqpsya9+fRRQ7D3/AwrzkaQtyojrB
 TvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RVFIcvBIZjLkY8s+suNe0y3bifbcWq93tR29Oci6vHc=;
 b=OqSuObyJpcrbouGOPxQPJG45yFkf4Ln939+clMhCbw16N/Lj24gR6ioCjHFRq1hPFZ
 rLvDT7ePy16jddJBy8Oj2BAdaJfc3IhihuYhXQkE9SXxC3tq/7HLjEO08E8liy7GY64I
 ymXCOjg2GYwUy6r7vZUArREIJwXa633sgyo/AIQOIwA9ebNnG4Wtfyta0h3sk3AHn0Jv
 Vb8OdKll+xjpYqbJo+y5zB+t21SH7Ru1Q5zqiULqtsoOF/JBZ4v9lNDV9zrJnq8aIXvs
 cboOXUGj8DO1+vVCyQ7riI+BybPkkOj/i9wJjHH0Gbo7QcdGn4WbEFL2SHj1XULso/kW
 B3Eg==
X-Gm-Message-State: APjAAAVZInlSNHE8euzNiE7QKvwrS5N4SygxZ5VY365U6Afw4SR/2ycQ
 PJBRBR1tOVfXlhXKSAcCesvm2iqsagU=
X-Google-Smtp-Source: APXvYqxcwmRREeo/uZnt2RwM53RcFjwsmZt2wtFlZioRM2o7vpXWClM0eLXTew5mga8qvJUGwazmfA==
X-Received: by 2002:adf:8294:: with SMTP id 20mr22811841wrc.175.1583151224545; 
 Mon, 02 Mar 2020 04:13:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w19sm14742394wmc.22.2020.03.02.04.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:13:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74F671FF87;
 Mon,  2 Mar 2020 12:13:42 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-20-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 19/33] docs/system: convert Texinfo documentation to rST
In-reply-to: <20200228153619.9906-20-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:13:42 +0000
Message-ID: <87y2sj9cp5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

<snip>
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-19-pbonzini@redhat.com
> [PMM: Fixed target-arm.rst use of :math:; remove out of date
>  note about images.rst from commit message; fixed expansion
>  of |qemu_system_x86|; use parsed-literal in invocation.rst
>  when we want to use |qemu_system_x86|; fix incorrect subsection
>  level for "OS requirements" in target-i386.rst; fix incorrect
>  syntax for making links to other sections of the manual]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

