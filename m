Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41CC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8ED20857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8ED20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDukf-0006Pn-Tk
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 13:41:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDujX-0005Pi-CF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDujV-0002i5-Df
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDujU-0002dR-OW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDDA58DA30;
	Tue,  9 Apr 2019 17:40:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 75BDF5D961;
	Tue,  9 Apr 2019 17:40:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BCBFD1138648; Tue,  9 Apr 2019 19:40:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 19:40:18 +0200
Message-Id: <20190409174018.25798-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 09 Apr 2019 17:40:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409174018.XhVo-wpDMF00Y0rKXCEybvA1GON-SZWWuqRfpdYPWxw@z>

If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
computation of @dt_size overflows to a negative number, which then
gets converted to a very large size_t for g_malloc0() and
load_image_size().  In the (fortunately improbable) case g_malloc0()
succeeds and load_image_size() survives, we'd assign the negative
number to *sizep.  What that would do to the callers I can't say, but
it's unlikely to be good.

Fix by rejecting images whose size would overflow.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 device_tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/device_tree.c b/device_tree.c
index 296278e12a..f8b46b3c73 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
                      filename_path);
         goto fail;
     }
+    if (dt_size > INT_MAX / 2 - 10000) {
+        error_report("Device tree file '%s' is too large", filename_path);
+        goto fail;
+    }
 
     /* Expand to 2x size to give enough room for manipulation.  */
     dt_size += 10000;
-- 
2.17.2


