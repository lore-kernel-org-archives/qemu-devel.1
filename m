Received: from eggs.gnu.org ([2001:4830:134:3::10]:51842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJC8-0006gw-Si
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJC5-0006O6-Mm
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnJC5-0006Nh-DT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:43:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 Aug 2017 14:42:50 +0800
Message-Id: <20170831064302.14427-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/12] tests: Add VM based build tests (for
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

v5: Generate source tar file with a script.
    Fix tmpdir, use pwd.
    Reduce default -j to half cores.

v4: Drop unused imports and parameters. [Cleber]
    Use --exclude-vcs (still no --exclude-vcs-ignores because it's too ne=
w). [Philippe]
    Use gtar if available. [Philippe, Kamil]
    /dev/ld1a -> /dev/rld1a for netbsd. [Kamil]
    Only use '-enable-kvm' if /dev/kvm is there. [Kamil]
    Grammar fixes of README. [Stefan]
    Rename image on the server to include version and arch. [Kamil]
    Just ignore *.tmp. [Philippe]

v3: Drop RFC.
    Add Stefan's and Kamil's reviewed-bys.
    Use optparse. [Stefan]
    Drop the VGA patch. [Paolo, Stefan]
    Improve exit/exit code/doc. [Stefan]
    Drop unused line from basevm.py. [Stefan]
    Drop "--target-list" form Makefile.
    More intelligent '-j'.
    Add README. [Stefan]

v2: - Add docstring. [Stefan]
    - Call self._load_io_lod. [Stefan]
    - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
    - Add image checksum.
    - Use os.rename() and os.makedirs(). [Stefan]
    - Fix NetBSD URL. [Kamil]

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

Fam Zheng (12):
  gitignore: Ignore vm test images
  qemu.py: Add "wait()" method
  scripts: Add archive-source.sh
  tests: Add vm test lib
  tests: Add ubuntu.i386 image
  tests: Add FreeBSD image
  tests: Add NetBSD image
  tests: Add OpenBSD image
  Makefile: Add rules to run vm tests
  MAINTAINERS: Add tests/vm entry
  tests: Add README for vm tests
  docker: Use archive-source.py

 .gitignore                    |   2 +
 MAINTAINERS                   |   1 +
 Makefile                      |   2 +
 configure                     |   2 +-
 scripts/archive-source.sh     |  29 +++++
 scripts/qemu.py               |   7 ++
 tests/docker/Makefile.include |  15 +--
 tests/docker/run              |   8 +-
 tests/vm/Makefile.include     |  42 +++++++
 tests/vm/README               |  63 ++++++++++
 tests/vm/basevm.py            | 276 ++++++++++++++++++++++++++++++++++++=
++++++
 tests/vm/freebsd              |  42 +++++++
 tests/vm/netbsd               |  42 +++++++
 tests/vm/openbsd              |  43 +++++++
 tests/vm/ubuntu.i386          |  88 ++++++++++++++
 15 files changed, 641 insertions(+), 21 deletions(-)
 create mode 100755 scripts/archive-source.sh
 create mode 100644 tests/vm/Makefile.include
 create mode 100644 tests/vm/README
 create mode 100755 tests/vm/basevm.py
 create mode 100755 tests/vm/freebsd
 create mode 100755 tests/vm/netbsd
 create mode 100755 tests/vm/openbsd
 create mode 100755 tests/vm/ubuntu.i386

--=20
2.13.5
