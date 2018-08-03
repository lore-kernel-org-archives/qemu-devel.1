Received: from eggs.gnu.org ([2001:4830:134:3::10]:46972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpC-0007yo-6N
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpB-0003e5-Ek
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flVpB-0003Tb-6Y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 09:52:25 +0100
Message-Id: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] tests/vm: various minor improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The setup I had for my BSD VMs broke today, so I thought I'd
have a look at using the tests/vm/ support for building QEMU
inside BSD VMs rather than re-rolling my own. This patchset
fixes some rough edges I ran into along the way:
 * fixes support for non-KVM accelerators
 * propagates J=n setting into 'make check' in the VM
 * propagates V=1 setting into 'make' and 'make check' in the VM
 * uses --output-sync so that J=n settings don't mangle output
 * bumps the RAM settings so J=n doesn't cause the guest to
   run out of memory and kill the compiler

Ideally I'd like to be able to separately invoke commands
for "build in VM" and "run make check in VM for that build"; for
instance I only want V=1 on the make-check, not the make, and in
some cases might want to do a build but not check, and so on.
But that seemed too complicated for the moment.

Is it possible for the VMs to be persistent? Currently it
looks like they throw away their contents and start afresh
for every invocation. Doing build tests as incremental is
faster than doing every one as a from-clean...

Also, I notice that the OpenBSD VM setup is using SDL 1.2,
which means that configure complains and suggests switching
to SDL 2.0. How do we update the base image?

thanks
-- PMM

Peter Maydell (5):
  tests/vm: Use -cpu max rather than -cpu host
  tests/vm: Pass the jobs parallelism setting to 'make check'
  tests/vm: Propagate V=1 down into the make inside the VM
  tests/vm: Bump guest RAM up from 2G to 4G
  tests/vm: Use make's --output-sync option

 tests/vm/Makefile.include | 1 +
 docs/devel/testing.rst    | 1 +
 tests/vm/basevm.py        | 9 ++++++---
 tests/vm/freebsd          | 4 ++--
 tests/vm/netbsd           | 4 ++--
 tests/vm/openbsd          | 4 ++--
 tests/vm/ubuntu.i386      | 4 ++--
 7 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.17.1
