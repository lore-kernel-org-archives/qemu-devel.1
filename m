Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2531C221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggiy/vbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2531C221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZyo-0001TG-3R
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQZxg-0000FE-VM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQZxd-0002cz-OS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ij3cIGhFZH+mzCSLTiimg8xRHBG+dGy13W0N2g9yF8A=;
 b=Ggiy/vbL9NwEKHk6RBXRMJSGojBwrwSAp+IQPlIDbwn+ZBsJnY6E321lRT6XVpMUoZo6P4
 CFZGDzT9TNDkDe5gGrW3XwCI711q/KVR4hgAWGqArkldCveyGC7NxpOuafY0TZfy7+a2CQ
 d/+aOBCtyVHqlHvY9ONPuqAan4og9n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-JnDzu5n1O7SAyt2vkVdzUw-1; Thu, 08 Oct 2020 13:44:04 -0400
X-MC-Unique: JnDzu5n1O7SAyt2vkVdzUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B48D1084C9B
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 17:44:03 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-212.ams2.redhat.com
 [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8604455785;
 Thu,  8 Oct 2020 17:44:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	thuth@redhat.com
Subject: [PATCH] mingw: Fix builds on f33 mingw
Date: Thu,  8 Oct 2020 18:43:59 +0100
Message-Id: <20201008174359.157627-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fedora 33's mingw moans about:

In file included from ../tests/test-bitmap.c:12:
/home/dgilbert/git/migpull/include/qemu/osdep.h:76: error: "__USE_MINGW_ANSI_STDIO" redefined [-Werror]
   76 | #define __USE_MINGW_ANSI_STDIO 1
      |

the fix is to make sure osdep.h is the first include - which is our
rule anyway; but one we broke in a couple of places.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 2 +-
 tests/test-bitmap.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index ab9e1301f6..42b71e771e 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -10,8 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include <zlib.h>
 #include "qemu/osdep.h"
+#include <zlib.h>
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/config-file.h"
diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 2f5b71458a..c3c9d79667 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -8,8 +8,8 @@
  * Author: Peter Xu <peterx@redhat.com>
  */
 
-#include <stdlib.h>
 #include "qemu/osdep.h"
+#include <stdlib.h>
 #include "qemu/bitmap.h"
 
 #define BMAP_SIZE  1024
-- 
2.28.0


