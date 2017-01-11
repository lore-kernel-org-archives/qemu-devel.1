Received: from eggs.gnu.org ([2001:4830:134:3::10]:60862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCz3-0006c9-7W
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCz0-0000Ib-NJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:57329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCz0-0000IP-Hb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:06:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCyz-0006bq-Lb
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:06:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7976E2E80C8
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:06:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:50:28 -0000
From: Thomas Huth <696834@bugs.launchpad.net>
Reply-To: Bug 696834 <696834@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110103151427.20128.15402.malonedeb@soybean.canonical.com>
Message-Id: <20170111065028.14697.44164.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 696834] Re: FP exception reporting not working on
 NetBSD host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for verifying!

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/696834

Title:
  FP exception reporting not working on NetBSD host

Status in QEMU:
  Fix Released

Bug description:
  I recognize that NetBSD is not one of the officially supported host
  OS.  However, qemu 0.13.0 is available in the NetBSD pkgsrc
  collection, and works quite well.  Well, with one exception (pun
  intended): It seems that Floating Point exceptions don't get reported
  properly.

  The following code-snippet demonstrates the problem:

  =

  volatile int flt_signal =3D 0;

  static sigjmp_buf sigfpe_flt_env;
  static void
  sigfpe_flt_action(int signo, siginfo_t *info, void *ptr)
  {
          flt_signal++;
  }

  void trigger(void)
  {               =

          struct sigaction sa;
          double d =3D strtod("0", NULL);
          =

          if (sigsetjmp(sigfpe_flt_env, 0) =3D=3D 0) {
                  sa.sa_flags =3D SA_SIGINFO;
                  sa.sa_sigaction =3D sigfpe_flt_action;
                  sigemptyset(&sa.sa_mask);
                  sigaction(SIGFPE, &sa, NULL);
                  fpsetmask(FP_X_INV|FP_X_DZ|FP_X_OFL|FP_X_UFL|FP_X_IMP);
                  printf("%g\n", 1 / d);
          }
          printf("FPE signal handler invoked %d times.\n");
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/696834/+subscriptions
