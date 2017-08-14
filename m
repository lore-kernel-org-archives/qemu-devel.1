Received: from eggs.gnu.org ([2001:4830:134:3::10]:36134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dhKGl-00079C-JG
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dhKGi-00072D-GA
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dhKGi-00071r-7e
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:39:16 -0400
Date: Mon, 14 Aug 2017 19:39:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170814183910.GA2469@work-vm>
References: <8b120ab5-5319-30d6-6971-411c7e5c4330@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8b120ab5-5319-30d6-6971-411c7e5c4330@univention.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFH: difference in read-only mapped bios.bin -
 memory corruption?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>

* Philipp Hahn (hahn@univention.de) wrote:
> Hello,
>=20
> I'm currently investigating a problem, were a Linux VM does not reboot
> and gets stuck in the SeaBIOS reboot code:
>=20
> I'm using SeaBIOS-1.7 from Debian with a more modern qemu-2.8
>=20
> > virsh # qemu-monitor-command --hmp ucs41-414 info roms
> > fw=3Dgenroms/kvmvapic.bin size=3D0x002400 name=3D"kvmvapic.bin"
> > addr=3D00000000fffe0000 size=3D0x020000 mem=3Drom name=3D"bios.bin"
>=20
> which (to my understanding) is mapped at two physical locations:
> > virsh # qemu-monitor-command --hmp ucs41-414 info mtree
> ...> memory-region: system
> ...>       00000000000e0000-00000000000fffff (prio 1, R-): alias
> isa-bios @pc.bios 0000000000000000-000000000001ffff
> >       00000000fffe0000-00000000ffffffff (prio 0, R-): pc.bios
>=20
> If I dump both regions and compare them, I get a difference:
> > virsh # qemu-monitor-command --pretty --domain ucs41-414 '{"execute":=
"pmemsave","arguments":{"val":917504,"size":131072,"filename":"/tmp/bios-=
low.dump"}}'
> > virsh # qemu-monitor-command --pretty --domain ucs41-414 '{"execute":=
"pmemsave","arguments":{"val":4294836224,"size":131072,"filename":"/tmp/b=
ios-high.dump"}}'
> > # diff --suppress-common-lines -y <(od -Ax -tx1 -w1 -v /tmp/bios-low.=
dump) <(od -Ax -tx1 -w1 -v /tmp/bios-high.dump)
> > 00f798 fa                                                     | 00f79=
8 80
> > 00f799 7a                                                     | 00f79=
9 89
> > 00f79a f4                                                     | 00f79=
a f2
> > 016d40 00                                                     | 016d4=
0 ff
> > 016d41 00                                                     | 016d4=
1 ff
> > 016d42 00                                                     | 016d4=
2 ff
> > 016d43 00                                                     | 016d4=
3 ff
>=20
> The high address dump is the same as the original:

You might want seabios commit c68aff5 and b837e6 that got fixed after
I tracked down some reboot hangs - although they were rare, not every
time.  c68aff5 did certainly cause a corruption, and the address of that
corruption was determined at link time and could overlay random useful
bits of code if you were unlucky.

> > # cmp -l /tmp/bios-high.dump /usr/share/seabios/bios.bin
>=20
> > virsh # qemu-monitor-command --hmp ucs41-414 x/6i 0x00000000000ef78f
> > 0x00000000000ef78f:  mov    $0xcf8,%esi
> > 0x00000000000ef794:  mov    $0xfa000000,%eax
> > 0x00000000000ef799:  jp     0xef78f
>                        ^^^^^^^^^^^^^^ BUG: endless loop
> > 0x00000000000ef79b:  out    %eax,(%dx)
> > 0x00000000000ef79c:  mov    $0xfe,%dl
> > 0x00000000000ef79e:  in     (%dx),%ax
>=20
> > virsh # qemu-monitor-command --hmp ucs41-414 xp/6i 0x00000000fffef78f
> > 0x00000000fffef78f:  mov    $0xcf8,%esi
> > 0x00000000fffef794:  mov    $0x80000000,%eax
> > 0x00000000fffef799:  mov    %esi,%edx
>                        ^^^^^^^^^^^^^^^^ CORRECT original code
> > 0x00000000fffef79b:  out    %eax,(%dx)
> > 0x00000000fffef79c:  mov    $0xfe,%dl
> > 0x00000000fffef79e:  in     (%dx),%ax
>=20
> (That's some code from seabios-1.7.0/src/pci.c)
>=20
> I had exactly the same run some weeks ago, but I also get different
> patterns:
> > # diff --suppress-common-lines -y <(od -Ax -tx1 -w1 -v /tmp/bios2.dum=
p) <(od -Ax -tx1 -w1 -v bios.bin)
> > 00f798 f0                                                     | 00f79=
8 80
> > 00f799 8d                                                     | 00f79=
9 89
> > 00f79a f3                                                     | 00f79=
a f2
> > 016d40 00                                                     | 016d4=
0 ff
> > 016d41 00                                                     | 016d4=
1 ff
> > 016d42 00                                                     | 016d4=
2 ff
> > 016d43 00                                                     | 016d4=
3 ff
>=20
> Not all runs lead to reboot problems, but I don't know if any other
> corruption happened there.
>=20
> I had a similar problem with OVMF back in June
> <https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03940.html=
>,
> which I "solved" by upgrading the OVMF version: I have not seen the
> problem there since than, but this problems looks very similar.
>=20
>=20
> 1. How can it be, that the low-mem ROM mapping is modified?

I can't remember all the details, but PC ROM is shadowed and mapped over
with RAM at various times, and the bioses play lots of silly tricks of
being copied and then reusing bits of the copied space as temporaries
and..... oh it's just a mess.

Dave

> 2. Can I tell QEMU or gdb to trap any modification of that 128 KiB area=
?
>=20
> I'll try to get http://rr-project.org/ running, but any help is appreci=
ated.
>=20
> Philipp
> --=20
> Philipp Hahn
> Open Source Software Engineer
>=20
> Univention GmbH
> be open.
> Mary-Somerville-Str. 1
> D-28359 Bremen
> Tel.: +49 421 22232-0
> Fax : +49 421 22232-99
> hahn@univention.de
>=20
> http://www.univention.de/
> Gesch=E4ftsf=FChrer: Peter H. Ganten
> HRB 20755 Amtsgericht Bremen
> Steuer-Nr.: 71-597-02876
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
