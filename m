Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5VMl-0008VP-QQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5VMi-0001eg-Lz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5VMi-0001dH-GF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D3895F73B
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 11:21:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-43.ams2.redhat.com
	[10.36.117.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D516D5BD40
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 11:21:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Oct 2017 13:21:21 +0200
Message-Id: <20171020112121.12321-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-pr-helper: Do not use {0} for
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first field in struct dm_ioctl is an array, and old GCC warns
about it with -Wmissing-braces (GCC <= 4.8).  The "{0}" universal
zero initializer is only useful if the other side might be a scalar;
for a struct, "{}" is enough and shuts up the compiler.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index dd9785143b..8e475f676e 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -258,12 +258,12 @@ static void *dm_dev_ioctl(int fd, int ioc, struct dm_ioctl *dm)
 
 static void dm_init(void)
 {
+    struct dm_ioctl dm = {};
     control_fd = open(CONTROL_PATH, O_RDWR);
     if (control_fd < 0) {
         perror("Cannot open " CONTROL_PATH);
         exit(1);
     }
-    struct dm_ioctl dm = { 0 };
     if (!dm_ioctl(DM_VERSION, &dm)) {
         perror("ioctl");
         exit(1);
-- 
2.14.2
