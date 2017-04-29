Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4d1d-0001HN-V8
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 20:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4d1a-0006YM-Ti
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 20:47:46 -0400
Received: from mail-db5eur01on0136.outbound.protection.outlook.com
	([104.47.2.136]:9680
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d4d1a-0006YC-Jj
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 20:47:42 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 29 Apr 2017 23:15:08 +0000
Message-ID: <VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>Ah, you are using curses... I've been putting logs onto stderr for simplic=
ity, not the proper qemu logs. Here is a fixed patch to get output in the l=
og.

OK, I have an interesting development that I hope will shed some light on t=
he problem.
This configuration works using a different image (nslookup succeeds and I c=
an see your debug output):

[mfonnemann@desktopPC qemu]$ /usr/local/bin/qemu-system-i386 -display curse=
s -readconfig works.cfg --enable-kvm
                   [mfonnemann@localhost ~]$ nslookup www.google.com
                   UDP packet for DNS server
                                            translating 302000a against fff=
fff 302000a
                                                                           =
           it's an alias
                                                                           =
                        it's DNS
                                                                           =
                                dns_addr is cached: 1020204
               got Server:conf entr10.0.2.3.1'
                   Address:        10.0.2.3#53

                   Non-authoritative answer:
                   Name:   www.google.com
                   Address: 172.217.10.68
 [mfonnemann@desktopPC qemu]$ cat works.cfg
[drive]
  format =3D "raw"
  file =3D "fc5.img"

[drive]
  format =3D "vhdx"
  file =3D "placeholder2.vhdx"

[drive]
  format =3D "raw"
  file =3D "swap_512m.img"

[drive]
  format =3D "vhdx"
  file =3D "placeholder.vhdx"

[machine]
  usb =3D "on"

[memory]
  size =3D "2G"

[smp-opts]
  cpus =3D "2"

But my original one still does not:

[mfonnemann@desktopPC qemu]$ /usr/local/bin/qemu-system-i386 -display curse=
s -readconfig NG.cfg --enable-kvm
root@qemu:~# nslookup www.google.com
                   *** Unknown host

                   nslookup: www.google.com: Unknown host
                   root@qemu:~#=20
[mfonnemann@desktopPC qemu]$ cat NG.cfg
[drive]
  format =3D "raw"
  file =3D "qemu_rootfs_512.img"

[drive]
  format =3D "raw"
  file =3D "placeholder2.vhdx"

[drive]
  format =3D "raw"
  file =3D "swap_512m.img"

[drive]
  format =3D "vhdx"
  file =3D "placeholder.vhdx"

[machine]
  usb =3D "on"
  initrd =3D "initrd-2.6.11.12.img.gz"
  kernel =3D "vmlinuz-2.6.11.12-vanilla.bz"
  append =3D "root=3D/dev/hda"

[memory]
  size =3D "2G"

[smp-opts]
  cpus =3D "2"

Both are using static IP addresses.

Mark.
