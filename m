Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D1C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C232051A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vIrq8KBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C232051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHSP-0000lJ-8g
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1izHRY-0008J1-MG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1izHRV-00052e-VC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:58:00 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:37046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1izHRV-0004rb-Mf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:57:57 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0159vSQt013269; Wed, 5 Feb 2020 01:57:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=JqtjQ272n4cHD6Y9FQw1by8sD3rxhtn5J/g6d9TVXLg=;
 b=vIrq8KBsTfZ7YcjBs0SB9GqGeoxY4VDy7uxgjfOUDdzdX8BO12VOqqLGhziPePgk/Thf
 B4OTmSdihoSL12Itima2ipzJt6FOHei5Xwc9VPIVDfgiXwgMZghJ5rxBXMrcW7rHsNCI
 nnH2UjetKJsF5o55mQxfdgFPzMdOoZEiw4p9ge5bXjicj4fCJHK2Y9GZ5DMNIxVjZCEf
 z5SF7MzbbvS9izeuzfA7qadbSHLakbRHWtHail9IAstu02BluqXuKNZcCr7y6+mnDR1z
 mah+yG0Qik1fxO4Oqw8SIHy6q2GNuqQK9R7d5y3LgUUe1cOVMn69ix51JW0aDQZXUl+J 3g== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xyhpr9761-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 01:57:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEV40fUHJKVo0yg5/uPpOclpv5pzr39al3Dnl6vwyur6F8tWneWIm1hqG63O1fp+vrtxRx1gdFOousg+8eCLkbM6CVrfJ+l4qPDCxitDzkSGVpc+Wfbr+ZQC0uiIwWNKXYiFYXwZROpT1YoTYZrHnAco62Hy19oZAfhjwOCdzJ5GiABlp3LxCWjZQ9vSE9y7N89ZFD0Gk6M79KlxHq2JmMxB56MPK++oWxuN97tpd8oZcAjf0v7GOh45v7tK/TRxdEsjhzJ+B0w6Mx4+NA/JC+64JsW++DoIZVx/xiYTioklt8zAB2qmZXYqaaxNiisGJ8oFVGUdqyQZ94yr6lamHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqtjQ272n4cHD6Y9FQw1by8sD3rxhtn5J/g6d9TVXLg=;
 b=WuiodSFJumW3CG7voDNgOCBkRzDEcUu9ch+mzT9D17TgGCpVugag97qc7f+VkozNLAsCl9guv0Sui8m72XZwV43dcVRgoPMdA04n6kj9vyivgJj6WCthge2xts/qthCi2WwD8OPGgLn+gdKHDMCjL8E76qjcbaQnPfkAdwXlweWPE+1Nb/LMiDJaCEDrEHToPaf1pisIv0GkR73F1yPizBUuTr9d7sSnU7PPPHZ4t+WfaMSr4bvyIiPCkUGwPUXa18HBqHTC/4p1bOiLSH0tuQC++0CQeJpn7U/yQhwcaZKSOZrlzkIWXWeO8dqnr+phrWiuufqzGoZWFYwmldxybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BN6PR02MB2643.namprd02.prod.outlook.com (10.173.145.9) by
 BN6PR02MB3346.namprd02.prod.outlook.com (10.161.154.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Wed, 5 Feb 2020 09:57:52 +0000
Received: from BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::8401:9618:837d:d44b]) by BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::8401:9618:837d:d44b%10]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 09:57:51 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v2] fence: introduce a file-based self-fence mechanism
Date: Wed,  5 Feb 2020 09:57:37 +0000
Message-Id: <20200205095737.20153-1-felipe@nutanix.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::48) To BN6PR02MB2643.namprd02.prod.outlook.com
 (2603:10b6:404:5c::9)
MIME-Version: 1.0
Received: from nutanix.com (62.254.189.133) by
 AM0PR01CA0035.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend
 Transport; Wed, 5 Feb 2020 09:57:50 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d45189-7608-43fa-693e-08d7aa21dcf0
X-MS-TrafficTypeDiagnostic: BN6PR02MB3346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR02MB33462C1AC9D156B4D11007B2D7020@BN6PR02MB3346.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(1076003)(81166006)(81156014)(8676002)(4326008)(36756003)(55016002)(30864003)(8936002)(107886003)(5660300002)(86362001)(966005)(478600001)(956004)(7696005)(52116002)(2616005)(66556008)(26005)(316002)(6666004)(66476007)(110136005)(2906002)(66946007)(16526019)(8886007)(186003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR02MB3346;
 H:BN6PR02MB2643.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCS4z2Wu2Ix5lDaOgFQsBrD6oDZpeyQ1l24HkuOye6zqlXs1E4GWsYByqERBHaYjB71VWeH3HLAlWL5zUxMJFUJL7qjcKsLffQsc5q8p+kgoDcTnzutOAVOBK1s2s4X6bPnOw9fGEiYBAgEcTc+hfrNQSSnxFf/fqJdeE0IIwcoU/6y74iDU7GF158cceC/inp1RFzN2dF3UjFR+V1nHft6R+US9Mb5ubPoAmOCHVnxOCmfP5eFDeBaoS2+eQg70MsNVeuPeTJF4a3kpiS/GKiDqRvsPNJRcDETjaLA2k0RO9HsmvVIhC1HGYrIAukjjSPqLNn4o7wuilppfIMMgCxP+AMt5UdYSvPC18Yd2Yk1jw1pH4ZhSoKkVIEjEYBQ4kWpIF1tFxOodSyFPAcfInE0ov/Oo2KR49Ug2UCLlDMmfHWeqO6rwgb5kDcmE8qLVFdbUvc5CxStymI7STkB71E9SYZa/LNfNAjdWlCPtkNk/i4y7x7vK7WFxqxlzugjuSMNQDTg8tABRVGc+XWKZWvWBwhmt8lRfCoXoudKBjsFxk8owJmz0+bqDim31prN3
X-MS-Exchange-AntiSpam-MessageData: N32uLJCriFeCix79tUiMzaX7YmJ3SusMd1LvVMbJb+mUrJjHuSVWelO3DbwP7s7PQdcfmSMm79afPceOtgSCA9Qeq4pv1hIY0xcFV2dSE9ntgM9BwDkttTuD8FrmVfqxneeEqFAccN+DBXmkXnQwkA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d45189-7608-43fa-693e-08d7aa21dcf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 09:57:51.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq6oP0q3sOmnBcH9BIn9cCBkfML87tBCZAuZOnxQLDNIVebMbTRAVlYaNkmxeuBeXjOTKl3Qqu/fx0/PcBzqzIE7YIR3AQxXNl35nX292OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3346
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_02:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: qemu-devel@nongnu.org, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces a self-fence mechanism to Qemu, causing it to die if a
heartbeat condition is not met. Currently, a file-based heartbeat is
available and can be configured as follows:

-object file-fence,id=ff0,file=/foo,qtimeout=20,ktimeout=25,signal=kill

Qemu will watch 'file' for attribute changes. Touching the file works as
a heartbeat. This parameter is mandatory.

Fencing happens after 'qtimeout' or 'ktimeout' seconds elapse without a
heartbeat. At least one of these must be specified. Both may be used, in
which case 'ktimeout' must be greater than 'qtimeout'. Setting either to
zero has no effect (as if they weren't specified).

When using 'qtimeout', an internal Qemu timer is used. Fencing with this
method gives Qemu a chance to write a log message indicating which file
caused the event. If Qemu's main loop is hung for whatever reason, this
method won't successfully kill Qemu.

When using 'ktimeout', a kernel timer is used. In this case, 'signal'
can be 'kill' (for SIGKILL, default) or 'quit' (for SIGQUIT). Using
SIGQUIT may be preferred for obtaining core dumps. If Qemu is hung
(eg. uninterruptable sleep), this method won't successfully kill Qemu.

It is worth noting that even successfully killing Qemu may not be
sufficient to completely fence a VM as certain operations like network
packets or block commands may be pending in the kernel. If that is a
concern, systems should consider using further fencing mechanisms like
hardware watchdogs either instead or in conjunction with this for
additional protection.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 backends/Makefile.objs |   2 +
 backends/file-fence.c  | 374 +++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx        |  27 ++-
 3 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 backends/file-fence.c

Changelog:
v1->v2:
- Publish patch in https://github.com/franciozzy/qemu/tree/filefence
- Rename file_fence to file-fence and move to backends/
- Use error_printf() instead of printf() when fencing
- Replace a check already done by filemonitor-inotify with assert
- Add return value to _setup() functions to simplify error logic
- Use g_ascii_strcasecmp() to simplify logic in _set_signal()
- Use glib memory allocation helpers in _set_file()
- Fix bug to allow using qtimeout without ktimeout
- Clarify usage of q/k timeouts in commit message
- Clarify usage of hardware watchdogs in commits message

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..da2a589bdf 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -9,6 +9,8 @@ common-obj-$(CONFIG_POSIX) += hostmem-file.o
 common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
 
+common-obj-y += file-fence.o
+
 ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
 common-obj-y += cryptodev-vhost.o
 common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
diff --git a/backends/file-fence.c b/backends/file-fence.c
new file mode 100644
index 0000000000..3dbbed7325
--- /dev/null
+++ b/backends/file-fence.c
@@ -0,0 +1,374 @@
+/*
+ * QEMU file-based self-fence mechanism
+ *
+ * Copyright (c) 2019 Nutanix Inc. All rights reserved.
+ *
+ * Authors:
+ *    Felipe Franciosi <felipe@nutanix.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/error-report.h"
+#include "qemu/filemonitor.h"
+#include "qemu/timer.h"
+
+#include <time.h>
+
+#define TYPE_FILE_FENCE "file-fence"
+
+typedef struct FileFence {
+    Object parent_obj;
+
+    gchar *dir;
+    gchar *file;
+    uint32_t qtimeout;
+    uint32_t ktimeout;
+    int signal;
+
+    timer_t ktimer;
+    QEMUTimer *qtimer;
+
+    QFileMonitor *fm;
+    uint64_t id;
+} FileFence;
+
+#define FILE_FENCE(obj) \
+    OBJECT_CHECK(FileFence, (obj), TYPE_FILE_FENCE)
+
+static void
+timer_update(FileFence *ff)
+{
+    struct itimerspec its = {
+        .it_value.tv_sec = ff->ktimeout,
+    };
+    int err;
+
+    if (ff->qtimeout) {
+        timer_mod(ff->qtimer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                              ff->qtimeout * 1000);
+    }
+
+    if (ff->ktimeout) {
+        err = timer_settime(ff->ktimer, 0, &its, NULL);
+        g_assert(err == 0);
+    }
+}
+
+static void
+file_fence_abort_cb(void *opaque)
+{
+    FileFence *ff = opaque;
+    error_printf("Fencing after %u seconds on '%s'\n",
+                 ff->qtimeout, g_strconcat(ff->dir, "/", ff->file, NULL));
+    abort();
+}
+
+static void
+file_fence_watch_cb(int64_t id, QFileMonitorEvent ev, const char *file,
+                    void *opaque)
+{
+    FileFence *ff = opaque;
+
+    if (ev != QFILE_MONITOR_EVENT_ATTRIBUTES) {
+        return;
+    }
+
+    g_assert(g_str_equal(file, ff->file));
+
+    timer_update(ff);
+}
+
+static void
+ktimer_tear(FileFence *ff)
+{
+    int err;
+
+    if (ff->ktimer) {
+        err = timer_delete(ff->ktimer);
+        g_assert(err == 0);
+        ff->ktimer = NULL;
+    }
+}
+
+static gboolean
+ktimer_setup(FileFence *ff, Error **errp)
+{
+    int err;
+
+    struct sigevent sev = {
+        .sigev_notify = SIGEV_SIGNAL,
+        .sigev_signo = ff->signal ? ff->signal : SIGKILL,
+    };
+
+    if (ff->ktimeout == 0) {
+        return TRUE;
+    }
+
+    err = timer_create(CLOCK_MONOTONIC, &sev, &ff->ktimer);
+    if (err == -1) {
+        error_setg(errp, "Error creating kernel timer: %m");
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+static void
+qtimer_tear(FileFence *ff)
+{
+    if (ff->qtimer) {
+        timer_del(ff->qtimer);
+        timer_free(ff->qtimer);
+    }
+    ff->qtimer = NULL;
+}
+
+static gboolean
+qtimer_setup(FileFence *ff, Error **errp)
+{
+    QEMUTimer *qtimer;
+
+    if (ff->qtimeout == 0) {
+        return TRUE;
+    }
+
+    qtimer = timer_new_ms(QEMU_CLOCK_REALTIME, file_fence_abort_cb, ff);
+    if (qtimer == NULL) {
+        error_setg(errp, "Error creating Qemu timer");
+        return FALSE;
+    }
+
+    ff->qtimer = qtimer;
+
+    return TRUE;
+}
+
+static void
+watch_tear(FileFence *ff)
+{
+    if (ff->fm) {
+        qemu_file_monitor_remove_watch(ff->fm, ff->dir, ff->id);
+        qemu_file_monitor_free(ff->fm);
+        ff->fm = NULL;
+        ff->id = 0;
+    }
+}
+
+static gboolean
+watch_setup(FileFence *ff, Error **errp)
+{
+    QFileMonitor *fm;
+    int64_t id;
+
+    fm = qemu_file_monitor_new(errp);
+    if (!fm) {
+        return FALSE;
+    }
+
+    id = qemu_file_monitor_add_watch(fm, ff->dir, ff->file,
+                                     file_fence_watch_cb, ff, errp);
+    if (id < 0) {
+        qemu_file_monitor_free(fm);
+        return FALSE;
+    }
+
+    ff->fm = fm;
+    ff->id = id;
+
+    return TRUE;
+}
+
+static void
+file_fence_complete(UserCreatable *obj, Error **errp)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    if (ff->dir == NULL) {
+        error_setg(errp, "A 'file' must be set");
+        return;
+    }
+
+    if (ff->signal != 0 && ff->ktimeout == 0) {
+        error_setg(errp, "Using 'signal' requires 'ktimeout' to be set");
+        return;
+    }
+
+    if (ff->ktimeout == 0 && ff->qtimeout == 0) {
+        error_setg(errp, "One or both of 'ktimeout' or 'qtimeout' must be set");
+        return;
+    }
+
+    if (ff->qtimeout >= ff->ktimeout && ff->ktimeout != 0) {
+        error_setg(errp, "Using 'qtimeout' >= 'ktimeout' doesn't make sense");
+        return;
+    }
+
+    if (!watch_setup(ff, errp) ||
+        !qtimer_setup(ff, errp) ||
+        !ktimer_setup(ff, errp)) {
+        return;
+    }
+
+    timer_update(ff);
+
+    return;
+}
+
+static void
+file_fence_set_signal(Object *obj, const char *value, Error **errp)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    if (ff->signal) {
+        error_setg(errp, "Signal property already set");
+        return;
+    }
+
+    if (value == NULL) {
+        goto err;
+    }
+
+    if (g_ascii_strcasecmp(value, "QUIT") == 0) {
+        ff->signal = SIGQUIT;
+        return;
+    }
+
+    if (g_ascii_strcasecmp(value, "KILL") == 0) {
+        ff->signal = SIGKILL;
+        return;
+    }
+
+err:
+    error_setg(errp, "Invalid signal. Must be 'quit' or 'kill'");
+}
+
+static char *
+file_fence_get_signal(Object *obj, Error **errp)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    switch (ff->signal) {
+    case SIGKILL:
+        return g_strdup("kill");
+    case SIGQUIT:
+        return g_strdup("quit");
+    }
+
+    /* Unreachable */
+    abort();
+}
+
+static void
+file_fence_set_file(Object *obj, const char *value, Error **errp)
+{
+    FileFence *ff = FILE_FENCE(obj);
+    g_autofree gchar *dir = NULL, *file = NULL;
+
+    if (ff->dir) {
+        error_setg(errp, "File property already set");
+        return;
+    }
+
+    dir = g_path_get_dirname(value);
+    if (g_str_equal(dir, ".")) {
+        error_setg(errp, "Path for file-fence must be absolute");
+        return;
+    }
+
+    file = g_path_get_basename(value);
+    if (g_str_equal(file, ".")) {
+        error_setg(errp, "Path for file-fence must be a file");
+        return;
+    }
+
+    ff->dir = g_steal_pointer(&dir);
+    ff->file = g_steal_pointer(&file);
+}
+
+static char *
+file_fence_get_file(Object *obj, Error **errp)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    if (ff->file) {
+        return g_build_filename(ff->dir, ff->file, NULL);
+    }
+
+    return NULL;
+}
+
+static void
+file_fence_instance_finalize(Object *obj)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    ktimer_tear(ff);
+    qtimer_tear(ff);
+    watch_tear(ff);
+
+    g_free(ff->file);
+    g_free(ff->dir);
+}
+
+static void
+file_fence_instance_init(Object *obj)
+{
+    FileFence *ff = FILE_FENCE(obj);
+
+    object_property_add_str(obj, "file",
+                            file_fence_get_file,
+                            file_fence_set_file,
+                            &error_abort);
+    object_property_add_str(obj, "signal",
+                            file_fence_get_signal,
+                            file_fence_set_signal,
+                            &error_abort);
+    object_property_add_uint32_ptr(obj, "qtimeout", &ff->qtimeout,
+                                   OBJ_PROP_FLAG_READWRITE, &error_abort);
+    object_property_add_uint32_ptr(obj, "ktimeout", &ff->ktimeout,
+                                   OBJ_PROP_FLAG_READWRITE, &error_abort);
+}
+
+static void
+file_fence_class_init(ObjectClass *klass, void *class_data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
+    ucc->complete = file_fence_complete;
+}
+
+static const TypeInfo file_fence_info = {
+    .name = TYPE_FILE_FENCE,
+    .parent = TYPE_OBJECT,
+    .class_init = file_fence_class_init,
+    .instance_size = sizeof(FileFence),
+    .instance_init = file_fence_instance_init,
+    .instance_finalize = file_fence_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+register_types(void)
+{
+    type_register_static(&file_fence_info);
+}
+
+type_init(register_types);
diff --git a/qemu-options.hx b/qemu-options.hx
index 224a8e8712..5ea94b37af 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4974,8 +4974,33 @@ The polling parameters can be modified at run-time using the @code{qom-set} comm
 
 @end table
 
-ETEXI
+@item -object file-fence,id=@var{id},file=@var{file},qtimeout=@var{qtimeout},ktimeout=@var{ktimeout},signal=@{signal}
+
+Self-fence Qemu if @var{file} is not modified within a given timeout.
+
+Qemu will watch @var{file} for attribute changes. Touching the file works as a
+heartbeat. This parameter is mandatory.
+
+Fencing happens after @var{qtimeout} or @var{ktimeout} seconds elapse
+without a heartbeat. At least one of these must be specified. Both may be used.
 
+When using @var{qtimeout}, an internal Qemu timer is used. Fencing with
+this method gives Qemu a chance to write a log message indicating which file
+caused the event. If Qemu's main loop is hung for whatever reason, this method
+won't successfully kill Qemu.
+
+When using @var{ktimeout}, a kernel timer is used. In this case, @var{signal}
+can be 'kill' (for SIGKILL, default) or 'quit' (for SIGQUIT). Using SIGQUIT may
+be preferred for obtaining core dumps. If Qemu is hung (eg. uninterruptable
+sleep), this method won't successfully kill Qemu.
+
+It is worth noting that even successfully killing Qemu may not be sufficient to
+completely fence a VM as certain operations like network packets or block
+commands may be pending in the kernel. If that is a concern, systems should
+consider using further fencing mechanisms like hardware watchdogs either in
+addition or in conjunction with this feature for additional protection.
+
+ETEXI
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
-- 
2.20.1


