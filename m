Received: from eggs.gnu.org ([2001:4830:134:3::10]:58163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv35N-0007dj-Du
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv35K-0002lo-2Y
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dv35J-0002lH-Pn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Sep 2017 23:07:42 +0800
Message-Id: <20170921150755.19914-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 00/13] tests: Add VM based build tests (for
 non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

v11: Fix archive-source.sh. [Eric]

v10: Rebase - trivial conflict in docker Makefile.include.
     Specify bash in shebang. [Eric]
     Tweaks in README and pub key comment. [Eric]
     Clean up $1.list if tar failed. [Eric]
     Set locale in cloud-init for ubuntu image.

v9: Don't use 'set -e' in archive-source.sh. [Eric]
    Add tests/keys/README. [Eric]
    Fix direct invocation of ./netbsd etc. [Alex]
    Add a note about test image well-known ssh key. [Eric]

Build tests in one 32 bit Linux guest and three BSD images are defined in=
 this
series. This is a more managable way than the manually maintained virtual
machines in patchew. Also, one big advantage of ephemeral VMs over long r=
unning
guests is the reduced RAM usage of host, which makes it possible to have =
one
host test all these BSD variants and probably more.

The BSD guest templates are manually prepared following

https://wiki.qemu.org/Hosts/BSD

as it is not easy to automate. (The ideal approach is like the ubuntu.i38=
6
script, which configures the guest on top of an official released image, =
fully
automatically.)

Need for help: "gmake check" in the added OpenBSD image fails with -ENOME=
M
errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And =
there
is a warning from ./configure about OpenBSD going to be unsupported in co=
ming
releases, is it still the case?

Fam

Fam Zheng (13):
  gitignore: Ignore vm test images
  qemu.py: Add "wait()" method
  scripts: Add archive-source.sh
  tests: Add a test key pair
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests
  MAINTAINERS: Add tests/vm entry
  tests: Add README for vm tests
  docker: Use archive-source.py

 .gitignore                    |   1 +
 MAINTAINERS                   |   1 +
 Makefile                      |   2 +
 configure                     |   2 +-
 scripts/archive-source.sh     |  51 ++++++++
 scripts/qemu.py               |   7 ++
 tests/.gitignore              |   1 +
 tests/docker/Makefile.include |  14 +--
 tests/docker/run              |   8 +-
 tests/keys/README             |   6 +
 tests/keys/id_rsa             |  27 +++++
 tests/keys/id_rsa.pub         |   1 +
 tests/vm/Makefile.include     |  42 +++++++
 tests/vm/README               |  89 ++++++++++++++
 tests/vm/basevm.py            | 262 ++++++++++++++++++++++++++++++++++++=
++++++
 tests/vm/freebsd              |  42 +++++++
 tests/vm/netbsd               |  42 +++++++
 tests/vm/openbsd              |  43 +++++++
 tests/vm/ubuntu.i386          |  89 ++++++++++++++
 19 files changed, 710 insertions(+), 20 deletions(-)
 create mode 100755 scripts/archive-source.sh
 create mode 100644 tests/keys/README
 create mode 100644 tests/keys/id_rsa
 create mode 100644 tests/keys/id_rsa.pub
 create mode 100644 tests/vm/Makefile.include
 create mode 100644 tests/vm/README
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

--=20
2.13.5
