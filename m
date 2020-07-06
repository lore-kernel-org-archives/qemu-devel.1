Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03934C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79AB206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3V28Tja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79AB206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUDE-00059i-2Q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC2-000385-Gw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC0-000346-IY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUR1zcxCwWSJ7BPTneSRwcEpx9JFwTwEk3HpPfj0dNY=;
 b=G3V28Tja0egkFWkzZLnTYkEmDKPDl07OwSW25Ocd1ZjQeR0LcWaCrJ7gncn7S96NF48Ifz
 +f+wrr2GDLV/qS9djTSfckA+9nz5vTQ2L2b1fhxDenFe6PdfQexRjqP6weMSka+yitbnij
 Sk6ZTSXT8jshOdI+RX4hz/+94zoUMV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-EXGoTtpsNDqbNX-DK7XfNA-1; Mon, 06 Jul 2020 12:42:01 -0400
X-MC-Unique: EXGoTtpsNDqbNX-DK7XfNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C0EF107ACCD;
 Mon,  6 Jul 2020 16:41:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30AD81002380;
 Mon,  6 Jul 2020 16:41:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/53] util/qemu-error: prepend guest name to error message to
 identify affected VM owner
Date: Mon,  6 Jul 2020 12:41:05 -0400
Message-Id: <20200706164155.24696-4-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Mario Smarduch <msmarduch@digitalocean.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mario Smarduch <msmarduch@digitalocean.com>

This is followup patch to the one submitted back in Oct, 19

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg02102.html

My mistake here, I took my eyes of the mailing list after I got the
initial thumbs up. This patch follows up on Markus comments in the
above link.

Purpose of this patch:

We want to print guest name for errors, warnings and info messages. This
was the first of two patches the second being MCE errors targeting a VM
with guest name prepended. But in a large fleet we see many other
errors that disable a VM or crash it. In a large fleet and centralized
logging having the guest name enables identify of owner and customer.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
Message-Id: <20200626201900.8876-1-msmarduch@digitalocean.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/error-report.h |  2 ++
 qemu-options.hx             | 12 +++++++++---
 softmmu/vl.c                |  9 +++++++++
 util/qemu-error.c           |  7 +++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 87532d8596..a5ad95ff1b 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -75,5 +75,7 @@ void error_init(const char *argv0);
 const char *error_get_progname(void);
 
 extern bool error_with_timestamp;
+extern bool error_with_guestname;
+extern const char *error_guest_name;
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 196f468786..e5b5d6564a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4291,16 +4291,22 @@ HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg timestamp[=on|off]\n"
+    "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
     "                control error message format\n"
-    "                timestamp=on enables timestamps (default: off)\n",
+    "                timestamp=on enables timestamps (default: off)\n"
+    "                guest-name=on enables guest name prefix but only if\n"
+    "                              -name guest option is set (default: off)\n",
     QEMU_ARCH_ALL)
 SRST
-``-msg timestamp[=on|off]``
+``-msg [timestamp[=on|off]][,guest-name[=on|off]]``
     Control error message format.
 
     ``timestamp=on|off``
         Prefix messages with a timestamp. Default is off.
+
+    ``guest-name=on|off``
+        Prefix messages with guest name but only if -name guest option is set
+        otherwise the option is ignored. Default is off.
 ERST
 
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3e15ee2435..b003a49058 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -389,6 +389,12 @@ static QemuOptsList qemu_msg_opts = {
             .name = "timestamp",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "guest-name",
+            .type = QEMU_OPT_BOOL,
+            .help = "Prepends guest name for error messages but only if "
+                    "-name guest is set otherwise option is ignored\n",
+        },
         { /* end of list */ }
     },
 };
@@ -1109,6 +1115,7 @@ static void realtime_init(void)
 static void configure_msg(QemuOpts *opts)
 {
     error_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
+    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
 }
 
 
@@ -3578,6 +3585,8 @@ void qemu_init(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                /* Capture guest name if -msg guest-name is used later */
+                error_guest_name = qemu_opt_get(opts, "guest");
                 break;
             case QEMU_OPTION_prom_env:
                 if (nb_prom_envs >= MAX_PROM_ENVS) {
diff --git a/util/qemu-error.c b/util/qemu-error.c
index dac7c7dc50..3ee41438e9 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -26,6 +26,8 @@ typedef enum {
 
 /* Prepend timestamp to messages */
 bool error_with_timestamp;
+bool error_with_guestname;
+const char *error_guest_name;
 
 int error_printf(const char *fmt, ...)
 {
@@ -213,6 +215,11 @@ static void vreport(report_type type, const char *fmt, va_list ap)
         g_free(timestr);
     }
 
+    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
+    if (error_with_guestname && error_guest_name && !cur_mon) {
+        error_printf("%s ", error_guest_name);
+    }
+
     print_loc();
 
     switch (type) {
-- 
2.26.2



