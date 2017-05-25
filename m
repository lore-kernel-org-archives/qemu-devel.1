Received: from eggs.gnu.org ([2001:4830:134:3::10]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dDndb-0006DU-BP
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dDndY-0007KP-8R
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:56:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dDndX-0007G7-UR
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:56:48 -0400
References: <87h90d3sz9.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <54ce558d-3571-fb30-db3f-59b58ec979fc@vivier.eu>
Date: Thu, 25 May 2017 09:56:25 +0200
MIME-Version: 1.0
In-Reply-To: <87h90d3sz9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 22/05/2017 à 15:45, Alex Bennée a écrit :
> Hi,
> 
> While looking at some of the docker cross-build patches I thought I'd
> checkout if I could still bootstrap some Debian linux-user images. I
> made some tweaks to allow debootstrap to bootstrap from Debian's ports
> to see if I could get the SPARC64 file-system up and running:
> 
>  https://github.com/stsquad/qemu/commits/docker/sparc64-linux-user

I was waiting that for a while, thanks!
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

Do you know if the default CPU for linux-user is the good one for
debian-sparc64?

I used to run linux-user in a container, and I have this kind of problem
too. The last time I have checked I think it was because a floating
point instruction emulation failure. I don't know how works sparc64, but
 on some architectures, FPU instructions are emulated by the kernel, so
it could explain why it works in softmmu mode and not in linux-user
mode: qemu doesn't emulate it because it relies on the kernel for that,
and in this case the kernel can't.

Laurent
