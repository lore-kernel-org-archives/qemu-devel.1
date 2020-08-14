Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8FC2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCgGLg5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8FC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Vtc-0000eI-87
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmV-0004x5-CI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmM-0002oL-7y
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrHVUEx7Xlep9B0WzqbnKA4wjHnNK9UAi/WWX4MDCB8=;
 b=BCgGLg5s+7DZpTYt1My0OD7BVRJt+gC7ASg2bR1QrhQ3qpi1aF15bKBd5Q7OG2WbVLFuVb
 pCkNipXUgqz6AXXNfpX2+us90qEyfYEU1QUGbFEL6RGvgeBIvJz8p4ie5NdDVPGXD94JFp
 sM50BYxYu17NrfzfRChjSsa7SgrEXk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-K3arMqrMPfaLcqxR0WIimw-1; Fri, 14 Aug 2020 05:13:35 -0400
X-MC-Unique: K3arMqrMPfaLcqxR0WIimw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF1A1005E5B
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 909B1709D9
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 011/150] nsis: use "make DESTDIR=" instead of "make prefix="
Date: Fri, 14 Aug 2020 05:11:07 -0400
Message-Id: <20200814091326.16173-12-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will prevent modifying the prefix on "make install".  Adjust the
creation of the installer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 5596482dbd..ec12101a84 100644
--- a/Makefile
+++ b/Makefile
@@ -1188,16 +1188,16 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
-	$(MAKE) install prefix=${INSTDIR}
+$(INSTALLER): $(SRC_PATH)/qemu.nsi
+	$(MAKE) install DESTDIR=${INSTDIR}
 ifdef SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in *.exe; do \
            $(SIGNCODE) $${i}; \
          done \
         )
 endif # SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in qemu-system-*.exe; do \
            arch=$${i%.exe}; \
            arch=$${arch#qemu-system-}; \
@@ -1206,11 +1206,11 @@ endif # SIGNCODE
            echo File \"\$${BINDIR}\\$$i\"; \
            echo SectionEnd; \
          done \
-        ) >${INSTDIR}/system-emulations.nsh
+        ) >${INSTDIR}/${bindir}/system-emulations.nsh
 	makensis $(nsisflags) \
                 $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
                 $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}" \
+                -DBINDIR="${INSTDIR}/${bindir}" \
                 $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
                 -DSRCDIR="$(SRC_PATH)" \
                 -DOUTFILE="$(INSTALLER)" \
-- 
2.26.2



