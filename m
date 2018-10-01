Received: from eggs.gnu.org ([2001:4830:134:3::10]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g6yy9-0002M6-IP
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g6yy5-0006D5-8D
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:14:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35912)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g6yy4-0006A7-UH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:14:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 01 Oct 2018 17:14:34 +0300
From: dovgaluk <dovgaluk@ispras.ru>
In-Reply-To: <CANzW0mvSX5nWuinDU68W2yJzgoQSGAHPqpz0G36A6NKwRsz_4A@mail.gmail.com>
References: <CANzW0mvSX5nWuinDU68W2yJzgoQSGAHPqpz0G36A6NKwRsz_4A@mail.gmail.com>
Message-ID: <d45bff6c4e472811f01452b5f730c1b6@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru

Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-09-30 14:01:
> Feature still broken :(

Thanks for testing.

>=20
> Brief description of my tests.
>=20
> Guest image is Linux, which just powers off after kernel boots
> (instead of proceeding to user-space /init or /sbin/init).
> Base cmdline:
> qemu-system-x86_64 -nodefaults -machine pc,accel=3Dtcg -m 2048 -cpu
> qemu64 -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 -kernel bzImage -init=
rd
> rootfs -append 'nokaslr console=3DttyS0 rdinit=3D/init_poweroff'
> -nographic -serial SERIAL_VALUE -icount
> 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin

I've never tried it with sleep=3Doff. Can you remove it and try again?

We also seen a problem with '-nographic'. When we remove this option and=20
QEMU runs with SDL
window, everything is ok. There is some problem with main loop which may=20
sleep when there
is no GUI to update, or something like that. We couldn't fix it yet.

>=20
> Test 1. When SERIAL_VALUE=3Dnone
> Running with RR_VALUE=3Drecord completes successfully.
> Running with RR_VALUE=3Dreplay doesn't completes. qemu process just
> eating ~100% cpu and memory usage doesn't grow after some moment. I
> don't see what happens because of problem no.2 (see below).

Try 'info replay' monitor command. Does instruction counter increases?

>=20
> Test 2. When SERIAL_VALUE=3Dstdio
> Running with RR_VALUE=3Drecord completes successfully.
>=20
> Running with RR_VALUE=3Dreplay caues exit with error:
>=20
> "qemu-system-x86_64: Missing character write event in the replay log"
>=20
> These problems are same with qemu 2.12 (both vanilla and with previous
> versions of these patches applied). Furthemore, I consider whole
> icount mode broken and determinism isn't achievable.
> The irony is that I actually don't need record/replay feature. I've
> tried to use it only as instrument to debug failing determinism in
> qemu code. But since replay/record feature itself relies on
> determinism, which is broken, it's no wonder why it fails also (I just
> hoped to bypass it).
>=20
> Contact me if you need more details. I just tired a lot trying to get
> all these things working... Hope is leaving me...

Can you share the kernel in case the icount still broken?


Pavel Dovgalyuk
