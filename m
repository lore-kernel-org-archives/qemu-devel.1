Received: from eggs.gnu.org ([209.51.188.92]:58635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLscB-0002qI-8V
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLsc6-0006IF-Gx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:50 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:47010
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLsc6-000609-3c
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:46 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Wed,  1 May 2019 11:01:25 -0600
Message-Id: <20190501170125.10244-1-brogers@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scsi-disk: assert positive value to avoid
 compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, eblake@redhat.com, jsnow@redhat.com, Bruce Rogers <brogers@suse.com>

While investigating link-time-optimization, the compiler complained as
follows:
In function ‘scsi_disk_new_request_dump’,
    inlined from ‘scsi_new_request.part.24’ at hw/scsi/scsi-disk.c:2549:9,
    inlined from ‘scsi_new_request’ at hw/scsi/scsi-disk.c:2533:21:
hw/scsi/scsi-disk.c:2523:19: error: argument 1 value ‘18446744073709551612’ exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
hw/scsi/scsi-disk.c: In function ‘scsi_new_request’:
/usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation function ‘g_malloc’ declared here
 gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1);

Asserting that len is positive avoids this diagnostic. This assert is
reasonable since the error case of scsi_cdb_length() has already been
handled by a previous call to that function.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..ac180fdddf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2520,6 +2520,7 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
     int len = scsi_cdb_length(buf);
     char *line_buffer, *p;
 
+    assert(len > 0);
     line_buffer = g_malloc(len * 5 + 1);
 
     for (i = 0, p = line_buffer; i < len; i++) {
-- 
2.21.0
