Received: from eggs.gnu.org ([2001:4830:134:3::10]:47729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dn-00035m-VT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dm-0008Di-QN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1em2dm-0008DQ-Ld
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:50 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 14 Feb 2018 21:22:23 +0200
Message-Id: <20180214192230.70287-4-marcel@redhat.com>
In-Reply-To: <20180214192230.70287-1-marcel@redhat.com>
References: <20180214192230.70287-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V11 03/10] scripts/update-linux-headers: import
 pvrdma headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com, ghammer@redhat.com

Modify the script to import the headers used by the pvrdma device.
Part of them are interfaces between the guest driver and the device,
import them under include/standart-headers/drivers/infiniband/... .

Remove the unused functions from pvrdma_verbs.h avoiding the
unnecessary import of several infiniband/networking/other headers.

Reviewed-by: Gal Hammer <ghammer@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 scripts/update-linux-headers.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 135a10d96a..be065704df 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -38,6 +38,7 @@ cp_portable() {
                                      -e 'linux/if_ether' \
                                      -e 'input-event-codes' \
                                      -e 'sys/' \
+                                     -e 'pvrdma_verbs' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -46,6 +47,7 @@ cp_portable() {
 
     header=$(basename "$f");
     sed -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
+        -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
         -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
@@ -56,6 +58,7 @@ cp_portable() {
         -e 's/__inline__/inline/' \
         -e '/sys\/ioctl.h/d' \
         -e 's/SW_MAX/SW_MAX_/' \
+        -e 's/atomic_t/int/' \
         "$f" > "$to/$header";
 }
 
@@ -147,6 +150,33 @@ for i in "$tmpdir"/include/linux/*virtio*.h "$tmpdir/include/linux/input.h" \
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
 
+rm -rf "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
+mkdir -p "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma"
+
+# Remove the unused functions from pvrdma_verbs.h avoiding the unnecessary
+# import of several infiniband/networking/other headers
+tmp_pvrdma_verbs="$tmpdir/pvrdma_verbs.h"
+# Parse the entire file instead of single lines to match
+# function declarations expanding over multiple lines
+# and strip the declarations starting with pvrdma prefix.
+sed  -e '1h;2,$H;$!d;g'  -e 's/[^};]*pvrdma[^(| ]*([^)]*);//g' \
+    "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h" > \
+    "$tmp_pvrdma_verbs";
+
+for i in "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h" \
+         "$linux/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h" \
+         "$tmp_pvrdma_verbs"; do \
+    cp_portable "$i" \
+         "$output/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/"
+done
+
+rm -rf "$output/include/standard-headers/rdma/"
+mkdir -p "$output/include/standard-headers/rdma/"
+for i in "$tmpdir/include/rdma/vmw_pvrdma-abi.h"; do
+    cp_portable "$i" \
+         "$output/include/standard-headers/rdma/"
+done
+
 cat <<EOF >$output/include/standard-headers/linux/types.h
 /* For QEMU all types are already defined via osdep.h, so this
  * header does not need to do anything.
-- 
2.13.5
