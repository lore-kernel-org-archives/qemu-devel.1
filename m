Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A0FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBEB208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUD/bFn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBEB208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlWJQ-0003MU-5E
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jlWIY-0002Y4-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:32:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jlWIV-0001ID-12
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592393519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mW5lgnVH430AFxF+uNuE8NXPJ763+5rhCUne925yUkU=;
 b=dUD/bFn/dZjMrQp+79XYOWzXB6LxS0HzRKakrVRATi2KITD2y4GrVeL1v2sxG9qw+u+v5Q
 Y/3NWLWhScoiQCwYg1FWrXNBYfoIkrpnjpUg1KQSkq3oJ44TZjM/4MaAooXXkXYwdYngaH
 WZ2YmJhuAnN/QXHu9rkA4eyftiYQfyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-wVA8V_7KPICWRC84qqM6yA-1; Wed, 17 Jun 2020 07:31:58 -0400
X-MC-Unique: wVA8V_7KPICWRC84qqM6yA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A1810AB64B
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:31:57 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-71.ams2.redhat.com [10.36.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4296660BF4;
 Wed, 17 Jun 2020 11:31:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: fix multifd_send_pages() next channel
Date: Wed, 17 Jun 2020 13:31:54 +0200
Message-Id: <20200617113154.593233-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

multifd_send_pages() loops around the available channels,
the next channel to use between two calls to multifd_send_pages() is stored
inside a local static variable, next_channel.

It works well, except if the number of channels decreases between two calls
to multifd_send_pages(). In this case, the loop can try to access the
data of a channel that doesn't exist anymore.

The problem can be triggered if we start a migration with a given number of
channels and then we cancel the migration to restart it with a lower number.
This ends generally with an error like:
qemu-system-ppc64: .../util/qemu-thread-posix.c:77: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

This patch fixes the error by capping next_channel with the current number
of channels before using it.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/multifd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 5a3e4d0d46d1..d0441202aae9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -415,6 +415,12 @@ static int multifd_send_pages(QEMUFile *f)
     }
 
     qemu_sem_wait(&multifd_send_state->channels_ready);
+    /*
+     * next_channel can remain from a previous migration that was
+     * using more channels, so ensure it doesn't overflow if the
+     * limit is lower now.
+     */
+    next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         p = &multifd_send_state->params[i];
 
-- 
2.26.2


