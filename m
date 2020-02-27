Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B300C3F2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46ADB24690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRayFQF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ADB24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QrX-0006MB-DU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j7Qqw-0005nH-CE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j7Qqv-0002Km-B2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:37:54 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j7Qqs-0002Hr-SL; Thu, 27 Feb 2020 16:37:51 -0500
Received: by mail-lj1-x242.google.com with SMTP id d10so899501ljl.9;
 Thu, 27 Feb 2020 13:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UZVzMiJRShPlueonyaoikwmNMD6aFXintv3DsagvrH0=;
 b=SRayFQF4K8ZX5PNl/v5pzJ6YdRbXtIjy5aoY/qPp0OtzonVtQhSjWyf56PgRY9//9b
 mYxZTUv9TJMyEjTZE2stN6aZdHt3XL0oJ2xMad4tlx03jcOyPhWz4shiBXlLsFbRdy9W
 yG/u9maxuKcDpZpdcbU+tLemQHVySE5xNu7rSh8ksjKUFRwIHUGYY4Av7z9XEsgvK/Vz
 qpGzbiAo2GNf+RMgLC1Qb6heS0sMRIBoLmBXbNjOv0uf4sGge1dU3sHtY5iITHZpW+w9
 Kpi7isnJDseMsOY8cYuBnsPwNq+caQ/aOe2yAXCGJnv/BcGqFlnPWgt1yRmBmKtXRqiv
 r0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UZVzMiJRShPlueonyaoikwmNMD6aFXintv3DsagvrH0=;
 b=dn54t0OYQ4vDLItIMw2yuqJraJyyuNtF5V5MLL6skzK4gPDht6vY6VoUYg7V+GkS1b
 e2PT/frGz42KUtYVJ5QMHzMEzGI3TLg814qlZ5crTDGLDR2v1Kc49Hp66CTksbGLenq4
 kXqCCGjfoNmajYr8oApBWzhI2hjSybNZxfeBrVW6nV38MdFnxbOniuO6ZDzIDrSsHnH9
 mXZ0uDu6Y24+sBHTFo2aT+5gp550TpJYDsCoS1J5Q+RFPPaOZz8lR63t54SHoeYQUDQo
 LnhN1HKqESkqIsxIsB2QGfnauX6+noQ6FWD4y/BP2YCLIsjUEj3aPF0/d9Ip0vM6jQBX
 xnoQ==
X-Gm-Message-State: ANhLgQ2MIghgXlRQ/aE4FlQlPbKbCOAY18p4I3aFUMdihEIfxz2xk0/h
 zmabg2FjjWIUAx7cM+kUrCXAUjsqMhnu1fLjJwA=
X-Google-Smtp-Source: ADFU+vvQpH/nQLuT9Dmr7jqUj4WCSmbTjGj/wi1eDSH53N9gdu+612hYFSleZNqLxcrJl5DkuzKKh2SqEQzIPTgrxvg=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr664142ljn.107.1582839468777; 
 Thu, 27 Feb 2020 13:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20200227115005.66349-1-root@stephanos.io>
 <20200227115005.66349-3-root@stephanos.io>
 <88ad7129-9654-088d-6569-066949973a86@redhat.com>
In-Reply-To: <88ad7129-9654-088d-6569-066949973a86@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Feb 2020 13:30:03 -0800
Message-ID: <CAKmqyKMkTsgqSEWhrkCmbQ3LMNz1OgdeHE6zFaMsZdRjAFvdRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 5:32 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Stephanos,
>
> On 2/27/20 12:51 PM, Stephanos Ioannidis wrote:
> > The ARMv7-M CPU reset handler, which loads the initial SP and PC
> > register values from the vector table, is currently executed before
> > the ROM reset handler (rom_reset), and this causes the devices that
> > alias low memory region (e.g. STM32F405 that aliases the flash memory
> > located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
> > the kernel image is linked to be loaded at the high memory address.
>
> So we have armv7m_load_kernel -> load_elf_as -> rom_add_blob_fixed_as ->
> rom_add_blob -> rom_insert.
>
> arm_cpu_reset is called before rom_reset, rom_ptr is NULL, we call
> initial_pc =3D ldl_phys(cpu_as) from an empty flash.
>
> Then later rom_reset -> address_space_write_rom.
>
> I think Alistair and myself use the 'loader' device with Cortex-M boards
> and never hit this problem.

I do hit this problem, Peter described a workaround in the previous
version of this patch, that is to link at address 0 instead of the
alias address.

Alistair

>
> >
> > For instance, it is norm for the STM32F405 firmware ELF image to have
> > the text and rodata sections linked at 0x8000000, as this facilitates
> > proper image loading by the firmware burning utility, and the processor
> > can execute in place from the high flash memory address region as well.
> >
> > In order to resolve this issue, this commit downgrades the ARMCPU reset
> > handler invocation priority level to -1 such that it is always executed
> > after the ROM reset handler, which has a priority level of 0.
> >
> > Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
> > ---
> >   hw/arm/armv7m.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> > index 7531b97ccd..8b7c4b12a6 100644
> > --- a/hw/arm/armv7m.c
> > +++ b/hw/arm/armv7m.c
> > @@ -352,7 +352,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *ke=
rnel_filename, int mem_size)
> >        * way A-profile does it. Note that this means that every M profi=
le
> >        * board must call this function!
> >        */
> > -    qemu_register_reset(armv7m_reset, cpu);
> > +    qemu_register_reset_with_priority(
> > +        QEMU_RESET_PRIORITY_LEVEL(-1), armv7m_reset, cpu);
> >   }
> >
> >   static Property bitband_properties[] =3D {
> >
>
>

