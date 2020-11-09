Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62FDC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0132068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVb4idcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0132068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7RQ-0007tU-Bv
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OV-0004r6-RJ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OS-0000iI-Ri
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCDwkoAWBs5TBvHw5DNhs4UXxWuEbUL+YWIMbOieb+c=;
 b=iVb4idcJku6jGtKmJu8Vz8yt/jyQGAR5D6MVLc5ROV+M2qDarXkZqQmPK3eFojZjAWcI5Z
 8WW224ARiEUPE4cnPH3ETcxbD52PPuMVFi7alkJXdpSy9Cvk5Ax4/h0L9xaAURjrp9Pz7v
 FqNTyr6gSqidhLg61WUAS5oSEMjSK5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-QjgLzQqIPBWTVoahuYHA4w-1; Mon, 09 Nov 2020 08:39:34 -0500
X-MC-Unique: QjgLzQqIPBWTVoahuYHA4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F5D809DC9
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59F656EF40;
 Mon,  9 Nov 2020 13:39:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] qemu-option: restrict qemu_opts_set to merge-lists
 QemuOpts
Date: Mon,  9 Nov 2020 08:39:28 -0500
Message-Id: <20201109133931.979563-4-pbonzini@redhat.com>
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_opts_set is used to create default network backends and to
parse sugar options -kernel, -initrd, -append, -bios and -dtb.
Switch the former to qemu_opts_parse, so that qemu_opts_set
is now only used on merge-lists QemuOptsList (for which it makes
the most sense indeed)... except in the testcase, which is
changed to use a merge-list QemuOptsList.

With this change we can remove the id parameter.  With the
parameter always NULL, we know that qemu_opts_create cannot fail
and can pass &error_abort to it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/option.h  |  3 +--
 softmmu/vl.c           | 19 +++++++------------
 tests/test-qemu-opts.c | 24 +++++++++++++++++++++---
 util/qemu-option.c     |  9 +++------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index ac69352e0e..f73e0dc7d9 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -119,8 +119,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
                            int fail_if_exists, Error **errp);
 void qemu_opts_reset(QemuOptsList *list);
 void qemu_opts_loc_restore(QemuOpts *opts);
-bool qemu_opts_set(QemuOptsList *list, const char *id,
-                   const char *name, const char *value, Error **errp);
+bool qemu_opts_set(QemuOptsList *list, const char *name, const char *value, Error **errp);
 const char *qemu_opts_id(QemuOpts *opts);
 void qemu_opts_set_id(QemuOpts *opts, char *id);
 void qemu_opts_del(QemuOpts *opts);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index a71164494e..65607fe55e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3107,20 +3107,16 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_kernel:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "kernel", optarg,
-                              &error_abort);
+                qemu_opts_set(qemu_find_opts("machine"), "kernel", optarg, &error_abort);
                 break;
             case QEMU_OPTION_initrd:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "initrd", optarg,
-                              &error_abort);
+                qemu_opts_set(qemu_find_opts("machine"), "initrd", optarg, &error_abort);
                 break;
             case QEMU_OPTION_append:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "append", optarg,
-                              &error_abort);
+                qemu_opts_set(qemu_find_opts("machine"), "append", optarg, &error_abort);
                 break;
             case QEMU_OPTION_dtb:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "dtb", optarg,
-                              &error_abort);
+                qemu_opts_set(qemu_find_opts("machine"), "dtb", optarg, &error_abort);
                 break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
@@ -3230,8 +3226,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_bios:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "firmware", optarg,
-                              &error_abort);
+                qemu_opts_set(qemu_find_opts("machine"), "firmware", optarg, &error_abort);
                 break;
             case QEMU_OPTION_singlestep:
                 singlestep = 1;
@@ -4258,9 +4253,9 @@ void qemu_init(int argc, char **argv, char **envp)
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-        qemu_opts_set(net, NULL, "type", "nic", &error_abort);
+        qemu_opts_parse(net, "nic", true, &error_abort);
 #ifdef CONFIG_SLIRP
-        qemu_opts_set(net, NULL, "type", "user", &error_abort);
+        qemu_opts_parse(net, "user", true, &error_abort);
 #endif
     }
 
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 297ffe79dd..322b32871b 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -84,11 +84,25 @@ static QemuOptsList opts_list_03 = {
     },
 };
 
+static QemuOptsList opts_list_04 = {
+    .name = "opts_list_04",
+    .head = QTAILQ_HEAD_INITIALIZER(opts_list_04.head),
+    .merge_lists = true,
+    .desc = {
+        {
+            .name = "str3",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
 static void register_opts(void)
 {
     qemu_add_opts(&opts_list_01);
     qemu_add_opts(&opts_list_02);
     qemu_add_opts(&opts_list_03);
+    qemu_add_opts(&opts_list_04);
 }
 
 static void test_find_unknown_opts(void)
@@ -402,17 +416,21 @@ static void test_qemu_opts_set(void)
     QemuOpts *opts;
     const char *opt;
 
-    list = qemu_find_opts("opts_list_01");
+    list = qemu_find_opts("opts_list_04");
     g_assert(list != NULL);
     g_assert(QTAILQ_EMPTY(&list->head));
-    g_assert_cmpstr(list->name, ==, "opts_list_01");
+    g_assert_cmpstr(list->name, ==, "opts_list_04");
 
     /* should not find anything at this point */
     opts = qemu_opts_find(list, NULL);
     g_assert(opts == NULL);
 
     /* implicitly create opts and set str3 value */
-    qemu_opts_set(list, NULL, "str3", "value", &error_abort);
+    qemu_opts_set(list, "str3", "first_value", &error_abort);
+    g_assert(!QTAILQ_EMPTY(&list->head));
+
+    /* set it again */
+    qemu_opts_set(list, "str3", "value", &error_abort);
     g_assert(!QTAILQ_EMPTY(&list->head));
 
     /* get the just created opts */
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 59be4f9d21..c88e159f18 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -665,15 +665,12 @@ void qemu_opts_loc_restore(QemuOpts *opts)
     loc_restore(&opts->loc);
 }
 
-bool qemu_opts_set(QemuOptsList *list, const char *id,
-                   const char *name, const char *value, Error **errp)
+bool qemu_opts_set(QemuOptsList *list, const char *name, const char *value, Error **errp)
 {
     QemuOpts *opts;
 
-    opts = qemu_opts_create(list, id, 1, errp);
-    if (!opts) {
-        return false;
-    }
+    assert(list->merge_lists);
+    opts = qemu_opts_create(list, NULL, 0, &error_abort);
     return qemu_opt_set(opts, name, value, errp);
 }
 
-- 
2.26.2



