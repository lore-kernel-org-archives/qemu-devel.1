Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEFBC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6485D206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlLsdDbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2BFm-0002v7-En
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 05:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2BDy-0002DK-Mh
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 05:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2BDv-0006VD-8Y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 05:23:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2BDu-0006UL-Tg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 05:23:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so15120017wmg.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZMKsDk1ez8pOMos7vwEqWdwJCAlC08q1qZLnn+N1weA=;
 b=LlLsdDbFz6oZ0aMiSrUVmu6AjBkLir/Wu1XIv8LF7jIHL7v7Hi2fybmkymmZYgnzH+
 o2P10LL8v7akPUdBQ+wHVv3Hv8vO1KL9KDXayOyMRbo/TYoH3RcAp/DPNQMqhTRBgwdl
 F1/eBltj4JdJwQtN+50KctoivHewTtd0jPpgpuw4HQsUUrRtPQtxouYvU9WzLhxV5xs2
 Ht1BZUzzytyxvRKeqNVgxoJIyrP+FBFixMg8czd6BNa8WRjPgIVeu5uALUXcsl0jVD7k
 Vews1H5T0GWDp0fKktOEV86tNnWpOlQ/3puGt6OpSyC+pVYzBtwMI+qUG3M0QR4LbUKU
 jIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZMKsDk1ez8pOMos7vwEqWdwJCAlC08q1qZLnn+N1weA=;
 b=YkyuFfGWzPJ+ykG9NaXzfgu1Rn1HxT8EGuTD7VUqM/aOFBlv1t7jax5LIDC87wpwPS
 f76nF4kVf3mpzDGTBcDPoBeQ2moAVF8ZWgyj09FknQ/FsIFdAQXVbTU9IHMeFUpNmuhy
 wtkjHDtqMXs21HfWkz2oq/b6zIwgxE4IdRg4tU+QGxl5qa4+sUYSMHBZmZ6GQ4EQ5HnA
 LzrKEH8c4USnV1BMo9uTgxPjLc1ZGQFlD/1Wd+dSqHnP+mX5xVKxwil05hbqA6dF4bwt
 yyLF3NeZnlSujE7/CDKXE/j6yzFu5R9QP4mYnuvqPlB5y9EcYnywuxcBmH3mV99jD/58
 mNbw==
X-Gm-Message-State: APjAAAW46pXSZAL4M3IbUPWu8nkOq5IaPE3RlAjtl9Z4PwFd6CbsOHGU
 SNYS3wqEGL/cpU1cPmUfOa3ogA==
X-Google-Smtp-Source: APXvYqzIAw8s3pKM1RjSI4++xOnwFeRKafWQgTzarRwBFf9w1BBCQnZqf6y2EQ5GtGfDc5UOZAnAtA==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr20295849wmg.15.1566811417308; 
 Mon, 26 Aug 2019 02:23:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o8sm20437572wma.1.2019.08.26.02.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 02:23:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A5D61FF87;
 Mon, 26 Aug 2019 10:23:36 +0100 (BST)
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190824184635.34192-9-mrolnik@gmail.com>
Date: Mon, 26 Aug 2019 10:23:35 +0100
Message-ID: <87mufwz3e0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael Rolnik <mrolnik@gmail.com> writes:

> 1. Avocado test
>     The test is based on
>     https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
>     demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' o=
ut.
>     it also demostrates that timer and IRQ are working
>
> 2. Boot serial test
>     Prinit out 'T' through serial port
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/Makefile.include           |  2 ++
>  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>  tests/boot-serial-test.c         | 10 +++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 49684fd4f4..dbaeb87572 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -202,6 +202,8 @@ check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(=
EXESUF)
>  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
>
> +check-qtest-avr-y +=3D tests/boot-serial-test$(EXESUF)
> +
>  check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
>
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_=
avr6.py
> new file mode 100644
> index 0000000000..0601080b01
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,36 @@
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process
> +
> +class AVR6Machine(Test):
> +    timeout =3D 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=3Darch:avr
> +        :avocado: tags=3Dmachine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/=
Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQ=
RSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url +=3D '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo=
.elf'
> +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> +
> +        self.vm.set_machine('sample')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.add_args('-nographic')
> +        self.vm.launch()
> +
> +        time.sleep(2)
> +        self.vm.shutdown()
> +
> +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 24852d4c7d..22cbaccc1b 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -16,6 +16,15 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>
> +static const uint8_t bios_avr[] =3D {
> +    0x88, 0xe0,             /* ldi r24, 0x08   */
> +    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
> +    0x86, 0xe0,             /* ldi r24, 0x06   */
> +    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 =
*/
> +    0x84, 0xe5,             /* ldi r24, 0x54   */
> +    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
> +};
> +

Are there any compilers available so we can add the multiarch tests to "che=
ck-tcg"?

>  static const uint8_t kernel_mcf5208[] =3D {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> @@ -92,6 +101,7 @@ typedef struct testdef {
>
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
> +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },


--
Alex Benn=C3=A9e

