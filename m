Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43154C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8132231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjysXKac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8132231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbpG-0000Z6-Qv
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbml-0006JS-Ob
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbmk-0000ND-0e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttpmKTxQQcEtHaAyvXiR2xFw0gTSBa9jIX3xX1Z03z8=;
 b=GjysXKacvf6YAmkiyrSWKQpqJlZzvH0mAn+0JeR+C7tGazN4M72+rPTJv1Wbqbpa6qhiah
 Ba1STXZajQWc8kt67rZvMZmk0zMeDRRFZzEZpobmHYGF2ZME5TrN059IFkVsw9Yx3Szr6B
 FIx2aHt42yG6Uuiw+4Y+AbjwfSp5OdY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-BBgSD1XYMEqAfKcO_52H4Q-1; Mon, 02 Nov 2020 10:30:15 -0500
X-MC-Unique: BBgSD1XYMEqAfKcO_52H4Q-1
Received: by mail-qk1-f200.google.com with SMTP id v134so8889154qka.19
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttpmKTxQQcEtHaAyvXiR2xFw0gTSBa9jIX3xX1Z03z8=;
 b=flTEX6a58gB/bQ/qMCcp/owKwLD7WRSEG8JDVjQ7AogDX/suTArb5xFIcfLWmgJY3Y
 z/CAqj9uRSFlrMnfrbm4na/wgUIsG8p58CDkuOT1i0aZ1MiX+Mf0uTGopRD85GISriaf
 PoTG89GGiefsrxU5qdvNT8UQRnr9ZFrTZVZ36wv9iIO/xI1Uh2w8YfKvqexaQ+GSfPPs
 4HJmhhpjjmvcAt1N9fPfzuh2Omray6n0xANS5yJ9XJHLBtPLG33LXq65AlFj3mNZgpQP
 CFlQA/FBxvgfl7gUgBALf3Bip2vwyCYRa7rKxlJXz4haH15VN6WOoiSNBABmFE7VBDvC
 30xA==
X-Gm-Message-State: AOAM532uk97w5lu6RDmkTaSpU7RTpjulrlbMjwlrnN1hfn6pR1X1Ldx4
 Du3LL+XdMUYbeegn11SwdRb0r6bgpLTQmLn8XfubDgPVkFXwSPYJHmFNVqsET6kj8ez8UOsaMKm
 ZjWmSu4RD+mOuFV0=
X-Received: by 2002:ac8:74c:: with SMTP id k12mr14338454qth.32.1604331014325; 
 Mon, 02 Nov 2020 07:30:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQajPollHF16WrpLl+C50sKj80ASpJ0SClVELCsd6u/u6Pd0FhntKH5bZR+zmHVhSjjOXm5A==
X-Received: by 2002:ac8:74c:: with SMTP id k12mr14338436qth.32.1604331014047; 
 Mon, 02 Nov 2020 07:30:14 -0800 (PST)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id z125sm5936184qke.54.2020.11.02.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:30:13 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] migration: Unify reset of last_rb on destination node
 when recover
Date: Mon,  2 Nov 2020 10:30:09 -0500
Message-Id: <20201102153010.11979-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102153010.11979-1-peterx@redhat.com>
References: <20201102153010.11979-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When postcopy recover happens, we need to reset last_rb after each return of
postcopy_pause_fault_thread() because that means we just got the postcopy
migration continued.

Unify this reset to the place right before we want to kick the fault thread
again, when we get the command MIG_CMD_POSTCOPY_RESUME from source.

This is actually more than that - because the main thread on destination will
now be able to call migrate_send_rp_req_pages_pending() too, so the fault
thread is not the only user of last_rb now.  Move the reset earlier will allow
the first call to migrate_send_rp_req_pages_pending() to use the reset value
even if called from the main thread.

(NOTE: this is not a real fix to 0c26781c09 mentioned below, however it is just
 a mark that when picking up 0c26781c09 we'd better have this one too; the real
 fix will come later)

Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 2 --
 migration/savevm.c       | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d3bb3a744b..d99842eb1b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -903,7 +903,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * the channel is rebuilt.
              */
             if (postcopy_pause_fault_thread(mis)) {
-                mis->last_rb = NULL;
                 /* Continue to read the userfaultfd */
             } else {
                 error_report("%s: paused but don't allow to continue",
@@ -985,7 +984,6 @@ retry:
                 /* May be network failure, try to wait for recovery */
                 if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
                     /* We got reconnected somehow, try to continue */
-                    mis->last_rb = NULL;
                     goto retry;
                 } else {
                     /* This is a unavoidable fault */
diff --git a/migration/savevm.c b/migration/savevm.c
index 21ccba9fb3..e8834991ec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2061,6 +2061,12 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         return 0;
     }
 
+    /*
+     * Reset the last_rb before we resend any page req to source again, since
+     * the source should have it reset already.
+     */
+    mis->last_rb = NULL;
+
     /*
      * This means source VM is ready to resume the postcopy migration.
      * It's time to switch state and release the fault thread to
-- 
2.26.2


