Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DF92078D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsXnjgip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DF92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlUrZ-0003l5-HB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlUqu-0003CN-AG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:59:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlUqs-0002H1-93
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:59:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so1668071wrp.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8Xuuu1/axhXOLX4MafyDblXLx8eAwN44YG61Pq4hI2E=;
 b=xsXnjgipsKyP2k4M5meSjfimQXVokiyB1qW5yTySL0RA/nUButE9XKIC+tIUd23IFj
 ni/ELxUN7T7XPCav1+ByZ+t3Zupm9B3pslwTxYX8jHOb5qpzyYKd/k6htm+7BoTy5djT
 uypiDurcbwR8wczOcvxpg6I0L9V9FVu5hA5UUCyj1+F1FBXEZrAr7yBH3mvuNXbvAD+s
 bhOUcSM2t8WkNgw5dkH3ioebvc8CPO1IrHEnM3TsV4PkyCaZg6eykmmCa11dfRg2kq4V
 nYdDOmd6G5c8+tt9uDVb8VDD+OLrJvznpNXBwGDAIyMloxINYkiSICb5U0lLbUXdzGlC
 Ex5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8Xuuu1/axhXOLX4MafyDblXLx8eAwN44YG61Pq4hI2E=;
 b=kxwwYnDm8VLg8mPTdDsQtKAemrPQOQsy+Fs8wIKuMAVTPqOgrKhrbR4BjtwyutcyX/
 qnRz9d9zKjiA0fK8V2sIS/iHdYgJDtx0h1yJ2aiCHaGp9WmrwORFfRsjZbvL8kDR8+Ka
 ZKCOHL+3Mps+p++lB/syXqaWCqvt8fXSRHQORaIdf9x5xbhFUotRQUmQlwuX+/sPq8Xc
 S2qrWpcyzuq3fqkoQ7T/phuGjcDNt/th7w18K63IgMr+y7GkOYIZoax57rTZk7hRsPQL
 Zvvi36OPILUmGCSRXlh6/F6G/vmNziWBT7LSj5o4CFdyD4cRLCgf9ETMv/OGqEn98H8s
 H49Q==
X-Gm-Message-State: AOAM533lSIN95IthubyaeebYlKZ15D1+6nMWxsFna49gfI3BSy0Y1eCL
 /IMBc1CHjTQYspXhdoCw2+Ad7A==
X-Google-Smtp-Source: ABdhPJwKuN/fStrqZjBfo5LfTEB6HW8utEvbnqcI1LC7yyLEbZRBAc+yS/VmUULN+NcXPhE5ja0D/Q==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr8077736wrj.342.1592387964154; 
 Wed, 17 Jun 2020 02:59:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b132sm7648440wmh.3.2020.06.17.02.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 02:59:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 270E71FF7E;
 Wed, 17 Jun 2020 10:59:22 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-4-kbastian@mail.uni-paderborn.de>
 <87blljyo8d.fsf@linaro.org>
 <20200617061313.uaru24twuzqgml5j@schnipp-desktop>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 03/15] tests/tcg: Run timeout cmds using --foreground
In-reply-to: <20200617061313.uaru24twuzqgml5j@schnipp-desktop>
Date: Wed, 17 Jun 2020 10:59:22 +0100
Message-ID: <87sgeuxbb9.fsf@linaro.org>
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

> On Tue, Jun 16, 2020 at 05:22:42PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>>=20
>> > when trying to run successful short tests from the Makefile timeout wo=
uld no
>> > terminate. Rather it would wait until the time runs out. Excerpt from =
the
>> > manpage:
>>=20
>> Which tests hang without this change?
>
> The TriCore tests ;).

Hmm I wonder why? All the other tests work so is this a function of
output from the test? The softmmu tests for example usually redirect
their output via a chardev device. Tests which require actual input from
the user are skipped (the semiconsole test is MANUAL only).

>
>>=20
>> >
>> > --foreground
>> >     when not running timeout directly from a shell prompt,
>> >     allow COMMAND to read from the TTY and get TTY signals; in this mo=
de, chil=E2=80=90
>> >     dren of COMMAND will not be timed out
>> >
>> > Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> > ---
>> >  tests/tcg/Makefile.target | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>> > index b3cff3cad1..423caffa56 100644
>> > --- a/tests/tcg/Makefile.target
>> > +++ b/tests/tcg/Makefile.target
>> > @@ -40,9 +40,10 @@ quiet-command =3D $(if $(V),$1,$(if $(2),@printf " =
 %-7s %s\n" $2 $3 && $1, @$1))
>> >=20=20
>> >  # $1 =3D test name, $2 =3D cmd, $3 =3D desc
>> >  ifdef CONFIG_USER_ONLY
>> > -run-test =3D $(call quiet-command, timeout $(TIMEOUT) $2 > $1.out,"TE=
ST",$3)
>> > +run-test =3D $(call quiet-command, timeout --foreground $(TIMEOUT) $2=
 > $1.out \
>> > +	"TEST",$3)
>>=20
>> This breaks make check-tcg due to a dropped ,
>
> Whoops
>
> Cheers,
> Bastian


--=20
Alex Benn=C3=A9e

