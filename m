Received: from eggs.gnu.org ([209.51.188.92]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpgwe-0007XB-J2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpgkw-000626-MG
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:53:51 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
Date: Fri, 1 Feb 2019 16:53:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] 2x-3x tcg performance regression on ppc64 (maybe
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

While working on the "boot_linux_console.py" tests, after a given
rebase, I noticed that the ppc64 specific test began timing out.  The
original timeout set to the test was 60 seconds, and it "always" had
room to spare when running either on my system, or on Travis CI.

Then, Alex mentioned that specific test timing out on his "slow"
system[1].  I did some further investigation and found out that commit
f7b78602f might have been responsible for a significant slowdown,
and maybe was also affecting his execution.

Getting straight to the point, this is the ppc64 "boot linux console"
test, running 10 times, on top my latest rebase (e8977901b, that
includes f7b78602f).

 ...
 (01/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(63.07 s)
 (02/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(64.00 s)
 (03/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(62.93 s)
 (04/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(64.01 s)
 (05/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(63.13 s)
 (06/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(64.65 s)
 (07/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(63.25 s)
 (08/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(66.77 s)
 (09/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(65.07 s)
 (10/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(63.55 s)
 ...

The exact branch I used for the results above can be seen at:
  - https://github.com/clebergnu/qemu/tree/regression_tcg_ppc64

Then, with f7b78602f reverted:

 (01/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.54 s)
 (02/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(21.06 s)
 (03/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.81 s)
 (04/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(21.00 s)
 (05/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.37 s)
 (06/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.40 s)
 (07/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.36 s)
 (08/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.39 s)
 (09/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.39 s)
 (10/10) boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries: PASS
(20.38 s)

The exact branch I used for the results above can be seen at:
  - https://github.com/clebergnu/qemu/tree/regression_tcg_ppc64_revert

Even though there's a lot more noise involved, similar results can be
seen on Travis-CI:

  - https://travis-ci.org/clebergnu/qemu/builds/487607293#L3035
     (04/16)
/home/travis/build/clebergnu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries:
 PASS (22.21 s)

  - https://travis-ci.org/clebergnu/qemu/builds/487606849#L3035
     (04/16)
/home/travis/build/clebergnu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ppc64_pseries:
 PASS (11.27 s)

The reasons for the extra noise include:
  1) Those tests download the kernel images
  2) They are run only once
  3) They run on shared infrastructure

Based on Travis-CI runs alone, it's hard to determine if there was any
other significant regression (or improvement?) for other targets.  I'm
posting this early, but if I come up with more relevant information,
follow up here.

Regards,
- Cleber.

---

[1] - https://www.mail-archive.com/qemu-devel@nongnu.org/msg589497.html
