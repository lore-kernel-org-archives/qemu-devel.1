Received: from eggs.gnu.org ([2001:4830:134:3::10]:57163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCned-0000rz-8G
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCnea-0001Me-KI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:45:47 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCnea-0001MI-Ea
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:45:44 -0400
Received: by mail-wm0-x22a.google.com with SMTP id e127so38852313wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:45:44 -0700 (PDT)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 22 May 2017 14:45:46 +0100
Message-ID: <87h90d3sz9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] sparc64 linux-user status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi,

While looking at some of the docker cross-build patches I thought I'd
checkout if I could still bootstrap some Debian linux-user images. I
made some tweaks to allow debootstrap to bootstrap from Debian's ports
to see if I could get the SPARC64 file-system up and running:

 https://github.com/stsquad/qemu/commits/docker/sparc64-linux-user

However when I try to run it:

  make docker-image-debian-sparc64-user V=1

It fails:

  Step 4 : RUN /debootstrap/debootstrap --second-stage
   ---> Running in 2241c809c19f
  *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
  Illegal instruction (core dumped)
  *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
  Illegal instruction (core dumped)
  *** longjmp causes uninitialized stack frame ***: /bin/sh terminated
  Illegal instruction (core dumped)
  I: Keyring file not available at /usr/share/keyrings/debian-archive-keyring.gpg; switching to https mirror https://deb.debian.org/debian
  W: Failure trying to run:  dpkg-deb -f /var/cache/apt/archives/dpkg_1.18.24_sparc64.deb Version
  W: See //debootstrap/debootstrap.log for details
  I: Installing core packages...
  W: Failure trying to run:  dpkg --force-depends --install /var/cache/apt/archives/base-passwd_3.5.43_sparc64.deb
  W: See //debootstrap/debootstrap.log for details
  Illegal instruction (core dumped)
  The command '/bin/sh -c /debootstrap/debootstrap --second-stage' returned a non-zero code: 132

Although I can manually get the shell at least partially running:

  14:43 last:125, alex@zen taken:25, git:docker/sparc64-linux-user, [/home/alex/lsrc/qemu/qemu.git]> docker run --rm -it 1084ed198b00 /bin/sh
  # uname -a
  [1] + Stopped (tty output)       uname -a
  # uname -a | cat
  [2] + Stopped (tty output)       uname -a | cat
  # echo "hello"
  hello
  #

Bringing anything to the foreground hangs the window:

  # fg
  uname -a | cat
  Linux 8cbf3e5e2234 4.4.0-78-generic #99-Ubuntu SMP Thu Apr 27 15:29:09 UTC 2017 sun4u GNU/Linux
  /bin/sh: 4: fg: Cannot set tty process group (Inappropriate ioctl for device)
  *** longjmp causes uninitialized stack frame ***: /bin/sh terminated

Which makes me think it might be a linux-user bug rather than the main
translation. Is this a tested combination? Any idea what the bug could be?

--
Alex Bennée
