Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 01:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7478C21871
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIuZv7Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7478C21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvAsq-0005Xn-PO
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 21:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvAsU-00057R-0x
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 21:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvAsS-0004Mi-Q8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 21:36:33 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvAsQ-0004LB-2m; Tue, 06 Aug 2019 21:36:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id k21so84388578edq.3;
 Tue, 06 Aug 2019 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uKu0tsS9K7kwjmF4PzxoJR1/FCHJllfHIy6qHNa1Kkw=;
 b=MIuZv7OshtnaKtKPHXX1jgAABonIAMT/7ql6u0ig5Vw98Gv1o7KzkBaNBpSYuBD0PX
 GMvGkVFKkGf3xQaRzD938YcIPcZkFe0homc6fze8dh9phJ5y93GLOlISdfjYvAbzc0Xh
 YFaGAN6vbCN6KagOUhTYo/OCCY/HkE41XHe/aG0Sb6Bqw71Hhuhn56rjH+tU1tJQ0apo
 45A+95hpw3f6LarsSkhHhbtVZRM+0C9ltI07cqne58kPXgXxr+gk4PHh4h+E7J+gDgbN
 VBD6BplKRKAZi0jA0qj6/zrmNYyWvne8C2eGUI5vek15Q8QY0kx1kg+1DXZ/XveJlJYB
 YDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uKu0tsS9K7kwjmF4PzxoJR1/FCHJllfHIy6qHNa1Kkw=;
 b=cd9cU+AOd4dkopO1a+3C/9WRrfYxvlAZsM2Jt6TJqFHZTtM/SDChbTxzpucaqQNjLS
 +Sw2PkHw65m6n4xDJeXj0tym9xKUIG61yT0blsfvS7f5A9Vj4HhEpuz5IfcUVfNsI9Ki
 aKwDN4ZC1f7EmJ9uGifClTb0uDXLbfllo/x/wZIvpdosvVZQmaodHw+anakRu9rOS8DP
 RvoWzcSdPAOzblk2mJxy/aWAjaHvVW51kw/NYJc973BAh7+XOpSznDbGoBvtlI78+d57
 mNACIANjDlNzwnjUdSxVSMoiACSGHll899mefTS0W7OOLovjczsCyJDM6VLFamSLYGJ3
 zWJQ==
X-Gm-Message-State: APjAAAXHuBlW+U294za0jMfWBp9PGR2bPZVsZMNSpBxcXdp8nXQB0PVb
 ff4vTFALd7484y3w+4q077LrhrOKdPjxdP6Y1lQ=
X-Google-Smtp-Source: APXvYqx0VPV4Vctfd8+53Hnx3bUPN9EzbVOasNwUvUEbM4m/WyTQp4l5E3UXnqaEb81+0qytrr9h8CHkD346lPiHoxo=
X-Received: by 2002:a17:906:499a:: with SMTP id
 p26mr6127750eju.308.1565141788000; 
 Tue, 06 Aug 2019 18:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
 <CAEUhbmU-TdVocONETkSV-+DtX_66+8J8m3yYeph3P1i_3C9LzQ@mail.gmail.com>
 <11403b54-d41a-3083-7794-2c699a223479@redhat.com>
In-Reply-To: <11403b54-d41a-3083-7794-2c699a223479@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Aug 2019 09:36:17 +0800
Message-ID: <CAEUhbmVfUAwvDi_p8FikZnzX0drZ9an_mENdGKF0yEmR7Gvseg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 5:06 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 8/5/19 8:43 AM, Bin Meng wrote:
> > On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sifive.com> =
wrote:
> >> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>
> >>> Some of the SoC IP block sizes are wrong. Correct them according
> >>> to the FE310 manual.
> >>>
> >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >>> ---
> >>>
> >>>  hw/riscv/sifive_e.c | 6 +++---
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> >>> index 2a499d8..9655847 100644
> >>> --- a/hw/riscv/sifive_e.c
> >>> +++ b/hw/riscv/sifive_e.c
> >>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
> >>>      hwaddr base;
> >>>      hwaddr size;
> >>>  } sifive_e_memmap[] =3D {
> >>> -    [SIFIVE_E_DEBUG] =3D    {        0x0,      0x100 },
> >>> +    [SIFIVE_E_DEBUG] =3D    {        0x0,     0x1000 },
> >>>      [SIFIVE_E_MROM] =3D     {     0x1000,     0x2000 },
> >>>      [SIFIVE_E_OTP] =3D      {    0x20000,     0x2000 },
> >>>      [SIFIVE_E_CLINT] =3D    {  0x2000000,    0x10000 },
> >>>      [SIFIVE_E_PLIC] =3D     {  0xc000000,  0x4000000 },
> >>> -    [SIFIVE_E_AON] =3D      { 0x10000000,     0x8000 },
> >>> -    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x8000 },
> >>> +    [SIFIVE_E_AON] =3D      { 0x10000000,     0x1000 },
> >>> +    [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x1000 },
> >>>      [SIFIVE_E_OTP_CTRL] =3D { 0x10010000,     0x1000 },
> >>>      [SIFIVE_E_GPIO0] =3D    { 0x10012000,     0x1000 },
> >>>      [SIFIVE_E_UART0] =3D    { 0x10013000,     0x1000 },
> >>> --
> >>> 2.7.4
> >>>
> >>
> >> It seems the modification follows  E310-G002(Hifive1 Rev B) spec and t=
he origin is for E310-G000(Hifive1) spec.
> >> There should be some way to specify different board version with diffe=
rent memory map or we have policy, always support the latest spec.
>
> I agree with Chao, it would be cleaner to have two different boards
> (machines).
> Since the SoCs are very similar, you could add a 'revision' property and
> use it to select the correct map.
>
> >>
> >
> > Yes, I checked both specs. The older spec says these bigger sizes,
> > however their register sizes fit well in the smaller range as well. So
> > I think the modification works well for both.
>
> This is OK for the PRCI, since sifive_prci_create() does not use
> memmap[SIFIVE_E_PRCI].size.
>
> However the AON case is borderline, since you shrink it from 32KiB to 4Ki=
B.
>
> BTW (not related to this patch) it is odd a function named
> sifive_mmio_emulate() creates a RAM region with memory_region_init_ram()
> and does not use the UnimplementedDevice (see make_unimp_dev() in
> hw/arm/musca.c).

Yes, this sifive_mmio_emulate() issue has been pointed out by Alistair
when reviewing the following patch:
http://patchwork.ozlabs.org/patch/1142293/

Regards,
Bin

