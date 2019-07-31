Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD2C32750
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 00:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316E820665
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 00:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316E820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hscSm-0002qG-FN
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 20:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hscS3-0001yY-Qd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 20:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hscS2-0006Pn-Ii
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 20:26:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:40440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hscS2-0006Mw-9d
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 20:26:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jul 2019 17:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; d="scan'208";a="162912187"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 30 Jul 2019 17:26:39 -0700
Date: Wed, 31 Jul 2019 08:26:15 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190731002615.GA26871@richard>
References: <1564464816-21804-1-git-send-email-ivanren@tencent.com>
 <1564464816-21804-3-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564464816-21804-3-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v3 2/3] migration: add speed limit for
 multifd migration
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
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 01:33:35PM +0800, Ivan Ren wrote:
>From: Ivan Ren <ivanren@tencent.com>
>
>Limit the speed of multifd migration through common speed limitation
>qemu file.
>
>Signed-off-by: Ivan Ren <ivanren@tencent.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> migration/ram.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/migration/ram.c b/migration/ram.c
>index 889148dd84..88ddd2bbe2 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -922,7 +922,7 @@ struct {
>  * false.
>  */
> 
>-static int multifd_send_pages(void)
>+static int multifd_send_pages(RAMState *rs)
> {
>     int i;
>     static int next_channel;
>@@ -954,6 +954,7 @@ static int multifd_send_pages(void)
>     multifd_send_state->pages = p->pages;
>     p->pages = pages;
>     transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;
>+    qemu_file_update_transfer(rs->f, transferred);
>     ram_counters.multifd_bytes += transferred;
>     ram_counters.transferred += transferred;;
>     qemu_mutex_unlock(&p->mutex);
>@@ -962,7 +963,7 @@ static int multifd_send_pages(void)
>     return 1;
> }
> 
>-static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>+static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
> {
>     MultiFDPages_t *pages = multifd_send_state->pages;
> 
>@@ -981,12 +982,12 @@ static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>         }
>     }
> 
>-    if (multifd_send_pages() < 0) {
>+    if (multifd_send_pages(rs) < 0) {
>         return -1;
>     }
> 
>     if (pages->block != block) {
>-        return  multifd_queue_page(block, offset);
>+        return  multifd_queue_page(rs, block, offset);
>     }
> 
>     return 1;
>@@ -1054,7 +1055,7 @@ void multifd_save_cleanup(void)
>     multifd_send_state = NULL;
> }
> 
>-static void multifd_send_sync_main(void)
>+static void multifd_send_sync_main(RAMState *rs)
> {
>     int i;
> 
>@@ -1062,7 +1063,7 @@ static void multifd_send_sync_main(void)
>         return;
>     }
>     if (multifd_send_state->pages->used) {
>-        if (multifd_send_pages() < 0) {
>+        if (multifd_send_pages(rs) < 0) {
>             error_report("%s: multifd_send_pages fail", __func__);
>             return;
>         }
>@@ -1083,6 +1084,7 @@ static void multifd_send_sync_main(void)
>         p->packet_num = multifd_send_state->packet_num++;
>         p->flags |= MULTIFD_FLAG_SYNC;
>         p->pending_job++;
>+        qemu_file_update_transfer(rs->f, p->packet_len);
>         qemu_mutex_unlock(&p->mutex);
>         qemu_sem_post(&p->sem);
>     }
>@@ -2079,7 +2081,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
> static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
>                                  ram_addr_t offset)
> {
>-    if (multifd_queue_page(block, offset) < 0) {
>+    if (multifd_queue_page(rs, block, offset) < 0) {
>         return -1;
>     }
>     ram_counters.normal++;
>@@ -3482,7 +3484,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
>     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
> 
>-    multifd_send_sync_main();
>+    multifd_send_sync_main(*rsp);
>     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>     qemu_fflush(f);
> 
>@@ -3570,7 +3572,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> 
> out:
>-    multifd_send_sync_main();
>+    multifd_send_sync_main(rs);
>     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>     qemu_fflush(f);
>     ram_counters.transferred += 8;
>@@ -3629,7 +3631,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> 
>     rcu_read_unlock();
> 
>-    multifd_send_sync_main();
>+    multifd_send_sync_main(rs);
>     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>     qemu_fflush(f);
> 
>-- 
>2.17.2 (Apple Git-113)
>

-- 
Wei Yang
Help you, Help me

