Received: from eggs.gnu.org ([2001:4830:134:3::10]:46741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eltF1-0006AM-IY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eltEw-0001bW-KH
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:20:39 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38500)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eltEw-0001a5-BR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:20:34 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_eOdwSz7U+VepkNHwPakLt3TZYBYw66dk_CpqpdaT6bOA@mail.gmail.com>
In-Reply-To: <CAFXrp_eOdwSz7U+VepkNHwPakLt3TZYBYw66dk_CpqpdaT6bOA@mail.gmail.com>
Date: Wed, 14 Feb 2018 12:20:32 +0300
Message-ID: <000c01d3a575$10abaf40$32030dc0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Kevin Wolf' <kwolf@redhat.com>, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jason Wang' <jasowang@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, 'Gerd Hoffmann' <kraxel@redhat.com>, 'Thomas Dullien' <thomas.dullien@googlemail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> The patch 23bdb6f7ce73c33f96449e43b4cae01e55f79ae1 appears to be
> segfaulting `qemu-img` at `replay_mutex_lock`.

Thanks, fixed.

> 
> The problem does not happen on the patch base
> bc2943d6caf787e1c9a5f3109cdb98f37630b89e
> 
> The command is:
> 
>     buildroot/output.x86_64~/images
>     ../host/bin/qemu-img convert -f raw -O qcow2 rootfs.ext2 rootfs.ext2.qcow2
>     Aborted (core dumped)
> 
> and the backtrace:
> 
>     >>> bt
>     #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
>     #1  0x00007ffff5ce6f5d in __GI_abort () at abort.c:90
>     #2  0x000055555565ae79 in replay_mutex_unlock () at stubs/replay.c:79
>     #3  0x00005555556393a3 in os_host_main_loop_wait
> (timeout=<optimized out>) at util/main-loop.c:256
>     #4  main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:522
>     #5  0x0000555555576890 in convert_do_copy (s=0x7fffffffca10) at
> qemu-img.c:1900
>     #6  img_convert (argc=<optimized out>, argv=<optimized out>) at
> qemu-img.c:2332
>     #7  0x0000555555571dda in main (argc=7, argv=<optimized out>) at
> qemu-img.c:4763
>     >>>
> 
>     77 void replay_mutex_lock(void)
>     78 {
>     79     abort();
>     80 }

Pavel Dovgalyuk
