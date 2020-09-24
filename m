Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C99C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0923787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOJRgQHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0923787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNmt-0002wv-Gw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTe-0000no-4x
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTa-00061l-Qv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPGN14OSCMYNXNLG+fBRadBep+GNDOZx9iI5NmAfHvs=;
 b=MOJRgQHC7h4EWJ13ZNMxXzzGYJix0bPFSSVVJBiZz4MK9ng4IXm4lNXxlw7xTkNEmBvamL
 +BPvJJ9pVK/CxytYnAnP/Zn/pKFdo1GR0LLEaSQd+laJskQ34RHHgYqH7jcGeFSJVeGDEo
 QlIJrxA6m/olx8BxvhI3tKkA4gmB9X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-mHIOoTkkO8W8azg9YcAqUw-1; Thu, 24 Sep 2020 05:23:40 -0400
X-MC-Unique: mHIOoTkkO8W8azg9YcAqUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5281C104D3E4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 173B25576C
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/92] meson: extend libmpathpersist test for static linking
Date: Thu, 24 Sep 2020 05:22:13 -0400
Message-Id: <20200924092314.1722645-32-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

libmultipath has a dependency on libdevmapper, so
include it as well when static linking.  It seems that
the rabbit hole ends there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 86b6fe49c4..eff3fb0f72 100644
--- a/meson.build
+++ b/meson.build
@@ -302,14 +302,25 @@ if targetos == 'linux' and not get_option('mpath').disabled()
           mpath_lib_init(udev);
           return 0;
       }'''
-  libmultipath = cc.find_library('multipath',
-                                 required: get_option('mpath'),
-                                 static: enable_static)
-  libmpathpersist = cc.find_library('mpathpersist',
-                                    required: get_option('mpath'),
-                                    static: enable_static)
-  if libmultipath.found() and libmpathpersist.found() and libudev.found()
-    mpathlibs = [libmultipath, libmpathpersist, libudev]
+  mpathlibs = [libudev]
+  if enable_static
+    mpathlibs += cc.find_library('devmapper',
+                                   required: get_option('mpath'),
+                                   static: enable_static)
+  endif
+  mpathlibs += cc.find_library('multipath',
+                               required: get_option('mpath'),
+                               static: enable_static)
+  mpathlibs += cc.find_library('mpathpersist',
+                               required: get_option('mpath'),
+                               static: enable_static)
+  foreach lib: mpathlibs
+    if not lib.found()
+      mpathlibs = []
+      break
+    endif
+  endforeach
+  if mpathlibs.length() > 0
     if cc.links(mpath_test_source_new, dependencies: mpathlibs)
       mpathpersist = declare_dependency(dependencies: mpathlibs)
       mpathpersist_new_api = true
-- 
2.26.2



