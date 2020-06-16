Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3475C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C244220786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTQQ1VA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C244220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlENB-0002i7-3q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlEMK-0000ws-KH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:22:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlEMI-0006rP-SP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:22:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so21440648wro.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6+BJrA9RJ40BpdrJYLx5xkVRSgQ5/8rW5luGV75cAVQ=;
 b=eTQQ1VA7cljlqbsDxsTdPPVsxP85dbbW/tC9rkOh1VJ2oIGWjewn2thj2lE8k5NKqN
 EoOLmdIAGKOuG5RnsdZFg78UbXlc6H1yIb7d6OjkFCBIuGqGtrWmRcYujsRYrXCHXdHN
 plR/lXmDbCX+CF7XNNDM/VcUffGlMgT6CFFU82jzrYSIsisN5OFRMdB6MKjfiF+vqrGH
 nXzoxEXHAs/4MI6UIzZQ5igBdNKNgvRb/FYJrnqi7O4cxkNw2A5eHTVe4v/qVM42bS+6
 3i9B2txRiXdjWJcGV2zlc0Hgo4evMwsn3maHOeJGUhbJ/O0Xj8g5XpKrhBrFbv9W4hK5
 DZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6+BJrA9RJ40BpdrJYLx5xkVRSgQ5/8rW5luGV75cAVQ=;
 b=BUvyiztPPgWWOZad3Zeunc2N4aSllrJjSR8L7GdHcjq6v/Y84P/SwuhcqvcEPIRaWv
 M4nAsa0k44umcnGzVJZ1JGTU+B5ljFjlHmOw95eier0MoLof9G3toJJBsricsDWny7wU
 MSK5p4Xq4+BuvhV+bEqjoaycVnXERb4ShmIHVvi8CvXlrOICWorEuopkGbh9jPrUOAMc
 pHy8uHV58gynHU4kJoXRqiWjJy2OzQ29x2/jVVYksEnwvotIuZhcPfuZlwMV3ADVE+Pa
 i5dX7B7Z4Fm3zJ1T8rVa2XTbxIs9WGu6mF/3s10gkHDKmdg5daVdzRHnan6xD6U2LMsa
 yHTg==
X-Gm-Message-State: AOAM5333yLEawkBzN2pd523L/fWglQ7O2AqqmpWTKZVcxeKCX2oDIDO9
 EzyGAvPY4Njr8KJ/Q0bqoI55CQ==
X-Google-Smtp-Source: ABdhPJzKgNfMU2UGrqMEcGGguWDFbNHoh57MpsSbih8GvFSOCUCTolkPvZHvXXifHP/PQul4+8WdZw==
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr3700548wrh.13.1592324565235;
 Tue, 16 Jun 2020 09:22:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n19sm4519781wmi.33.2020.06.16.09.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:22:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F33A81FF7E;
 Tue, 16 Jun 2020 17:22:42 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-4-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 03/15] tests/tcg: Run timeout cmds using --foreground
In-reply-to: <20200604085441.103087-4-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 17:22:42 +0100
Message-ID: <87blljyo8d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> when trying to run successful short tests from the Makefile timeout would=
 no
> terminate. Rather it would wait until the time runs out. Excerpt from the
> manpage:

Which tests hang without this change?

>
> --foreground
>     when not running timeout directly from a shell prompt,
>     allow COMMAND to read from the TTY and get TTY signals; in this mode,=
 chil=E2=80=90
>     dren of COMMAND will not be timed out
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/Makefile.target | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index b3cff3cad1..423caffa56 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -40,9 +40,10 @@ quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-=
7s %s\n" $2 $3 && $1, @$1))
>=20=20
>  # $1 =3D test name, $2 =3D cmd, $3 =3D desc
>  ifdef CONFIG_USER_ONLY
> -run-test =3D $(call quiet-command, timeout $(TIMEOUT) $2 > $1.out,"TEST"=
,$3)
> +run-test =3D $(call quiet-command, timeout --foreground $(TIMEOUT) $2 > =
$1.out \
> +	"TEST",$3)

This breaks make check-tcg due to a dropped ,

>  else
> -run-test =3D $(call quiet-command, timeout $(TIMEOUT) $2,"TEST",$3)
> +run-test =3D $(call quiet-command, timeout --foreground $(TIMEOUT) $2,"T=
EST",$3)
>  endif
>=20=20
>  # $1 =3D test name, $2 =3D reference


--=20
Alex Benn=C3=A9e

