Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIY60-0004GA-0D
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIY5y-0007PS-TY
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gIY5y-0007Or-JI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:34 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 11:52:35 +0000
Message-Id: <20181102115239.22485-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-3.1 0/4] configure: symlink directories,
 not wildcarded files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patchset fixes a problem with our build infrastructure
that meant that MST's recent 'pci, pc, virtio' pullreq failed
tests.

Currently our configure script has a wildcard loop that creates
symlinks for every data file in tests/acpi-test-data from the
source tree to the build tree. However, if a new data file is
added in git, there is nothing that causes configure to be rerun,
and so it is not available in the build tree, which can cause
test failures.

In v1 of this patchset I addressed this by changing configure
to make tests/acpi-test-data itself a symlink. Unfortunately
this has an awkward consequence that if we did that and
a developer switched git branches from one after that change
to one before it then configure would end up trashing all
the test files by making them symlinks to themselves.
So instead in v2, we move all the data files to the tests/data/
directory. tests/data/ is already symlinked as a directory,
so there is no problem for bisection.

Patch 1 does that for tests/acpi-test-data.
Patch 2 does that for tests/hex-loader-check-data.
Patch 3 is a cleanup, renaming a variable and adding
documentation so that it's clearer that symlinking can
be used for directories and that wildcarding files is bad.
Patch 4 rolls some ad-hoc symlinking into the common loop.

We do still use wildcarding to construct a list of files in
pc-bios to be symlinked; we get away with this because we don't
in practice add new BIOS images often and if we do there's also
usually a change that means configure is rerun anyway. We can't
just symlink all of pc-bios into the build tree because it
contains other things than just generated binaries. There
might be scope for fixing this, but I wanted to get this fix out.

thanks
-- PMM

Peter Maydell (4):
  tests: Move tests/acpi-test-data/ to tests/data/acpi/
  tests: Move tests/hex-loader-check-data/ to tests/data/hex-loader/
  configure: Rename FILES variable to LINKS
  configure: Use LINKS loop for all build tree symlinks

 configure                                     |  57 ++++++++----------
 tests/bios-tables-test.c                      |   2 +-
 tests/hexloader-test.c                        |   2 +-
 MAINTAINERS                                   |   2 +-
 tests/{acpi-test-data => data/acpi}/pc/APIC   | Bin
 .../acpi}/pc/APIC.cphp                        | Bin
 .../acpi}/pc/APIC.dimmpxm                     | Bin
 tests/{acpi-test-data => data/acpi}/pc/DSDT   | Bin
 .../acpi}/pc/DSDT.bridge                      | Bin
 .../acpi}/pc/DSDT.cphp                        | Bin
 .../acpi}/pc/DSDT.dimmpxm                     | Bin
 .../acpi}/pc/DSDT.ipmikcs                     | Bin
 .../acpi}/pc/DSDT.memhp                       | Bin
 .../acpi}/pc/DSDT.numamem                     | Bin
 tests/{acpi-test-data => data/acpi}/pc/FACP   | Bin
 tests/{acpi-test-data => data/acpi}/pc/FACS   | Bin
 tests/{acpi-test-data => data/acpi}/pc/HPET   | Bin
 .../acpi}/pc/NFIT.dimmpxm                     | Bin
 .../acpi}/pc/SLIT.cphp                        | Bin
 .../acpi}/pc/SLIT.memhp                       | Bin
 .../acpi}/pc/SRAT.cphp                        | Bin
 .../acpi}/pc/SRAT.dimmpxm                     | Bin
 .../acpi}/pc/SRAT.memhp                       | Bin
 .../acpi}/pc/SRAT.numamem                     | Bin
 .../acpi}/pc/SSDT.dimmpxm                     | Bin
 tests/{acpi-test-data => data/acpi}/q35/APIC  | Bin
 .../acpi}/q35/APIC.cphp                       | Bin
 .../acpi}/q35/APIC.dimmpxm                    | Bin
 tests/{acpi-test-data => data/acpi}/q35/DSDT  | Bin
 .../acpi}/q35/DSDT.bridge                     | Bin
 .../acpi}/q35/DSDT.cphp                       | Bin
 .../acpi}/q35/DSDT.dimmpxm                    | Bin
 .../acpi}/q35/DSDT.ipmibt                     | Bin
 .../acpi}/q35/DSDT.memhp                      | Bin
 .../acpi}/q35/DSDT.numamem                    | Bin
 tests/{acpi-test-data => data/acpi}/q35/FACP  | Bin
 tests/{acpi-test-data => data/acpi}/q35/FACS  | Bin
 tests/{acpi-test-data => data/acpi}/q35/HPET  | Bin
 tests/{acpi-test-data => data/acpi}/q35/MCFG  | Bin
 .../acpi}/q35/NFIT.dimmpxm                    | Bin
 .../acpi}/q35/SLIT.cphp                       | Bin
 .../acpi}/q35/SLIT.memhp                      | Bin
 .../acpi}/q35/SRAT.cphp                       | Bin
 .../acpi}/q35/SRAT.dimmpxm                    | Bin
 .../acpi}/q35/SRAT.memhp                      | Bin
 .../acpi}/q35/SRAT.numamem                    | Bin
 .../acpi}/q35/SSDT.dimmpxm                    | Bin
 .../acpi}/rebuild-expected-aml.sh             |   2 -
 .../hex-loader}/test.hex                      |   0
 49 files changed, 27 insertions(+), 38 deletions(-)
 rename tests/{acpi-test-data => data/acpi}/pc/APIC (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/APIC.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/APIC.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.bridge (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.ipmikcs (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/DSDT.numamem (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/FACP (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/FACS (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/HPET (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/NFIT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SLIT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SLIT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SRAT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SRAT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SRAT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SRAT.numamem (100%)
 rename tests/{acpi-test-data => data/acpi}/pc/SSDT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/APIC (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/APIC.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/APIC.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.bridge (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.ipmibt (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/DSDT.numamem (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/FACP (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/FACS (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/HPET (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/MCFG (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/NFIT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SLIT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SLIT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SRAT.cphp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SRAT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SRAT.memhp (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SRAT.numamem (100%)
 rename tests/{acpi-test-data => data/acpi}/q35/SSDT.dimmpxm (100%)
 rename tests/{acpi-test-data => data/acpi}/rebuild-expected-aml.sh (86%)
 rename tests/{hex-loader-check-data => data/hex-loader}/test.hex (100%)

-- 
2.19.1
