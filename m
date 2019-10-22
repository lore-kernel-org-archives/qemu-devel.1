Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E2CA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35A620684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpUF-0003Mb-Tq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yezhenyu2@huawei.com>) id 1iMpHM-0004DG-3j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yezhenyu2@huawei.com>) id 1iMpHK-0005Zg-4s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:12:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43656 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yezhenyu2@huawei.com>)
 id 1iMpHI-0005U5-H3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:12:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 13B927598E85984AF5B8;
 Tue, 22 Oct 2019 16:12:15 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.212) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 22 Oct 2019 16:12:04 +0800
From: "yezhenyu (A)" <yezhenyu2@huawei.com>
To: <stefanha@redhat.com>, <pbonzini@redhat.com>, <dgilbert@redhat.com>,
 <eblake@redhat.com>
Subject: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <5DAEB9D3.3080503@huawei.com>
Date: Tue, 22 Oct 2019 16:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.212]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: jiangyiwen <jiangyiwen@huawei.com>, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, yezhenyu2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since qemu2.9, QEMU added three AioContext poll parameters to struct
IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
used to control iothread polling time.

However, there isn't properly hmp commands to adjust them when the VM is
alive. It's useful to adjust them online when observing the impact of
different property value on performance.

This patch add three hmp commands to adjust iothread poll-* properties
for special iothread:

set_iothread_poll_max_ns: set the maximum polling time in ns;
set_iothread_poll_grow: set how many ns will be added to polling time;
set_iothread_poll_shrink: set how many ns will be removed from polling
time.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
hmp-commands.hx | 42 ++++++++++++++++++++
hmp.c | 30 +++++++++++++++
hmp.h | 3 ++
include/sysemu/iothread.h | 6 +++
iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
qapi/misc.json | 23 +++++++++++
6 files changed, 184 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index a2c3ffc218..6fa0c5227a 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -74,6 +74,48 @@ VM initialization using configuration data provided on the command line
and via the QMP monitor during the preconfig state. The command is only
available during the preconfig state (i.e. when the --preconfig command
line option was in use).
+ETEXI
+
+ {
+ .name = "set_iothread_poll_max_ns",
+ .args_type = "iothread_id:s,poll_max_ns:i",
+ .params = "iothread_id poll_max_ns",
+ .help = "set poll_max_ns for a special iothread",
+ .cmd = hmp_set_iothread_poll_max_ns,
+ },
+
+STEXI
+@item set_iothread_poll_max_ns
+@findex set_iothread_poll_max_ns
+set poll_max_ns property for a special iothread.
+ETEXI
+
+ {
+ .name = "set_iothread_poll_grow",
+ .args_type = "iothread_id:s,poll_grow:i",
+ .params = "iothread_id poll_grow",
+ .help = "set poll_grow for a special iothread",
+ .cmd = hmp_set_iothread_poll_grow,
+ },
+
+STEXI
+@item set_iothread_poll_grow
+@findex set_iothread_poll_grow
+set poll_grow property for a special iothread.
+ETEXI
+
+ {
+ .name = "set_iothread_poll_shrink",
+ .args_type = "iothread_id:s,poll_shrink:i",
+ .params = "iothread_id poll_shrink",
+ .help = "set poll_shrink for a special iothread",
+ .cmd = hmp_set_iothread_poll_shrink,
+ },
+
+STEXI
+@item set_iothread_poll_shrink
+@findex set_iothread_poll_shrink
+set poll_shrink property for a special iothread.
ETEXI

{
diff --git a/hmp.c b/hmp.c
index 56a3ed7375..87520bcc85 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2711,6 +2711,36 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
qapi_free_IOThreadInfoList(info_list);
}

+void hmp_set_iothread_poll_max_ns(Monitor *mon, const QDict *qdict)
+{
+ const char *iothread_id = qdict_get_str(qdict, "iothread_id");
+ int64_t poll_max_ns = qdict_get_int(qdict, "poll_max_ns");
+ Error *err = NULL;
+
+ qmp_set_iothread_poll_param(iothread_id, "poll_max_ns", poll_max_ns, &err);
+ hmp_handle_error(mon, &err);
+}
+
+void hmp_set_iothread_poll_grow(Monitor *mon, const QDict *qdict)
+{
+ const char *iothread_id = qdict_get_str(qdict, "iothread_id");
+ int64_t poll_grow = qdict_get_int(qdict, "poll_grow");
+ Error *err = NULL;
+
+ qmp_set_iothread_poll_param(iothread_id, "poll_grow", poll_grow, &err);
+ hmp_handle_error(mon, &err);
+}
+
+void hmp_set_iothread_poll_shrink(Monitor *mon, const QDict *qdict)
+{
+ const char *iothread_id = qdict_get_str(qdict, "iothread_id");
+ int64_t poll_shrink = qdict_get_int(qdict, "poll_shrink");
+ Error *err = NULL;
+
+ qmp_set_iothread_poll_param(iothread_id, "poll_shrink", poll_shrink, &err);
+ hmp_handle_error(mon, &err);
+}
+
void hmp_qom_list(Monitor *mon, const QDict *qdict)
{
const char *path = qdict_get_try_str(qdict, "path");
diff --git a/hmp.h b/hmp.h
index 43617f2646..8ce3b53556 100644
--- a/hmp.h
+++ b/hmp.h
@@ -41,6 +41,9 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict);
void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
void hmp_info_tpm(Monitor *mon, const QDict *qdict);
void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
+void hmp_set_iothread_poll_max_ns(Monitor *mon, const QDict *qdict);
+void hmp_set_iothread_poll_grow(Monitor *mon, const QDict *qdict);
+void hmp_set_iothread_poll_shrink(Monitor *mon, const QDict *qdict);
void hmp_quit(Monitor *mon, const QDict *qdict);
void hmp_stop(Monitor *mon, const QDict *qdict);
void hmp_sync_profile(Monitor *mon, const QDict *qdict);
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 5f6240d5cb..7ebeb51f37 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -45,6 +45,12 @@ char *iothread_get_id(IOThread *iothread);
IOThread *iothread_by_id(const char *id);
AioContext *iothread_get_aio_context(IOThread *iothread);
GMainContext *iothread_get_g_main_context(IOThread *iothread);
+void iothread_set_poll_max_ns(IOThread *iothread, int64_t poll_max_ns);
+int64_t iothread_get_poll_max_ns(IOThread *iothread);
+void iothread_set_poll_grow(IOThread *iothread, int64_t poll_grow);
+int64_t iothread_get_poll_grow(IOThread *iothread);
+void iothread_set_poll_shrink(IOThread *iothread, int64_t poll_shrink);
+int64_t iothread_get_poll_shrink(IOThread *iothread);

/*
* Helpers used to allocate iothreads for internal use. These
diff --git a/iothread.c b/iothread.c
index 7130be58e3..4ab6128c5f 100644
--- a/iothread.c
+++ b/iothread.c
@@ -384,3 +384,83 @@ IOThread *iothread_by_id(const char *id)
{
return IOTHREAD(object_resolve_path_type(id, TYPE_IOTHREAD, NULL));
}
+
+void iothread_set_poll_max_ns(IOThread *iothread, int64_t poll_max_ns)
+{
+ iothread->poll_max_ns = poll_max_ns;
+}
+
+int64_t iothread_get_poll_max_ns(IOThread *iothread)
+{
+ return iothread->poll_max_ns;
+}
+
+void iothread_set_poll_grow(IOThread *iothread, int64_t poll_grow)
+{
+ iothread->poll_grow = poll_grow;
+}
+
+int64_t iothread_get_poll_grow(IOThread *iothread)
+{
+ return iothread->poll_grow;
+}
+
+void iothread_set_poll_shrink(IOThread *iothread, int64_t poll_shrink)
+{
+ iothread->poll_shrink = poll_shrink;
+}
+
+int64_t iothread_get_poll_shrink(IOThread *iothread)
+{
+ return iothread->poll_shrink;
+}
+
+void qmp_set_iothread_poll_param(const char *iothread_id, const char *name,
+ int64_t value, Error **errp)
+{
+ Error *local_error = NULL;
+ int64_t old_value = 0;
+ IOThread *iothread = iothread_by_id(iothread_id);
+ if (!iothread) {
+ error_setg(errp, "can not find iothread: %s", iothread_id);
+ return;
+ }
+
+ if (strcmp(name, "poll_max_ns") == 0) {
+ old_value = iothread_get_poll_max_ns(iothread);
+ iothread_set_poll_max_ns(iothread, value);
+ } else if (strcmp(name, "poll_grow") == 0) {
+ old_value = iothread_get_poll_grow(iothread);
+ iothread_set_poll_grow(iothread, value);
+ } else if (strcmp(name, "poll_shrink") == 0) {
+ old_value = iothread_get_poll_shrink(iothread);
+ iothread_set_poll_shrink(iothread, value);
+ } else {
+ error_setg(errp, "can not find param name: %s", name);
+ return;
+ }
+
+ /* update the value in context */
+ aio_context_set_poll_params(iothread->ctx,
+ iothread->poll_max_ns,
+ iothread->poll_grow,
+ iothread->poll_shrink,
+ &local_error);
+
+ if (local_error) {
+ error_propagate(errp, local_error);
+
+ /* reset the property to old value */
+ if (strcmp(name, "poll_max_ns") == 0) {
+ iothread_set_poll_max_ns(iothread, old_value);
+ } else if (strcmp(name, "poll_grow") == 0) {
+ iothread_set_poll_grow(iothread, old_value);
+ } else if (strcmp(name, "poll_shrink") == 0) {
+ iothread_set_poll_shrink(iothread, old_value);
+ }
+
+ return;
+ }
+
+ return;
+}
diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..43d3f4351c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -675,6 +675,29 @@
{ 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
'allow-preconfig': true }

+##
+# @set-iothread-poll-param:
+#
+# Set poll-* properties for a special iothread.
+# The poll-* name can be poll_max_ns/poll_grow/poll_shrink.
+#
+# Notes: can not set the QEMU main loop thread, which is not declared
+# using the -object iothread command-line option. The poll_ns property can not
+# be set manually, which is auto-adjust.
+#
+# Example:
+#
+# -> { "execute": "set-iothread-poll-param",
+# "arguments": { "iothread_id": "1",
+# "name": "poll_max_ns",
+# "value": 1000 } }
+# <- { "return": {} }
+#
+# Since 3.0
+##
+{ 'command': 'set-iothread-poll-param',
+ 'data': {'iothread_id': 'str', 'name': 'str', 'value': 'int'} }
+
##
# @BalloonInfo:
#
-- 
2.22.0.windows.1


