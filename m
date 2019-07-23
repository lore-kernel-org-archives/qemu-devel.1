Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153FEC7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21082184E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrvgrQXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21082184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptGh-0002bW-TV
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hptGU-00022B-Ue
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hptGT-0003rE-RT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:47:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hptGT-0003qr-MA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:47:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id w79so32082222oif.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fz9eaAluHIdQpvsypCntyI9q7SgqRMnI4BQquledjgY=;
 b=hrvgrQXCUkVsiVVWHOkdbQ2/e3KlV3YhYnwlR0j83Y4V28wx+NuxPUjYDNdFsOZzDP
 FVnLD5aBApWa6m5DMP6rv2Av70SNhRxSDfVV7ZspG7oAX40ofXuIbqwdVkC/Cs+HBkiv
 DREG9MYPK/vrBkbZYeU9AFsPOtHYnmMOAlUaXOIgSfghtkZ3EaypRpt9cbiqJoJdHNEB
 db6cEOyGLfms93Zgl6yfaNDBupo0cupqMSNXfHjkkGCoGbC7gW8qtWqEN+cbTDEU0amk
 ijZgg12JKsxa2o/QeGevdavwRXqztKW/yo7aGocL6A+K99OrxDlarIAL2SZgzKnD/A8d
 hSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fz9eaAluHIdQpvsypCntyI9q7SgqRMnI4BQquledjgY=;
 b=IG3lUF/hWFtENZ5SRPmjYQp+Ig5teE5LG5soAccM0KjfDwy7RL0eANm/maGud8K94T
 21oExmnjZpNsBubV8gsxpVX9SEZIsdgLiKmtL29DCOrfDcri8OwxWR65az7LVh0V7USI
 xTjRettisUjp1zgL79DoGuLiKTUtfpyKANdIAvfU/SKslKUnA2EkZouFECoHTbjobu6+
 z1CtDvGhhDcXVRkP9Q0D3N6FtVx8PSsPKV+6iA8UXrNKLSifbqMthbryPAzT9OSMAyha
 VTG69VkAIOlK5AM68lf025zYutUQRVSm6htfDTp9hvZ7OvM4X+zxRVFg/ksLSXXGtckU
 6AkA==
X-Gm-Message-State: APjAAAX5c2nZiNChwnFDJwA7LwGsLuU/oNVAEzWT1zZOSZ6FNxvBsXnr
 FMi4HfPfpBYDCkoecU0RTjiPY8KVo5MsnZXAKzLxgQ==
X-Google-Smtp-Source: APXvYqy8p4uetYE2MjVqQWIWzOIP3MWFzXARcHl+pnKIY0Fn9YOsdDbu/++kmxrjwTSRrOaxo5Hp7TjigLMq2Uyj7CU=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr33770929oib.146.1563882448703; 
 Tue, 23 Jul 2019 04:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190723113301.16867-1-alex.bennee@linaro.org>
In-Reply-To: <20190723113301.16867-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 12:47:17 +0100
Message-ID: <CAFEAcA9CP0cUkDR4qOKVgM1b2U1KNot=A-5OPEAOKu3=KpMyuw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for 4.2] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 12:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While most features are now detected by probing the ID_* registers
> kernels can (and do) use MIDR_EL1 for working out of they have to
> apply errata. This can trip up warnings in the kernel as it tries to
> work out if it should apply workarounds to features that don't
> actually exist in the reported CPU type.
>
> Avoid this problem by synthesising our own MIDR value using the
> reserved value of 0 for the implementer and telling kernels the ID
> registers should tell them everything they need to know.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - don't leak QEMU version into ID reg
> ---
>  target/arm/cpu.h   | 6 ++++++
>  target/arm/cpu64.c | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 7efbb488d9d..61eaef924e4 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
>  /*
>   * System register ID fields.
>   */
> +FIELD(MIDR_EL1, REVISION, 0, 4)
> +FIELD(MIDR_EL1, PARTNUM, 4, 12)
> +FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
> +FIELD(MIDR_EL1, VARIENT, 20, 4)

"VARIANT".

> +FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
> +
>  FIELD(ID_ISAR0, SWAP, 0, 4)
>  FIELD(ID_ISAR0, BITCOUNT, 4, 4)
>  FIELD(ID_ISAR0, BITFIELD, 8, 4)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index b1bb394c6dd..e88aadfd2fd 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -296,6 +296,12 @@ static void aarch64_max_initfn(Object *obj)
>          uint32_t u;
>          aarch64_a57_initfn(obj);
>
> +        /* reset MIDR so our franken-max-cpu type isn't mistaken for a r=
eal one */
> +        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0); /* Reserved for S=
W */
> +        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* See ID_* fo=
r details */
> +        /* the rest is enigmatically empty lest kernels assume it means =
something */
> +        cpu->midr =3D t;

I think this would be easier to read if you used one big block
comment rather than being extremely terse so as to fit the
comments on the end of the lines:

 /*
  * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
  * one and try to apply errata workarounds or use impdef features we
  * don't provide.
  * An IMPLEMENTER field of 0 means "reserved for software use";
  * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
  * to see which features are present";
  * the VARIANT, PARTNUM and REVISION fields are all implementation
  * defined and we choose to leave them all at zero.
  */

It's also a bit inconsistent to do an explicit deposit of 0
for the IMPLEMENTER field but not for the VARIANT/PARTNUM/REVISION.

I wonder if we should put 0x51 (ascii 'Q') in the PARTNUM field;
then if somebody really needs to distinguish QEMU from random
other software-models they have a way to do it.

thanks
-- PMM

