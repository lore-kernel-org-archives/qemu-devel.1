Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99986C433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5E22065E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuGzD9p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5E22065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Hg-0001e1-Py
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv1Fh-00008a-Aw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:24:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv1Fe-0003Bm-9C
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594657458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=AuGzD9p74CklMtLPTA/0K5n8zcb73rOBefCAqz0dl3YYTjWRO3BOU7TJZYVyBNMEP8fefs
 Vb/nx4ueCnc6U9hSgO/ya7k9Ao0Ts6Z+HTusjdHNqScDr2hbm/QAcUr8zIGKbvsCuDaotU
 pP7u9hUHII9V3B0NgiDmfohux66sqQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-9Lj3PjDoNMKmVrQ81NBzWA-1; Mon, 13 Jul 2020 12:24:17 -0400
X-MC-Unique: 9Lj3PjDoNMKmVrQ81NBzWA-1
Received: by mail-wm1-f72.google.com with SMTP id c124so75348wme.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=dabUQ7FYw6NjG1+v/A5LmBENnF7bjciGq5xvsOF8hIbzlG59MoudgpOxtES/BUoZMt
 3wXw6nLxmhearUxHSuNKbo+vXfKJOK2b/B33q5EDmB3LSMlwIlhvqe5fJmSUkBdl48JC
 9gp3dr2yuP2mOukrFBKJLYRmOU+voLOj6rB0Y2DKhcA4kiMSmZsgY1yAZIRFPl+Mta/N
 43S3HB5T4E2FgWDUvHqDGipJN6L/Pg6OfPCaqpqkbqkBWIbWa4JcsdN3oS+WzK/vfSdi
 5Y1bNMrexWB7zWeU+K+G6NmoQx6yyflbBwrTbuDcvFpsWI+8LWET2+J1XlkvoLfLttuc
 4/vw==
X-Gm-Message-State: AOAM531AzmhK7eYM/vQrNWkuR+M1JcX9CP3ZKX0TQ56m9ltc8HpYbBYw
 vRK070hhOm5DtVf3SutrWaA7ENvq2DQQ2KoZJzGD0cT+RP1aax5Fqt8Ad98KWNb5lXzV07ZdUka
 1qTpg8S6gVzZ6I/c=
X-Received: by 2002:adf:f34e:: with SMTP id e14mr105240wrp.299.1594657456147; 
 Mon, 13 Jul 2020 09:24:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSlrhKWVoCLF6tFLsTt5zcpG7y3hBnMGxp/7hsM6fDML95BUHkMregMTet+ZCwLnYL63yQ1A==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr105126wrp.299.1594657455015; 
 Mon, 13 Jul 2020 09:24:15 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id y7sm24170187wrt.11.2020.07.13.09.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 09:24:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
Date: Mon, 13 Jul 2020 18:24:09 +0200
Message-Id: <20200713162410.11577-3-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713162410.11577-1-quintela@redhat.com>
References: <20200713162410.11577-1-quintela@redhat.com>
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


