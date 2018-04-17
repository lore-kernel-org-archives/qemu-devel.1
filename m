Received: from eggs.gnu.org ([2001:4830:134:3::10]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1f8Sla-0004VB-GV
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1f8SlX-0007dW-FS
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:43:34 -0400
Received: from mail-he1eur01on0122.outbound.protection.outlook.com
	([104.47.0.122]:52675
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1f8SlW-0007co-Kr
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:43:31 -0400
Date: Tue, 17 Apr 2018 18:43:25 +0300
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Message-ID: <20180417184325.7d3af718@vp-pc>
In-Reply-To: <CAJ+F1CLU5QyQ+d2Ji9Guz8wjB4m50pjRT7chyvW5bNBjqXyCTA@mail.gmail.com>
References: <1523973044-25754-1-git-send-email-viktor.prutyanov@virtuozzo.com>
	<CAJ+F1CLU5QyQ+d2Ji9Guz8wjB4m50pjRT7chyvW5bNBjqXyCTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Roman Kagan <rkagan@virtuozzo.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

On Tue, 17 Apr 2018 16:17:54 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

Hello,

> Hi
>=20
> On Tue, Apr 17, 2018 at 3:50 PM, Viktor Prutyanov
> <viktor.prutyanov@virtuozzo.com> wrote:
> > This patch adds Windows crashdumping feature. Now QEMU can produce
> > ELF-dump containing Windows crashdump header, which can help to
> > convert to a valid WinDbg-understandable crashdump file, or
> > immediately create such file. The crashdump will be obtained by
> > joining physical memory dump and 8K header exposed through
> > vmcoreinfo/fw_cfg device by guest driver at BSOD time. Option '-w'
> > was added to dump-guest-memory command. At the moment, only x64
> > configuration is supported. Suitable driver can be found at
> > https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwc=
fg64
> >
> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> > --- =20
>=20
> untested, but looks good to me.
>=20
> Could you provide more details on how to test? provide a test build
> for the driver, the tool you use for elf conversion, explain windbg
> usage etc?
>=20
> Thanks

How to test:

1. Use '-device vmcoreinfo', then install fwcfg64 driver from
   virtio-win repository into guest Windows. Versions from 7 to 10 are
   supported.
   Unofficial test-signed driver sample can be found at
   https://www.dropbox.com/s/nodjbehr9bb1x6i/fwcfg.zip?dl=3D0
2. Turn off "Automatically restart" or=20
   use '-device pvpanic -no-shutdown' and install pvpanic driver.
3. Cause BSOD, for example, with HMP 'nmi' command.
4. Execute HMP command 'dump-guest-memory -w memory.dmp'
5. Open memory.dmp with WinDbg (better from WDK 10) on a Windows
   machine. It can use dump file in a proper way, for example, to
   display general information about dump with '!analyze -v' command or
   investigate a call stack with 'k' command.

In this way, if guest Windows can't save dump in appropriate type, we
can still do this.

At the moment, there are no tools to produce fully valid Windows dump
file from ELF because they are unaware of header information. But in
future, tools like Volatility which try to do this, could use header
from ELF-note.

Regards,
Viktor Prutyanov
=20
=20
