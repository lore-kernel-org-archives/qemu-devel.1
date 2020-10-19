Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F740C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE16122200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afe/1H3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE16122200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUe7T-0000UO-JH
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5w-00079p-MR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5u-0005cx-Us
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603148254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5HFQfdM4TJN4VGII06GowLAi2up3lb9QwDK/dU70iw=;
 b=Afe/1H3+KGSmP8Fhbyrc2Hn9xU+osGPkewu+uT7jybk6tS3NUjkMlyuzwSGie3hGG4IJaU
 3N9jknRfVf29YiRU27tbX1QOTUQCQ4XllOFPTNFo3X4SZy04KfXodD+/ZqAix5dMp95oZM
 8AkA+Bk9ia7DGYaKqarER62Spap+dBc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-_0hkHQUNMhWfvAPFDrrk8A-1; Mon, 19 Oct 2020 18:57:32 -0400
X-MC-Unique: _0hkHQUNMhWfvAPFDrrk8A-1
Received: by mail-io1-f71.google.com with SMTP id x13so1339695iom.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D5HFQfdM4TJN4VGII06GowLAi2up3lb9QwDK/dU70iw=;
 b=Ep+qfYhMtuIBt4zrgD44D5fRDkhx3LLzdIFrroX7h5+MjbWER3tfLhtg6mQANn6U7/
 B/LEvNij3Bw9uESdHATD7I/noh5uUxmJhndEDyghpAJPA7sZaWlY9DNY8nb4zpgbGrxF
 XI945oZ8UFpXplUPe3yDiV7kt0SbgMksj9f6qOS6c5omUnvhSd/Qzb86mhFAZKPYSlN6
 lAeRPhx6ijD6Xcl5bXBfp8wRCGYwvefAQl8YtICCxgFGsWMM2t+dsDlK0GUSs1Os9DX+
 A2xtnkUHIynfuf6M4cbtm/Zmrs48CwlrzfQU8BSUBPZcLF/yBfTR/Msms4vXYNNd1fkU
 KxUw==
X-Gm-Message-State: AOAM532SgqTskQH5dve1LQZIhrrnhH7XgsgN9EqGTOP2OXH9DDHnn2GE
 wX9NQCOMi+vvGOPir5XcBHj96zQLw9vmQZB0Rt3mYQi59pLAfq+6lVYWRTDtZOlLgG1wCpa/95R
 ZykUMPFl/wq4B7Yo=
X-Received: by 2002:a92:d709:: with SMTP id m9mr2053137iln.226.1603148251634; 
 Mon, 19 Oct 2020 15:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrHKKdgocksKmW88BekSWF8FxFlKMkfhuGqm4kBj2vERLcVumo9AMK0xXE8x9yBFi7IoPJ8A==
X-Received: by 2002:a92:d709:: with SMTP id m9mr2053121iln.226.1603148251321; 
 Mon, 19 Oct 2020 15:57:31 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z89sm6017ilk.4.2020.10.19.15.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 15:57:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/6] migration/postcopy: Release fd before going into
 'postcopy-pause'
Date: Mon, 19 Oct 2020 18:57:19 -0400
Message-Id: <20201019225720.172743-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019225720.172743-1-peterx@redhat.com>
References: <20201019225720.172743-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
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
index 0b4fcff01f..50df6251b7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3182,9 +3182,6 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
 
-        migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_POSTCOPY_PAUSED);
-
         /* Current channel is possibly broken. Release it. */
         assert(s->to_dst_file);
         qemu_mutex_lock(&s->qemu_file_lock);
@@ -3195,6 +3192,9 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_POSTCOPY_PAUSED);
+
         error_report("Detected IO failure for postcopy. "
                      "Migration paused.");
 
-- 
2.26.2


