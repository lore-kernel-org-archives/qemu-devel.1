Received: from eggs.gnu.org ([209.51.188.92]:54701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1e2k-00014a-Rh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1e2g-0007Fw-Ek
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:25:35 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1e2e-0006zf-Fu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:25:32 -0500
Received: by mail-pg1-x52c.google.com with SMTP id r124so9427451pgr.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 13:25:11 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 7 Mar 2019 00:21:35 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201903070021.35672.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

> What do you mean by DIMM size not detected?

Sorry, I mean "No DIMM in slot 1" message.

PMON2000 MIPS Initializing. Standby...
ERRORPC=3D00000000 CONFIG=3D00030932
 PRID=3D00006302
DIMM read
read memory type
read number of rows
read blocks per ddrram
read number of sides
read width
00000002
No DIMM in slot 1
DIMM SIZE=3D10000000
sdcfg=3D2d5043df
msize=3D10000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg =3D 00030932

Copy PMON to execute location...
  start =3D 0x81000000
  s0 =3D 0x3ec00000
a1050000
copy text section done.
Copy PMON to execute location done.
sp=3D80ffc000Uncompressing Bios........................OK,Booting Bios

[...]

with binary I got:

PMON2000 MIPS Initializing. Standby...
ERRORPC=3D00000000 CONFIG=3D00030932
 PRID=3D00006302
DIMM read
00000080
read memory type
read number of rows
read memory size per side
read blocks per ddrram
read number of sides
read width
DIMM SIZE=3D10000000
sdcfg=3D3d5043df
msize=3D10000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg =3D 00030932

Copy PMON to execute location...
  start =3D 0x85000000
  s0 =3D 0x3ac00000
a5040000
copy text section done.
Copy PMON to execute location done.
sp=3D84ffc000Uncompressing Bios........................OK,Booting Bios


As far as I understand those values come from=20
Targets/Bonito2edev/Bonito/start.S

#include "i2c.S"
        beqz msize,.nodimm
        nop
        b 2f
        nop
=2Enodimm:
        move    dbg,a0
        PRINTSTR ("\r\nNo DIMM in all slots,use default configure\r\n")
        li  msize,0x10000000
        li      sdCfg,0x055043df         /* zgj-8-7-14-13 */
2:
        PRINTSTR("DIMM SIZE=3D")
        move    a0,msize
        bal     hexserial
        nop
        PRINTSTR("\r\n")

        li      t0, 0xbff00008
        sd      sdCfg, 0(t0)

        #### gx 2006-03-17: mode ####
        #li     t1,0x20
        li      t1,0x28
        li      t0, 0xbff00000
        sw      t1,0(t0)
        nop
        li      t1,0x0
        li      t0, 0xbff00000
        sw      t1,0x30(t0)
        nop


and in turn i2c.S has this:

Targets/Bonito2edev/Bonito/i2c.S

#define i2cread newi2cread
        li      msize,0
        PRINTSTR("DIMM read\r\n")

        /* only one memory slot, slave address is 1010000b */
        li      sdCfg,0x04000000 /*bit 26=CD=BB=B7=A2=CA=BD=B6=C1=D0=B4=CA=
=B1=B5=C4=BF=E9=C4=DA=CB=B3=D0=F2*/
        li      a1, 0x0
    li      a0,0xa1
    bal     i2cread
        nop
        beq     v0,0xff,1f
        nop
        beq v0,0x80,1f
        nop
        move a0,v0
        bal hexserial
        nop
    PRINTSTR ("\r\nNo DIMM in slot 0 \r\n");
        b 2f
        nop
1:
        or      sdCfg, 0x1<<29
        nop
        li a0,0xa1
        bal ii2c_cfg
        nop
2:
        li      a1, 0x0
    li      a0,0xa3
    bal     i2cread
        nop
        li      a1,0x0
        beq     v0,0xff,1f
        nop
        beq v0,0x80,1f
        nop
        move a0,v0
        bal hexserial
        nop
    PRINTSTR ("\r\nNo DIMM in slot 1 \r\n");
        b 2f
        nop
1:
        li a0,0xa3
        bal ii2c_cfg
        nop

        b 2f
        nop

2:
        b 211f
        nop
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ah, it talks about SLOT _1_ ! So, slot _0_ apparently read correctly ....=20
but config info still not printed.... by pmon


Sorry, I misread output!
