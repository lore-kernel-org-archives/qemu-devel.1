Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61D820658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oy7ZsYMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61D820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaEK-00054z-Vb
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaDU-0004L9-5f
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaDS-0003AM-SG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:39:08 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:37479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaDS-00039e-5M
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:39:06 -0400
Received: by mail-ot1-x330.google.com with SMTP id g23so7633134otq.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ttFRTy1miBphiIkRdmeJ7d7lmPHn2JFJgTlTt9y5xDY=;
 b=oy7ZsYMiDp5Es2IvFowVFh0nr4+ydviKOk/cJWOGWV5G+4UZRor6v6j5BnVXyTDQAw
 qpU1jNIl9XhNxR270tB+3awACdQY1r4P++FIVs6Lo0ILF1gPhqIqvd5mFPHRupPdaYSA
 D/iQ43oXoU7RDdcGDg0B24Pt7TMnj0pjNbevqM9Ghc/YVjO1fJRnJ+JFZuzq2fMmpxlh
 1TsShaNqjV9qNHBtkeGGWtvi6H6Jvp5kWS3pW8gf/yTUyrV4ihYcAZYe/ptsDR6pmYBH
 Q1fs90oCKS/D0oCmhg/oeooj2jorB2nHEVa9ZoxRW5od8NRNy7LUAzQMegm32ikfkyvX
 89QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ttFRTy1miBphiIkRdmeJ7d7lmPHn2JFJgTlTt9y5xDY=;
 b=ttzuoXTjWAOQs6VNPZY/23eHhmYa01EoDHu1TTdULDDnm8yEXl1p0wjJgBRok1raM/
 1u+e0AoO4QS6PBcdvKSuxyeytBfcWSnMMRZ/pp4+kAgJ+B+WxjBfsnN6PRDhDkcdhZ6f
 k3GCFHc9oW7hYnKlMstaUNQ/xF5nsvws0bTwSOerM3ekBGhlf+t31D90X+aheFr2JGV6
 AArPpC4Ott4ivU9M4reX70GB9XhPWqCLEQzrguLMBReuabksU3PmVp4soDtN/aP5AZpA
 4zee9/nZ8OYR9sK92KYsBUvL1XtiyU1TdVDLeO1ZZmwZ7nhWGh5rF6MgdYMinJRrtN8e
 IBNw==
X-Gm-Message-State: ANhLgQ2jyETPh8YvsJn856JPRlbbSXfrk3Rv/HAlW0PQgXob0IMl0hKq
 DAT+RRt1TViKbJ9oI9Z4sfcB1780aEFX8WLDxzQgPg==
X-Google-Smtp-Source: ADFU+vsr5IzCSl9lBQiEgE2XocyyR3ZWLPD05jdlPB06nPoyvel5brs0CtYjgJGaAaTtMs341LbocOOpyzqiC2yYx9E=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr7656604ota.221.1585258744877; 
 Thu, 26 Mar 2020 14:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-6-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:38:53 +0000
Message-ID: <CAFEAcA97j0LD__A4eSkf1Aq2GpcQ5up1e76Hwfcj-Dd3o6iOeg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 05/12] hw/i386/x86: Add missing error-propagation
 code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/x86.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 87b73fe33c..0a4865d4a9 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -103,13 +103,17 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState=
 *x86ms,
>  void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>  {
>      Object *cpu =3D NULL;
>      Error *local_err =3D NULL;
>
>      cpu =3D object_new(MACHINE(x86ms)->cpu_type);
>
>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      object_property_set_bool(cpu, true, "realized", &local_err);
>
>      object_unref(cpu);
>      error_propagate(errp, local_err);
>  }

Hmm, not sure about this one -- in the error-exit path
for failure-to-realize we object_unref(), do we need to
do so also if we error-exit for failure to set the apic-id ?

(Since apic-id is a PROP_UINT32 with no set function, there
is not currently any way for the set_uint to fail, as it
happens. But we ought to either have the error-propagation
right or use error_abort if we truly believe it can never fail.)

thanks
-- PMM

