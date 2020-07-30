Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A07C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8A32082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hPC9FlqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8A32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Aez-0000N4-RX
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad8-00074l-Tt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad6-00024X-CL
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXgGG156161;
 Thu, 30 Jul 2020 15:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dijgsEynUNDBNs0kElXjXPqxdC+9Litu30NacqUmQDQ=;
 b=hPC9FlqWro9zSXaKvl7HVagYvZ0cfce99DJvlCCTEXKsJgPIiQaqM4n/KqpK/Dq5HmPS
 nD5u0ZWrFqno7CIMd8apHQR1n/sPo3oJT1H+4JIFnO9HLAlONxtMPg3hoo3UcHRxlSow
 o3QxfeagyGranhO4S/ikXIacg614mrkGznQLLwBv96vwWVhLHkFbcE8wMPWB4x1VYnsp
 jGfGQEyG2s0THtc5Ys6c6+cVZOIe263YMTX5ktyE+wc14674Vm+DvD/M5lRxhKHlaI02
 7FRj47BjxD7etHr+ruTwMctIsR7F1hafaClGHSJwHyjfzD3PBO4JY5ikVUW3eH2L5Bi6 iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32hu1jmebr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:37:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSkf130680;
 Thu, 30 Jul 2020 15:37:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 32hu5wwgj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFbr9c020268;
 Thu, 30 Jul 2020 15:37:53 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:53 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 01/32] savevm: add vmstate handler iterators
Date: Thu, 30 Jul 2020 08:14:05 -0700
Message-Id: <1596122076-341293-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=3 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:57
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide the SAVEVM_FOREACH and SAVEVM_FORALL macros to loop over all save
VM state handlers.  The former will filter handlers based on the operation
in the later patch "savevm: VM handlers mode mask".  The latter loops over
all handlers.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/savevm.c | 57 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 45c9dd9..a07fcad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -266,6 +266,25 @@ static SaveState savevm_state = {
     .global_section_id = 0,
 };
 
+/*
+ * The FOREACH macros will filter handlers based on the current operation when
+ * additional conditions are added in a subsequent patch.
+ */
+
+#define SAVEVM_FOREACH(se, entry)                                    \
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
+
+#define SAVEVM_FOREACH_SAFE(se, entry, new_se)                       \
+    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)   \
+
+/* The FORALL macros unconditionally loop over all handlers. */
+
+#define SAVEVM_FORALL(se, entry)                                     \
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
+
+#define SAVEVM_FORALL_SAFE(se, entry, new_se)                        \
+    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)
+
 static bool should_validate_capability(int capability)
 {
     assert(capability >= 0 && capability < MIGRATION_CAPABILITY__MAX);
@@ -673,7 +692,7 @@ static uint32_t calculate_new_instance_id(const char *idstr)
     SaveStateEntry *se;
     uint32_t instance_id = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FORALL(se, entry) {
         if (strcmp(idstr, se->idstr) == 0
             && instance_id <= se->instance_id) {
             instance_id = se->instance_id + 1;
@@ -689,7 +708,7 @@ static int calculate_compat_instance_id(const char *idstr)
     SaveStateEntry *se;
     int instance_id = 0;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FORALL(se, entry) {
         if (!se->compat) {
             continue;
         }
@@ -803,7 +822,7 @@ void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
     }
     pstrcat(id, sizeof(id), idstr);
 
-    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
+    SAVEVM_FORALL_SAFE(se, entry, new_se) {
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             savevm_state_handler_remove(se);
             g_free(se->compat);
@@ -867,7 +886,7 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
 {
     SaveStateEntry *se, *new_se;
 
-    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
+    SAVEVM_FORALL_SAFE(se, entry, new_se) {
         if (se->vmsd == vmsd && se->opaque == opaque) {
             savevm_state_handler_remove(se);
             g_free(se->compat);
@@ -1119,7 +1138,7 @@ bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FORALL(se, entry) {
         if (se->vmsd && se->vmsd->unmigratable) {
             error_setg(errp, "State blocked by non-migratable device '%s'",
                        se->idstr);
@@ -1145,7 +1164,7 @@ bool qemu_savevm_state_guest_unplug_pending(void)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->vmsd && se->vmsd->dev_unplug_pending &&
             se->vmsd->dev_unplug_pending(se->opaque)) {
             return true;
@@ -1162,7 +1181,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
     int ret;
 
     trace_savevm_state_setup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
@@ -1193,7 +1212,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
 
     trace_savevm_state_resume_prepare();
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
@@ -1223,7 +1242,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
     int ret = 1;
 
     trace_savevm_state_iterate();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_live_iterate) {
             continue;
         }
@@ -1291,7 +1310,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     SaveStateEntry *se;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_live_complete_postcopy) {
             continue;
         }
@@ -1324,7 +1343,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     SaveStateEntry *se;
     int ret;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
@@ -1366,7 +1385,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     vmdesc = qjson_new();
     json_prop_int(vmdesc, "page_size", qemu_target_page_size());
     json_start_array(vmdesc, "devices");
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
 
         if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
             continue;
@@ -1476,7 +1495,7 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
     *res_postcopy_only = 0;
 
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->save_live_pending) {
             continue;
         }
@@ -1501,7 +1520,7 @@ void qemu_savevm_state_cleanup(void)
     }
 
     trace_savevm_state_cleanup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->ops && se->ops->save_cleanup) {
             se->ops->save_cleanup(se->opaque);
         }
@@ -1580,7 +1599,7 @@ int qemu_save_device_state(QEMUFile *f)
     }
     cpu_synchronize_all_states();
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         int ret;
 
         if (se->is_ram) {
@@ -1612,7 +1631,7 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
 {
     SaveStateEntry *se;
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FORALL(se, entry) {
         if (!strcmp(se->idstr, idstr) &&
             (instance_id == se->instance_id ||
              instance_id == se->alias_id))
@@ -2334,7 +2353,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     }
 
     trace_qemu_loadvm_state_section_partend(section_id);
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->load_section_id == section_id) {
             break;
         }
@@ -2400,7 +2419,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
     int ret;
 
     trace_loadvm_state_setup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
@@ -2425,7 +2444,7 @@ void qemu_loadvm_state_cleanup(void)
     SaveStateEntry *se;
 
     trace_loadvm_state_cleanup();
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+    SAVEVM_FOREACH(se, entry) {
         if (se->ops && se->ops->load_cleanup) {
             se->ops->load_cleanup(se->opaque);
         }
-- 
1.8.3.1


