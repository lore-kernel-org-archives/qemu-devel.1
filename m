Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F126DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA420206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoOuQRqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA420206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igp3z-0000Xl-UC
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igp2x-0008NV-ET
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igp2w-0003QM-6d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:00:19 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igp2v-0003Ea-UW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:00:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so6397571wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=M0RwzBS/F4nB5naVwBAmHvyq5deN3Jtm4Cf5duqoyDM=;
 b=EoOuQRqjsnf5X4AH2AwmhDOh49aO7Vgr6fgXy2pm8gTic9f03oBRYx1ZwTQOpr1qkT
 RhbsmdnsDVOZNaBGKxw8x9P4eCJ01BTcU9siN3dvFom3Tm/QrkSLox5T4tNjzfDRDWOq
 KEfRX44B6nXpPItys/jSoa7f7HAHDfa+Ld0AKeIa6EIc+4PhbEs7NNa6R7wywEP492DX
 ACcODQ8t1vc6IUpUi4IIBkgNzURpym4dEo8P/sB0h7l7078pMck/13glntN50pmH/S9R
 S+ayA4XLXTVXNUlPUS4C2n2VgnvR1Wiz2HSQg4yvDGQlxXrIFPvp0krraOx72Wg6w24f
 bD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=M0RwzBS/F4nB5naVwBAmHvyq5deN3Jtm4Cf5duqoyDM=;
 b=PXduqzkQ6tcQTk+EX2/du5VYI+qSteLuAsFItKsR+5YL7H7EH4mFIF+g8MEuae3AKF
 OyztisNrvRlBWT4i0Tcc9qD4ykC5VT1YpwNLbMPMfcsOv7Cmb7CAPx214cKeloY44lBZ
 BI/rZsvXMGG01jR9vMZ+vrqGLJjS0l0q9TBrOPGVCkebnvR+5Ocz8Pf1rqybL691jfck
 fNrNmCVKBw/rnBDcGu0AoZ2yWteBYws+08vIjRjL9pN4e8gY2dEgbrNrHYOkzRytOR4P
 opmNcp1tDGMEZNsKZWDBeCM4PSDxKFbx7sPsSlOVnWa/KmWl7OtFWOZwzp2lxMgvbqo5
 oe5Q==
X-Gm-Message-State: APjAAAVfE3ZTB/it1BTyZkOIwSSKz/Ca8GoIRGfopzYPItnTwK8l5K49
 +fHkMK7Rk3ThXdJl3Lpd9ROw2A==
X-Google-Smtp-Source: APXvYqy1BSltwX+8Z8Eh5oyj0KjAfT41Ay4xxkHtF+RZxwL63X58axGOGjaqXbS9zr6VaGGl5USbQw==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr29583971wmd.33.1576497615455; 
 Mon, 16 Dec 2019 04:00:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm20422681wrs.96.2019.12.16.04.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 04:00:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B19E41FF87;
 Mon, 16 Dec 2019 12:00:12 +0000 (GMT)
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-6-alex.bennee@linaro.org>
 <0dbd7631-2258-83e8-fc96-3265cbd8d8d1@vivier.eu>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 5/6] linux-user: convert target_munmap debug to a
 tracepoint
In-reply-to: <0dbd7631-2258-83e8-fc96-3265cbd8d8d1@vivier.eu>
Date: Mon, 16 Dec 2019 12:00:12 +0000
Message-ID: <87mubswkdv.fsf@linaro.org>
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 05/12/2019 =C3=A0 13:25, Alex Benn=C3=A9e a =C3=A9crit :
>> Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
>> last remanents of the #ifdef hackery.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/mmap.c       | 9 ++-------
>>  linux-user/trace-events | 1 +
>>  2 files changed, 3 insertions(+), 7 deletions(-)
>>=20
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Are you going to take this series via your tree or would you like me to
put the PR together?

--=20
Alex Benn=C3=A9e

