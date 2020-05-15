Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75DB20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAFzGzjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75DB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaDl-0003un-3H
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjf-0003qR-BY
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjd-0002Uc-Jr
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrAIxJcjh5A8J6Ib5EEpUk0UGIpNUfO0ZmICznK/aY8=;
 b=EAFzGzjpwLEvnpkgzw8Bq+OCt6YgeXnYWn3+//lsQyZar0GI61DA5643TUIkPVqR1bv3Mv
 1sabmA5vQ5vQYSBtP7/VnGoKHWjgmNq7yi9ihYSDLnsXEk1CeC1Ed+4AP9lD5DAPq6yNBG
 ehsjk84gBsxkxuUiy29j4IH/JdUe9ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-cDxvFGNsN7iIoRS3RfisCw-1; Fri, 15 May 2020 08:46:38 -0400
X-MC-Unique: cDxvFGNsN7iIoRS3RfisCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 256DE474;
 Fri, 15 May 2020 12:46:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C2AB2E024;
 Fri, 15 May 2020 12:46:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 48/51] block/block-copy: Simplify block_copy_do_copy()
Date: Fri, 15 May 2020 14:45:18 +0200
Message-Id: <20200515124521.335403-49-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

block_copy_do_copy() is static, only used in block_copy_task_entry
with the error_is_read argument set. No need to check for it,
simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200507121129.29760-3-philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-copy.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7c7f7acbae..bb8d0569f2 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -343,9 +343,7 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
                                     ~BDRV_REQ_WRITE_COMPRESSED);
         if (ret < 0) {
             trace_block_copy_write_zeroes_fail(s, offset, ret);
-            if (error_is_read) {
-                *error_is_read = false;
-            }
+            *error_is_read = false;
         }
         return ret;
     }
@@ -393,9 +391,7 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
     ret = bdrv_co_pread(s->source, offset, nbytes, bounce_buffer, 0);
     if (ret < 0) {
         trace_block_copy_read_fail(s, offset, ret);
-        if (error_is_read) {
-            *error_is_read = true;
-        }
+        *error_is_read = true;
         goto out;
     }
 
@@ -403,9 +399,7 @@ static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
                          s->write_flags);
     if (ret < 0) {
         trace_block_copy_write_fail(s, offset, ret);
-        if (error_is_read) {
-            *error_is_read = false;
-        }
+        *error_is_read = false;
         goto out;
     }
 
-- 
2.25.4


