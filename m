Received: from eggs.gnu.org ([2001:4830:134:3::10]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dDnR0-0000uE-Ta
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dDnQx-0002D2-O9
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:43:50 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44196
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dDnQx-0002C5-Gx
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:43:47 -0400
References: <87h90d3sz9.fsf@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5e31d55c-7c6f-9343-a84c-0190cac4b0a5@ilande.co.uk>
Date: Thu, 25 May 2017 08:43:35 +0100
MIME-Version: 1.0
In-Reply-To: <87h90d3sz9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] sparc64 linux-user status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 22/05/17 14:45, Alex Bennée wrote:

> Hi,
> 
> While looking at some of the docker cross-build patches I thought I'd
> checkout if I could still bootstrap some Debian linux-user images. I
> made some tweaks to allow debootstrap to bootstrap from Debian's ports
> to see if I could get the SPARC64 file-system up and running:
> 
>  https://github.com/stsquad/qemu/commits/docker/sparc64-linux-user
> 
> However when I try to run it:
> 
>   make docker-image-debian-sparc64-user V=1
> 
> It fails:
> 
>   Step 4 : RUN /debootstrap/debootstrap --second-stage
>    ---> Running in 2241c809c19f
>   *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
>   Illegal instruction (core dumped)
>   *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
>   Illegal instruction (core dumped)
>   *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
>   Illegal instruction (core dumped)
>   I: Keyring file not available at /usr/share/keyrings/debian-archive-keyring.gpg; switching to https mirror https://deb.debian.org/debian
>   W: Failure trying to run:  dpkg-deb -f /var/cache/apt/archives/dpkg_1.18.24_sparc64.deb Version
>   W: See //debootstrap/debootstrap.log for details
>   I: Installing core packages...
>   W: Failure trying to run:  dpkg --force-depends --install /var/cache/apt/archives/base-passwd_3.5.43_sparc64.deb
>   W: See //debootstrap/debootstrap.log for details
>   Illegal instruction (core dumped)
>   The command '/bin/sh -c /debootstrap/debootstrap --second-stage' returned a non-zero code: 132
> 
> Although I can manually get the shell at least partially running:
> 
>   14:43 last:125, alex@zen taken:25, git:docker/sparc64-linux-user, [/home/alex/lsrc/qemu/qemu.git]> docker run --rm -it 1084ed198b00 /bin/sh
>   # uname -a
>   [1] + Stopped (tty output)       uname -a
>   # uname -a | cat
>   [2] + Stopped (tty output)       uname -a | cat
>   # echo "hello"
>   hello
>   #
> 
> Bringing anything to the foreground hangs the window:
> 
>   # fg
>   uname -a | cat
>   Linux 8cbf3e5e2234 4.4.0-78-generic #99-Ubuntu SMP Thu Apr 27 15:29:09 UTC 2017 sun4u GNU/Linux
>   /bin/sh: 4: fg: Cannot set tty process group (Inappropriate ioctl for device)
>   *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
> 
> Which makes me think it might be a linux-user bug rather than the main
> translation. Is this a tested combination? Any idea what the bug could be?

Hmmm interesting. I tend to spend my time working on the system
emulation rather than linux-user section so to be honest it's not
something I test on a regular basis.

If you peek at the debian-sparc archives over the past year you'll see
there have been various SPARC64 linker bugs that have been fixed that
were causing corrupt binaries to be produced.

I see above that you're using a 4.4.0-78 kernel whereas John Paul's
latest ISO images are running 4.9.0-2 (and he's fairly good at getting
patches into ports) so without looking in detail my first thoughts are
that you could be trying to run older binaries affected by one or more
linker bugs? From memory the latest binaries are being published to sid
under debian-ports, but please do double-check against the debian-sparc
archives...


ATB,

Mark.
