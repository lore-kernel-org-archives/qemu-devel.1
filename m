Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A438C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293CB20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icC7ZRXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293CB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxVq-0005YU-8t
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juxUy-0004HQ-9A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juxUv-0008Bv-N3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594643033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=icC7ZRXaUxSJuFUDTdTwR5u6bvnM5LsxXg8gaBnwjdE+wGDvqH0P6L5Fg4xWQrm+WsV3JC
 6zOpKGOhDD4FPT1goEPLL/Od46ICXDCaFS+jR93YCLhtNAjKueJI1Na2O2QScRdApvKnNe
 sXPGfPfKCxkJs/2Fx6SyB2YCPSmQLsg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iqBj4hn-P-m9sLBlJ5Q4Cg-1; Mon, 13 Jul 2020 08:23:51 -0400
X-MC-Unique: iqBj4hn-P-m9sLBlJ5Q4Cg-1
Received: by mail-wr1-f70.google.com with SMTP id f5so17495609wrv.22
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfIb0WoSohr36CI5PC7CR58EVtgqFNPY3VFIqPoN2Bk=;
 b=kJutDq7XQUTi2PyCYNgbv+KCWWi2FkyhzM8rxmgXOJtbdxt+L3vezvN35F76jZb3oa
 g63SwFhP6rpv02DtiRzEZicHm1ucW7zH9i+mY1g2GWnvnkZY4S46dmRlWAZ8aJyjZGmi
 tI1EjuCceX8C/k8LYgVZQnR8j8IsXYyTysDNekKsXljxz8KC9vSpI3L2et388spoKI9e
 0EzNFvWBHUU+JbJ7OAj8wnS8JTzv2bhmxDxDmx8yUV4DnGsjmyMnZKwyhHjd7ZU8BqhG
 LSiCQCh5rw783yfHEHMyr0BuovP1HyOik5zrYtWOm9RWGKunuDyBnmOmYfMsYPOMDMUy
 IccA==
X-Gm-Message-State: AOAM5316h2oR51lPGoSYAShfFlYg5NNWV52pzw6GsXK22WA6dBlmFSk1
 R8YpFf2MSlOs446XbSZWbdhcmHcLdMFI9SBZSxA4j3itWhFXx/+tcJhW0MHwu+hyNUWUL8d+qSm
 CMtzG17VrplSvYyU=
X-Received: by 2002:adf:ea06:: with SMTP id q6mr76552859wrm.69.1594643030415; 
 Mon, 13 Jul 2020 05:23:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD8Tv1/8scnzYgunGpZl+J5+Kp/EUsoG1fyd1fvml44og4Jeik5MUjGN7kvbk4K5OKuMJ8kA==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr76552837wrm.69.1594643030238; 
 Mon, 13 Jul 2020 05:23:50 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id c25sm21124125wml.18.2020.07.13.05.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 05:23:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
Date: Mon, 13 Jul 2020 14:23:44 +0200
Message-Id: <20200713122345.9289-3-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713122345.9289-1-quintela@redhat.com>
References: <20200713122345.9289-1-quintela@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
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
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
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


