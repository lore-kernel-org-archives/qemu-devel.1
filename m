Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2EC432C3
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 00:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4160920714
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 00:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm0qX5ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4160920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYfvG-0007Oc-Fn
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 19:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYfuX-0006us-3Y
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 19:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYfuV-0002Dj-9n
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 19:37:57 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:46139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYfuV-0002DO-40
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 19:37:55 -0500
Received: by mail-oi1-x22f.google.com with SMTP id n14so9885053oie.13
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ihnISIdwTOF4SWBoKCUbxKRf9iiP+E+j9/+NYkJB5oI=;
 b=Dm0qX5ti7GgfdoBEqZbTCN9Nw2V3AspGF1vYVkZauk9UTFnyuD2ryeGYwsB1HtOrex
 T1H0v2VfBvK0JU/dA5uEypC5/+73IlXGvP6aRsDyRKRKFoQ963Ji62t+Y5hI1KIlHfoH
 IMjW9Q+v1zYk3LaRQLOYxoBoQilEfe277GFKGLr/llCiLT91+EkwpmUPUqcoy1od1sxo
 y05EOOwgQ+mPZNIBCNXjIsNOl2Yk8oaOnq2VmvtVkx59iuauKnhBxgQaXTVQebHgNIkv
 mDLmDmAEDqrglJHTbZ2zKegnfHD1aFn6xQcgfs0Rp18MRWEXMtCaM3bNEtHGRkUT/iV/
 WNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ihnISIdwTOF4SWBoKCUbxKRf9iiP+E+j9/+NYkJB5oI=;
 b=cVpoNi+L5sdjJuOlXLFIXw39M8jQOzvtqGhUfKjuMSSPO39QqjwPU2oxnMceJ1Sbod
 aiUiRQs9xTSfen2aqc4QsLCmpQ+ne4QMfIx4SCA4+NBTqSulZs/pHa9XZDDf5TuA/JXK
 qCln21OJ5wysryw2/R13c3oszPqefbgszcnY42EsYhJR7mBtQmeQhqsNOlmumaQlRsoo
 gBdwHBu9+RrcGc+9JlQ0EvBc9u3DKLfGSyZSqp98ni0oWH1uOyUPGZ5Gy9N6DIMWYgNJ
 NiFab5/WKqR41IBrK6dEF3uRizBamVlk+sdbBDloWn69L68mmW6cKRtD5gQxdxVPEKak
 LN+g==
X-Gm-Message-State: APjAAAViVC/5ARbReBU/jWtTQDlUAHn5AmGFsFC3wtFO2HSbVBfcIit3
 v6PLSQGZ8DJCJ21s4o3hPoJHhPUmlqL2WJxnWM4=
X-Google-Smtp-Source: APXvYqwRlBSfLl3lYYE7ve5PusrWXHf0GuN0lgNRy0hF+89x8UhbjAERLynTwUkPB2in5v6AdtCKxv3FFzPx8Zs0E6Q=
X-Received: by 2002:aca:6287:: with SMTP id w129mr3151906oib.106.1574555874242; 
 Sat, 23 Nov 2019 16:37:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 23 Nov 2019 16:37:53
 -0800 (PST)
In-Reply-To: <20191029212430.20617-14-mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-14-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 01:37:53 +0100
Message-ID: <CAL1e-=jzNuJPjZrvqMdDtf-e8_Exacwvxsj2jjXWikABiSeNbA@mail.gmail.com>
Subject: Re: [PATCH v35 13/13] target/avr: Add tests
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009034f005980cdbec"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009034f005980cdbec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 29, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> 1. Avocado test
>     The test is based on
>     https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
>     demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX'
> out.
>     it also demostrates that timer and IRQ are working
>
> 2. Boot serial test
>     Print out 'T' through serial port
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---


Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

But, please, Michael, divide this patch into two in the next version:

- target/avr: Add boot serial test
- target/avr: Add Avocado acceptance test

with, of course, adjusted corresponding commit messages. You can transfer
all "Reviewed-by:"s, "Tested-by:"s and "Acked-by:"s (includong mine) to
both new patches.

Yours, Aleksandar



>  tests/Makefile.include           |  2 ++
>  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>  tests/boot-serial-test.c         | 10 +++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7f487f65e7..3c077f6ca4 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -206,6 +206,8 @@ check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(
> EXESUF)
>  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
>
> +check-qtest-avr-y +=3D tests/boot-serial-test$(EXESUF)
> +
>  check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
>
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_
> avr6.py
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
> +        https://github.com/seharris/qemu-avr-tests/raw/master/
> free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEF
> GHIJKLMNOPQRSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url +=3D '/raw/master/free-rtos/Demo/
> AVR_ATMega2560_GCC/demo.elf'
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
> index d3a54a0ba5..1121ed0db2 100644
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
>  static const uint8_t kernel_mcf5208[] =3D {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> @@ -103,6 +112,7 @@ typedef struct testdef {
>
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
> +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
> --
> 2.17.2 (Apple Git-113)
>
>

--0000000000009034f005980cdbec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 29, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">1. Avocado test<br>
=C2=A0 =C2=A0 The test is based on<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/ma=
ster/free-rtos/Demo" target=3D"_blank">https://github.com/seharris/<wbr>qem=
u-avr-tests/tree/master/<wbr>free-rtos/Demo</a><br>
=C2=A0 =C2=A0 demo which. If working correctly, prints &#39;ABCDEFGHIJKLMNO=
PQRSTUVWX&#39; out.<br>
=C2=A0 =C2=A0 it also demostrates that timer and IRQ are working<br>
<br>
2. Boot serial test<br>
=C2=A0 =C2=A0 Print out &#39;T&#39; through serial port<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Acked-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.=
com</a>&gt;<br>
---</blockquote><div><br></div><div>Acked-by: Aleksandar Markovic &lt;<a hr=
ef=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br></di=
v><div><br></div><div>But, please, Michael, divide this patch into two in t=
he next version:</div><div><br></div><div>- target/avr: Add boot serial tes=
t</div><div>- target/avr: Add Avocado acceptance test</div><div><br></div><=
div>with, of course, adjusted corresponding commit messages. You can transf=
er all &quot;Reviewed-by:&quot;s, &quot;Tested-by:&quot;s=C2=A0and &quot;Ac=
ked-by:&quot;s (includong mine) to both new patches.</div><div><br></div><d=
iv>Yours, Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 ++<br>
=C2=A0tests/acceptance/machine_avr6.<wbr>py | 36 ++++++++++++++++++++++++++=
++++<wbr>++<br>
=C2=A0tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++=
+++<br>
=C2=A03 files changed, 48 insertions(+)<br>
=C2=A0create mode 100644 tests/acceptance/machine_avr6.<wbr>py<br>
<br>
diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
index 7f487f65e7..3c077f6ca4 100644<br>
--- a/tests/Makefile.include<br>
+++ b/tests/Makefile.include<br>
@@ -206,6 +206,8 @@ check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(<w=
br>EXESUF)<br>
=C2=A0check-qtest-i386-y +=3D tests/numa-test$(EXESUF)<br>
=C2=A0check-qtest-x86_64-y +=3D $(check-qtest-i386-y)<br>
<br>
+check-qtest-avr-y +=3D tests/boot-serial-test$(<wbr>EXESUF)<br>
+<br>
=C2=A0check-qtest-alpha-y +=3D tests/boot-serial-test$(<wbr>EXESUF)<br>
=C2=A0check-qtest-alpha-$(CONFIG_<wbr>VGA) +=3D tests/display-vga-test$(<wb=
r>EXESUF)<br>
<br>
diff --git a/tests/acceptance/machine_<wbr>avr6.py b/tests/acceptance/machi=
ne_<wbr>avr6.py<br>
new file mode 100644<br>
index 0000000000..0601080b01<br>
--- /dev/null<br>
+++ b/tests/acceptance/machine_<wbr>avr6.py<br>
@@ -0,0 +1,36 @@<br>
+import logging<br>
+import time<br>
+import distutils.spawn<br>
+<br>
+from avocado import skipUnless<br>
+from avocado_qemu import Test<br>
+from avocado.utils import process<br>
+<br>
+class AVR6Machine(Test):<br>
+=C2=A0 =C2=A0 timeout =3D 5<br>
+<br>
+=C2=A0 =C2=A0 def test_freertos(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:avr<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:sample<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/seharris/qemu-av=
r-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf" target=3D"_b=
lank">https://github.com/seharris/<wbr>qemu-avr-tests/raw/master/<wbr>free-=
rtos/Demo/AVR_ATMega2560_<wbr>GCC/demo.elf</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 constantly prints out &#39;<wbr>ABCDEFGHIJKLMN=
OPQRSTUVWXABCDEF<wbr>GHIJKLMNOPQRSTUVWX&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url =3D &#39;<a href=3D"https://github.com=
/seharris/qemu-avr-tests" target=3D"_blank">https://github.com/seharris/<wb=
r>qemu-avr-tests</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_url +=3D &#39;/raw/master/free-rtos/Demo/<=
wbr>AVR_ATMega2560_GCC/demo.elf&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_hash =3D &#39;<wbr>7eb521f511ca8f2622e0a3c=
5e8dd68<wbr>6efbb911d4&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_path =3D self.fetch_asset(rom_url, asset_h=
ash=3Drom_hash)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;sample&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-bios&#39;, rom_path)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-nographic&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.shutdown()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D &#39;<wbr>ABCDEFGHIJKLMNOPQRSTUVWXAB=
CDEF<wbr>GHIJKLMNOPQRSTUVWX&#39;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(match, self.vm.get_log())<br>
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c<br>
index d3a54a0ba5..1121ed0db2 100644<br>
--- a/tests/boot-serial-test.c<br>
+++ b/tests/boot-serial-test.c<br>
@@ -16,6 +16,15 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;libqtest.h&quot;<br>
<br>
+static const uint8_t bios_avr[] =3D {<br>
+=C2=A0 =C2=A0 0x88, 0xe0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* ldi r24, 0x08=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */<br=
>
+=C2=A0 =C2=A0 0x86, 0xe0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* ldi r24, 0x06=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bi=
ts to 8 */<br>
+=C2=A0 =C2=A0 0x84, 0xe5,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* ldi r24, 0x54=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output &#39;T&#=
39; */<br>
+};<br>
+<br>
=C2=A0static const uint8_t kernel_mcf5208[] =3D {<br>
=C2=A0 =C2=A0 =C2=A00x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,=C2=A0 =C2=A0 =C2=A0=
/* lea 0xfc060000,%a0 */<br>
=C2=A0 =C2=A0 =C2=A00x10, 0x3c, 0x00, 0x54,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* move.b #&#39;T&#39;,%d0 */<br>
@@ -103,6 +112,7 @@ typedef struct testdef {<br>
<br>
=C2=A0static testdef_t tests[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;alpha&quot;, &quot;clipper&quot;, &quot;&quot;,=
 &quot;PCI:&quot; },<br>
+=C2=A0 =C2=A0 { &quot;avr&quot;, &quot;sample&quot;, &quot;&quot;, &quot;T=
&quot;, sizeof(bios_avr), NULL, bios_avr },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ppc&quot;, &quot;ppce500&quot;, &quot;&quot;, &=
quot;U-Boot&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ppc&quot;, &quot;40p&quot;, &quot;-vga none -bo=
ot d&quot;, &quot;Trying cd:,&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ppc&quot;, &quot;g3beige&quot;, &quot;&quot;, &=
quot;PowerPC,750&quot; },<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000009034f005980cdbec--

