Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1340C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6955720809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWFAU9Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6955720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ABX-0006VG-Im
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AA6-0004m7-Bs
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AA4-0004r6-5i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5NbTZAmm+WYBkXgq6rCd6kSo+mW8LZZy66ctqa9KBo=;
 b=SWFAU9Qle9DWaSxSxhW4Rw0+xf3buXnwtHvLyV6SCG+BBxG2HpA/TEsmdsdLO97fCcxtIP
 CfIPzkAuQZVLJlbVua5MMdnYQ7UxRtaey/EjSONf2j9jlz7m94EpS2RuDOMoqpA3LrkaFM
 5NVag2/wCqOvLUBWOPWgpOcMfRZKamw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-M3irSXQVMxyAj0FKcyUwdQ-1; Mon, 27 Jul 2020 16:55:48 -0400
X-MC-Unique: M3irSXQVMxyAj0FKcyUwdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B81E186A82A;
 Mon, 27 Jul 2020 20:55:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CFAA19D82;
 Mon, 27 Jul 2020 20:55:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] qcow2: Fix capitalization of header extension constant.
Date: Mon, 27 Jul 2020 15:55:20 -0500
Message-Id: <20200727205543.206624-2-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:qcow2" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Make the capitalization of the hexadecimal numbers consistent for the
QCOW2 header extension constants in docs/interop/qcow2.txt.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1594973699-781898-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qcow2.txt | 2 +-
 block/qcow2.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index cb723463f241..f072e27900e6 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -231,7 +231,7 @@ be stored. Each extension has a structure like the following:

     Byte  0 -  3:   Header extension type:
                         0x00000000 - End of the header extension area
-                        0xE2792ACA - Backing file format name string
+                        0xe2792aca - Backing file format name string
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
diff --git a/block/qcow2.c b/block/qcow2.c
index fadf3422f8c5..6ad6bdc166ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -66,7 +66,7 @@ typedef struct {
 } QEMU_PACKED QCowExtension;

 #define  QCOW2_EXT_MAGIC_END 0
-#define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
+#define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xe2792aca
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
-- 
2.27.0


