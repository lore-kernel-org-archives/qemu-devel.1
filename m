Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16194C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D626F20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PR+yR1z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D626F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTnI-0000XQ-0W
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA9-0001Ou-5f
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA7-0001M4-EU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmnoTWG/btVuCmK6Ik7UOefkyk2LvbJKaqZOS4PyRXs=;
 b=PR+yR1z9rI5aRgWY3iXHvj+6OJQHRFcRvQrMgvrHppoc2WsvrNMa7rste+jMkuvJRQhM1y
 az+zWgguE2ey+sZBImrC7cWD25Spf4zzIkwQwGXFfSbk5fxopUEn8I/wpV6cNPICqI3kbc
 k48IrDSfeaAwzpQWKzFvehqCMECrNWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-EpW8h2KiOeujYIFYA0AugA-1; Thu, 11 Jun 2020 15:46:52 -0400
X-MC-Unique: EpW8h2KiOeujYIFYA0AugA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9777C1940920;
 Thu, 11 Jun 2020 19:46:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD1560E3E;
 Thu, 11 Jun 2020 19:46:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 076/115] util/oslib: Returns the real thread identifier on
 FreeBSD and NetBSD
Date: Thu, 11 Jun 2020 15:44:10 -0400
Message-Id: <20200611194449.31468-77-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Carlier <devnexen@gmail.com>

getpid is good enough in a mono thread context, however thr_self/_lwp_self
reflects the real current thread identifier from a given process.

Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..916f1be224 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -48,11 +48,13 @@
 #ifdef __FreeBSD__
 #include <sys/sysctl.h>
 #include <sys/user.h>
+#include <sys/thr.h>
 #include <libutil.h>
 #endif
 
 #ifdef __NetBSD__
 #include <sys/sysctl.h>
+#include <lwp.h>
 #endif
 
 #include "qemu/mmap-alloc.h"
@@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
     return syscall(SYS_gettid);
+#elif defined(__FreeBSD__)
+    /* thread id is up to INT_MAX */
+    long tid;
+    thr_self(&tid);
+    return (int)tid;
+#elif defined(__NetBSD__)
+    return _lwp_self();
 #else
     return getpid();
 #endif
-- 
2.26.2



