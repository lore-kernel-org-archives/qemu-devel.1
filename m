Received: from eggs.gnu.org ([2001:4830:134:3::10]:53054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfs-0005O9-7H
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMHfo-0007dP-FH
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fMHfo-0007dH-B0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:42:44 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 25 May 2018 14:42:14 -0400
Message-Id: <20180525184219.14440-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

TL;DR
=====

Another version, with a minimalist approach, to the acceptance tests
infrastructure for QEMU, based on the Avocado Testing Framework.

Background
==========

The previous version, still considered an RFC, was sent to the list by
Eduardo[1] was based on the work held in Amador's branch[2].  After
reviewing in under a different light, including the experiences
done and reported by Philippe[3], it was clear to me that a different
approach would be better.

Differences from previous versions
==================================

The main difference is that this series include only the minimal
changes deemed necessary to have a starting point.  I like to think
that it's better connected to the QEMU community and project needs,
and will hopefully allow for a more organic growth.

Since this version has less features than the previous versions,
provided it's accepted, these are the next probable development tasks:

 * Provide a simple variants mechanism to allow the same tests to be
   run under different targets, machine models and devices (present on
   the previous versions as a "YAML to Mux" file with architecture
   definitions)
 * Implement QEMUMachine migration support (present on the previous
   version in the "avocado_qemu.test._VM" class)
 * Implement Guest OS image selection and download (mostly an Avocado
   feature, paired with a parameter convention and cloud-init support
   code)
 * Implement interactive support for Guest OS sessions (present on
   the previous versions, supported by the aexpect Python module)

Even though this version shares very little (if any) code with the
previous versions, the following is a list of noteworthy changes:

 * Tests directory is now "tests/acceptance" (was "tests/avocado")
 * Base test class is now "avocado_qemu.Test" (was
   "avocado_qemu.test.QemuTest")
 * Base test class is now hosted in "avocado_qemu/__init__.py" (was
   "avocado_qemu/test.py")
 * Direct use of "qemu.QEMUMachine", that is, the
   avocado_qemu.test._VM class is gone
 * avocado_qemu.Test won't search for QEMU binaries on $PATH.  To use
   QEMU binary on a custom system location it's necessary to use the
   "qemu_bin" parameter
 * Example test in README.rst is distributed as a real test
   ("test_version.py")
 * A new "Linux boot console" test, loosely modeled after Phillipe's
   use case

Changes from v1
===============

 * Moved documentation to docs/devel/testing.rst
 * Changed code markers from "::" to ".. code::" in the documentation
   for consistency
 * Added copyright notices
 * Removed useless "qemu_bin=None" attribution on avocado_qemu.Test.setUp()
 * Removed reference about setting arguments, instead of appending them,
   on "Acceptance tests: add quick VNC tests" commit message
 * Fixed typo (s/inteligence/intelligence/) on "scripts/qemu.py:
   introduce set_console() method" commit message
 * Removed useless "return" in add_args()

Commit summary
==============

Cleber Rosa (5):
  Add functional/acceptance tests infrastructure
  scripts/qemu.py: allow adding to the list of extra arguments
  Acceptance tests: add quick VNC tests
  scripts/qemu.py: introduce set_console() method
  Acceptance tests: add Linux kernel boot and console checking test

 docs/devel/testing.rst                      | 153 ++++++++++++++++++++++
 scripts/qemu.py                             | 103 ++++++++++++++-
 scripts/test_qemu.py                        | 186 +++++++++++++++++++++++++++
 tests/acceptance/README.rst                 |  10 ++
 tests/acceptance/avocado_qemu/__init__.py   |  54 ++++++++
 tests/acceptance/test_boot_linux_console.py |  47 +++++++
 tests/acceptance/test_version.py            |  24 ++++
 tests/acceptance/test_vnc.py                |  60 +++++++++
 8 files changed, 636 insertions(+), 1 deletion(-)
 create mode 100644 scripts/test_qemu.py
 create mode 100644 tests/acceptance/README.rst
 create mode 100644 tests/acceptance/avocado_qemu/__init__.py
 create mode 100644 tests/acceptance/test_boot_linux_console.py
 create mode 100644 tests/acceptance/test_version.py
 create mode 100644 tests/acceptance/test_vnc.py

---

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03443.html
[2] https://github.com/apahim/qemu/commits/avocado_qemu
[3] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03076.html
