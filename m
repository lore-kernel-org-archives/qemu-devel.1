Received: from eggs.gnu.org ([2001:4830:134:3::10]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qx-00053c-JQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qw-000415-5M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:11 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qv-000404-V5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:10 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so58623226wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:25 +0100
Message-Id: <1485524749-118532-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/41] block: get max_transfer limit for char
 (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

We can get the maximum number of bytes for a single I/O transfer
from the BLKSECTGET ioctl, but we only perform this for block
devices.  scsi-generic devices are represented as character devices,
and so do not issue this today.  Update this, so that virtio-scsi
devices using the scsi-generic interface can return the same data.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170120162527.66075-4-farman@linux.vnet.ibm.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9f83725..2134e0e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -674,7 +674,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     struct stat st;
 
     if (!fstat(s->fd, &st)) {
-        if (S_ISBLK(st.st_mode)) {
+        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
             int ret = hdev_get_max_transfer_length(bs, s->fd);
             if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
                 bs->bl.max_transfer = pow2floor(ret);
-- 
1.8.3.1
