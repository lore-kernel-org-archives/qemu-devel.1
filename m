Received: from eggs.gnu.org ([209.51.188.92]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgj-0005ew-HY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwcgh-0000t9-Ps
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:09 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 20 Feb 2019 19:57:33 -0500
Message-Id: <20190221005753.27955-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/20] Acceptance Tests: target architecture
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
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, Cornelia Huck <cohuck@redhat.com>

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

Changes from v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * On "Acceptance tests: introduce arch parameter and attribute":
   - Made the documentation on the "arch" attribute and parameter
     clearer as to what the framework does with them, and what tests
     may use them for (Cornelia).

 * On "Acceptance tests: use "arch:" tag to filter target specific tests"=
:
   - Bumped avocado-framework to the latest release (68.0, instead of
     67.0 on v2).

 * On "Boot Linux Console Test: add a test for mips64el + malta":
   - Broke down kernel source/doc URLs lines on docstring to make
     patchew happy about number of columns in line

 * On "Boot Linux Console Test: add a test for aarch64 + virt"
   - Broke down "kernel_command_line" assignment line to make patchew
     happy about number of columns in line

 * On "Boot Linux Console Test: add a test for arm + virt"
   - Broke down "kernel_command_line" assignment line to make patchew
     happy about number of columns in line

Open issues during v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * The timeout change to 90s may not be necessary, or the best
   idea, given that a possible tcg+ppc64 performance regression
   has been identified.
   - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00338.html

 * A possible race condition has been identified in the aarch64
   target, when running on an environment with more than 1 CPUs
   (initially reported by Wainer).
   - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00192.html

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * On "Acceptance tests: introduce arch parameter and attribute":
   - Added explicit *host system architecture* to the "arch" parameter
     behavior documentation (Caio / Philippe)
   - Added explicit arch parameter name in call to pick_default_qemu_bin(=
)
     (Caio)
   - Fixed the documentation about the value of the "arch" attribute when
     a parameter is not given (Wainer).

 * On "Acceptance tests: use "arch:" tag to filter target specific tests"=
:
   - Updated "arch" tag on tests "linux_initrd.py" and
     "virtio_version.py" (Cornelia)
   - Fixed the documentation about the value of the "arch" attribute (Wai=
ner)

 * On "Acceptance tests: look for target architecture in test tags first"
   - Fixed the documentation given that starting with this patch, the
     "arch" attribute can also be depend on the "arch:" tag (based on
     previous patch point raised by Wainer).

 * New patch "Boot Linux Console Test: add common kernel command line
   options" (Philippe)

 * New patch "Boot Linux Console Test: increase timeout" (based on
   reports from Alex)

 * On "scripts/qemu.py: support adding a console with the default serial =
device":
   - Removed all non-essential console device type defintions from
     CONSOLE_DEV_TYPES.  At this point, setting the console will
     attempt to use "-serial" on all but the "s390-ccw-virtio*"
     machines (Philippe).
   - Updated documentation to make it clear that a specific device
     type will only be picked from CONSOLE_DEV_TYPES if the machine
     type is set, and a matching entry exists (Wainer).

 * On "Boot Linux Console Test: add a test for mips + malta":
   - Replaced "not easily reproducible kernel" for a kernel built and
     packaged by the Debian distro (Philippe, and previously Alex)
   - With the change to a kernel within a Debian package, and its use
     on another commit, added an utility function,
     "extract_from_deb()", to extract the kernel from the package
     (Philippe)
   - Switched to using common kernel command line options (Philippe)

 * On "Boot Linux Console Test: add a test for mips64el + malta":
   - Used the "extract_from_deb()" utility function introduced in the
     previous patch (Philippe)
   - Switched to using common kernel command line options (Philippe)
   - Fixed numbered references on the docstring (Wainer)
   - Fixed tag name on commit message (s/mips/mips64el/) (Wainer)

 * On "Boot Linux Console Test: add a test for ppc64 + pseries":
    - Switched to using common kernel command line options (Philippe)

 * On "Boot Linux Console Test: add a test for aarch64 + virt":
    - Switched to using common kernel command line options (Philippe)

 * On "Boot Linux Console Test: add a test for arm + virt"
     - Switched to using common kernel command line options (Philippe)

 * On "Boot Linux Console Test: add a test for s390x + s390-ccw-virtio":
     - Switched to using common kernel command line options (Philippe)

 * On "Boot Linux Console Test: add a test for alpha + clipper":
    - Switched to using common kernel command line options (Philippe)

---

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/target_arch_v3
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/target_arch_v3

Travis CI:
  - Build: https://travis-ci.org/clebergnu/qemu/builds/496229528
  - Relevant Job: https://travis-ci.org/clebergnu/qemu/jobs/496229549
  - Tests added here: https://travis-ci.org/clebergnu/qemu/jobs/496229549=
#L3085

Cleber Rosa (19):
  scripts/qemu.py: log QEMU launch command line
  Acceptance tests: show avocado test execution by default
  Acceptance tests: improve docstring on pick_default_qemu_bin()
  Acceptance tests: fix doc reference to avocado_qemu directory
  Acceptance tests: introduce arch parameter and attribute
  Acceptance tests: use "arch:" tag to filter target specific tests
  Acceptance tests: look for target architecture in test tags first
  Boot Linux Console Test: rename the x86_64 after the arch and machine
  Boot Linux Console Test: update the x86_64 kernel
  Boot Linux Console Test: add common kernel command line options
  Boot Linux Console Test: increase timeout
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
 docs/devel/testing.rst                    |  35 +++-
 scripts/qemu.py                           |  40 ++--
 tests/Makefile.include                    |   5 +-
 tests/acceptance/avocado_qemu/__init__.py |  23 ++-
 tests/acceptance/boot_linux_console.py    | 230 ++++++++++++++++++++--
 tests/acceptance/linux_initrd.py          |   2 +-
 tests/acceptance/virtio_version.py        |   2 +-
 tests/requirements.txt                    |   2 +-
 9 files changed, 294 insertions(+), 49 deletions(-)

--=20
2.20.1
