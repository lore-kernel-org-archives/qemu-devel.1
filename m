Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033E8212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsdXqzUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033E8212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlczf-0008RP-7W
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwq-0003vn-TD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwp-0008BF-8Q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dd7PfU60ZH2AcRhRnv1bLgRZ5bOsNrGcQr6j2cs2djg=;
 b=XsdXqzUfuxhvQDBvA8nBwY1A+F4BIXvRPkRdjvG2gykgCLbHB5Ub4+cd59riE1maYFL/xE
 dpHSvtBFtvWb3IWm+HypDy1XFNryzGRWUre4Inf+Rvn6dZo/kMTWXfFOxP2ImD/L8s1xmO
 egVVVS0aUJrXWyyPyTahhw/GTdw110o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-qtme5ml6Pqy0Zwgo01QQnQ-1; Wed, 17 Jun 2020 14:38:03 -0400
X-MC-Unique: qtme5ml6Pqy0Zwgo01QQnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3272107ACCD;
 Wed, 17 Jun 2020 18:38:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D65635EE0E;
 Wed, 17 Jun 2020 18:37:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 07/12] monitor/hmp-cmds: don't silently output when running
 'migrate_set_downtime' fails
Date: Wed, 17 Jun 2020 19:37:28 +0100
Message-Id: <20200617183733.186168-8-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Although 'migrate_set_downtime' has been deprecated and replaced
with 'migrate_set_parameter downtime_limit', it has not been
completely eliminated, possibly due to compatibility with older
versions. I think as long as this old parameter is running, we
should report appropriate message when something goes wrong, not
be silent.

before:
(qemu) migrate_set_downtime -1
(qemu)

after:
(qemu) migrate_set_downtime -1
Error: Parameter 'downtime_limit' expects an integer in the range of 0 to 2000 seconds

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200603080904.997083-5-maozhongyi@cmss.chinamobile.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/hmp-cmds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 2c630ec88d..a704b3469a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1189,8 +1189,11 @@ void hmp_migrate_pause(Monitor *mon, const QDict *qdict)
 /* Kept for backwards compatibility */
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict)
 {
+    Error *err = NULL;
+
     double value = qdict_get_double(qdict, "value");
-    qmp_migrate_set_downtime(value, NULL);
+    qmp_migrate_set_downtime(value, &err);
+    hmp_handle_error(mon, err);
 }
 
 void hmp_migrate_set_cache_size(Monitor *mon, const QDict *qdict)
-- 
2.26.2


