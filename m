Received: from eggs.gnu.org ([2001:4830:134:3::10]:33095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cR6As-0006BU-Se
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 18:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cR6Ao-0001Mt-6R
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 18:49:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:39445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cR6An-0001Ls-W3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 18:49:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cR6Am-00065P-9f
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 23:49:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C35B2E80C9
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 23:49:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 23:30:34 -0000
From: Paul Goyette <696834@bugs.launchpad.net>
Reply-To: Bug 696834 <696834@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110103151427.20128.15402.malonedeb@soybean.canonical.com>
	<20170110091459.21384.46239.malone@gac.canonical.com>
Message-Id: <Pine.NEB.4.64.1701110729300.5977@speedy.whooppee.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 696834] Re: FP exception reporting not
 working on NetBSD host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Tue, 10 Jan 2017, Thomas Huth wrote:

> QEMU 0.13 is completely outdated nowadays - can you still reproduce this
> problem with the latest version of QEMU (currently version 2.8) ?

The test program running on qemu 2.8.0 now produces the expected results =

- 1 FP exception

You can close this bug.


+------------------+--------------------------+------------------------+
| Paul Goyette     | PGP Key fingerprint:     | E-mail addresses:      |
| (Retired)        | FA29 0E3B 35AF E8AE 6651 | paul at whooppee.com   |
| Kernel Developer | 0786 F758 55DE 53BA 7731 | pgoyette at netbsd.org |
+------------------+--------------------------+------------------------+

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/696834

Title:
  FP exception reporting not working on NetBSD host

Status in QEMU:
  Incomplete

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
