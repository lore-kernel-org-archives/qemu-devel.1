Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE86CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA18F20661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWrjDY9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA18F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKAN-00085l-Pv
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixK9n-0007Tn-82
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixK9l-0008Ea-Rg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:27:35 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixK9l-0008EA-Mz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:27:33 -0500
Received: by mail-ot1-x343.google.com with SMTP id p8so4935342oth.10
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jxlfjAWvUShGtPotMnbawxLdorG7MPq2+ALCTzKVANI=;
 b=PWrjDY9RAfJHCDE0ggi4+uSlWb6ZouxmYb8kFp856QENB6ogv3zmd+R8oNV0eMDYA3
 0GQ8XQS75NBuaw5BdLSPnxhwu3kXd1fXQc8LmWze4SIA+Bt18lY+3RMZ25RhHaLvCfnM
 Swd1l02tQ8zLuZhL3D5dYSm8pJ/qk3z3TYG0WI/e3dKOFJhVEJwIh/jbPmpLBsArFgvu
 3WQA1Gw3UQztc89aOsvRgEPoPZAmpeS44m3PN3yIJrepAIHobyN589kMERe6zKPnkiuV
 IHd/YiDDDhTTPoyGvmtHQwlqbl2zQ/Aa7L55vqKptLBa2CjLoPK7RAb9BYchpe0DWvyV
 E0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jxlfjAWvUShGtPotMnbawxLdorG7MPq2+ALCTzKVANI=;
 b=atoNWkTRY6t/8ri4vzJlUpScHqiTxAiEfmI1tnaq1OXcLuYL1ukaDHLE91pbvx8OQP
 yKwru7q/WEnSF8skX0CKVDim0j9Edw6jLRny3zcbpEBV2e90THjiBmu+TW4gaziVPK+3
 WUTioQLplGYg1qiobnmSoTWDZTEsFLv84rWQ88N5lVWSIMC/SQ8igeoPp5u4jHAHj9Y9
 6SvI4KOf9zCH60iRhJIB53vgNykAcg4Bo4YjKoybvF1+IXoni38N0m/BMVJf4wO67hxV
 qE1wtN5fJzPonBWD9PCA3rsPEOG9xtltLYVWa7POcWJHhx2Mx5FbxFw5+3s+XOIFxrxu
 YbuQ==
X-Gm-Message-State: APjAAAWeRfhLJ8HOmUjAFpJq980jkOOgZqQRuJ3UPaF8B/23QnHQ/kKY
 9lskKgaBp3yCjeTfepdGLSK5wnIbpTzSdSfavI8=
X-Google-Smtp-Source: APXvYqwmZfON6lmc9EX0kzRMI1hR/PSX429OiE2Pv5eQDD1GlS9MdzmPa24CqvZQUAR5IWYf+6NVZH80Ca9Ac9VuXBc=
X-Received: by 2002:a9d:831:: with SMTP id 46mr5818886oty.295.1580430452930;
 Thu, 30 Jan 2020 16:27:32 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-21-git-send-email-aleksandar.markovic@rt-rk.com>
 <2bf92b9e-7a1f-57a1-d9a3-d0afb6990e70@redhat.com>
In-Reply-To: <2bf92b9e-7a1f-57a1-d9a3-d0afb6990e70@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 01:27:22 +0100
Message-ID: <CAL1e-=iHmNZkEVGY+ORyHdaqhWn4uLNQf_P2=6SY_MomLQxjHg@mail.gmail.com>
Subject: Re: [PATCH rc4 20/29] target/avr: Register AVR support with the rest
 of QEMU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 1:23 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/31/20 1:03 AM, Aleksandar Markovic wrote:
> > From: Michael Rolnik <mrolnik@gmail.com>
> >
> > Add AVR related definitions into QEMU.
> >
> > [AM: Remove word 'Atmel' from filenames and all elements of code]
> > Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > ---
> >   arch_init.c                |  2 ++
> >   include/disas/dis-asm.h    | 19 +++++++++++++++++++
> >   include/sysemu/arch_init.h |  1 +
> >   qapi/machine.json          |  3 ++-
> >   4 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch_init.c b/arch_init.c
> > index 705d0b9..6a74116 100644
> > --- a/arch_init.c
> > +++ b/arch_init.c
> > @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
> >   #define QEMU_ARCH QEMU_ARCH_UNICORE32
> >   #elif defined(TARGET_XTENSA)
> >   #define QEMU_ARCH QEMU_ARCH_XTENSA
> > +#elif defined(TARGET_AVR)
> > +#define QEMU_ARCH QEMU_ARCH_AVR
> >   #endif
> >
> >   const uint32_t arch_type =3D QEMU_ARCH;
> > diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> > index f87f468..a36e658 100644
> > --- a/include/disas/dis-asm.h
> > +++ b/include/disas/dis-asm.h
> > @@ -211,6 +211,25 @@ enum bfd_architecture
> >   #define bfd_mach_m32r          0  /* backwards compatibility */
> >     bfd_arch_mn10200,    /* Matsushita MN10200 */
> >     bfd_arch_mn10300,    /* Matsushita MN10300 */
> > +  bfd_arch_avr,        /* AVR microcontrollers */
> > +#define bfd_mach_avr1       1
> > +#define bfd_mach_avr2       2
> > +#define bfd_mach_avr25      25
> > +#define bfd_mach_avr3       3
> > +#define bfd_mach_avr31      31
> > +#define bfd_mach_avr35      35
> > +#define bfd_mach_avr4       4
> > +#define bfd_mach_avr5       5
> > +#define bfd_mach_avr51      51
> > +#define bfd_mach_avr6       6
> > +#define bfd_mach_avrtiny    100
> > +#define bfd_mach_avrxmega1  101
> > +#define bfd_mach_avrxmega2  102
> > +#define bfd_mach_avrxmega3  103
> > +#define bfd_mach_avrxmega4  104
> > +#define bfd_mach_avrxmega5  105
> > +#define bfd_mach_avrxmega6  106
> > +#define bfd_mach_avrxmega7  107
>
> I think the changes in include/disas/dis-asm.h should go in patch #6
> "target/avr: Add defintions of AVR core types" where the definitions are
> used:
>
>    const char *avr_flags_to_cpu_type(uint32_t flags, const char
> *def_cpu_type)
>    {
>        switch (flags & EF_AVR_MACH) {
>        case bfd_mach_avr1:
>            return AVR_CPU_TYPE_NAME("avr1");
>

I agree.

> >     bfd_arch_cris,       /* Axis CRIS */
> >   #define bfd_mach_cris_v0_v10   255
> >   #define bfd_mach_cris_v32      32
> > diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> > index 62c6fe4..893df26 100644
> > --- a/include/sysemu/arch_init.h
> > +++ b/include/sysemu/arch_init.h
> > @@ -24,6 +24,7 @@ enum {
> >       QEMU_ARCH_NIOS2 =3D (1 << 17),
> >       QEMU_ARCH_HPPA =3D (1 << 18),
> >       QEMU_ARCH_RISCV =3D (1 << 19),
> > +    QEMU_ARCH_AVR =3D (1 << 20),
> >   };
> >
> >   extern const uint32_t arch_type;
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index b3d30bc..f2dc385 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -21,11 +21,12 @@
> >   #        is true even for "qemu-system-x86_64".
> >   #
> >   # ppcemb: dropped in 3.1
> > +# avr: since 5.0
> >   #
> >   # Since: 3.0
> >   ##
> >   { 'enum' : 'SysEmuTarget',
> > -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
> > +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',=
 'lm32',
> >                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >                'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >
>

