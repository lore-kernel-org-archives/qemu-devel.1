Received: from eggs.gnu.org ([2001:4830:134:3::10]:56834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMB-000678-7M
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM8-0000D6-OJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM8-0000Ai-Bc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 858FC46233
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C712CFD2
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:56 +0200
Message-Id: <20181016174158.15229-37-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 36/38] block: Clean up bdrv_img_create()'s
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

bdrv_img_create() takes an Error ** argument and uses it in the
conventional way, except for one place: when qemu_opts_do_parse()
fails, it first reports its error to stderr or the HMP monitor with
error_report_err(), then error_setg()'s a generic error.

When the caller reports that second error similarly, this produces two
consecutive error messages on stderr or the HMP monitor.

When the caller does something else with it, such as send it via QMP,
the first error still goes to stderr or the HMP monitor.  Fortunately,
no such caller exists.

Simply use the first error as is.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block.c b/block.c
index 5d51419d21..08d64cdc61 100644
--- a/block.c
+++ b/block.c
@@ -4803,9 +4803,6 @@ void bdrv_img_create(const char *filename, const char *fmt,
     if (options) {
         qemu_opts_do_parse(opts, options, NULL, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            error_setg(errp, "Invalid options for file format '%s'", fmt);
             goto out;
         }
     }
-- 
2.17.1
