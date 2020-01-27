Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F786C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A15D207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="rGfOR49r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A15D207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1su-000700-9S
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1iw1oI-0000PL-2l
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1iw1oH-0005Yh-4D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:40:01 -0500
Received: from [51.158.76.159] (port=45120 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>)
 id 1iw1oG-0005Wi-BW; Mon, 27 Jan 2020 05:40:01 -0500
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1580121597;
 bh=Tf5BUO74dU2ST3RK1ZdbaSDVkYUtS2C1gdfE8DGJ+I4=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=rGfOR49r36ZG56OPmkeA/5hOJvB1yuban3k3bEBbeoIekSM5RMJnmVMklwOLVzBAJ
 Pd5RpwFBToNgq2XV8wcmvvQe9epKw+X6TH7y7QJwB018n5pboFKsKGa9BKgdzMW5En
 6wepEggys/d3F3Y3DMwQhsr+vEiy2vQzeGKuY0xbJ1pfIw6hIKRL0kP/llE0XvtqGV
 WY0n9Q3teRVSV4tjrJJydqnt/t9IsFnjTzeIIpPKEyNeXPYkDuXqbBFmsheKYytHHB
 9hhZ1GqFgqSmTleua5HOr0BN9Cz6PoMNB2/vLAm057nLwW/TtVUZRCTucAkivB0uAS
 k2CsRwAncAROw==
To: Michael Rolnik <mrolnik@gmail.com>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <7ae1607e-060e-23ac-f651-8f2ace8991ba@xcancerberox.com.ar>
 <CAK4993iH77DfpHQbNNR41C=rJy2M+uHDNMuof6Fq7ofhMtB9hw@mail.gmail.com>
 <5f3a988c-c7a4-526a-47ab-1252de535787@xcancerberox.com.ar>
 <CAK4993hX440rdQZVJokd0AzrENCQSwxgTGfyiDunPWBxW4nQWQ@mail.gmail.com>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Openpgp: preference=signencrypt
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <95759d35-8995-8e2e-acd4-b5291926f7e1@xcancerberox.com.ar>
Date: Mon, 27 Jan 2020 11:39:56 +0100
Mime-Version: 1.0
In-Reply-To: <CAK4993hX440rdQZVJokd0AzrENCQSwxgTGfyiDunPWBxW4nQWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 10:48 AM, Michael Rolnik wrote:
> Not used. it's there just for clarity. to follow the pattern like PC
>=20
>      AVR_FEATURE_1_BYTE_PC,
>      AVR_FEATURE_2_BYTE_PC,
>      AVR_FEATURE_3_BYTE_PC,
>=20
>      AVR_FEATURE_1_BYTE_SP,
>      AVR_FEATURE_2_BYTE_SP,
>=20
> To show that there is not 3 byte SP or so.
>=20
> Should I remove it?

Just asking, I get confused doing the review. I ratter prefer not to
have dead code, but is your call.

--joa

