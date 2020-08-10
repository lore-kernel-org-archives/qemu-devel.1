Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C43720838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOSCtS1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C43720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BQN-0002Zj-CI
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIj-0005XV-3M
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIh-0002jV-D3
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xyg2tgiWB6JmFmvllZCzSpCGsu2mkSQ8xFMhSgN8skU=;
 b=eOSCtS1mVNgAxZPRQDv/GdAPIzYVa/QhqRSYAIpMblZtxXgEoUum9J4Zp5hLaJJQ4GGs22
 sq1lGqTjtmaZDL/+wXZFVNwxjqbiIq+SOd/rLyVlzpAeGzs7qux79Wz34vugq3OBvZNwh3
 W7fq/Ng9l23zvCwIhwT39U3VaQddRpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-WrQ3IgiMNSu-L2NGcu9wsA-1; Mon, 10 Aug 2020 13:09:28 -0400
X-MC-Unique: WrQ3IgiMNSu-L2NGcu9wsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7358014D7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:28 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51E895F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 010/147] nsis: use "make DESTDIR=" instead of "make prefix="
Date: Mon, 10 Aug 2020 19:06:48 +0200
Message-Id: <1597079345-42801-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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
index f237ff8..9d94782 100644
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
1.8.3.1



