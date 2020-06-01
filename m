Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17184C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8887206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0+Ucr8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8887206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpNh-0000fP-26
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMO-0007KY-Bl
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMN-0000Ru-JZ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZ7A3P+PwIYLctkAyC7UJgyIv7xUHiwVdokylR25WsU=;
 b=P0+Ucr8TsCoYSQDP+N7fGm6HOcBtS8oBb9/3S6PimOYKkgp4yBWM1oEv+8hn4qquaw5Tgo
 ZnijqCkGJ2MFtjBOvRgzoj8MV5G0JeDxBnp7Ui/2kja1L7VBxA45hXHgcgfkvDRY4vwEZ6
 sJwAsEZVSNjLdVbcyL4kctYQoz/YQqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-DsewDDCIP8CR9g65TeXVyQ-1; Mon, 01 Jun 2020 14:40:28 -0400
X-MC-Unique: DsewDDCIP8CR9g65TeXVyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 726DE107B7D1;
 Mon,  1 Jun 2020 18:40:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE3DC1001281;
 Mon,  1 Jun 2020 18:40:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] migration/colo.c: Use cpu_synchronize_all_states()
Date: Mon,  1 Jun 2020 19:40:00 +0100
Message-Id: <20200601184004.272784-9-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

cpu_synchronize_all_pre_loadvm() marks all vcpus as dirty, so the
registers are loaded from CPUState before we continue running
the vm. However if we failover during checkpoint, CPUState is not
initialized and the registers are loaded with garbage. This causes
guest hangs and crashes.

Fix this by using cpu_synchronize_all_states(), which initializes
CPUState from the current cpu registers additionally to marking
the vcpus as dirty.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Message-Id: <9675031ce557b73ebd10e7bd20ebbf57f30b177c.1589193382.git.lukasstraub2@web.de>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index fe0d6e93e5..d00b3b9d6b 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -705,7 +705,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     }
 
     qemu_mutex_lock_iothread();
-    cpu_synchronize_all_pre_loadvm();
+    cpu_synchronize_all_states();
     ret = qemu_loadvm_state_main(mis->from_src_file, mis);
     qemu_mutex_unlock_iothread();
 
-- 
2.26.2


