Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B9C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849292084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJ8Tc7aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849292084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz61R-0007Eo-N1
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz60U-0006an-KW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz60T-0001Bi-8m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:45:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz60T-0000tF-05
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:45:17 -0500
Received: by mail-wr1-x442.google.com with SMTP id u6so11761463wrt.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QgF6x2eLBCriN95Jy183TXuSSqrsJ1AoMe3IBewr8Zg=;
 b=EJ8Tc7aMAwYYrBGejtzNXRrGto/KNlW+yARiAaxjPvocq2nRQSrWXzED+0aZWOJlR/
 qWnvsOCjtZNY3G01Sc+DwVPnQV7DoJ09rCOS1yN3Zb3NR85TdHxe5ZBKsv4k92+g8sQ1
 Q2dZfGFSSKC12X/UYZwuowezjnOXsilHdTMJ7ifUIAQjeL25aPGyR39afm8PXguMtxaz
 GXEXbII8CoPxI1yfiWZKWVuhFqEu2YZ1QuR9IxvN+T24xILdLRMNTlVielIPQY9FnJI/
 tJgWYXY/8kJk3Eio8KxakU6gFdomUQ5PGP+hEyGdsOuHnptlzJv49qrigSS7m3epptBB
 ofjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QgF6x2eLBCriN95Jy183TXuSSqrsJ1AoMe3IBewr8Zg=;
 b=jCV4aSt7LS9dHelpKd/qAuW4rSwEHtXyeE9XPqKC2DHA5m0p99mrewJtdGl2SkejVL
 d7MQP2sZYB+SJ4uDXApiGXYoL1j+DBYkl8VeOB0vXeSJY+7vP/7ywMAyr2sbcdAJT2fI
 3JfZEp52rWE1cscUKKsfN8WtacQTW+h6sCHsTjxscB+OyolUQJTlMe0MZYZLe8ciybOK
 igZ/JFoYe25juIP0P3cc+U0eHecLefUy4ipU+0JizSDbbFxTM6gSKbhppN5utk7LCR5S
 2EWZaKQ7PWuQSUszvTZxJzb1JQk5jGfZV+gHHMj2mmHLfGUqObKisKfPGrZOfoZUQDYz
 S0Qg==
X-Gm-Message-State: APjAAAXauGY973U4GsyRgjA2zOSIIr7abFkuSaUl+kZigwZLtFLp0FRA
 hIANRFGvY5tOxt6/hldr3z7/eg==
X-Google-Smtp-Source: APXvYqylcfgoumnviMRS2uW+vfP9CZld+Jn+BQ0vubJWomXSUWT6G8gFR8e3LDmV16dXtJaa5ulf2w==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr17067877wrb.33.1580852715046; 
 Tue, 04 Feb 2020 13:45:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u8sm5443862wmm.15.2020.02.04.13.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 13:45:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 146C91FF87;
 Tue,  4 Feb 2020 21:45:12 +0000 (GMT)
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-21-alex.bennee@linaro.org>
 <2731815f-9a72-390b-0a8e-73b77c4b62b6@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 20/22] tests/tcg/aarch64: add test-sve-ioctl
 guest-debug test
In-reply-to: <2731815f-9a72-390b-0a8e-73b77c4b62b6@linaro.org>
Date: Tue, 04 Feb 2020 21:45:12 +0000
Message-ID: <87lfpi81sn.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/14/20 5:09 AM, Alex Benn=C3=A9e wrote:
>> This test exercises the gdbstub while runing the sve-iotcl test. I
>> haven't plubmed it into make system as we need a way of verifying if
>> gdb has the right support for SVE.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v4
>>   - interrogate ZCR_EL1 directly as no longer have vg
>
> Note that ZCR_EL1 does not give you the correct answer if the hypervisor =
has
> set ZCR_EL2 to something lower.

Sure - although this is only a user space test so we are not expecting
shenanigans.


> Also, ZCR_EL1 it itself not correct if the
> hardware does not support all vector sizes.
>
> See some of Andrew Jones' qemu command-line work.  Try -cpu max,sve512=3D=
on and
> then use the ioctl to set vq to 3 (sve384).  The result will be an effect=
ive vq
> of 2 (sve256).
>
> We *really* need vg, as computed from sve_zcr_len_for_el().

How come TARGET_PR_SVE_GET_VL is happy to compute directly from ZCR
then?

I'll put the vg back in but it seemed a little pointless given the
gdbstub ignores it.

>
>
> r~


--=20
Alex Benn=C3=A9e

