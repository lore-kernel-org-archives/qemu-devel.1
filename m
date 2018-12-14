Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmve-0004qt-Fu
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXmvb-0000HV-4T
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:50:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:47794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXmva-0000H4-T1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:50:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXmvY-0005B9-TA
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:50:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB9B22E8082
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:50:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Dec 2018 12:36:47 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1737444 <1737444@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151294713207.10703.11276532235992679828.malonedeb@wampee.canonical.com>
Message-Id: <154479100726.23071.8418846487285300971.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737444] Re: gccgo setcontext conftest crashes
 qemu-sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This still reproduces on git master:

(sid-sh4-sbuild)root@nofan:/# gcc setcontext.c -o setcontext -lpthread
(sid-sh4-sbuild)root@nofan:/# ./setcontext =

Unhandled trap: 0x180
pc=3D0x7f68e99e sr=3D0x00000000 pr=3D0x00400750 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0x7f7a2de8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x7f68e960 fpul=3D0x00000000
r0=3D0x00e11158 r1=3D0x00000000 r2=3D0x00000001 r3=3D0x7ffff590
r4=3D0x00e11068 r5=3D0x7ffff5c4 r6=3D0x7ffff5cc r7=3D0x00000000
r8=3D0x004007f0 r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
r12=3D0x7f79ec64 r13=3D0x00000000 r14=3D0x7ffff538 r15=3D0x7ffff538
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
(sid-sh4-sbuild)root@nofan:/#

And it is fixed by reverting 61dedf2af7

(sid-sh4-sbuild)root@nofan:/# ./setcontext =

(sid-sh4-sbuild)root@nofan:/# echo $?
0
(sid-sh4-sbuild)root@nofan:/#

So it's presumably the same bug as
https://bugs.launchpad.net/qemu/+bug/1796520

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737444

Title:
  gccgo setcontext conftest crashes qemu-sh4

Status in QEMU:
  New

Bug description:
  While testing gccgo on sh4 to add SH platform definitions to libgo, I
  discovered that the following conftest program which is part of the
  libgo configure script crashes on qemu-sh4:

  (sid-sh4-sbuild)root@z6:/# cat setcontext.c
  #include <pthread.h>                                                     =
                                                                           =
                                                                           =
                                                =

  #include <stdlib.h>                                                      =
                                                                           =
                                                                           =
                                                =

  #include <ucontext.h>                                                    =
                                                                           =
                                                                           =
                                                =

  #include <unistd.h>                                                      =
                                                                           =
                                                                           =
                                                =


  __thread int tls;

  static char stack[10 * 1024 * 1024];
  static ucontext_t c;

  /* Called via makecontext/setcontext.  */

  static void
  cfn (void)
  {
    exit (tls);
  }

  /* Called via pthread_create.  */

  static void *
  tfn (void *dummy)
  {
    /* The thread should still see this value after calling
       setcontext.  */
    tls =3D 0;

    setcontext (&c);

    /* The call to setcontext should not return.  */
    abort ();
  }

  int
  main ()
  {
    pthread_t tid;

    /* The thread should not see this value.  */
    tls =3D 1;

    if (getcontext (&c) < 0)
      abort ();

    c.uc_stack.ss_sp =3D stack;
  #ifdef MAKECONTEXT_STACK_TOP                                             =
                                                                           =
                                                                           =
                                                =

    c.uc_stack.ss_sp +=3D sizeof stack;
  #endif                                                                   =
                                                                           =
                                                                           =
                                                =

    c.uc_stack.ss_flags =3D 0;
    c.uc_stack.ss_size =3D sizeof stack;
    c.uc_link =3D NULL;
    makecontext (&c, cfn, 0);

    if (pthread_create (&tid, NULL, tfn, NULL) !=3D 0)
      abort ();

    if (pthread_join (tid, NULL) !=3D 0)
      abort ();

    /* The thread should have called exit.  */
    abort ();
  }

  (sid-sh4-sbuild)root@z6:/# gcc -o setcontext -lpthread setcontext.c
  (sid-sh4-sbuild)root@z6:/# ./setcontext =

  Unhandled trap: 0x180
  pc=3D0x7f69235e sr=3D0x00000000 pr=3D0x00400710 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0x7f658478 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x7f692320 fpul=3D0x000000=
00
  r0=3D0x00e11158 r1=3D0x00000000 r2=3D0x00000001 r3=3D0x7ffff2e0
  r4=3D0x00e11068 r5=3D0x7ffff314 r6=3D0x7ffff31c r7=3D0x00000000
  r8=3D0x004007b0 r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0x7f79ac54 r13=3D0x00000000 r14=3D0x7ffff288 r15=3D0x7ffff288
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  (sid-sh4-sbuild)root@z6:/#

  The same code works fine on my Renesas SH7785LCR evaluation board:

  root@tirpitz:~> uname -a
  Linux tirpitz 3.16.7-ckt7 #8 PREEMPT Fri Oct 21 18:47:41 CEST 2016 sh4a G=
NU/Linux
  root@tirpitz:~> gcc -o setcontext setcontext.c  -lpthread
  root@tirpitz:~> ./setcontext =

  root@tirpitz:~> echo $?
  0
  root@tirpitz:~>

  Due to this bug, it is not possible to compile gcc-7 with the Go
  frontend enabled on qemu-sh4.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737444/+subscriptions
