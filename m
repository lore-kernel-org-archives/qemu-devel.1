Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76542C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49205206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 02:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49205206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht0jT-0002Ww-J1
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 22:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ht0iv-00026y-Ui
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ht0iu-0003L8-Q5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:21:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:6289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1ht0iu-0003KG-Hn
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 22:21:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 19:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="191468188"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2019 19:21:41 -0700
Date: Thu, 1 Aug 2019 10:21:18 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190801022118.GA21992@richard>
References: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH] migration: always initial ram_counters for
 a new migration
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 01:36:32PM +0800, Ivan Ren wrote:
>From: Ivan Ren <ivanren@tencent.com>
>
>This patch fix a multifd migration bug in migration speed calculation, this
>problem can be reproduced as follows:
>1. start a vm and give a heavy memory write stress to prevent the vm be
>   successfully migrated to destination
>2. begin a migration with multifd
>3. migrate for a long time [actually, this can be measured by transferred bytes]
>4. migrate cancel
>5. begin a new migration with multifd, the migration will directly run into
>   migration_completion phase
>
>Reason as follows:
>
>Migration update bandwidth and s->threshold_size in function
>migration_update_counters after BUFFER_DELAY time:
>
>    current_bytes = migration_total_bytes(s);
>    transferred = current_bytes - s->iteration_initial_bytes;
>    time_spent = current_time - s->iteration_start_time;
>    bandwidth = (double)transferred / time_spent;
>    s->threshold_size = bandwidth * s->parameters.downtime_limit;
>
>In multifd migration, migration_total_bytes function return
>qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
>s->iteration_initial_bytes will be initialized to 0 at every new migration,
>but ram_counters is a global variable, and history migration data will be
>accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
>pending_size >= s->threshold_size become false in migration_iteration_run
>after the first migration_update_counters.
>
>Signed-off-by: Ivan Ren <ivanren@tencent.com>
>---
> migration/migration.c | 15 ++++++++++++++-
> migration/savevm.c    |  1 +
> 2 files changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/migration/migration.c b/migration/migration.c
>index 8a607fe1e2..d35a6ae6f9 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -1908,6 +1908,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>     }
> 
>     migrate_init(s);
>+    /*
>+     * set ram_counters memory to zero for a
>+     * new migration
>+     */
>+    memset(&ram_counters, 0, sizeof(ram_counters));
> 
>     return true;
> }
>@@ -3187,6 +3192,10 @@ static void *migration_thread(void *opaque)
> 
>     object_ref(OBJECT(s));
>     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>+    /*
>+     * Update s->iteration_initial_bytes to match s->iteration_start_time.
>+     */
>+    s->iteration_initial_bytes = migration_total_bytes(s);

Is this one necessary? We have sent out nothing yet.

> 
>     qemu_savevm_state_header(s->to_dst_file);
> 
>@@ -3252,7 +3261,11 @@ static void *migration_thread(void *opaque)
>              * breaking transferred_bytes and bandwidth calculation
>              */
>             s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>-            s->iteration_initial_bytes = 0;
>+            /*
>+             * Update s->iteration_initial_bytes to current size to
>+             * avoid historical data lead wrong bandwidth.
>+             */
>+            s->iteration_initial_bytes = migration_total_bytes(s);
>         }
> 
>         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>diff --git a/migration/savevm.c b/migration/savevm.c
>index 79ed44d475..480c511b19 100644
>--- a/migration/savevm.c
>+++ b/migration/savevm.c
>@@ -1424,6 +1424,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>     }
> 
>     migrate_init(ms);
>+    memset(&ram_counters, 0, sizeof(ram_counters));
>     ms->to_dst_file = f;
> 
>     qemu_mutex_unlock_iothread();
>-- 
>2.17.2 (Apple Git-113)
>

-- 
Wei Yang
Help you, Help me

