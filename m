Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71653C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4008F206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTb8JCIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4008F206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdw4-00042i-DY
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVdvK-0003Nu-2D
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVdvI-0002rG-MT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:54:13 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVdvI-0002qo-Ek
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:54:12 -0500
Received: by mail-oi1-x243.google.com with SMTP id s71so8968842oih.11
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=atw3TSAHp5sUoKm0tYtA5WsNLZwGQVqLvIdj5jlFEYk=;
 b=jTb8JCIYaZs7aQAvIfx4dzpQ+X6QxjZ77tfuEfFmcF8Hf8c+KJuPNRaaZMQo4LdmEM
 yvFZaPz3aYITwJCxfKsxRCM3CNEbZwDZNh2KLT+H2FekLi1eM8jf4GqCSsY18F1MYuBs
 fJI+INjrWDNFL9djS5GZRlkgaNifsAWY0g6wkWx1VOkheLggBZbk51Q+kynKoVjHrvgj
 ZdRo2S6cD3PczFyI+CMfy3wZ5fG0bj85YqzoUXDbFs3x+M0cbt4RVjp3H13DaDjbkvtn
 +mDIYoHhFP3AXBeAngc+6jMQEcFEF7LSp98kajtQSt5lyuRpWW7hvrc/ngivixU2GbCD
 k5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=atw3TSAHp5sUoKm0tYtA5WsNLZwGQVqLvIdj5jlFEYk=;
 b=FEeAeHE2PrnOWY34AW5bh2Sxzv4MBF0Fu6tY1a9hLrh9+R6l2ctKcsKbj0V6SGTzyp
 cYb72LO0YdgXJ7sijzdrezer2asIvKmTmAPCU2eyTpNjSJSIfSDuRjzu+OHBfu7sVE7P
 XD/LIhZtu+ICnfiY5n23Ay0KeGDDvKbpFWHOv+p16gtL3yoQFYYLln7Gchzkbb9fh4rT
 j2eQjerzMqhkBgUcYYz3ybePSu5YSiybXMw7aYMKR1gJZ0BD5R7N6Nr5OGEBmuL+2SG0
 Hu/VYkJCWnnedk6FmXlqwPXIj2Hkpb/yHGKrIr/nS0Djqpg6DlXeKjwdktS9cr8DYxnp
 efzQ==
X-Gm-Message-State: APjAAAWFE6m0HOr/rQ4DGw6USb+rc8BQ2eIQPYFLBfNtDBDK1JTlvAV3
 yDKtrIUNL46I4NFdrZUbHnpzK6XOfa5jIkr7L8CjYw==
X-Google-Smtp-Source: APXvYqy9sGkiqFEAlUg2s1s7+P7FjHnRIjCOjyaFptEsoI+8205oUfEtc6F+AoL8/blJ27oQ+YtoEz41TMtEewuNXlY=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr8092284oig.48.1573833251458; 
 Fri, 15 Nov 2019 07:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20191115145049.26868-1-thuth@redhat.com>
In-Reply-To: <20191115145049.26868-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 15:54:00 +0000
Message-ID: <CAFEAcA-EuQVBtr=BCE5sdHo+LMv8XchHUSPM=CgSYxPVryWKZg@mail.gmail.com>
Subject: Re: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA
 is disabled
To: Thomas Huth <thuth@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 15:10, Thomas Huth <thuth@redhat.com> wrote:
>
> When CONFIG_IDE_ISA is disabled, compilation currently fails:
>
>  hw/i386/pc_piix.c: In function =E2=80=98pc_init1=E2=80=99:
>  hw/i386/pc_piix.c:81:9: error: unused variable =E2=80=98i=E2=80=99 [-Wer=
ror=3Dunused-variable]
>
> Move the variable declaration to the right code block to avoid
> this problem.
>
> Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/pc_piix.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2aefa3b8df..d187db761c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *system_io =3D get_system_io();
> -    int i;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
>      PCII440FXState *i440fx_state;
> @@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
>      }
>  #ifdef CONFIG_IDE_ISA
>  else {
> -        for(i =3D 0; i < MAX_IDE_BUS; i++) {
> +        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
>              ISADevice *dev;
>              char busname[] =3D "ide.0";
>              dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],

Don't put variable declarations inside 'for' statements,
please. They should go at the start of a {} block.

thanks
-- PMM

