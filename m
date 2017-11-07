Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC5un-00015c-4q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC5uh-0008WI-HF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:35:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:60600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC5uh-0008VH-BU
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:35:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC5ug-00080p-Ei
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 15:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6C6D92E8058
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 15:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 15:18:27 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1614348 <1614348@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160818033638.22562.88196.malonedeb@soybean.canonical.com>
Message-Id: <151006790764.20130.13067138357150511535.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1614348] Re: qemu-arm core dumped for no entry
 symbol programe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Why do you think this is a bug in QEMU? This program crashes on exit if
you run it on real arm hardware. This is unsurprising as you have told
the compiler to build it with no C runtime. The program thus starts at
the beginning of 'main', and when it hits the return at the end there is
nowhere for it to return to and it crashes. If you link the program with
the C runtime the way you are expected to, then the runtime gets control
at the start of execution and provides a place for main() to return to.
If you choose not to link against the C runtime then it is your
responsibility to provide an alternate runtime (including defining an
entry point) which implements the semantics that the main() function
expects.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1614348

Title:
  qemu-arm core dumped for no entry symbol programe

Status in QEMU:
  Invalid

Bug description:
  Hi qemu developers,

  Environment:
  * Fedora 24 x86_64
  * qemu-arm version 2.6.92, Copyright (c) 2003-2008 Fabrice Bellard
  * arm-linux-gnu-gcc 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) target: =
arm-linux-gnueabi
  * glibc-arm-linux-gnu-devel-2.23

  very simple hello.c:

  #include <stdio.h>

  int main(int argc, char *argv[]) =

  {
      printf("Hello World\n");

      return 0;
  }

  arm-linux-gnu-gcc hello.c -I/usr/arm-linux-gnu/include -L/usr/arm-
  linux-gnu/lib -nostdlib -lc

  /usr/bin/arm-linux-gnu-ld: Warning: Cannot find entry symbol _start;
  defaulting to 00000000000101fc

  qemu-arm -L /usr/arm-linux-gnu ./a.out

  Hello World
  qemu: uncaught target signal 4 (Illegal instruction) - core dumped
  Illegal instruction

  But provided entry symbol:

  arm-linux-gnu-gcc hello.c -I/usr/arm-linux-gnu/include -L/usr/arm-
  linux-gnu/lib -nostdlib /usr/arm-linux-gnu/lib/crt1.o /usr/arm-linux-
  gnu/lib/crti.o /usr/arm-linux-gnu/lib/crtn.o -lc

  qemu-arm -L /usr/arm-linux-gnu ./a.out is able to work happily!

  Regards,
  Leslie Zhai

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1614348/+subscriptions
