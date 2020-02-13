Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34186C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01116218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1lJm2e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01116218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2F2k-0002wt-7o
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2F1h-0002Il-8t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2F1f-0006bC-Tr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:59:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2F1f-0006ab-NV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:59:31 -0500
Received: by mail-oi1-x243.google.com with SMTP id l136so5848839oig.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jtk5PA8UGsfHiZak2FNNgWCN2l/hNUfxWUPNMl5qe18=;
 b=Q1lJm2e81ck7BhXPU6/Pci9B3CURO16ddwNPqR9fwRnzGTNtPUSXJvr5DLjryMBLWM
 LNrgYWb4miRxMPrg0E7uiwhGW8mFyCHK8h/gzlKkLucOABuDsMpZ9+PeWjtYE1F6/ic8
 78zu+gznOv2pUPYJBWiigr5w1Z5ztluno0SqL9W7YS6X7jsYXXdmSbmhCddz2QYilVYE
 NBWlntYenUK1xG72ZirMRPOzAry/Ru/jy0xGMG74J5gr9tad/A79nHyQaB9DdSS36RNU
 YngwbqFl0TLMpa0wJCyUjmF99qFgBsUQvqMJim55zK+ZoGKohMj9vaBN66wAWx68o6Kj
 G5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jtk5PA8UGsfHiZak2FNNgWCN2l/hNUfxWUPNMl5qe18=;
 b=BYgd64nCziRtIPz9tWfVRE2vXZcz9R580f44DjKJuz9iC+LG9OUSEBov5ncIEKO7hr
 dtuKL8ZJaMFQhnfJF+U9rw4AVO9p/zefKjOA8Rp9X/SLrvHQSxPygIc4gR+6T9DVIi45
 GFx70WwMWDvs/1XhJEQUgCFZZ+mb9Vuj09PyDes88DGA3MkQEI2KVPOa3vgjDnQ5aq+G
 pFRqkbPy3u4udyoFlK9Aj/osVTQYw6UwLKT5CI6LM8mwzQvt1vWVWb7pmfKeq366olCW
 ndpuDGpWi7VstwnrNSxeWqxxpSf7pUF2+YfSympa214uikwv4cWNjgc43iv+0ls6KT4A
 o96w==
X-Gm-Message-State: APjAAAXxtUPKWhQtp7POrwMYr2QUU+KTM8bvmc6M82OInW8YIC52Z7rk
 2V1eTO6hH0safvtxIM6Q/wbDwSH8k2i+ImNMgvvZtw==
X-Google-Smtp-Source: APXvYqzXOj/q40c5r3ScLKrkY6ws8pO1BQdiCxXPqScejknTdStR0fqwOZdCgXMczHC0Un6sZywgpvoYSKSdBzYUW1c=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2868127oic.48.1581602370710; 
 Thu, 13 Feb 2020 05:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-13-f4bug@amsat.org>
In-Reply-To: <20200208165645.15657-13-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:59:19 +0000
Message-ID: <CAFEAcA8e4NqwKPM6qx=vKm6NOz__=S90trhUuhaSNe_yJ8GeXg@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> With the exception of the ignore_memory_transaction_failures
> flag set for the raspi2, both machine_class_init() methods
> are now identical. Merge them to keep a unique method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/raspi.c | 31 ++++++-------------------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 0537fc0a2d..bee6ca0a08 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -294,7 +294,7 @@ static void raspi_machine_init(MachineState *machine)
>      setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
>
> -static void raspi2_machine_class_init(ObjectClass *oc, void *data)
> +static void raspi_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> @@ -311,41 +311,22 @@ static void raspi2_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
>      mc->default_ram_size =3D board_ram_size(board_rev);
> -    mc->ignore_memory_transaction_failures =3D true;
> +    if (board_version(board_rev) =3D=3D 2) {
> +        mc->ignore_memory_transaction_failures =3D true;
> +    }
>  };

This isn't really the correct condition here. What we want is:
 * for the board named 'raspi2' which was introduced before
   we added the transaction-failure support to Arm CPU emulation,
   disable signaling transaction failures
 * for any other board, leave it enabled (whether that new
   board is BCM2836 based or anything else)

(This kind of follows on from my remark on patch 3: we should
be suspicious of anything that's conditional on board_version();
it should probably be testing something else.)

The natural way to implement this is to have the .class_data
be a pointer to a struct which is in an array and defines
relevant per-class stuff, the same way we do in
bcm2836_register_types(). That way the struct can indicate
both the board revision number and also "is this a legacy
board that needs transaction-failures disabled?".

The other approach here, as discussed on IRC, is that if
we're confident we really have all the devices in the SoC
either present or stubbed out with unimplemented-device
then we could disable ignore_memory_transaction_failures
for raspi2. (The flag is only there because I didn't want
to try to do the auditing and fielding of potential bug
reports if I changed the behaviour of a bunch of our
existing not-very-maintained board models: the real
correct behaviour in almost all cases would be to allow
transaction failures and just make sure we have stub devices
as needed.)

That said, this does give the right answer for our current boards,
so I'm ok with taking this series if you want to address this
in a followup patch.

thanks
-- PMM

