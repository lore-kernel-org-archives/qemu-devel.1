Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15903C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4702206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDlQ6Fm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4702206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorg8-0007T1-0r
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorT7-00006l-9R
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorT5-0007MA-JY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593189886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THjSHFXW5OWYQXUjbOgTZCQR9lPztYkWqZ/Y57Uc3s8=;
 b=NDlQ6Fm1dnszwt0dgCneIpqFaLNXGLY6kAK6WrFkewOr7aP1OpG/HJlXF0i9Xmo+9lOWH+
 FbeALTopmPjYAO5cXahFfWDUyvj5+iBi2knc9jkSVliB1B+GNWvYpIsExc4E38igEUTRpa
 9I1n8JgysLx9QOIGxjfBhZtwdtjlrb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-p7x5DZ_xPSSBFUlrg42wsg-1; Fri, 26 Jun 2020 12:44:45 -0400
X-MC-Unique: p7x5DZ_xPSSBFUlrg42wsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AFA805EEF;
 Fri, 26 Jun 2020 16:44:44 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA1D1757A;
 Fri, 26 Jun 2020 16:44:15 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] REMOVE: Instrumentation to show the module functions
 being replaced
Date: Fri, 26 Jun 2020 18:43:07 +0200
Message-Id: <20200626164307.3327380-11-dinechin@redhat.com>
In-Reply-To: <20200626164307.3327380-1-dinechin@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 include/qemu/module.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 1922a0293c..8d6e10ba81 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -14,10 +14,13 @@
 #ifndef QEMU_MODULE_H
 #define QEMU_MODULE_H
 
+#include "trace/recorder.h"
 
 #define DSO_STAMP_FUN         glue(qemu_stamp, CONFIG_STAMP)
 #define DSO_STAMP_FUN_STR     stringify(DSO_STAMP_FUN)
 
+RECORDER_DECLARE(modules);
+
 #ifdef BUILD_DSO
 void DSO_STAMP_FUN(void);
 /* This is a dummy symbol to identify a loaded DSO as a QEMU module, so we can
@@ -55,6 +58,7 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
     static void __attribute__((constructor)) Name##_register(void)      \
     {                                                                   \
         Name = Name##_implementation;                                   \
+        record(modules, "Setting " #Name " to %p", Name);               \
     }                                                                   \
     Ret Name##_implementation Args
 #else /* !CONFIG_MODULES */
-- 
2.26.2


