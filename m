Received: from eggs.gnu.org ([2001:4830:134:3::10]:46555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkp-0004cf-Pg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkp-00054x-34
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 18:24:58 +0100
Message-Id: <20181009172501.17353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] block/qcow*: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

There are a few places in the affected files where the in-place swap
function is used on something other than a packed struct field; we
convert those anyway, for consistency.

Patches produced mechanically using spatch; in one case I also
did a little hand-editing to wrap overlong lines that checkpatch
would otherwise complain about.

(clang also complains about other files in block: vdi.c, vpc.c,
vhdx.h, vhdx.c, vhdx-endian.c, vhdx-log.c -- I may produce patches
for those later if nobody else gets there first.)

thanks
-- PMM

Peter Maydell (3):
  block/qcow2: Don't take address of fields in packed structs
  block/qcow: Don't take address of fields in packed structs
  block/qcow2-bitmap: Don't take address of fields in packed structs

 block/qcow.c         | 18 ++++++-------
 block/qcow2-bitmap.c | 24 ++++++++---------
 block/qcow2.c        | 64 +++++++++++++++++++++++---------------------
 3 files changed, 55 insertions(+), 51 deletions(-)

-- 
2.19.0
