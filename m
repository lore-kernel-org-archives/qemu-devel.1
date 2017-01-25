Received: from eggs.gnu.org ([2001:4830:134:3::10]:56083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cWS67-0008EZ-It
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cWS66-0000a8-8n
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:15:07 -0500
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:33669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cWS66-0000Zk-50
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:15:06 -0500
Received: by mail-io0-x231.google.com with SMTP id v96so20239874ioi.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:15:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170125161606.17471.13847.malone@chaenomeles.canonical.com>
References: <20160912101319.11954.40146.malonedeb@gac.canonical.com>
	<20170125161606.17471.13847.malone@chaenomeles.canonical.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 25 Jan 2017 19:14:45 +0100
Message-ID: <CACXAS8CBv+ciGYYjLXm0U8jThf0YDri-wj=aW=x=SJ82TFH-8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1622547] Re: qemu-system-sparc fatal error
 Trap 0x29 on Solaris 2.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Bug 1622547 <1622547@bugs.launchpad.net>

Richard, can you please look at it?

The test case:

qemu-system-sparc -bios ./ss20_v2.25_rom -M SS-20 -nographic -m 512
-cpu "TI SuperSparc 60"

Kind regards,
Artyom

On Wed, Jan 25, 2017 at 5:16 PM, mike@papersolve.com
<mike@papersolve.com> wrote:
> That was fun! And we have a result:
>
> fbb4bbb62e5603c991b880e25dc4bb30d342b944 is the first bad commit
> commit fbb4bbb62e5603c991b880e25dc4bb30d342b944
> Author: Richard Henderson <rth@twiddle.net>
> Date:   Tue Jul 12 15:38:13 2016 -0700
>
>     target-sparc: Implement ldstub_asi inline
>
>     Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>     Signed-off-by: Richard Henderson <rth@twiddle.net>
>
> :040000 040000 670db498d49d38bc878efccd55e39d03f074cadf
> 5052ce1f32ddf00646aaa9e37bb73e38b4e750f1 M      target-sparc
>
>
> I verified that the last good commit not only boots the BIOS but also boo=
ts the OS properly (and faster than 2.7.1).
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1622547
>
> Title:
>   qemu-system-sparc fatal error Trap 0x29 on Solaris 2.6
>
> Status in QEMU:
>   New
>
> Bug description:
>   When trying to install Solaris 2.6 from original CDROM, qemu fail with
>   the following error :
>
>   qemu: fatal: Trap 0x29 while interrupts disabled, Error state
>   pc: f0041280  npc: f0041284
>   %g0-7: 00000000 f0281800 08000000 ffffffff 00000000 f0243b88 00000001 f=
0244020
>   %o0-7: 40400ce2 40400ce2 00000000 404000e2 f0243b88 00000000 f023ffd8 f=
0057914
>   %l0-7: 40000cc2 f009645c f0096460 00000002 00000209 00000004 00000007 f=
023ff90
>   %i0-7: 00000042 404000e3 00000000 404000e3 e0000000 f028192a f0240038 f=
0096448
>   %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
>   psr: 40400cc2 (icc: -Z-- SPE: SP-) wim: 00000002
>   fsr: 00000000 y: 00000000
>
>   The command line was :
>
>   qemu-system-sparc -nographic -bios ./openbios-sparc32 -M SS-20 -hda
>   ./36G.disk -m 512 -cdrom Solaris_2.6_Software_05_98.img -boot d
>   -serial telnet:0.0.0.0:3000,server -smp 2,cores=3D2 -monitor null
>
>   It fails with a similar output when using bios ss20_v2.25_rom.
>
>   =E2=96=B6 qemu-system-sparc --version
>   QEMU emulator version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard an=
d the QEMU Project developers
>
>   =E2=96=B6 uname -a
>   Linux xxx 4.7.1-1-ARCH #1 SMP PREEMPT Wed Aug 17 08:13:35 CEST 2016 x86=
_64 GNU/Linux
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1622547/+subscriptions
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
