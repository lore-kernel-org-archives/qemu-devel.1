Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82783C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF8A2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R92H6Xmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF8A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOVu-0007BX-IU
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODi-0000TQ-3b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODg-0002p2-8e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8StGSzSvq32/9gAol6iL6H2HpzjgTv5zAb0M+ocs8Y=;
 b=R92H6XmkoCpAlG2zezLpPdW9azBTE1w9twpGsHCTfrx1pRNRH13M0SKceD+6418Z/LsaP1
 beXGaODXePuo9JAg10r+syiBt2aMUvoBqY6aJq8d9kP02zMkaV+shlGsMEpcNVhrXEXZyg
 ZdfnFAm8Hmwzi/lYxBR1BhR3YOSuhRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-bOMZV9m_M_KIEztx7Etdaw-1; Fri, 16 Oct 2020 07:48:20 -0400
X-MC-Unique: bOMZV9m_M_KIEztx7Etdaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9F1E8015B1;
 Fri, 16 Oct 2020 11:48:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5971B5C1D0;
 Fri, 16 Oct 2020 11:48:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/22] meson.build: don't condition iconv detection on library
 detection
Date: Fri, 16 Oct 2020 07:48:04 -0400
Message-Id: <20201016114814.1564523-13-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Yonggang Luo <lbrogers@suse.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bruce Rogers <brogers@suse.com>

It isn't necessarily the case that use of iconv requires an additional
library. For that reason we shouldn't conditionalize iconv detection on
libiconv.found.

Fixes: 5285e593c33 (configure: Fixes ncursesw detection under msys2/mingw by convert them to meson)

Signed-off-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Yonggang Luo<l <brogers@suse.com>uoyonggang@gmail.com>
Reviewed-by:Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201014221939.196958-1-brogers@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 0c0f4f9fd8..c1c45e9845 100644
--- a/meson.build
+++ b/meson.build
@@ -459,15 +459,13 @@ if not get_option('iconv').disabled()
   libiconv = cc.find_library('iconv',
                              required: false,
                              static: enable_static)
-  if libiconv.found()
-    if cc.links('''
-      #include <iconv.h>
-      int main(void) {
-        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
-        return conv != (iconv_t) -1;
-      }''', dependencies: [libiconv])
-      iconv = declare_dependency(dependencies: [libiconv])
-    endif
+  if cc.links('''
+    #include <iconv.h>
+    int main(void) {
+      iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
+      return conv != (iconv_t) -1;
+    }''', dependencies: [libiconv])
+    iconv = declare_dependency(dependencies: [libiconv])
   endif
 endif
 if get_option('iconv').enabled() and not iconv.found()
-- 
2.26.2



