Received: from eggs.gnu.org ([2001:4830:134:3::10]:48346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBgKd-00053Y-Q3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBgKb-0003qF-Tu
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBgKb-0003pv-Ni
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBgKa-0004cY-S9
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 12:16:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D41852E8058
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 12:16:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 11:58:53 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1098729 <1098729@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130111214005.8995.51690.malonedeb@wampee.canonical.com>
Message-Id: <150996953327.5103.4419738112862755827.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1098729] Re: qemu-user-static for armhf: segfault
 in threaded code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We think we've fixed the multithreading issues in QEMU linux-user (in
particular the test case that started this bug report works). If there
are still problems with a QEMU version later than 2.10, please open
fresh bug reports for specific guest programs that fail, giving detailed
how-to-reproduce instructions.


** Tags added: arm linux-user

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1098729

Title:
  qemu-user-static for armhf: segfault in threaded code

Status in QEMU:
  Fix Released

Bug description:
  =

  Currently running QEMU from git (fedf2de31023) and running the armhf vers=
ion of qemu-user-static which I have renamed qemu-armhf-static to follow th=
e naming convention used in Debian.

  The host systems is a Debian testing x86_64-linux and I have an Debian
  testing armhf chroot which I invoke using schroot.

  Majority of program in the armhf chroot run fine, but I'm getting qemu
  segfaults in multi-threaded programs.

  As an example, I've grabbed the threads demo program here:

  https://computing.llnl.gov/tutorials/pthreads/samples/dotprod_mutex.c

  and changed NUMTHRDS from 4 to 10. I compile it as (same compile
  command on both x86_64 host and armhf guest):

      gcc -Wall -lpthread dotprod_mutex.c -o dotprod_mutex

  When compiled for x86_64 host it runs perfectly and even under
  Valgrind displays no errors whatsoever.

  However, when I compile the program in my armhs chroot and run it it
  usually (but not always) segaults or hangs or crashes. Example output:

  =

      (armhf) $ ./dotprod_mutex
      Thread 1 did 100000 to 200000:  mysum=3D100000.000000 global sum=3D10=
0000.000000
      Thread 0 did 0 to 100000:  mysum=3D100000.000000 global sum=3D200000.=
000000
      TCG temporary leak before f6731ca0
      qemu-arm-static: /home/erikd/Git/qemu-posix-timer-hacking/Upstream/tc=
g/tcg-op.h:2371:
      tcg_gen_goto_tb: Assertion `(tcg_ctx.goto_tb_issue_mask & (1 << idx))=
 =3D=3D 0' failed.

  =

      (armhf) $ ./dotprod_mutex
      qemu: uncaught target signal 11 (Segmentation fault) - core dumped
      Segmentation fault

      (armhf) $ ./dotprod_mutex
      qemu-arm-static: /home/erikd/Git/qemu-posix-timer-hacking/Upstream/tc=
g/tcg.c:519:
      tcg_temp_free_internal: Assertion `idx >=3D s->nb_globals && idx < s-=
>nb_temps' failed.

  =

      (armhf) $ ./dotprod_mutex
      Thread 1 did 100000 to 200000:  mysum=3D100000.000000 global sum=3D10=
0000.000000
      qemu: uncaught target signal 11 (Segmentation fault) - core dumped
      Segmentation fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1098729/+subscriptions
