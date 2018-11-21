Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMK-0003KO-Dq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPaMG-0003vz-KU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPaME-0003th-LW
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:48:28 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 21 Nov 2018 16:48:16 -0500
Message-Id: <20181121214818.22874-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Add "boot_linux" acceptance test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Cleber Rosa <crosa@redhat.com>

Some hopefully useful pointers for reviewers:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/test_boot_linux_v2
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/test_boot_linux_v2

Travis CI Info:

  - Build: https://travis-ci.org/clebergnu/qemu/builds/458110642
  - Execution results for the test added here:
    * https://travis-ci.org/clebergnu/qemu/jobs/458110664#L2043

Previous version:
  - http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02530.html

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * The commit message was adjusted, removing the reference to the
   avocado.utils.vmimage encoding issue on previous Avocado versions
   (<=3D 64.0) and the fix that would (and was) included in Avocado
   version 65.0.

 * Effectively added pycdlib=3D=3D1.6.0 to the requirements.txt file,
   added on a56931eef3, and adjusted the commit message was also
   to reflect that.

 * Updated the default version of the guest OS, from Fedora 28 to 29.
   Besides possible improvements in the (virtual) hardware coverage,
   it brings a performance improvement in the order of 20% to the
   test:

   With a Fedora 28 guest:
   ... boot_linux.py:BootLinux.test: PASS (14.23 s)

   With a Fedora 29 guest:
   ...  boot_linux.py:BootLinux.test: PASS (11.87 s)

 * Removed all direct parameters usage from the test.  Because some
   parameters and its default values implemented in the test would
   prevent it from running on some environments.  Example: the "accel"
   parameter had a default value of "kvm", which would prevent this
   test, that boots a x86_64 OS, from running on a host arch different
   than x86_64.  I recognize that it's desirable to make tests
   reusable and parameterized (that was the reason for the first
   version doing so), but the mechanism to be used to define the
   architectures that a given test should support is still an open
   issue, and has been discussed in other threads.  I'll follow up
   those discussions with a proposal, and until then, removing those
   aspects from this test implementation seemed to be the best option.
   A caveat: this test currently adds the same tag (x86_64) and
   follows other assumptions made on "boot_linux_console.py", that is,
   that a x86_64 target binary will be used to run it.  If a user is
   in an environment that does not have a x86_64 target binary, it
   could filter those tests out with: "avocado run
   --filter-by-tags=3D'-x86_64' tests/acceptance".

 * Removed most arguments to the QEMU command line for pretty much the
   same reasons described above, and by following the general
   perception that I could grasp from other discussions that QEMU
   defaults should preferrably be used.  This test, as well as others,
   can and should be extended later to allow for different test
   scenarios by passing well documented parameter values.  That is,
   they should respect well-known parameters such as "accel" mentioned
   above, so that the same test can run with KVM or TCG.

 * Changed the value of the memory argument to 1024, which based on
   my experimentations and observations is the minimum amount of RAM
   for the Fedora 29 cloud image to sucessfully boot on QEMU.  I know
   there's no such thing as a "one size fits all", specially for QEMU,
   but this makes me wonder wether a x86_64 machine type shouldn't
   have its default_ram_size bumped to a number practical enough to
   run modern operating systems.

 * Added a new patch "RFC: Acceptance tests: add the build directory
   to the system PATH", which is supposed to gather feedback on how to
   enable the use of built binaries, such as qemu-img, to code used by
   the test code.  The specific situation here is that the vmimage,
   part of the avocado.utils libraries, makes use of qemu-img to create
   snapshot files.  Even though we could require qemu-img to be installed
   as a dependency of tests, system wide, it actually goes against the
   goal of testing all QEMU things from the source/build tree.  This
   became aparent with tests running on environments such as Travis CI,
   which don't necessarily have qemu-img available elsewhere.

Cleber Rosa (2):
  RFC: Acceptance tests: add the build directory to the system PATH
  Add "boot_linux" acceptance test

 tests/acceptance/avocado_qemu/__init__.py |  9 +++++
 tests/acceptance/boot_linux.py            | 46 +++++++++++++++++++++++
 tests/requirements.txt                    |  1 +
 3 files changed, 56 insertions(+)
 create mode 100644 tests/acceptance/boot_linux.py

--=20
2.19.1
