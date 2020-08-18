Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD318C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8F8207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd3FTYnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8F8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82QA-0005S8-QN
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K5-00035l-Oa
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K2-0007J8-0v
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrHVUEx7Xlep9B0WzqbnKA4wjHnNK9UAi/WWX4MDCB8=;
 b=Jd3FTYnOSS5JIiwWIq9Zbs0/2FM7IxSP2GaT10d7NkDSxs0lM/fd9aICo8WrUYo35MdR3Y
 29pIZkoJZr6xQG8ZyRLEbWyMZvyCu+n3BaM2dDhjaR1EX1G2icZILluzzLb/8YxPqhhT19
 8GwLypT4AuCcQc6qnzvyz6GmIMzuMOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-J4T8D0SPNZ2cVw-EHqT18Q-1; Tue, 18 Aug 2020 10:10:38 -0400
X-MC-Unique: J4T8D0SPNZ2cVw-EHqT18Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42BC8D6381
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1104DBA63
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 011/150] nsis: use "make DESTDIR=" instead of "make prefix="
Date: Tue, 18 Aug 2020 10:08:06 -0400
Message-Id: <20200818141025.21608-12-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



