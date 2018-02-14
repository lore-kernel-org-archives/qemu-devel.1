Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1elqS7-0001i0-Oj
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1elqS6-0007jk-GU
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:21:59 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1elqS6-0007i9-By
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 01:21:58 -0500
Received: by mail-it0-x242.google.com with SMTP id k6so13741671ita.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 22:21:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002401d3a010$8d551280$a7ff3780$@ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Wed, 14 Feb 2018 06:21:36 +0000
Message-ID: <CAFXrp_eOdwSz7U+VepkNHwPakLt3TZYBYw66dk_CpqpdaT6bOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

The patch 23bdb6f7ce73c33f96449e43b4cae01e55f79ae1 appears to be
segfaulting `qemu-img` at `replay_mutex_lock`.

The problem does not happen on the patch base
bc2943d6caf787e1c9a5f3109cdb98f37630b89e

The command is:

    buildroot/output.x86_64~/images
    ../host/bin/qemu-img convert -f raw -O qcow2 rootfs.ext2 rootfs.ext2.qcow2
    Aborted (core dumped)

and the backtrace:

    >>> bt
    #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
    #1  0x00007ffff5ce6f5d in __GI_abort () at abort.c:90
    #2  0x000055555565ae79 in replay_mutex_unlock () at stubs/replay.c:79
    #3  0x00005555556393a3 in os_host_main_loop_wait
(timeout=<optimized out>) at util/main-loop.c:256
    #4  main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:522
    #5  0x0000555555576890 in convert_do_copy (s=0x7fffffffca10) at
qemu-img.c:1900
    #6  img_convert (argc=<optimized out>, argv=<optimized out>) at
qemu-img.c:2332
    #7  0x0000555555571dda in main (argc=7, argv=<optimized out>) at
qemu-img.c:4763
    >>>

    77 void replay_mutex_lock(void)
    78 {
    79     abort();
    80 }

The configure command is:

    GCC="/usr/bin/gcc" CXX="/usr/bin/g++" CPP="/usr/bin/cpp"
OBJCOPY="/usr/bin/objcopy" RANLIB="/usr/bin/ranlib"
CPPFLAGS="-I/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/include"
CFLAGS="-O2 -I/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/include"
CXXFLAGS="-O2 -I/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/include"
LDFLAGS="-L/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/lib
-Wl,-rpath,/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/lib"
INTLTOOL_PERL=/usr/bin/perl CPP="/usr/bin/gcc -E" ./configure
--target-list="x86_64-softmmu"
--prefix="/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host"
--interp-prefix=/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/x86_64-buildroot-linux-uclibc/sysroot
--cc="/usr/bin/gcc" --host-cc="/usr/bin/gcc"
--python=/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/bin/python2
--extra-cflags="-O2
-I/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/include"
--extra-ldflags="-L/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/lib
-Wl,-rpath,/home/ciro/bak/git/linux-kernel-module-cheat/buildroot/output.x86_64~/host/lib"
--enable-debug --extra-cflags='-DDEBUG_PL061=1'
--enable-trace-backends=simple --enable-sdl --with-sdlabi=2.0

and everything is fully automated at:
https://github.com/cirosantilli/linux-kernel-module-cheat/tree/5ae702c71c2b2ad326b7791ff128cac0d8b298a2
by running:

    ./build -q


On Wed, Feb 7, 2018 at 12:38 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> Can you provide a test branch somewhere so I can easily test it out?
>
> Here it is: https://github.com/ispras/qemu/tree/rr-180207
>
> Pavel Dovgalyuk
>
