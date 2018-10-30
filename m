Received: from eggs.gnu.org ([2001:4830:134:3::10]:38009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTI-00012R-PZ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTG-00019T-Mr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gHTTG-000188-Ee
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:50:02 +0000
Message-Id: <20181030125005.28151-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] configure: symlink directories,
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
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

This patchset fixes a problem with our build infrastructure
that meant that MST's recent 'pci, pc, virtio' pullreq failed
tests.

Currently our configure script has a wildcard loop that creates
symlinks for every data file in tests/acpi-test-data from the
source tree to the build tree. However, if a new data file is
added in git, there is nothing that causes configure to be rerun,
and so it is not available in the build tree, which can cause
test failures.

The core of the change here is that instead of linking every
individual data file, we just symlink the directory itself (which
we do in patch 2 for this and also tests/hex-loader-check-data).
The rest of the patchset deals with:
 * renaming a shell variable to make it clearer that it's OK
   to put directories to symlink in it, not just files
 * adding a comment about why wildcarding is a bad idea
 * cleaning up a couple of places that did their own symlinking
   when they could have just used the existing code

We do still use wildcarding to construct a list of files in
pc-bios to be symlinked; we get away with this because we don't
in practice add new BIOS images often and if we do there's also
usually a change that means configure is rerun anyway. We can't
just symlink all of pc-bios into the build tree because it
contains other things than just generated binaries. There's
scope for fixing this, I think, but I wanted to get this fix out.

thanks
-- PMM

Peter Maydell (3):
  configure: Rename FILES variable to LINKS
  configure: Symlink entire test directories rather than individual
    files
  configure: Use FILES loop for all build tree symlinks

 configure | 58 ++++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

-- 
2.19.1
