Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2D5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433DB20781
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnXmklVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433DB20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2qh0-0008Nk-BT
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qdZ-0005BT-P9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qdX-0004Gr-KJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596523282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRmK6ldNQwrGyYExzTCRXxv7OxTu8BmMdV6vfrmJHAI=;
 b=YnXmklVoaayEnsWQyhAaMzJvZ3qA7vMIx3S6/E5mkEOpuDjyHLKsdTdD/4SrvHmSfBCcuA
 oWWjlGTc3TVukE2kFmf+2BaB6VD05wWal4XX5QDj4hyv9xoeKsnyWF0NV+zfir+IZkl8iB
 uXrIzUF67+pGMs5H6rfBH2lkMq1xa+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-P6gCVlKfNZyU0CBontyIeg-1; Tue, 04 Aug 2020 02:41:18 -0400
X-MC-Unique: P6gCVlKfNZyU0CBontyIeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3391719253C2;
 Tue,  4 Aug 2020 06:41:17 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-166.pek2.redhat.com
 [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 713E560BF4;
 Tue,  4 Aug 2020 06:41:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 1/2] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
Date: Tue,  4 Aug 2020 14:41:09 +0800
Message-Id: <1596523270-5492-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
References: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

s->iothread is checked for NULL on object creation in colo_compare_complete,
so it's guaranteed not to be NULL.
This resolves a false alert from Coverity (CID 1429969).

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index cc15f23..2c20de1 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
         qemu_chr_fe_deinit(&s->chr_notify_dev, false);
     }
 
-    if (s->iothread) {
-        colo_compare_timer_del(s);
-    }
+    colo_compare_timer_del(s);
 
     qemu_bh_delete(s->event_bh);
 
@@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
         g_hash_table_destroy(s->connection_track_table);
     }
 
-    if (s->iothread) {
-        object_unref(OBJECT(s->iothread));
-    }
+    object_unref(OBJECT(s->iothread));
 
     g_free(s->pri_indev);
     g_free(s->sec_indev);
-- 
2.7.4


