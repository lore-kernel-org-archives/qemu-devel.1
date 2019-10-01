Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC6C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D44920700
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D44920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEKQ-0008M4-Gu
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEIO-0006dw-RM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEIN-00057b-Ii
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:18:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:3300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iFEIN-00056L-Al
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:18:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 02:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; d="scan'208";a="366272833"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 01 Oct 2019 02:18:07 -0700
Date: Tue, 1 Oct 2019 17:17:49 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: use migration_is_active to
 represent active state
Message-ID: <20191001091749.GA14044@richard>
References: <20190717005341.14140-1-richardw.yang@linux.intel.com>
 <20190913235433.u66jqdhx4afnqae5@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913235433.u66jqdhx4afnqae5@master>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 11:54:33PM +0000, Wei Yang wrote:
>On Wed, Jul 17, 2019 at 08:53:41AM +0800, Wei Yang wrote:
>>Wrap the check into a function to make it easy to read.
>>
>
>Hi, Dave & Juan
>
>Do you like this one :-) ?
>

Sorry for ping again.

>>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>---
>> include/migration/misc.h |  1 +
>> migration/migration.c    | 12 ++++++++----
>> 2 files changed, 9 insertions(+), 4 deletions(-)
>>
>>diff --git a/include/migration/misc.h b/include/migration/misc.h
>>index 5cdbabd094..42d6abc920 100644
>>--- a/include/migration/misc.h
>>+++ b/include/migration/misc.h
>>@@ -61,6 +61,7 @@ void migration_object_init(void);
>> void migration_shutdown(void);
>> void qemu_start_incoming_migration(const char *uri, Error **errp);
>> bool migration_is_idle(void);
>>+bool migration_is_active(MigrationState *);
>> void add_migration_state_change_notifier(Notifier *notify);
>> void remove_migration_state_change_notifier(Notifier *notify);
>> bool migration_in_setup(MigrationState *);
>>diff --git a/migration/migration.c b/migration/migration.c
>>index 43fd8297ef..4c066fc85c 100644
>>--- a/migration/migration.c
>>+++ b/migration/migration.c
>>@@ -1529,8 +1529,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>>         qemu_fclose(tmp);
>>     }
>> 
>>-    assert((s->state != MIGRATION_STATUS_ACTIVE) &&
>>-           (s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE));
>>+    assert(!migration_is_active(s));
>> 
>>     if (s->state == MIGRATION_STATUS_CANCELLING) {
>>         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>>@@ -1690,6 +1689,12 @@ bool migration_is_idle(void)
>>     return false;
>> }
>> 
>>+bool migration_is_active(MigrationState *s)
>>+{
>>+    return (s->state == MIGRATION_STATUS_ACTIVE ||
>>+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>+}
>>+
>> void migrate_init(MigrationState *s)
>> {
>>     /*
>>@@ -3226,8 +3231,7 @@ static void *migration_thread(void *opaque)
>> 
>>     trace_migration_thread_setup_complete();
>> 
>>-    while (s->state == MIGRATION_STATUS_ACTIVE ||
>>-           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>>+    while (migration_is_active(s)) {
>>         int64_t current_time;
>> 
>>         if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
>>-- 
>>2.17.1
>>
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

