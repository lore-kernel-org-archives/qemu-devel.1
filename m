Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHJO-0005z8-61
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHJN-0002dh-1j
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:57:34 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chHJM-0002dL-Rq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:57:32 -0500
Received: by mail-wr0-x22a.google.com with SMTP id g10so12919124wrg.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:57:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87shn3lkj3.fsf@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
	<87wpcflmmb.fsf@linaro.org>
	<CAFEAcA-OhSMFKgRYsCWUrb6OBxxrWokkkpJyioveEur-p4-g2A@mail.gmail.com>
	<87shn3lkj3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:57:10 +0000
Message-ID: <CAFEAcA-e5s6Tru_Kfba9hQHL827r2N5jyBvbpwbro7fHX2m1KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/13] Rewrite NVIC to not
 depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 24 February 2017 at 14:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The tests currently fail to build:
>
> /usr/bin/arm-none-eabi-objcopy -S -O binary test6-kern.elf test6-kern.bin
> test7.c: In function 'usage':
> test7.c:58:9: error: format '%x' expects argument of type 'unsigned int',=
 but argument 2 has type 'uint32_t' [-Werror=3Dformat=3D]
>          testDiag("Ignoring bogus LR %x, doing return to handler", old_lr=
);
>          ^
> test7.c:76:9: error: format '%x' expects argument of type 'unsigned int',=
 but argument 2 has type 'uint32_t' [-Werror=3Dformat=3D]
>          testDiag("Ignoring bogus LR %x, doing return to thread", old_lr)=
;
>          ^
> test7.c: In function 'svc':
> test7.c:105:9: error: format '%x' expects argument of type 'unsigned int'=
, but argument 2 has type 'uint32_t' [-Werror=3Dformat=3D]
>          testDiag("New xPSR %x", sframe[7]);
>          ^
> test7.c:109:9: error: format '%x' expects argument of type 'unsigned int'=
, but argument 2 has type 'uint32_t' [-Werror=3Dformat=3D]
>          testDiag("old xPSR %x", sframe[7]);
>          ^
> test7.c:116:9: error: format '%x' expects argument of type 'unsigned int'=
, but argument 2 has type 'uint32_t' [-Werror=3Dformat=3D]
>          testDiag("In SVC handler (direct call from main with LR %x)", ol=
d_lr);
>          ^
> /usr/bin/arm-none-eabi-objcopy -S -O binary test8-kern.elf test8-kern.bin
> /usr/bin/arm-none-eabi-objcopy -S -O binary test9-kern.elf test9-kern.bin
> /usr/bin/arm-none-eabi-objcopy -S -O binary test10-kern.elf test10-kern.b=
in
> /usr/bin/arm-none-eabi-objcopy -S -O binary test11-kern.elf test11-kern.b=
in
> /usr/bin/arm-none-eabi-objcopy -S -O binary test13-kern.elf test13-kern.b=
in
> /usr/bin/arm-none-eabi-objcopy -S -O binary test14-kern.elf test14-kern.b=
in
> cc1: all warnings being treated as errors
> Makefile:49: recipe for target 'test7.o' failed
> make: *** [test7.o] Error 1
> make: Target 'all' not remade because of errors.
>
> I suspect its the same thing as I came across with kvm-unit-tests that
> compilers targeting the same abi can still disagree about sizes:
>
>   https://git.kernel.org/cgit/virt/kvm/kvm-unit-tests.git/commit/?id=3D52=
9046c397059b8c5ef4dc5fb3c258d86fafb126

Could be. I use arm-linux-gnueabihf-gcc to build. If you use
PRIx32 does it build OK?

thanks
-- PMM
