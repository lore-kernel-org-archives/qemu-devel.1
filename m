Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8756D20734
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLlBlDfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8756D20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZjJ-0000iY-Je
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOH-0003iE-AT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOF-0001r2-9B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxCDe5YbJ92Z6Vq7n4mmb7lS89YUzHq/6dTh//AJbho=;
 b=hLlBlDfGJwzhT5c5nCxBtE+i2xsp4qHzRa8vFUWGZygQndTjfYaiziTyLWUSh6xX0ZnlIn
 UnqOaBxNWu3m+4IjffvhnFQ1Cbh5d2E3kTNIbL+SjGoh/rVuBjqbDmfq5UDVfg+EIVJd6N
 zwM4kF6qzZlzQK690Q77j92CyERMwgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-5wOCv53TNAiBd7tyX5GZBQ-1; Wed, 17 Jun 2020 10:50:08 -0400
X-MC-Unique: 5wOCv53TNAiBd7tyX5GZBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC43100CCC9;
 Wed, 17 Jun 2020 14:50:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C860F7CAA0;
 Wed, 17 Jun 2020 14:50:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 37/43] block: lift blocksize property limit to 2 MiB
Date: Wed, 17 Jun 2020 16:49:03 +0200
Message-Id: <20200617144909.192176-38-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Logical and physical block sizes in QEMU are limited to 32 KiB.

This appears unnecessarily tight, and we've seen bigger block sizes
handy at times.

Lift the limitation up to 2 MiB which appears to be good enough for
everybody, and matches the qcow2 cluster size limit.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528225516.1676602-9-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 63d48db70c..ead35d7ffd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -784,9 +784,12 @@ const PropertyInfo qdev_prop_size32 = {
 /* lower limit is sector size */
 #define MIN_BLOCK_SIZE          512
 #define MIN_BLOCK_SIZE_STR      "512 B"
-/* upper limit is the max power of 2 that fits in uint16_t */
-#define MAX_BLOCK_SIZE          (32 * KiB)
-#define MAX_BLOCK_SIZE_STR      "32 KiB"
+/*
+ * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
+ * matches qcow2 cluster size limit
+ */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
 
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
-- 
2.25.4


