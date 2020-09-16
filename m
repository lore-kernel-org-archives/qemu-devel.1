Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112FEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A085B22208
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+nmXlrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A085B22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVzH-00053B-NQ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVuy-00079X-Ne
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVuw-0008CF-Sh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vPgTP1quLTioamb771udJU8nvol8XHvL3zkTO1QRjM=;
 b=S+nmXlrJS6NTR+JAxNBBSLbCLi9WekWK/5cIp2pG+cxS5K1U2LI8OgjM0Iqey1UpJbl1yM
 0IQz/MkwGzgNQol+Dds2nsCJvYGQRxtk0tL3gzH8FmLkTyDIy48J5RGYLHVHnKg/Ai87ZF
 e5HNXnPkVpWWWTXDXm6+thxWX99KTrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-516U39qQMQOZWp_jd3AeTw-1; Wed, 16 Sep 2020 07:48:03 -0400
X-MC-Unique: 516U39qQMQOZWp_jd3AeTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E13356BFB;
 Wed, 16 Sep 2020 11:48:02 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 693555DE4A;
 Wed, 16 Sep 2020 11:48:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/24] tests: Fixes test-io-channel-socket.c tests under
 msys2/mingw
Date: Wed, 16 Sep 2020 13:47:25 +0200
Message-Id: <20200916114731.102080-19-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Currently test-io-channel-socket doesn't init with
qemu_init_main_loop
and that's cause the qemu_aio_context not inited,
and the following is the stack when null pointer accessed:

qemu_fd_register (c:\work\xemu\qemu\util\main-loop.c:336)
qemu_try_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:224)
qemu_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:230)
socket_can_bind_connect (c:\work\xemu\qemu\tests\socket-helpers.c:93)
socket_check_protocol_support (c:\work\xemu\qemu\tests\socket-helpers.c:141)
main (c:\work\xemu\qemu\tests\test-io-channel-socket.c:568)
__tmainCRTStartup (@__tmainCRTStartup:142)
mainCRTStartup (@1400014f6..140001539:3)
BaseThreadInitThunk (@BaseThreadInitThunk:9)
RtlUserThreadStart (@RtlUserThreadStart:12)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200915121318.247-18-luoyonggang@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-io-channel-socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index d43083a766..743577d744 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -25,6 +25,7 @@
 #include "socket-helpers.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 
 
 static void test_io_channel_set_socket_bufs(QIOChannel *src,
@@ -556,6 +557,7 @@ int main(int argc, char **argv)
     bool has_ipv4, has_ipv6;
 
     module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
     socket_init();
 
     g_test_init(&argc, &argv, NULL);
-- 
2.18.2


