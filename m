Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF20BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9564C2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUIcJnPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9564C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTTV-0004Ls-Dn
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSQ-00030U-Gw
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSP-0004Os-PB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7oQeOM8Kdsn0XUvEPNvMseBYmeY7bj+MG39Jv5gXhM=;
 b=KUIcJnPqhYsm7OoDWMHOwT0qcfKMhuxrSwXQ+noYn7OxYwbFT+u9Z61VCDLGlTU/IV3+El
 OUwHjTTRkkm919vvwxwYDI3TQ5Mg6AvL7WdKtuHgJOyJzj6vMdyXh61arAxOuWv8L1WsPt
 fho/bda3y2JIQr+4wM5edE+PkSni1ZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-4u83NeV5OYuqzkGSeGAefQ-1; Fri, 15 May 2020 02:04:26 -0400
X-MC-Unique: 4u83NeV5OYuqzkGSeGAefQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D3F80183C
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2A915EE0E;
 Fri, 15 May 2020 06:04:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29D0111358BD; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] qom: Clearer reference counting in
 object_initialize_childv()
Date: Fri, 15 May 2020 08:04:04 +0200
Message-Id: <20200515060424.18993-2-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200505152926.18877-2-armbru@redhat.com>
---
 qom/object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index be700e831f..5511649502 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -571,18 +571,18 @@ void object_initialize_childv(Object *parentobj, const char *propname,
         }
     }
 
+out:
     /*
-     * Since object_property_add_child added a reference to the child object,
-     * we can drop the reference added by object_initialize(), so the child
-     * property will own the only reference to the object.
+     * We want @obj's reference to be 1 on success, 0 on failure.
+     * On success, it's 2: one taken by object_initialize(), and one
+     * by object_property_add_child().
+     * On failure in object_initialize() or earlier, it's 1.
+     * On failure afterwards, it's also 1: object_unparent() releases
+     * the reference taken by object_property_add_child().
      */
     object_unref(obj);
 
-out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(obj);
-    }
+    error_propagate(errp, local_err);
 }
 
 static inline bool object_property_is_child(ObjectProperty *prop)
-- 
2.21.1


