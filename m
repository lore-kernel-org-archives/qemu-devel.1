Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE25020829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC9PSkZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXX5R-0003gV-Ol
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX05-0006eI-JQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX03-0000h7-P0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603835966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4Wf+TSoUJ38Te4pzDCzvNjpiiOfgwoki4sys+5iq7E=;
 b=OC9PSkZ8Z0dvSLbNH8jvGIlee3DO0DlhTtXUxzpQBnjy2MPgrtTN0Y8yp9Mj50z46sm8sa
 soa50y/hNsHz1TM74b2wjMZ2eFnu7ELgy7BLSjO/nHTz7UiEnZRU9FotEzGTS4NEJFny3P
 0l8p1uMbAMB5K/VYtPLR12+QLkKwud4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-GErkVhIoO2KLb11HL7NXZg-1; Tue, 27 Oct 2020 17:59:24 -0400
X-MC-Unique: GErkVhIoO2KLb11HL7NXZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6668C809DDA;
 Tue, 27 Oct 2020 21:59:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A69F910013DB;
 Tue, 27 Oct 2020 21:59:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] nbd: Utilize QAPI_CLONE for type conversion
Date: Tue, 27 Oct 2020 16:59:07 -0500
Message-Id: <20201027215914.619460-6-eblake@redhat.com>
In-Reply-To: <20201027215914.619460-1-eblake@redhat.com>
References: <20201027215914.619460-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 17:59:21
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than open-coding the translation from the deprecated
NbdServerAddOptions type to the preferred BlockExportOptionsNbd, it's
better to utilize QAPI_CLONE_MEMBERS.  This solves a couple of issues:
first, if we do any more refactoring of the base type (which an
upcoming patch plans to do), we don't have to revisit the open-coding.
Second, our assignment to arg->name is fishy: the generated QAPI code
for qapi_free_NbdServerAddOptions does not visit arg->name if
arg->has_name is false, but if it DID visit it, we would have
introduced a double-free situation when arg is finally freed.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201027050556.269064-4-eblake@redhat.com>
---
 blockdev-nbd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 8174023e5c47..cee9134b12eb 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,6 +14,8 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-block-export.h"
 #include "qapi/qapi-commands-block-export.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
@@ -195,7 +197,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
      * the device name as a default here for compatibility.
      */
     if (!arg->has_name) {
-        arg->name = arg->device;
+        arg->has_name = true;
+        arg->name = g_strdup(arg->device);
     }

     export_opts = g_new(BlockExportOptions, 1);
@@ -205,15 +208,9 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
         .node_name              = g_strdup(bdrv_get_node_name(bs)),
         .has_writable           = arg->has_writable,
         .writable               = arg->writable,
-        .u.nbd = {
-            .has_name           = true,
-            .name               = g_strdup(arg->name),
-            .has_description    = arg->has_description,
-            .description        = g_strdup(arg->description),
-            .has_bitmap         = arg->has_bitmap,
-            .bitmap             = g_strdup(arg->bitmap),
-        },
     };
+    QAPI_CLONE_MEMBERS(BlockExportOptionsNbd, &export_opts->u.nbd,
+                       qapi_NbdServerAddOptions_base(arg));

     /*
      * nbd-server-add doesn't complain when a read-only device should be
-- 
2.29.0


