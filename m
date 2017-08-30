Received: from eggs.gnu.org ([2001:4830:134:3::10]:37101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn24p-000218-Eg
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn24o-0003o8-L4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:26:35 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dn24o-0003nV-Dl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:26:34 -0400
Received: by mail-wr0-x236.google.com with SMTP id k94so18092186wrc.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 05:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <10da5552-c90a-21e6-43ac-829932f64930@amsat.org>
References: <1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com>
	<1503938283-12404-5-git-send-email-sundeep.lkml@gmail.com>
	<10da5552-c90a-21e6-43ac-829932f64930@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2017 13:26:12 +0100
Message-ID: <CAFEAcA9W=YqbeYKuAxvfNyjfCWGyAXuPdxwFrpLmoezLJ4pm-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v7 PATCH 4/5] msf2: Add Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 30 August 2017 at 03:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> I think they might be issues if you start QEMU without -serial and then u=
se
> a firmware polling for an uart, the device won't be mapped and the memory
> accesses are mostly ignored.
>
> I'd rather use:
>
>     for (i =3D 0; i < MSF2_NUM_UARTS && i < MAX_SERIAL_PORTS; i++) {
>         static const char *serial[] =3D {"serial0", "serial1"};
>
>         if (!serial_hds[i]) {
>             serial_hds[i] =3D qemu_chr_new(serial[i], "null");
>
>         }
>
>> +            serial_mm_init(get_system_memory(), uart_addr[i], 2,
>> +                           qdev_get_gpio_in(armv7m, uart_irq[i]),
>> +                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN)=
;
>> +        }
>> +    }

It would be better to fix serial_mm_init() to handle having
a NULL chardev pointer, because we already have a lot of
SoC code that just passes it serial_hds[] regardless.

I'd leave this code as it is and we can fix serial_mm_init
separately (somebody pointed out this issue for a xilinx
board recently).

thanks
-- PMM
