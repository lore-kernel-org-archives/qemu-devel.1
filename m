Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D8620786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPgZWFeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D8620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0UVP-0000t4-8c
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUE-0007n7-8F
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUC-0005Mq-Mu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595961479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Hfp3QM9SgYQE0pQgUg/eToLLU9Zi7JYBr6vL1JgNcdI=;
 b=cPgZWFeLQ8r3kwso4iDeAISBgjZ4QNt660d4KAFN+EWLbZ/I6xqbjkoQfX1mraI2QNncY+
 GtVuDugBhnrgW6EXzIcrw7SPcYckcuBslTxZy2JZwk6PdqVJereS5/DKa+a7njCpbdm/6i
 2uSiuVHHbLSBgvtv2hH3tbiT4u1+ffU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-AWZM8PtnN4SP-KN18QMYCw-1; Tue, 28 Jul 2020 14:37:57 -0400
X-MC-Unique: AWZM8PtnN4SP-KN18QMYCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961F480046C;
 Tue, 28 Jul 2020 18:37:56 +0000 (UTC)
Received: from thuth.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05D2360BF4;
 Tue, 28 Jul 2020 18:37:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 2/6] pc-bios/s390-ccw: Move ipl-related code from
 main() into a separate function
Date: Tue, 28 Jul 2020 20:37:30 +0200
Message-Id: <20200728183734.7838-3-thuth@redhat.com>
In-Reply-To: <20200728183734.7838-1-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's move this part of the code into a separate function to be able
to use it from multiple spots later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 146a50760b..9b64eb0c24 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -223,14 +223,8 @@ static void virtio_setup(void)
     }
 }
 
-int main(void)
+static void ipl_boot_device(void)
 {
-    sclp_setup();
-    css_setup();
-    boot_setup();
-    find_boot_device();
-    enable_subchannel(blk_schid);
-
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
@@ -242,8 +236,18 @@ int main(void)
         break;
     default:
         print_int("Attempting to boot from unexpected device type", cutype);
-        panic("");
+        panic("\nBoot failed.\n");
     }
+}
+
+int main(void)
+{
+    sclp_setup();
+    css_setup();
+    boot_setup();
+    find_boot_device();
+    enable_subchannel(blk_schid);
+    ipl_boot_device();
 
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
-- 
2.18.1


