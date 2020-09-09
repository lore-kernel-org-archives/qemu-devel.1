Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0CF21919
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5sHTGnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0CF21919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1nR-0004iB-E9
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1ld-000178-B0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lb-0003m2-J0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMQlAf73YBYMHwrfbPfHm01yXpYu/jGVGq8w5VKBK4I=;
 b=f5sHTGnh8uAipsDM97I0bkyJXuhFBa3W6+on9ISEum8rVieztOO/hoSUhnuDuJzXCAptXi
 N22SAvt6WyYMrlZ0VLSQq8iSKlfBjUPj9WOJDp7gLiXZnsJr5l/k229SIdVz2+fFn2QrUD
 qewD0Cubp0F3NBPQKyaM95wQ5V+u/lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-TRcUdzysNOenqlt_o2q-Kw-1; Wed, 09 Sep 2020 11:12:08 -0400
X-MC-Unique: TRcUdzysNOenqlt_o2q-Kw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868BD1DDFD;
 Wed,  9 Sep 2020 15:12:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00C8A60C07;
 Wed,  9 Sep 2020 15:12:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 05/13] qmp: Assert that no other monitor is active
Date: Wed,  9 Sep 2020 17:11:41 +0200
Message-Id: <20200909151149.490589-6-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

monitor_qmp_dispatch() is never supposed to be called in the context of
another monitor, so assert that monitor_cur() is NULL instead of saving
and restoring it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/qmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index bb2d9d0cc7..8469970c69 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -140,8 +140,11 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
     QDict *error;
 
     old_mon = monitor_set_cur(&mon->common);
+    assert(old_mon == NULL);
+
     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
-    monitor_set_cur(old_mon);
+
+    monitor_set_cur(NULL);
 
     if (mon->commands == &qmp_cap_negotiation_commands) {
         error = qdict_get_qdict(rsp, "error");
-- 
2.25.4


