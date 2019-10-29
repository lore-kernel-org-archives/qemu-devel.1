Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E8CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C0A20874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5LGuo74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C0A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOqb-0002nt-6i
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iPOov-0000t9-Ci
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iPOoq-0001a3-38
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:33:49 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iPOop-0001YG-HG; Tue, 29 Oct 2019 06:33:43 -0400
Received: by mail-lj1-x244.google.com with SMTP id m9so4993910ljh.8;
 Tue, 29 Oct 2019 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oWTnhYRh/l57DL8jvOYmMmX3ZU2QpR0DAgs1aPU4g8s=;
 b=X5LGuo74z4qPP+CybkyPHgsSZHTgP5zfqOlFlFIhIcYatlF21EmXHDgP66OVvGMIWW
 cvw5VpfC9gQDTfvRdRL9J7EmzVQazayHYZ8aX1Ano55qU3RpHSMChqzonvFKUhlWvfcn
 dDC1Y8pjdT2WZD/PbuD5enslyv6hLDmXVpQ6oDIcfIB51BWfWA3HiYB+l/KU/HsV+ZWi
 e9Bd7d8EM9LPiBX/cHOKy/6MmO0l9i1at40Itgs96Q7z46gyR70/0++IZz5Y4E/tX8gv
 TwrJDkxRqmrDYNwQOE7TUJ3i9TrZxcNdWIdNh4Pv8B9kxKQ84srMUD7jcZ7QG9Br+Y6v
 eK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oWTnhYRh/l57DL8jvOYmMmX3ZU2QpR0DAgs1aPU4g8s=;
 b=AV9B9f8ArmACOZqj0jWg3JDUkkQzVWjQ2GVYvzzB3BCYYrJ62cL0Canb+STwSA7bB8
 wWPBBYO+JWUFeU5F3NV/ww82WxecfZC86kQvpCdimgAvAboW14MQgMdlZqB71iQtyUB3
 WI736yfZg8icIQ01WtfIRq5XJ2L+v+QDK4KcgcIY+lJoUsIrRTn/gWX+sw5LfoU1ZJ3D
 Xvs9Bwp0z6i51gxIVt1dHccumVnTEJZwjkb6i3JV+NMgQmrd8/op1ZU5vo1UPmWRXrlS
 +BtxYckeIDBg9no452ECI2Q87NtQyoa85Cp0DuCUi464KGoUL7II3Wh9XAyeLAqSEc4c
 nyCw==
X-Gm-Message-State: APjAAAW7hO/kHunRQyv7uZeov0LMDcuEdcbxIc0cwM1MMjHzgD4AxuZa
 mdAiZDmrpvP235N3bzvjRjxlxJihNwikAYh23h0=
X-Google-Smtp-Source: APXvYqxzhU/0X0Y8Ux/DjsaxaSORg5A+Nl+/D8R7U9sFuX/f1JGGZrnIdsXGNI1BP5CLJ+jw8gr8zioeVD+ENovLOlI=
X-Received: by 2002:a2e:b54d:: with SMTP id a13mr2131317ljn.4.1572345220922;
 Tue, 29 Oct 2019 03:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+75-XUbnCDp-JH6JRnGLqVMxDWTFa9kPHJaZXm3NfCzZUbYg@mail.gmail.com>
 <mhng-90e9ee91-7ee7-488a-8db0-35d39043f2fc@palmer-si-x1c4>
In-Reply-To: <mhng-90e9ee91-7ee7-488a-8db0-35d39043f2fc@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Oct 2019 11:33:14 +0100
Message-ID: <CAKmqyKMVvLXbziQ8qFC-VcOq2jv1Qm1pK0upK0c1nuYRELgqxw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] opensbi: Upgrade from v0.4 to v0.5
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 5:56 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sat, 26 Oct 2019 01:46:45 PDT (-0700), philmd@redhat.com wrote:
> > On Sat, Oct 26, 2019 at 10:45 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> Hi Alistair,
> >>
> >> On 10/26/19 1:15 AM, Alistair Francis wrote:
> >> > This release has:
> >> >      Lot of critical fixes
> >> >      Hypervisor extension support
> >> >      SBI v0.2 base extension support
> >> >      Debug prints support
> >> >      Handle traps when doing unpriv load/store
> >> >      Allow compiling without FP support
> >> >      Use git describe to generate boot-time banner
> >> >      Andes AE350 platform support
> >>
> >> Do you mind amending the output of 'git shortlog v0.4..v0.5'?
> >
> > Err this comment is for Palmer, if Alistair agree (no need to repost).
>
> Works for me.  I've included the shortlog as part of the patch on my for-=
master
> branch, unless there's any opposition I'll include this in my next PR.

Sounds good!

Alistair

>
> >
> >> >
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> > You can get the branch from here if the binaries are causing issues:
> >> > https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.ne=
xt
> >>
> >> You can use 'git format-patch --no-binary'.
> >>
> >> >
> >> >   pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 40984 =
bytes
> >> >   pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 49160 =
bytes
> >> >   pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 45064 =
bytes
> >> >   roms/opensbi                                 |   2 +-
> >> >   4 files changed, 1 insertion(+), 1 deletion(-)
> >> [...]
> >> > diff --git a/roms/opensbi b/roms/opensbi
> >> > index ce228ee091..be92da280d 160000
> >> > --- a/roms/opensbi
> >> > +++ b/roms/opensbi
> >> > @@ -1 +1 @@
> >> > -Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
> >> > +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
> >> >

