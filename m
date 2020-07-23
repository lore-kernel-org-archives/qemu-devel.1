Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E22FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEA120709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtCXdq6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEA120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybJm-00050C-AX
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHr-0003Kj-QF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jybHo-0005PV-5k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3X7RJpzUMPF8J+wdkMnhsqm3/0vtWeM8YRC6/Q+/O3E=;
 b=FtCXdq6DSutXnjdgIH9Z3PKO84j6wLqbjRD4YcM5lPkVuZl3F4sUAFiivKL2po+llUsFFM
 E5aVuyRLZpDUKHuhyyBLpnQuBrMpKk5yfeXUGmAanblf9JxCQBsfxxF8g7SIbobMTWPK98
 0++qxYfUCUThqOC2nmNd6/nOTXVrkNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-B1yugL9gP_OgJH_uaqwYoA-1; Thu, 23 Jul 2020 09:29:21 -0400
X-MC-Unique: B1yugL9gP_OgJH_uaqwYoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C2A057;
 Thu, 23 Jul 2020 13:29:20 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE6B85D9D3;
 Thu, 23 Jul 2020 13:29:18 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] trace: Example of non-tracing recorder use
Date: Thu, 23 Jul 2020 15:29:03 +0200
Message-Id: <20200723132903.1980743-3-dinechin@redhat.com>
In-Reply-To: <20200723132903.1980743-1-dinechin@redhat.com>
References: <20200723132903.1980743-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is a simple example showing how the recorder can be used to
have one "topic" covering multiple entries. Here, the topic is "lock",
the idea being to have the latest lock changes for instance in case of
a crash or hang.

Here are a few use cases:

* Tracing  lock updates:
    RECORDER_TRACES=lock qemu
* Showing lock changes prior to a hang
    RECORDER_TRACES=lock qemu &
    # Wait until hang
    killall -USR2 qemu  # This will trigger a dump
* Graphic visualization of lock states:
    RECORDER_TRACES="lock=state,id" qemu &
    recorder_scope state
    # Hit the 't' key to toggle timing display
    # Hit the 'c' key to dump the screen data as CSV
    cat recorder_scope_data-1.csv

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 util/qemu-thread-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
index 2af6b12085..0de07a471f 100644
--- a/util/qemu-thread-common.h
+++ b/util/qemu-thread-common.h
@@ -15,6 +15,9 @@
 
 #include "qemu/thread.h"
 #include "trace.h"
+#include "trace/recorder.h"
+
+RECORDER_DEFINE(lock, 16, "Lock state");
 
 static inline void qemu_mutex_post_init(QemuMutex *mutex)
 {
@@ -23,12 +26,14 @@ static inline void qemu_mutex_post_init(QemuMutex *mutex)
     mutex->line = 0;
 #endif
     mutex->initialized = true;
+    record(lock, "Init state %d for %p", -1, mutex);
 }
 
 static inline void qemu_mutex_pre_lock(QemuMutex *mutex,
                                        const char *file, int line)
 {
     trace_qemu_mutex_lock(mutex, file, line);
+    record(lock, "Locking state %d for %p", 1, mutex);
 }
 
 static inline void qemu_mutex_post_lock(QemuMutex *mutex,
@@ -39,6 +44,7 @@ static inline void qemu_mutex_post_lock(QemuMutex *mutex,
     mutex->line = line;
 #endif
     trace_qemu_mutex_locked(mutex, file, line);
+    record(lock, "Locked state %d for %p", 2, mutex);
 }
 
 static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
@@ -49,6 +55,7 @@ static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
     mutex->line = 0;
 #endif
     trace_qemu_mutex_unlock(mutex, file, line);
+    record(lock, "Unkocked state %d for %p", 0, mutex);
 }
 
 #endif
-- 
2.26.2


