Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711A320578
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROis712G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711A320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwz8-00057q-LC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvwtH-0006QW-MM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:57:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvwtF-0000Oe-71
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594879023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=qy1awPH/MCCgirWvJrYoJ8OYOu/U9msSfaqyM5IX5po=;
 b=ROis712GH4L/PEnZRb1Up7CQAFBRILYsBLG0m7IpnOp/oyev0HwvOgcEgeWCsEyymp3lcu
 88gWsPjRpytwXIbVLuJKCQMSaOoPXO8BP405+E/4LylNKZDYKNsOChUAl2FF4S/X1EZdBd
 4edddJkk0N0ToCps/4mBKQbMylrg2l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-BNgs00wkMBiuwgYKVJj_sg-1; Thu, 16 Jul 2020 01:57:01 -0400
X-MC-Unique: BNgs00wkMBiuwgYKVJj_sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0956418A1DED;
 Thu, 16 Jul 2020 05:57:00 +0000 (UTC)
Received: from thuth.com (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED87B2B6DC;
 Thu, 16 Jul 2020 05:56:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix for running with --enable-werror on macOS
Date: Thu, 16 Jul 2020 07:56:55 +0200
Message-Id: <20200716055655.24507-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The configure script currently refuses to succeed when run on macOS
with --enable-werror:

 ERROR: configure test passed without -Werror but failed with -Werror.

The information in config.log indicates:

 config-temp/qemu-conf.c:3:55: error: control reaches end of non-void
 function [-Werror,-Wreturn-type]
 static void *f(void *p) { pthread_setname_np("QEMU"); }
                                                      ^
And indeed, the return statement is missing here.

Fixes: 479a57475e ("util: Implement debug-threads for macOS")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: There is another issue with --enable-werror on macOS, with the
       atomic64, which I haven't quite figured out yet, so compiling
       with --enable-werror is still not working there.

 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index b751c853f5..e93836aaae 100755
--- a/configure
+++ b/configure
@@ -4198,7 +4198,7 @@ pthread_setname_np_wo_tid=no
 cat > $TMPC << EOF
 #include <pthread.h>
 
-static void *f(void *p) { pthread_setname_np("QEMU"); }
+static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
 int main(void)
 {
     pthread_t thread;
-- 
2.18.1


