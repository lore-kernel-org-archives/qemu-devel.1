Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E4C433F1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8690E20791
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds6fGxyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8690E20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0ra-0001o1-Pt
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0qk-0000Y2-P3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0qj-0008Nr-2X
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594655916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=Ds6fGxypeEvmPXzJzhyZj0s/uHE/CRtJz2UckmmQ9nwP8JiKLQityH+UylrPPXqtFBIma8
 ikrmZ7EdTdid3EqVDhIRoGmFgrZ69jHCmwHDP/acitgsoUc5VVvAjHf4GoHEqSeteRS33I
 SK1PAkS9gSEQOzHhJJwFiiOFxPfNX7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-YjIe9dGrPGun1hwmcQLQNA-1; Mon, 13 Jul 2020 11:58:33 -0400
X-MC-Unique: YjIe9dGrPGun1hwmcQLQNA-1
Received: by mail-wr1-f70.google.com with SMTP id o12so17940952wrj.23
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=eqMeIieGsgBAM0gZoxOEcTKtoC9Tqs0iysly7ruL0uKyOCIhuLZheEnnqH+desF8XJ
 msRhLm4GyZAGwEZuBxnghN783bsIFhzx4xGSW5ORlTbCNmM7Qxyk3ly3iYONkGYiH4w5
 Vrpz78eiUBwO+n0DX8Cijpue0e6yCU6GwPlPswNYUl3azMfFCEQUHD2s96nSeKAgwtKw
 uaZdk4N1Bj6xXV3zs05VIU+1FNYlyIDLdyEgbW/o304vfsoT0KB2sY0B//6T3P6Tzo9I
 co+lHYiStcXPABJP5C+DUG5qgfBxzfjOzUckS19ggP1YGLJO/QNFffwEBIlX/1brNEMX
 MGlg==
X-Gm-Message-State: AOAM530A4Pytisrl/zKTtHkmJG3v8zzbo8ff4xx0lHHlYnHrCZqCOdK5
 VeRedLofBM4USGO2bgGUI5G3ahx63haEjimjbMcK46fI8nhVEebHfAzCIPMYMMwjSoqAsvo0iQZ
 CsUZ5+vfRwTx6Jvw=
X-Received: by 2002:adf:e908:: with SMTP id f8mr14499wrm.3.1594655912208;
 Mon, 13 Jul 2020 08:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNXxqqrcgO97UOuRrER8Upn6tGlILYBCjh2rRzabhqc6jPKUjS50FIurvJRtjVJqzBNf0t4A==
X-Received: by 2002:adf:e908:: with SMTP id f8mr14484wrm.3.1594655911974;
 Mon, 13 Jul 2020 08:58:31 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id f14sm27075926wro.90.2020.07.13.08.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 08:58:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
Date: Mon, 13 Jul 2020 17:58:26 +0200
Message-Id: <20200713155827.10670-3-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713155827.10670-1-quintela@redhat.com>
References: <20200713155827.10670-1-quintela@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, quintela@trasno.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Denis V. Lunev" <den@openvz.org>

qemu_fclose() could return error, f.e. if bdrv_co_flush() will return
the error.

This validation will become more important once we will start waiting of
asynchronous IO operations, started from bdrv_write_vmstate(), which are
coming soon.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6e01724605..45c9dd9d8a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2635,7 +2635,7 @@ int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
-    int ret = -1;
+    int ret = -1, ret2;
     QEMUFile *f;
     int saved_vm_running;
     uint64_t vm_state_size;
@@ -2719,10 +2719,14 @@ int save_snapshot(const char *name, Error **errp)
     }
     ret = qemu_savevm_state(f, errp);
     vm_state_size = qemu_ftell(f);
-    qemu_fclose(f);
+    ret2 = qemu_fclose(f);
     if (ret < 0) {
         goto the_end;
     }
+    if (ret2 < 0) {
+        ret = ret2;
+        goto the_end;
+    }
 
     /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
      * for itself.  BDRV_POLL_WHILE() does not support nested locking because
-- 
2.25.4


