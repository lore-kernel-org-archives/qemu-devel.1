Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AEC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604F5205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzVliYtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604F5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht6BD-0004Dv-JC
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 04:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1ht6Ah-0003nj-OL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1ht6Ag-0006Bq-68
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:10:47 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1ht6Af-0006B3-WA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:10:46 -0400
Received: by mail-io1-xd42.google.com with SMTP id h6so17199053iom.7
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LEbZ3U87Fz4s3zCQUlQJ1Yb3TVozv0tUTPqcwYsHvHM=;
 b=lzVliYtcYIV5m60q9rLTVFNmEqv7hBHOeE5dwcGfkoWIVqRHH8ie5AiYt+1r81KxA6
 rAkf+rY6YoUwWU0SHGRwtZ+B2aRgxFD0/IsGiNWeumZl73QFvovTnPdSe+TPURB8Z+Qz
 Yeo+WE+Q8P18V2Be6F2SlQy1uLvFhfhuwTphArcmSCWVqSoVgPhntcQpDTq0bbs1R1T3
 7ojYqaZyq5WxBYXgZW1ivTXNxbFrzUX6YjHOqbGoovFSb5IuQapki1Lhe1IOVL28Qx31
 QDE+we7k7aiqm2H0LvyZeHLvZXYfG6bEdIDh2H3NOtC5hKFK3ki+/cyaUC06gQNfOfd9
 dQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEbZ3U87Fz4s3zCQUlQJ1Yb3TVozv0tUTPqcwYsHvHM=;
 b=IwdGHdDTtKwKw1ofUcHJWyWmEm7mlK7q6mcVCb93JmzTjrdSKNoiGnBw7NOdkPsxKG
 wKaTfUA9jAsR3SGopTcR/8VqnH3UQ9A3lv8v5dFzz44evXewvuqUpUnAXLnu3552g+nA
 hCvuudocn450Pm7+MVD4CHrJvmgZAfFayOjTEhfx+bV2P7K7Xq/dY+DpfL2udKUyH5T5
 WxgvNeWXsYu3gDLRLZmOs5yzs3W4pbgkfQ+5rpr+IWrW2dJHYgRmLknKYt4SOaSNg9GZ
 Qa4vy+nj7n3Bk50JABrcGyN59kPgOt6aAZIsQ9/vQZ7ixKEowP37d+owvIkjkXxKomtL
 FbpA==
X-Gm-Message-State: APjAAAXrHZ8zPuqsid8lC6/nyuuaJEl1rYS/hxm+P1jM1/JqvQNWA/Ol
 JBznaz1U6L9LIT1fcdxAtpQ4I/BGlfkqAZzZji5mTJEx
X-Google-Smtp-Source: APXvYqwAM+2PO+Uj/MJMLWfYstjIIMeortBs/sHURbSosuPOqYVCpX6F9fuVYvaNFkcAg0H//lNpAdR20VmsPSQyrMo=
X-Received: by 2002:a02:a1c7:: with SMTP id o7mr135123544jah.26.1564647045103; 
 Thu, 01 Aug 2019 01:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
 <20190801022118.GA21992@richard>
In-Reply-To: <20190801022118.GA21992@richard>
From: Ivan Ren <renyime@gmail.com>
Date: Thu, 1 Aug 2019 16:10:34 +0800
Message-ID: <CA+6E1==Dc5Zac3Q-tt2V2pbq-DofW=AZX6tP1RoDBp4KSNxiKw@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>+    /*
>>+     * Update s->iteration_initial_bytes to match
s->iteration_start_time.
>>+     */
>>+    s->iteration_initial_bytes = migration_total_bytes(s);
>
>Is this one necessary? We have sent out nothing yet.

Yes, currently nothing has been sent yet at this point.

Is that better to always match the update of iteration_initial_bytes
and iteration_start_time in a explicit way to avoid some potential missing?

Thanks.

On Thu, Aug 1, 2019 at 10:21 AM Wei Yang <richardw.yang@linux.intel.com>
wrote:

> On Tue, Jul 30, 2019 at 01:36:32PM +0800, Ivan Ren wrote:
> >From: Ivan Ren <ivanren@tencent.com>
> >
> >This patch fix a multifd migration bug in migration speed calculation,
> this
> >problem can be reproduced as follows:
> >1. start a vm and give a heavy memory write stress to prevent the vm be
> >   successfully migrated to destination
> >2. begin a migration with multifd
> >3. migrate for a long time [actually, this can be measured by transferred
> bytes]
> >4. migrate cancel
> >5. begin a new migration with multifd, the migration will directly run
> into
> >   migration_completion phase
> >
> >Reason as follows:
> >
> >Migration update bandwidth and s->threshold_size in function
> >migration_update_counters after BUFFER_DELAY time:
> >
> >    current_bytes = migration_total_bytes(s);
> >    transferred = current_bytes - s->iteration_initial_bytes;
> >    time_spent = current_time - s->iteration_start_time;
> >    bandwidth = (double)transferred / time_spent;
> >    s->threshold_size = bandwidth * s->parameters.downtime_limit;
> >
> >In multifd migration, migration_total_bytes function return
> >qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
> >s->iteration_initial_bytes will be initialized to 0 at every new
> migration,
> >but ram_counters is a global variable, and history migration data will be
> >accumulated. So if the ram_counters.multifd_bytes is big enough, it may
> lead
> >pending_size >= s->threshold_size become false in migration_iteration_run
> >after the first migration_update_counters.
> >
> >Signed-off-by: Ivan Ren <ivanren@tencent.com>
> >---
> > migration/migration.c | 15 ++++++++++++++-
> > migration/savevm.c    |  1 +
> > 2 files changed, 15 insertions(+), 1 deletion(-)
> >
> >diff --git a/migration/migration.c b/migration/migration.c
> >index 8a607fe1e2..d35a6ae6f9 100644
> >--- a/migration/migration.c
> >+++ b/migration/migration.c
> >@@ -1908,6 +1908,11 @@ static bool migrate_prepare(MigrationState *s,
> bool blk, bool blk_inc,
> >     }
> >
> >     migrate_init(s);
> >+    /*
> >+     * set ram_counters memory to zero for a
> >+     * new migration
> >+     */
> >+    memset(&ram_counters, 0, sizeof(ram_counters));
> >
> >     return true;
> > }
> >@@ -3187,6 +3192,10 @@ static void *migration_thread(void *opaque)
> >
> >     object_ref(OBJECT(s));
> >     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >+    /*
> >+     * Update s->iteration_initial_bytes to match
> s->iteration_start_time.
> >+     */
> >+    s->iteration_initial_bytes = migration_total_bytes(s);
>
> Is this one necessary? We have sent out nothing yet.
>
> >
> >     qemu_savevm_state_header(s->to_dst_file);
> >
> >@@ -3252,7 +3261,11 @@ static void *migration_thread(void *opaque)
> >              * breaking transferred_bytes and bandwidth calculation
> >              */
> >             s->iteration_start_time =
> qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >-            s->iteration_initial_bytes = 0;
> >+            /*
> >+             * Update s->iteration_initial_bytes to current size to
> >+             * avoid historical data lead wrong bandwidth.
> >+             */
> >+            s->iteration_initial_bytes = migration_total_bytes(s);
> >         }
> >
> >         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >diff --git a/migration/savevm.c b/migration/savevm.c
> >index 79ed44d475..480c511b19 100644
> >--- a/migration/savevm.c
> >+++ b/migration/savevm.c
> >@@ -1424,6 +1424,7 @@ static int qemu_savevm_state(QEMUFile *f, Error
> **errp)
> >     }
> >
> >     migrate_init(ms);
> >+    memset(&ram_counters, 0, sizeof(ram_counters));
> >     ms->to_dst_file = f;
> >
> >     qemu_mutex_unlock_iothread();
> >--
> >2.17.2 (Apple Git-113)
> >
>
> --
> Wei Yang
> Help you, Help me
>
