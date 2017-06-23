Received: from eggs.gnu.org ([2001:4830:134:3::10]:55913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1dOWZg-0003HC-Vo
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1dOWZf-00028j-OX
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:57:09 -0400
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viniciusfre@gmail.com>)
	id 1dOWZf-00028d-I0
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 17:57:07 -0400
Received: by mail-ua0-x234.google.com with SMTP id g40so44028140uaa.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 14:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6f0adf44-a0f0-2dd4-9f53-0c6280257ba6@amsat.org>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
	<20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
	<ecb7491d-6446-a9fa-49d1-f4aaade16470@amsat.org>
	<CAEz5UgGWxLNg+3Qg02H9Mpzkpy=MwP8YFYamZ8LdxK1gMuWq=g@mail.gmail.com>
	<CAEz5UgEQ1=RM2+v8ocUsZxA88jdk5Z+A0eo-G6=iD_CGoZQ2Sw@mail.gmail.com>
	<20170623192243.eb5bnfy2qqy3dqa4@aurel32.net>
	<6f0adf44-a0f0-2dd4-9f53-0c6280257ba6@amsat.org>
From: Vinicius Maciel <viniciusfre@gmail.com>
Date: Fri, 23 Jun 2017 18:57:06 -0300
Message-ID: <CAEz5UgEtFuAJ4xg6-ATOgJdwTRfd0-r0chceT6-QTN=sOSGg=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

2017-06-23 17:21 GMT-03:00 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> Hi Vinicius,
>
> Looking at the RT5350 datasheet:
> http://www.mouser.com/ds/2/813/RT5350-1022839.pdf
>
> pp.19>
> 3.2 Memory Map Summary
> 1000.0000 - 1000.00FF 256 Mbps    SYSCTL
> 1011.0000 - 1011.7FFF  32 Kbps    Ethernet switch
>
> pp.22>
> 3.4 System Control
> 3.4.3 Register Description (base: 0x1000_0000)
> GPIOMODE: GPIO Purpose Select (offset: 0x0060)
>
> pp.122>
> 3.19 Ethernet Switch
> 3.19.4 Register Description (base: 0x1011_0000)
> LEDC: LED Control Register  (offset: 0x0168)
> LED Polarity Control for each port: 1=E2=80=99b1: High active
>
> having 23=3D0b10111 my guess is your reset() function try to toggle on 4
> leds. everything seems fine on QEMU side, now it depends how you
> implemented the SYSCTL and EthernetSwitch devices.
>
> eventually you are missing some EthernetSwitch mapped registers and an
> exception is generated, ending reading some SYSCTL register...
>
> running qemu-system with '-d in_asm,int,unimp' helps to understand if the=
m
> problem comes from your model, before from QEMU core code.
>
> regards,
>
> Phil.
>

Hi,

In the machine code, I added Ethernet Switch at 0x10110000:
ralink_router.c#L282
<https://gitlab.com/vinifr/qemu-routers/blob/ralink/hw/mips/ralink_router.c=
#L282>.
And here is Ethernet code: ralink_net.c
<https://gitlab.com/vinifr/qemu-routers/blob/ralink/hw/net/ralink_net.c>.
I'm trying to run u-boot bootloader: u-boot_RT5350F-OLinuXino
<https://github.com/OLIMEX/u-boot_RT5350F-OLinuXino>. The problem happens
when executing this line: start.S#L1540
<https://github.com/OLIMEX/u-boot_RT5350F-OLinuXino/blob/master/cpu/ralink_=
soc/start.S#L1540>
.

I have found Qemu reaches the function memory_region_dispatch_write:

memory_region_dispatch_write (mr=3D0x555556219880 <io_mem_unassigned>,
addr=3D269549928, data=3D23,
    size=3D4, attrs=3D...) at
/home/vini/projs/emuladores/qemu-routers/memory.c:1306
1306    if (!memory_region_access_valid(mr, addr, size, true)) {
(gdb) n
1307        unassigned_mem_write(mr, addr, data, size);
                return MEMTX_DECODE_ERROR;
    }

So, it happened a decode error even with Ethernet Switch registered at
0x10110000.

Thanks for help!
Vini
