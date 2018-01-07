Received: from eggs.gnu.org ([2001:4830:134:3::10]:46704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYBx4-00066Z-2v
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYBx2-0001n1-U8
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:29:30 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:40003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYBx2-0001mZ-OC
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 09:29:28 -0500
Received: by mail-oi0-x22c.google.com with SMTP id w125so5877275oie.7
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 06:29:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <658f9066c2e35c4dab0343c3ce22a347@webmail.nanotek.info>
References: <658f9066c2e35c4dab0343c3ce22a347@webmail.nanotek.info>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Jan 2018 14:29:07 +0000
Message-ID: <CAFEAcA-r0OEtPHYH27CcB=S7h4SppLUD04C8FuQ1vJfRrAV=Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Building QEMU natively from ARM CPU statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: shiftag@nanotek.info
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 January 2018 at 06:55,  <shiftag@nanotek.info> wrote:
> Hi,
>
> I'm trying to build QEMU statically from ARM CPU (without cross-compiling). But at "configure" step I have the following issue :
>
> ERROR: User requested feature sdl
>  configure was not able to find it.
>  Install SDL devel
> However, from config.log, it seems that issue is not related to SDL.

> --------- long paste ---------
>
> I'm compiling version 2.11.0 so the SDL patch has already been applied. Also, some libraries errors are strange as I can find them on my system, see :
>
>  $ pkg-config --cflags --libs p11-kit-1 gnutls hogweed nettle dbus-1
>  -I/usr/include/p11-kit-1 -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -lp11-kit -lgnutls -lhogweed -lnettle -ldbus-1

You forgot --static on the pkg-config command line.
But in any case pkg-config is just reporting info from
a data file, which doesn't necessarily correspond to
what library .a and .so files are actually on the system.
(It's your distro's packaging and dependency info that's
responsible for making sure that all the dependent
library files are actually installed.)

> Also, I tried building a shared version (without --static) of qemu-2.11.0 and it works fine.

Problems with trying to build a statically linked
QEMU usually mean:

 * QEMU needs and links against static library X
 * static library X depends on static library Y
 * but either you don't have the static version of Y
   installed (a bug in your distro's library packaging
   or dependencies, possibly)
 * or the pkg-config information that your distro ships
   with library X does not correctly declare that it
   depends on Y and so Y doesn't go on the list of
   libraries QEMU links with

In this case all the "could not find -lfoo" errors
suggests that it's the "you don't have the static
library installed" case, and you should be able to fix
this by installing the right static libs from your distro.

In general, we provide --static for the benefit mostly
of the user-mode emulation binaries, which have a very
small list of library dependencies. Building the system
emulation binaries with --static is rather chancier.

The underlying reason for this kind of problem is that
very few people try to statically link anything, and so
bugs in distro packaging of statically linked libraries
very rarely get reported or fixed. Sometimes distros
don't provide static versions of some libraries at all.
As usual, if you wander away from the beaten path you
can run into thornbushes.

I notice that your configure arguments are rather
odd, which might be why you're running into trouble.

(1) you pass --cpu=arm -- this is almost never a good
idea. Let configure autodetect the host CPU for you.

(2) you pass --target-list=mips-linux-user, which suggest
you just want to build the mips user mode emulator, but
then you also pass a lot of arguments which are only
relevant for system emulation:
 --enable-system
 --enable-kvm
 --enable-gtk
 --enable-virtfs
 --enable-sdl
 --disable-vnc

Some of these are going to cause configure to try to
probe for things that mips-linux-user won't even use,
and then complain that it can't find them. If all you
want is mips-linux-user, drop all those other arguments.

thanks
-- PMM
