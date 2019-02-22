Received: from eggs.gnu.org ([209.51.188.92]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxBAE-0005pc-Nj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxAvv-00040N-Gu
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:32:13 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gxAvu-00032f-Kz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:32:07 -0500
Received: by mail-io1-xd36.google.com with SMTP id e186so1743348ioa.0
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:31:07 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <877edsqnfx.fsf@dusky.pond.sub.org>
Date: Fri, 22 Feb 2019 08:31:04 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD81AFC0-DEE7-4DC8-AFB4-41CD868C823E@oberlin.edu>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
	<87y36boe78.fsf@dusky.pond.sub.org>
	<fdec6838-6051-427d-6192-f68a76171915@redhat.com>
	<FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
	<877edsqnfx.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org



> On Feb 22, 2019, at 02:42, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Awesome.  The magic setup code in hw/i386/pc_sysfw.c will happily =
create
> any size that's a multiple of 4KiB.  The current sizes are 128KiB
> writable (power of two, good) and 2MiB - 128KiB for read-only (very =
much
> not a power of two, possibly bad).

As far as I can tell, the code I'm touching does not even compile by =
default for the i386 which only supports flash chips with the Intel =
command set hw/block/pflash_cfi01.c and not the flash chips with the AMD =
command set hw/block/pflash_cfi02.c.

> Can you tell us a bit more about what exactly can go wrong?

I don't know anything at all about the pflash_cfi01.c code. So if it's =
working now, then it's probably fine.

If you had been using pflash_cfi02.c, the problem would be that it has =
support for mapping the chip at multiple, consecutive locations (I'm not =
sure why that's part of the device itself and not something setup by =
code that's using the device). So device accesses mask offsets in the =
read and write functions by pfl->chip_len - 1 (here =
<https://github.com/qemu/qemu/blob/master/hw/block/pflash_cfi02.c#L154> =
and here =
<https://github.com/qemu/qemu/blob/master/hw/block/pflash_cfi02.c#L279>). =
If the chip size isn't a power of two, this breaks.

--=20
Stephen Checkoway
