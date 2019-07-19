Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FDC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C252085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmuM656w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C252085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUjD-0002SU-2x
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hoUj1-000215-2Q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hoUip-0001yJ-DG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:23:04 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hoUid-00083p-0O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:22:47 -0400
Received: by mail-qk1-x741.google.com with SMTP id r6so23507859qkc.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G9HTnj16hL3lrS+Wf+IaDLfnwfrAIi/eeo6AWXzILdI=;
 b=PmuM656w18TsMFHTLbn9aJeDQy1AfJDbMDDK8Vd4ye166SWWYNV4XwloNTz900j2BA
 uVp9NgaFK7v0/uQf6rmHi0gkwPiW8VDyBLNHO+JaRiAk6q9ud/o+slT4fw4j7qNW0BwF
 s6k2vWKggFpojGrEZBHUO7cSVnuLsxQERnBRbjsxA/tpOPsi+sPm6gU4Y1pcnxnj+Iv0
 7tQVZNiIMlMtjyoJQkhiPb+weQP4qCdXTFjWj6Wc8s/f59W8vsxcWlQ3exC1H7uI5MwL
 5PZYr5+fERrMsK+0LM7UAy2zR6qVXR35tMWlajeNOhUmiH6kiD2NP3zOorqtTb6vY1h6
 9sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G9HTnj16hL3lrS+Wf+IaDLfnwfrAIi/eeo6AWXzILdI=;
 b=tvKaBr33rii9HE/Wmoilvi2Ej2U2UlZQBA12bN7iNaMG7GTaB9m3lcLZpYz+HUDSdE
 NHwDnzpoSQSYmpKeOEZua6MYmF0QjKakLdBP4zzX4cLFVp+jpxt90p4mEQFrk5ZsO7q6
 lzUVdX3NbZNs3exqVm6bWT9DKzCruSDKlw0kxRn/qbD40U4M3Rb87u3yGO4svSALdSIx
 w4JvRu2dqO+blI3phQW4rQeARqRimCyYqDSXzqcnUphf1PNQsfbtpdPpVkS6il3IKIqb
 ez0nJEjBX2ck+qn1W0ckbekcFT5+ERggr6KVeWztcS/GguQ+CkwagoQ5Mk3To96mGnxk
 nRWA==
X-Gm-Message-State: APjAAAVSBJUPq9SXXIK/5KtIa//zo5zGsQqoXy+PsivwnCZnyvUgtq+d
 Qn5AZ3vqE6NeYPqCAVeC67sW3ew9EQlHVBDTCbk=
X-Google-Smtp-Source: APXvYqycNHAT/ozrlv+6NRyC5eh+TMq9f8qKGx8iYwcXz1Suy1ffMtaBZqlKrsaNY/Y7w1vq0LrF/FwD3AdM3sE7A0I=
X-Received: by 2002:a37:4d16:: with SMTP id a22mr35990390qkb.103.1563548750897; 
 Fri, 19 Jul 2019 08:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-9-mrolnik@gmail.com>
 <da64fd46-c0f0-b6b6-3b8f-d3da9041605d@redhat.com>
In-Reply-To: <da64fd46-c0f0-b6b6-3b8f-d3da9041605d@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 19 Jul 2019 18:05:13 +0300
Message-ID: <CAK4993g7L5T44a-=BnbdCObsQbtvXBwXgYiXj1Z9b0BCXKWGQQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v27 8/8] target/avr: Add tests
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

thanks.

On Fri, Jul 19, 2019 at 4:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 7/19/19 10:26 AM, Michael Rolnik wrote:
> > 1. Avocado test
> >     The test is based on
> >
> https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
> >     demo which, If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX'
> out
>
> Note, that test also demonstrates the timer and irq are working :)
>
> Enabling DB_PRINT:
>
> avr_timer16_interrupt: CTC OCRA overflow
> avr_timer16_interrupt: interrupt, cnt =3D 253
> avr_timer16_interrupt: CTC OCRA overflow
> avr_timer16_interrupt: interrupt, cnt =3D 269
> avr_timer16_interrupt: CTC OCRA overflow
> avr_timer16_interrupt: interrupt, cnt =3D 269
>
> (There is also GPIO accesses but you don't implement them yet).
>
> >
> > 2. Boot serial test
> >     Prinit out 'T' through serial port
>
> Excellent!
>
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  tests/Makefile.include           |  2 ++
> >  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
> >  tests/boot-serial-test.c         | 12 +++++++++++
> >  3 files changed, 50 insertions(+)
> >  create mode 100644 tests/acceptance/machine_avr6.py
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index fd7fdb8658..8a186dcc23 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -201,6 +201,8 @@ check-qtest-i386-y +=3D
> tests/test-x86-cpuid-compat$(EXESUF)
> >  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
> >  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
> >
> > +check-qtest-avr-y +=3D tests/boot-serial-test$(EXESUF)
> > +
> >  check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
> >  check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> >
> > diff --git a/tests/acceptance/machine_avr6.py
> b/tests/acceptance/machine_avr6.py
> > new file mode 100644
> > index 0000000000..0601080b01
> > --- /dev/null
> > +++ b/tests/acceptance/machine_avr6.py
> > @@ -0,0 +1,36 @@
> > +import logging
> > +import time
> > +import distutils.spawn
> > +
> > +from avocado import skipUnless
> > +from avocado_qemu import Test
> > +from avocado.utils import process
> > +
> > +class AVR6Machine(Test):
> > +    timeout =3D 5
> > +
> > +    def test_freertos(self):
> > +        """
> > +        :avocado: tags=3Darch:avr
> > +        :avocado: tags=3Dmachine:sample
> > +        """
> > +        """
> > +
> https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_=
ATMega2560_GCC/demo.elf
> > +        constantly prints out
> 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> > +        """
> > +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> > +        rom_url +=3D
> '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
> > +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> > +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> > +
> > +        self.vm.set_machine('sample')
> > +        self.vm.add_args('-bios', rom_path)
> > +        self.vm.add_args('-nographic')
> > +        self.vm.launch()
> > +
> > +        time.sleep(2)
> > +        self.vm.shutdown()
> > +
> > +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> > +
> > +        self.assertIn(match, self.vm.get_log())
> > diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> > index 24852d4c7d..73d273b73f 100644
> > --- a/tests/boot-serial-test.c
> > +++ b/tests/boot-serial-test.c
> > @@ -16,6 +16,17 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >
> > +static const uint8_t bios_avr[] =3D {
> > +    0x89, 0xe1,             /* ldi r24, 0x19   */
> > +    0x80, 0x93, 0xc5, 0x00, /* sts 0x00C5, r24 ; set baud rate to 3840=
0
> */
>
> FWIW we can remove the previous two lines, we don't care about the
> baudrate in this test.
>
> > +    0x88, 0xe0,             /* ldi r24, 0x08   */
> > +    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
> > +    0x86, 0xe0,             /* ldi r24, 0x06   */
> > +    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to =
8
> */
> > +    0x84, 0xe5,             /* ldi r24, 0x54   */
> > +    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
> > +};
> > +
> >  static const uint8_t kernel_mcf5208[] =3D {
> >      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> >      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> > @@ -92,6 +103,7 @@ typedef struct testdef {
> >
> >  static testdef_t tests[] =3D {
> >      { "alpha", "clipper", "", "PCI:" },
> > +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
> >      { "ppc", "ppce500", "", "U-Boot" },
> >      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
> >      { "ppc", "g3beige", "", "PowerPC,750" },
> >
>
> Testing shows:
>
>   TEST    check-qtest-avr: tests/boot-serial-test
> qemu-system-avr: Unable to load /tmp/qtest-boot-serial-cOndewD as ELF,
> trying again as raw binary
>
> I wonder if this might fail Peter's testing, so Cc'ing Thomas.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Regards,
>
> Phil.
>


--=20
Best Regards,
Michael Rolnik
