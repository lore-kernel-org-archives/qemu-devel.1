Received: from eggs.gnu.org ([2001:4830:134:3::10]:41294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fz-0005X3-Fc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fy-0001HL-9w
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8Fy-0001Go-4w
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:50 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:22 +0100
Message-Id: <20180129120932.12874-4-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] migration/savevm.c: set
 MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

MAX_VM_CMD_PACKAGED_SIZE is a constant used in qemu_savevm_send_packaged
and loadvm_handle_cmd_packaged to determine whether a package is too
big to be sent or received. qemu_savevm_send_packaged is called inside
postcopy_start (migration/migration.c) to send the MigrationState
in a single blob to the destination, using the MIG_CMD_PACKAGED subcommand,
which will read it up using loadvm_handle_cmd_packaged. If the blob is
larger than MAX_VM_CMD_PACKAGED_SIZE, an error is thrown and the postcopy
migration is aborted. Both MAX_VM_CMD_PACKAGED_SIZE and MIG_CMD_PACKAGED
were introduced by commit 11cf1d984b ("MIG_CMD_PACKAGED: Send a packaged
chunk ..."). The constant has its original value of 1ul << 24 (16MB).

The current MAX_VM_CMD_PACKAGED_SIZE value is not enough to support postcopy
migration of bigger pseries guests. The blob size for a postcopy migration of
a pseries guest with the following setup:

qemu-system-ppc64 --nographic -vga none -machine pseries,accel=kvm -m 64G \
-smp 1,maxcpus=32 -device virtio-blk-pci,drive=rootdisk \
-drive file=f27.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
-netdev user,id=u1 -net nic,netdev=u1

Goes around 12MB. Bumping the RAM to 128G makes the blob sizes goes to 20MB.
With 256G the blob goes to 37MB - more than twice the current maximum size.
At this moment the pseries machine can handle guests with up to 1TB of RAM,
making this postcopy blob goes to 128MB of size approximately.

Following the discussions made in [1], there is a need to understand what
devices are aggressively consuming the blob in that manner and see if that
can be mitigated. Until then, we can set MAX_VM_CMD_PACKAGED_SIZE to the
maximum value allowed. Since the size is a 32 bit int variable, we can set
it as 1ul << 32, giving a maximum blob size of 4G that is enough to support
postcopy migration of 32TB RAM guests given the above constraints.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg06313.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b7908f62be..b8e9c532af 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -81,7 +81,7 @@ enum qemu_vm_cmd {
     MIG_CMD_MAX
 };
 
-#define MAX_VM_CMD_PACKAGED_SIZE (1ul << 24)
+#define MAX_VM_CMD_PACKAGED_SIZE UINT32_MAX
 static struct mig_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
-- 
2.14.3
