Received: from eggs.gnu.org ([2001:4830:134:3::10]:39513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diAqp-0000Ge-Kj
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diAqm-0001Zg-HE
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diAqm-0001Z9-As
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:48:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 17 Aug 2017 10:47:36 +0800
Message-Id: <20170817024746.5961-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

v2: - Add docstring. [Stefan]
    - Call self._load_io_lod. [Stefan]
    - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
    - Add image checksum.
    - Use os.rename() and os.makedirs(). [Stefan]
    - Fix NetBSD URL. [Kamil]

Build tests in one 32 bit Linux guest and three BSD images are defined in this
series. This is a more managable way than the manually maintained virtual
machines in patchew. Also, one big advantage of ephemeral VMs over long running
guests is the reduced RAM usage of host, which makes it possible to have one
host test all these BSD variants and probably more.

The BSD guest templates are manually prepared following

https://wiki.qemu.org/Hosts/BSD

as it is not easy to automate. (The ideal approach is like the ubuntu.i386
script, which configures the guest on top of an official released image, fully
automatically.)

Need for help: "gmake check" in the added OpenBSD image fails with -ENOMEM
errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And there
is a warning from ./configure about OpenBSD going to be unsupported in coming
releases, is it still the case?

Fam

Fam Zheng (10):
  gitignore: Ignore vm test images
  qemu.py: Add variable vga type
  qemu.py: Add "wait()" method
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests
  MAINTAINERS: Add tests/vm entry

 .gitignore                |   2 +
 MAINTAINERS               |   1 +
 Makefile                  |   2 +
 configure                 |   2 +-
 scripts/qemu.py           |  10 +-
 tests/vm/Makefile.include |  41 ++++++++
 tests/vm/basevm.py        | 262 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          |  45 ++++++++
 tests/vm/netbsd           |  45 ++++++++
 tests/vm/openbsd          |  46 ++++++++
 tests/vm/ubuntu.i386      |  88 ++++++++++++++++
 11 files changed, 542 insertions(+), 2 deletions(-)
 create mode 100644 tests/vm/Makefile.include
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

-- 
2.13.4
