Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cWQf0-0002xz-DW
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cWQex-0002xY-Ac
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:43:02 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:41197 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cWQew-0002xO-O4
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:42:59 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed, 25 Jan 2017 19:42:52 +0300
Message-Id: <1485362572-7246-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] block: add missed BDRV_O_NOCACHE when
 block device is opened without file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Technically there is a problem when the guest DVD is created by libvirt
with AIO mode 'native' on Linux. Current QEMU is unable to start the
domain configured as follows:
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <target dev='sdb' bus='scsi'/>
      <readonly/>
    </disk>
The problem comes from the combination of 'cache' and 'io' options.

'io' option is common option and it is removed from block driver
specific options. 'cache' originally is not. The patch makes 'cache'
option common. This works fine as long as cdrom media insertion
later on.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

May be this has already discussed, but still. AIO=native for CDROM without
media seems important case.

diff --git a/blockdev.c b/blockdev.c
index 245e1e1..004dcde 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -374,6 +374,13 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
                return;
             }
         }
+
+        if (qemu_opt_get_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
+            *bdrv_flags |= BDRV_O_NO_FLUSH;
+        }
+        if (qemu_opt_get_bool(opts, BDRV_OPT_CACHE_DIRECT, false)) {
+            *bdrv_flags |= BDRV_O_NOCACHE;
+        }
     }
 
     /* disk I/O throttling */
@@ -569,11 +576,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         /* bdrv_open() defaults to the values in bdrv_flags (for compatibility
          * with other callers) rather than what we want as the real defaults.
          * Apply the defaults here instead. */
-        qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_DIRECT, "off");
-        qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
         qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
                               read_only ? "on" : "off");
-        assert((bdrv_flags & BDRV_O_CACHE_MASK) == 0);
 
         if (runstate_check(RUN_STATE_INMIGRATE)) {
             bdrv_flags |= BDRV_O_INACTIVE;
@@ -3996,6 +4000,14 @@ QemuOptsList qemu_common_drive_opts = {
             .type = QEMU_OPT_STRING,
             .help = "write error action",
         },{
+            .name = BDRV_OPT_CACHE_DIRECT,
+            .type = QEMU_OPT_BOOL,
+            .help = "Bypass software writeback cache on the host",
+        }, {
+            .name = BDRV_OPT_CACHE_NO_FLUSH,
+            .type = QEMU_OPT_BOOL,
+            .help = "Ignore flush requests",
+        }, {
             .name = BDRV_OPT_READ_ONLY,
             .type = QEMU_OPT_BOOL,
             .help = "open drive file as read-only",
-- 
2.7.4
