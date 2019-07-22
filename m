Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA72C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687FF21901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNbdEwK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687FF21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpd10-0002I7-KA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hpd0p-0001sF-SN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hpd0n-0002X5-2c
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:26:14 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hpd0m-0002Vt-OS; Mon, 22 Jul 2019 14:26:13 -0400
Received: by mail-lj1-x244.google.com with SMTP id p17so38563717ljg.1;
 Mon, 22 Jul 2019 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XnXm48m9ipg/WN3CxUkWMt9IuAcSwBJl1WhAU5TtDIE=;
 b=aNbdEwK+ER39LDq/H/hXltsZlDQk/piVqMynOgqpclVrGoqB7MKNWvAQ2+rkbryrno
 0xg1E0BhiFSjSChK8c3Sq4hkPLS8jFvNdzyrsr+c26ebgqLLUT+LMeCjCpnBRsW5BymI
 fW+plQr525QRVTf0gveE40gcT6tO++JldKp4d7Mmx3X0dQrTSlTOPPLAT3Ixm4WvEAtw
 GyyYYuWxh5YuwMEmvaFr1wC4XdB9JsIdNG4VCyz1ls70ewdcNXCPjlytTf/7ZiDeqpZn
 cKnBhbSv5+PiQDuXjU/PxkdQkLnYQEQnPaTKUe1yMum6PvoXxXcQs1oCyh+rhvdxMrtu
 A6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XnXm48m9ipg/WN3CxUkWMt9IuAcSwBJl1WhAU5TtDIE=;
 b=BdjoSxLN629jP7nYVkUjdue+2Zn68HXZtYEZb/88HNMYPS68viyhqq+cNEkhGorEKQ
 yAMDglzBKjNF/n3v/1E7TAreQ6nb9KpN07cUDregEDk0KGzGjl4ms8D8w7kyjn9ikGSh
 V2bznPBYA3drmawF3ytKTDn+x+tmKVzBgcRlaab88y8xWzE0hpR2yD6lsSMT0+rGha07
 8oHLluKG4h8cAyZ+d+po9JBpulmyG/iqbYWruUpDC3MwHM73ZFTlDj4GvBWKyHNE7Dfs
 W8WQ6SFKY9qoYynJVRDHj1/gLcX59iucJJ6A9mcdzdOgRwjcTKLbKSlqyncuXyHTbEGq
 +PNQ==
X-Gm-Message-State: APjAAAVbleIwoaDgTXNEkyB4gf+ANYVE6kxbRPem9nhYJKpwt0GKRC22
 Y9QOAZ7zqkCxzsQGMBkARQRiXGfB0nPdPTTTDlY=
X-Google-Smtp-Source: APXvYqxtk+tr4GlZTl1GWV9hyhINcEHi1Ncg8QAPG/Y9Z4G0J9i40W1cdxlhEXzRc+YC0QA5rEnwS/5kr7cVWEtezEw=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr37395224ljj.58.1563819970521; 
 Mon, 22 Jul 2019 11:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <edd3c94d357207e3862d1f5fec7e7346e70831f4.1563559494.git.alistair.francis@wdc.com>
 <550d4158-d7dd-c38b-3082-302184a20883@redhat.com>
In-Reply-To: <550d4158-d7dd-c38b-3082-302184a20883@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jul 2019 11:22:43 -0700
Message-ID: <CAKmqyKNnkToYf3Y025Hpv1e8jazMVjxhjAaOBtn0ajcHSFaTUA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv/boot: Fixup the RISC-V
 firmware warning
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 20, 2019 at 2:30 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 7/19/19 8:05 PM, Alistair Francis wrote:
> > Fix a typo in the warning message displayed to users, don't print the
> > message when running inside qtest and don't mention a specific QEMU
> > version for the deprecation.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/boot.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 5dee63011b..4b32ab1d26 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -26,6 +26,7 @@
> >  #include "hw/riscv/boot.h"
> >  #include "hw/boards.h"
> >  #include "elf.h"
> > +#include "sysemu/qtest.h"
> >
> >  #if defined(TARGET_RISCV32)
> >  # define KERNEL_BOOT_ADDRESS 0x80400000
> > @@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *mac=
hine,
> >           * In the future this defaul will change to loading the prebui=
lt
> >           * OpenSBI firmware. Let's warn the user and then continue.
> >          */
> > -        warn_report("No -bios option specified. Not loading a firmware=
.");
> > -        warn_report("This default will change in QEMU 4.3. Please use =
the " \
> > -                    "-bios option to aviod breakages when this happens=
.");
> > -        warn_report("See QEMU's deprecation documentation for details"=
);
> > +        if (!qtest_enabled()) {
> > +            warn_report("No -bios option specified. Not loading a firm=
ware.");
> > +            warn_report("This default will change in a future QEMU rel=
ease. " \
> > +                        "Please use the -bios option to avoid breakage=
s when "\
> > +                        "this happens.");
> > +            warn_report("See QEMU's deprecation documentation for deta=
ils");
>
> Maybe a final '.' in the last warning to be consistent with the previous
> lines?

Done in v2.

>
> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

Alistair

>
> > +        }
> >          return;
> >      }
> >
> >

