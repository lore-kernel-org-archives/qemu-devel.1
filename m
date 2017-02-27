Received: from eggs.gnu.org ([2001:4830:134:3::10]:52591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciJsw-00039v-TW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciJss-0002KU-0H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:54:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciJsr-0002Jp-Qa
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:54:29 -0500
Message-ID: <1488196464.25015.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 12:54:24 +0100
In-Reply-To: <CAFEAcA9nZCfVyDUzbavnu0HYtfHp1WTK=euATBB9FHkvnC7hTQ@mail.gmail.com>
References: <20170227081456.7131-1-shah.suramya@gmail.com>
	<CAFEAcA9nZCfVyDUzbavnu0HYtfHp1WTK=euATBB9FHkvnC7hTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Removed support for depth!=32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Suramya Shah <shah.suramya@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> (Gerd: can you remind me of the reason why we can assume that
> depth is always 32 here? IIRC it's because the UI layer always
> uses 32 bit depth now but I couldn't convince myself of that
> with a quick look through the ui code...)

qemu-allocated display surfaces (backed by host memory) are always
32bpp.  Display emulation will get such surfaces in case it uses
qemu_create_displaysurface() or qemu_console_resize().  So the display
emulation only needs to be able to generate 32bpp output
(PIXMAN_x8r8g8b8 to be exact) from whatever the guest creates.

There is also the option to create display surfaces which are backed by
guest ram or vga device memory, using qemu_create_displaysurface_from(),
those can have a different format (any pixman supported format is
allowed here, because the ui code will use pixman to convert those
surfaces if needed).

sm501 uses qemu_console_resize (see line 1320), so yes, the code will
never see a display surface with a depth !=3D 32 and a whole bunch of code
can be dropped.  The need for the include template goes away too.

cheers,
  Gerd
