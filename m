Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065EFC2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5796E21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuJeVA2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5796E21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO1r-00015D-ES
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU9-00020h-65
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU7-0006A6-8U
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYD3ca9nKAPeS67sQ64Xwoz3V+LQEik3mZArxHhunnU=;
 b=MuJeVA2p/2L1+rKUZkNO2Av8jhPVCLjiuJJDLMmX74XXBDT2/efR51erdwe1+zKViwHCFC
 UxNzxaUXO1Ltvn8LzoBtaAn7s9HZqjxWH9ElCioYQj/Q6B1hKjgotfJZs1YJ/8C0kvc5XY
 Z1XWIKCqWehZfkUEEMFEoDGn1yqtmQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-VJM2flinNBusWbiB7EqsTg-1; Thu, 24 Sep 2020 05:24:10 -0400
X-MC-Unique: VJM2flinNBusWbiB7EqsTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF441007464
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1C626198C;
 Thu, 24 Sep 2020 09:24:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 65/92] char: fix logging when chardev write fails
Date: Thu, 24 Sep 2020 05:22:47 -0400
Message-Id: <20200924092314.1722645-66-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 6b85099c03..78553125d3 100644
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



