Received: from eggs.gnu.org ([209.51.188.92]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqo-0005Jx-Ia
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCqk-00066K-S7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:57:12 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:10 -0500
Message-Id: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/18] Acceptance Tests: target architecture
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

The current acceptance tests don't provide any type of architecture
information that can be used to influence the selection of the QEMU
binary used on them[1].  If one is running tests on a x86_64 host, the
default QEMU binary will be "x86_64-softmmu/qemu-system-x86_64".

Given the nature of QEMU, some tests will be architecture agnostic,
while others will be architecture dependent.  The "check-qtest" and
"check-qtest-TARGET" make targets exemplify that pattern.

For the acceptance tests, the same requirement exists.  Tests should
be allowed to influence the binary used, and when they don't, a
default selection mechanism should kick in[2].  The proposed solution
here requires only that an Avocado tag is set, such as:

   class My(Test):
       def test_nx_cpu_flag(self):
           """
           :avocado: tags=3Darch:x86_64
           """
           test_code()

The value of the "arch" key, in this case, "x86_64" will be used when
selecting the QEMU binary to use in the test.  At the same time, if
"x86_64-softmmu" is not a built target, the test will be filtered out
by "make check-acceptance"[3].

Besides the convention explained above, where the binary will be
selected from the "arch" tag, it's also possible to set an "arch"
*parameter* that will also influence the QEMU binary selection:

  $ avocado run -p arch=3Daarch64 works-on-many-arches.py

Finally, it's also posible to set the "qemu_bin" parameter, which will
define (instead of just influencing) the QEMU binary to be used:

 $ avocado run -p qemu_bin=3Dqemu-bin-aarch64 test.py

As examples for the idea proposed here, a number of "boot linux
console" tests have been added, for a number of different target
architectures.  When the build environment includes them (as it has
been added to Travis CI jobs) the architecture specific tests will be
automatically executed.

As mentioned previously, this patch series include ideas present in
other patch series, and from different authors.  I tried by best
to include the information about authorship, but if I missed any,
please accept my apologies and let me know.

---

[1] - The "boot_linux_console.py" contains a "x86_64" test tag, but
      that is informational only, in the sense that it's not consumed
      by the test itself, or used by "make check-acceptance" to filter
      out tests.

[2] - This patch series doesn't attempt to change the default selection
      mechanism.  Possible changes in this area may include looking for
      any one built binary first, no matter the host architecture.

[3] - On a previous proposed version, the test class would look at the
      "arch" parameter given, and would cancel the test if there wasn't
      a match.

---

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/target_arch
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/target_arch

Cleber Rosa (17):
  scripts/qemu.py: log QEMU launch command line
  Acceptance tests: show avocado test execution by default
  Acceptance tests: improve docstring on pick_default_qemu_bin()
  Acceptance tests: fix doc reference to avocado_qemu directory
  Acceptance tests: introduce arch parameter and attribute
  Acceptance tests: use "arch:" tag to filter target specific tests
  Acceptance tests: look for target architecture in test tags first
  Boot Linux Console Test: rename the x86_64 after the arch and machine
  Boot Linux Console Test: update the x86_64 kernel
  Boot Linux Console Test: refactor the console watcher into utility
    method
  scripts/qemu.py: support adding a console with the default serial
    device
  Boot Linux Console Test: add a test for mips64el + malta
  Boot Linux Console Test: add a test for ppc64 + pseries
  Boot Linux Console Test: add a test for aarch64 + virt
  Boot Linux Console Test: add a test for arm + virt
  Boot Linux Console Test: add a test for s390x + s390-ccw-virtio
  Boot Linux Console Test: add a test for alpha + clipper

Philippe Mathieu-Daud=C3=A9 (1):
  Boot Linux Console Test: add a test for mips + malta

 .travis.yml                               |   4 +-
 docs/devel/testing.rst                    |  23 ++-
 scripts/qemu.py                           |  32 ++--
 tests/Makefile.include                    |   5 +-
 tests/acceptance/avocado_qemu/__init__.py |  22 ++-
 tests/acceptance/boot_linux_console.py    | 208 ++++++++++++++++++++--
 tests/requirements.txt                    |   2 +-
 7 files changed, 254 insertions(+), 42 deletions(-)

--=20
2.20.1
