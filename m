Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039EECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9026E206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9026E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0Ut-0007Fx-BH
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PZ-0000I1-Jq
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PY-0003qO-FN
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PY-0003pu-7G
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 794E1C05AA63;
 Fri, 11 Oct 2019 19:17:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAC3A5D6C8;
 Fri, 11 Oct 2019 19:17:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 09/21] migration/postcopy: map large zero page in
 postcopy_ram_incoming_setup()
Date: Fri, 11 Oct 2019 20:16:34 +0100
Message-Id: <20191011191646.226814-10-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 11 Oct 2019 19:17:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

postcopy_ram_incoming_setup() and postcopy_ram_incoming_cleanup() are
counterpart. It is reasonable to map/unmap large zero page in these two
functions respectively.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191005135021.21721-3-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9a16f52a79..08a3ed516e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1144,6 +1144,22 @@ int postcopy_ram_enable_notify(MigrationIncomingSt=
ate *mis)
         return -1;
     }
=20
+    /*
+     * Map large zero page when kernel can't use UFFDIO_ZEROPAGE for hug=
epages
+     */
+    mis->postcopy_tmp_zero_page =3D mmap(NULL, mis->largest_page_size,
+                                       PROT_READ | PROT_WRITE,
+                                       MAP_PRIVATE | MAP_ANONYMOUS,
+                                       -1, 0);
+    if (mis->postcopy_tmp_zero_page =3D=3D MAP_FAILED) {
+        int e =3D errno;
+        mis->postcopy_tmp_zero_page =3D NULL;
+        error_report("%s: Failed to map large zero page %s",
+                     __func__, strerror(e));
+        return -e;
+    }
+    memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
+
     /*
      * Ballooning can mark pages as absent while we're postcopying
      * that would cause false userfaults.
@@ -1250,23 +1266,7 @@ int postcopy_place_page_zero(MigrationIncomingStat=
e *mis, void *host,
                                            qemu_ram_block_host_offset(rb=
,
                                                                       ho=
st));
     } else {
-        /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
-        if (!mis->postcopy_tmp_zero_page) {
-            mis->postcopy_tmp_zero_page =3D mmap(NULL, mis->largest_page=
_size,
-                                               PROT_READ | PROT_WRITE,
-                                               MAP_PRIVATE | MAP_ANONYMO=
US,
-                                               -1, 0);
-            if (mis->postcopy_tmp_zero_page =3D=3D MAP_FAILED) {
-                int e =3D errno;
-                mis->postcopy_tmp_zero_page =3D NULL;
-                error_report("%s: %s mapping large zero page",
-                             __func__, strerror(e));
-                return -e;
-            }
-            memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_=
size);
-        }
-        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_pag=
e,
-                                   rb);
+        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_pag=
e, rb);
     }
 }
=20
--=20
2.23.0


