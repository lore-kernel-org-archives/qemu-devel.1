Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7803DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA5220719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="km/Z6bQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaPr-0001L6-D7
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaOm-0000Hr-BX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaOl-0000le-CV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:48 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:39526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaOl-0000kW-7Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:47 -0400
Received: by mail-oi1-x22e.google.com with SMTP id d63so7003878oig.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eHb0jfKvXVU274VJYP9E1m8sOv0o9NIfCTrQgmuuMxQ=;
 b=km/Z6bQKQvqySinTMdQCbKwMWomhCsjefkMpcfKgD5dpEFIAqVZzvDhpesBR9SGnOL
 X/045XR9qwEddTL/yolS8x5FoidJ7bdxVy1lJMJmEdhrleiVHLZUTSsz0orY1hknqnN2
 +W1s1DrYyf0+lwe0jcyJzJtZrKLWLS6qnluEKfat0vdrhJFgL3Qf1qZqnKfc87ypkgJr
 zAM99meJPbB+IBlIbAt6JHT2f/QOoOvUTkQT73mFkQlgZDqi7vQXQrhdyflfNrWMR+E8
 wtB6x+NGg+Chj6O3uiInCDfW7YsOqUwAbELXElGE8TShGAjAeRPl97oDkw6mtlA/RIii
 4aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eHb0jfKvXVU274VJYP9E1m8sOv0o9NIfCTrQgmuuMxQ=;
 b=hh21Tj06fcl8t8p4AdmCPi6GSRPYqLvRjaXfwQF9jcZ+KKBRsZkMPziaOixglmoZzP
 FHDioJkmYnBBLIOiaHlTYmyknOwr4fvOnhzDE9c+zO1cCJxQqLG7R1Dd76eCAXTjEpqH
 BITfqizkUvN7yxiJfZ8b0Ikfwh+Y038emFoKqf3LCLgm8wRjNiiDj8fsXVlfBLL/7E/O
 SgnlyW+hp/5MlpnrJvp7PsK1ZDFvX5oZPurCsjNBR9b5FulT/v7QqvKjd0Dmba+SHZeO
 yH0ZVHZAUuZyJPS7Sb10cMz+2NT3dk/4hbTqlL2QXFBssCi7uDmadNBcRZgwpS9ZNHiG
 sgLw==
X-Gm-Message-State: ANhLgQ1IgzUhYRyQNb2oIl3otiFTH1gyHjav8jWCe5XxDeuedoXUY7/C
 NT1L5SKA3tTLovsXK3oEADCSjfKomzGF2WlWLCTiiQ==
X-Google-Smtp-Source: ADFU+vtG3JVnS91kZlvWGSN6o2d1T88nsN+iTnHWTXokEih1kXTKVTrUTnaQgNH0r5YGUQ5q4cAy6sVLBBoTCQPMcHQ=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr1837436oih.146.1585259446443; 
 Thu, 26 Mar 2020 14:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-11-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-11-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:50:35 +0000
Message-ID: <CAFEAcA9boqPf35M9pEn7wF_McdXBUwoyWSSXHC=O5g8H+Aa=4g@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 10/12] hw/misc/macio/macio: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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

On Wed, 25 Mar 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_bool() hw/misc/macio/macio.c:350:8]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

