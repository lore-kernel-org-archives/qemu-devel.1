Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA0AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8965F20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixwwi5L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8965F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3g5-0008In-OH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jw3fL-0007Ys-Sy
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:11:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jw3fJ-0000B1-Nj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594905068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=+UzqOgDd1heW1N0Fj4ypJlrpAiJcLdvsnjXrMdFWkHo=;
 b=ixwwi5L5VIph7t/HSR9vI3PTDuweYMdORbu2hwBoyypFAamwDAnKoLktDpct+2sBYpuGQ8
 1nE0a+aHt2VSVawG4rDRAJ+IZS4D5+IT8Xw31oCqeU5QHyaRFq4eWP9UQsE7grKK4cLgGx
 l9OKZNRTcg/cL6ims640QGrvwlX02ZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-67lDVYx-NFWpZnfTPmOw_Q-1; Thu, 16 Jul 2020 09:11:06 -0400
X-MC-Unique: 67lDVYx-NFWpZnfTPmOw_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FC919200E8;
 Thu, 16 Jul 2020 13:11:05 +0000 (UTC)
Received: from thuth.com (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7E819C4F;
 Thu, 16 Jul 2020 13:11:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH] configure: Fix atomic64 test for --enable-werror on macOS
Date: Thu, 16 Jul 2020 15:11:01 +0200
Message-Id: <20200716131101.18462-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using --enable-werror for the macOS builders in the Cirrus-CI,
the atomic64 test is currently failing, and config.log shows a bunch
of error messages like this:

 config-temp/qemu-conf.c:6:7: error: implicit declaration of function
 '__atomic_load_8' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
  y = __atomic_load_8(&x, 0);
      ^
 config-temp/qemu-conf.c:6:7: error: this function declaration is not a
 prototype [-Werror,-Wstrict-prototypes]

Suppress the warnings to make it pass.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Not sure whether this is the best way to fix this issue ... thus marked
 as RFC.
 Even though the compiler warns here, the program links apparently just
 fine afterwards and CONFIG_ATOMIC64=y gets set in the config-host.mak
 file on macOS, so the 64-bit atomic operations seem to be available...
 Any macOS users here who could shed some light on this?

 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index e93836aaae..4d50a07b00 100755
--- a/configure
+++ b/configure
@@ -5939,7 +5939,8 @@ int main(void)
   return 0;
 }
 EOF
-if compile_prog "" "" ; then
+if compile_prog "-Wno-implicit-function-declaration -Wno-strict-prototypes" "";
+then
   atomic64=yes
 fi
 
-- 
2.18.1


