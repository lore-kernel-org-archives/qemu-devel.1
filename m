Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3425C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DC12145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DC12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0b61-0006Rt-19
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i0b5K-000634-Gi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i0b5J-0003G4-AZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:36:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:21306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1i0b5J-0003FX-2t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:36:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 17:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,414,1559545200"; d="scan'208";a="378324678"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2019 17:36:09 -0700
Date: Thu, 22 Aug 2019 08:35:47 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190822003547.GA11547@richard>
References: <20190821155327.25208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821155327.25208-1-berrange@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH] tests: make filemonitor test more robust
 to event ordering
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 04:53:27PM +0100, Daniel P. Berrangé wrote:
>The ordering of events that are emitted during the rmdir
>test have changed with kernel >= 5.3. Semantically both
>new & old orderings are correct, so we must be able to
>cope with either.
>
>To cope with this, when we see an unexpected event, we
>push it back onto the queue and look and the subsequent
>event to see if that matches instead.
>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Tested-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/test-util-filemonitor.c | 43 +++++++++++++++++++++++++++--------
> 1 file changed, 34 insertions(+), 9 deletions(-)
>
>diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
>index 46e781c022..301cd2db61 100644
>--- a/tests/test-util-filemonitor.c
>+++ b/tests/test-util-filemonitor.c
>@@ -45,6 +45,11 @@ typedef struct {
>     const char *filedst;
>     int64_t *watchid;
>     int eventid;
>+    /*
>+     * Only valid with OP_EVENT - this event might be
>+     * swapped with the next OP_EVENT
>+     */
>+    bool swapnext;
> } QFileMonitorTestOp;
> 
> typedef struct {
>@@ -98,6 +103,10 @@ qemu_file_monitor_test_handler(int64_t id,
>     QFileMonitorTestData *data = opaque;
>     QFileMonitorTestRecord *rec = g_new0(QFileMonitorTestRecord, 1);
> 
>+    if (debug) {
>+        g_printerr("Queue event id %" PRIx64 " event %d file %s\n",
>+                   id, event, filename);
>+    }
>     rec->id = id;
>     rec->event = event;
>     rec->filename = g_strdup(filename);
>@@ -125,7 +134,8 @@ qemu_file_monitor_test_record_free(QFileMonitorTestRecord *rec)
>  * to wait for the event to be queued for us.
>  */
> static QFileMonitorTestRecord *
>-qemu_file_monitor_test_next_record(QFileMonitorTestData *data)
>+qemu_file_monitor_test_next_record(QFileMonitorTestData *data,
>+                                   QFileMonitorTestRecord *pushback)
> {
>     GTimer *timer = g_timer_new();
>     QFileMonitorTestRecord *record = NULL;
>@@ -139,9 +149,15 @@ qemu_file_monitor_test_next_record(QFileMonitorTestData *data)
>     }
>     if (data->records) {
>         record = data->records->data;
>-        tmp = data->records;
>-        data->records = g_list_remove_link(data->records, tmp);
>-        g_list_free(tmp);
>+        if (pushback) {
>+            data->records->data = pushback;
>+        } else {
>+            tmp = data->records;
>+            data->records = g_list_remove_link(data->records, tmp);
>+            g_list_free(tmp);
>+        }
>+    } else if (pushback) {
>+        qemu_file_monitor_test_record_free(pushback);
>     }
>     qemu_mutex_unlock(&data->lock);
> 
>@@ -158,13 +174,15 @@ static bool
> qemu_file_monitor_test_expect(QFileMonitorTestData *data,
>                               int64_t id,
>                               QFileMonitorEvent event,
>-                              const char *filename)
>+                              const char *filename,
>+                              bool swapnext)
> {
>     QFileMonitorTestRecord *rec;
>     bool ret = false;
> 
>-    rec = qemu_file_monitor_test_next_record(data);
>+    rec = qemu_file_monitor_test_next_record(data, NULL);
> 
>+ retry:
>     if (!rec) {
>         g_printerr("Missing event watch id %" PRIx64 " event %d file %s\n",
>                    id, event, filename);
>@@ -172,6 +190,11 @@ qemu_file_monitor_test_expect(QFileMonitorTestData *data,
>     }
> 
>     if (id != rec->id) {
>+        if (swapnext) {
>+            rec = qemu_file_monitor_test_next_record(data, rec);
>+            swapnext = false;
>+            goto retry;
>+        }
>         g_printerr("Expected watch id %" PRIx64 " but got %" PRIx64 "\n",
>                    id, rec->id);
>         goto cleanup;
>@@ -347,7 +370,8 @@ test_file_monitor_events(void)
>           .filesrc = "fish", },
>         { .type = QFILE_MONITOR_TEST_OP_EVENT,
>           .filesrc = "", .watchid = &watch4,
>-          .eventid = QFILE_MONITOR_EVENT_IGNORED },
>+          .eventid = QFILE_MONITOR_EVENT_IGNORED,
>+          .swapnext = true },
>         { .type = QFILE_MONITOR_TEST_OP_EVENT,
>           .filesrc = "fish", .watchid = &watch0,
>           .eventid = QFILE_MONITOR_EVENT_DELETED },
>@@ -493,8 +517,9 @@ test_file_monitor_events(void)
>                 g_printerr("Event id=%" PRIx64 " event=%d file=%s\n",
>                            *op->watchid, op->eventid, op->filesrc);
>             }
>-            if (!qemu_file_monitor_test_expect(
>-                    &data, *op->watchid, op->eventid, op->filesrc))
>+            if (!qemu_file_monitor_test_expect(&data, *op->watchid,
>+                                               op->eventid, op->filesrc,
>+                                               op->swapnext))
>                 goto cleanup;
>             break;
>         case QFILE_MONITOR_TEST_OP_CREATE:
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me

