Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F222076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdVUyTYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F222076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlnI-0002K8-Mf
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHlll-0001ES-Bd
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHlli-0001XY-Bp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600079484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fle0bSrXP9esjMoswH7JR0vVF4fePVd2FffhvZ0/LD0=;
 b=fdVUyTYkJib7qk/NygLOvufatdh/FAuhRuEnz51ageTsA0GY+HCNa8RmG30uFOLCjkBJ5N
 VHAJ0fEWRuXryp7tw5ft9hwicY/ESoH6VZKeYqIOBHclXSNeQ9SpbStBxvT7IQ6w7sL+wP
 7KQSPOB3a+IUQxhADyZf3qVGX3tnV7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-CKjzUam8NZOqznT-nRBBIg-1; Mon, 14 Sep 2020 06:31:20 -0400
X-MC-Unique: CKjzUam8NZOqznT-nRBBIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7061008567
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 10:31:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-99.ams2.redhat.com
 [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38001100EBC0;
 Mon, 14 Sep 2020 10:31:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] char: fix logging when chardev write fails
Date: Mon, 14 Sep 2020 11:31:09 +0100
Message-Id: <20200914103109.1327875-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu_chr_write_buffer() method sends data to the chardev backend for
writing, and then also writes to the log file. In case the chardev
backend only writes part of the data buffer, we need to make sure we
only log the same subset. qemu_chr_write_buffer() will be invoked again
later to write the rest of the buffer.

In the case the chardev backend returns an error though, no further
attempts to likely to be made to write the data. We must therefore write
the entire buffer to the log immediately.

An example where this is important is with the socket backend. This will
return -1 for all writes if no client is currently connected. We still
wish to write data to the log file when no client is present though.
This used to work because the chardev would return "len" to pretend it
had written all data when no client is connected, but this changed to
return an error in

  commit 271094474b65de1ad7aaf729938de3d9b9d0d36f
  Author: Dima Stepanov <dimastep@yandex-team.ru>
  Date: Thu May 28 12:11:18 2020 +0300

    char-socket: return -1 in case of disconnect during tcp_chr_write

and this broke the logging, resulting in all data being discarded when
no client is present.

Fixes: https://bugs.launchpad.net/qemu/+bug/1893691
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..e30cd025f5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -138,7 +138,20 @@ static int qemu_chr_write_buffer(Chardev *s,
         }
     }
     if (*offset > 0) {
+        /*
+         * If some data was written by backend, we should
+         * only log what was actually written. This method
+         * may be invoked again to write the remaining
+         * method, thus we'll log the remainder at that time.
+         */
         qemu_chr_write_log(s, buf, *offset);
+    } else if (res < 0) {
+        /*
+         * If a fatal error was reported by the backend,
+         * assume this method won't be invoked again with
+         * this buffer, so log it all right away.
+         */
+        qemu_chr_write_log(s, buf, len);
     }
     qemu_mutex_unlock(&s->chr_write_lock);
 
-- 
2.26.2


