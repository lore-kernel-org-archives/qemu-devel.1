Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C9C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3232168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpJztbHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3232168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEGr-0002mw-IR
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kQEFu-0002IQ-KT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kQEFr-0000OD-PM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602095613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iuBPqxcsv0aTQ0rcLgkKxT6k78kO6ea209eSJdeHNsw=;
 b=QpJztbHiiNM1xFmI41ObH33j+AZgBf/B2BwF3tlNcGwLwIPlC97uGjg9BS6QvL0eCNRVqY
 3/RrnOq/3jqfAWR2QtwYIwzHSxKL5X2WbLO3LGOIvVwDgb1y/gcKPUhylaIeod0C8pAuku
 vCp7gIuSud0gPtknhmtxD8qmOlI2s+Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Ha_E2Zg4P-uJwMCfTL3pHA-1; Wed, 07 Oct 2020 14:33:32 -0400
X-MC-Unique: Ha_E2Zg4P-uJwMCfTL3pHA-1
Received: by mail-qv1-f69.google.com with SMTP id h12so1954621qvk.22
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 11:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iuBPqxcsv0aTQ0rcLgkKxT6k78kO6ea209eSJdeHNsw=;
 b=pwnvt+KYgkCQNYEfb0+662yk33535rwNU8aJ+pXBLTXMx23NNTFaLNTJ+m5Hz7tUKZ
 8LHvnZFHC7lz3OqVxP2rNEBWL+sKm0m0LhtRa4qLiaDvU1ahUgsFWIFewjI3tL50kJhO
 FS2HeIJVNHUyirlGlB5lSyKEw+gCKi6qlh0iS0SKxYSsqId0oH6Iccmr+oU/Jst+ADol
 IMkr+ECZJS9kBKz+uAWV3hC7/7prhiKeqXDkm9VScUYvppY2P/H2qCb075zr8T/kDuRD
 wXPRwuwFOaiwDTSBqkIDQbJ3xHxyfrFx0i71xWUTtLCUcJXvCUqQegr5cNpNmEgWosWl
 VjHA==
X-Gm-Message-State: AOAM530LkN8CPoCNI1N99d9x2qQJwSdIJhukUOYyQfEOR9dmSTu+LcPg
 MkWBnB/nokOPYFQFPwnoVyqi8+ArMBvGcwWExW007H2ZKNsOBGUkr+tRsdqit/SA4XmCHxPuTQJ
 vm1/M+fPz78Nd1fA=
X-Received: by 2002:ac8:6047:: with SMTP id k7mr4720601qtm.60.1602095608408;
 Wed, 07 Oct 2020 11:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLQd3LS9nzREe4DOgey+hzA8BMSKQKHWH0D51vX5vjt5qFY4u6ji4LJOMrEQiD4caJiPqRCA==
X-Received: by 2002:ac8:6047:: with SMTP id k7mr4720561qtm.60.1602095607863;
 Wed, 07 Oct 2020 11:33:27 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id o4sm2040873qkk.75.2020.10.07.11.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 11:33:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration/postcopy: Release fd before going into
 'postcopy-pause'
Date: Wed,  7 Oct 2020 14:33:24 -0400
Message-Id: <20201007183324.288379-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Logically below race could trigger with the old code:

          test program                        migration thread
          ------------                        ----------------
       wait_until('postcopy-pause')
                                          postcopy_pause()
                                            set_state('postcopy-pause')
       do_postcopy_recover()
         arm s->to_dst_file with new fd
                                            release s->to_dst_file [1]

Here [1] could have released the just-installed recoverying channel.  Then the
migration could hang without really resuming.

Instead, it should be very safe to release the fd before setting the state into
'postcopy-pause', because there's no reason for any other thread to touch it
during 'postcopy-active'.

Dave reported a very rare postcopy recovery hang that the migration-test
program waited for the migration to complete in migrate_postcopy_complete().
We do suspect it's the same thing that we're gonna fix here.  Hard to tell.
However since we've noticed this, fix this irrelevant of the hang report.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index aca7fdcd0b..e1b06e8a2a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3137,9 +3137,6 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
 
-        migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_POSTCOPY_PAUSED);
-
         /* Current channel is possibly broken. Release it. */
         assert(s->to_dst_file);
         qemu_mutex_lock(&s->qemu_file_lock);
@@ -3150,6 +3147,9 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_POSTCOPY_PAUSED);
+
         error_report("Detected IO failure for postcopy. "
                      "Migration paused.");
 
-- 
2.26.2


