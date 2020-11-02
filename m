Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6CC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D19223AC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7Z+GLaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D19223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYV5-0004l3-97
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZYUB-0003uc-1Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZYU8-0003dB-Ul
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604318332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ycHutG8a0nYkkphwYHwwF11Dqcw1B5bZHU7Uu2oN1Vo=;
 b=C7Z+GLaVs7I0EdbqDOpmhyUrDIkDS8y8QlpDjEexYo1IPpp8iWQVK1xmxYdHQZnTAKedSu
 0w0jHGXC9txaVs3sSF0aT2vYlUQ2pk7Ec5/3Xgx1V0Nm7FzrfjLEoAEM6otJpa6AcrtNcH
 uVAuCnArqVSVj2zw/n8LiPnQa1FqbQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-3kyDT1Y-P0SZ2sIYxpw03g-1; Mon, 02 Nov 2020 06:58:50 -0500
X-MC-Unique: 3kyDT1Y-P0SZ2sIYxpw03g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7448E18B9F8A
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 11:58:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47EAC5C5DE;
 Mon,  2 Nov 2020 11:58:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] trace: remove argument from trace_init_file
Date: Mon,  2 Nov 2020 06:58:41 -0500
Message-Id: <20201102115841.4017692-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not needed, all the callers are just saving what was
retrieved from -trace and trace_init_file can retrieve it
on its own.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/main.c                      |  6 ++----
 linux-user/main.c                    |  6 ++----
 qemu-img.c                           |  6 ++----
 qemu-io.c                            |  6 ++----
 qemu-nbd.c                           |  6 ++----
 scsi/qemu-pr-helper.c                |  6 ++----
 softmmu/vl.c                         |  6 ++----
 storage-daemon/qemu-storage-daemon.c |  9 +++------
 trace/control.c                      | 10 ++++------
 trace/control.h                      | 12 +++---------
 10 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index ac40d79bfa..0a918e8f74 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -745,7 +745,6 @@ int main(int argc, char **argv)
     const char *gdbstub = NULL;
     char **target_environ, **wrk;
     envlist_t *envlist = NULL;
-    char *trace_file = NULL;
     bsd_type = target_openbsd;
 
     if (argc <= 1)
@@ -851,8 +850,7 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "strace")) {
             do_strace = 1;
         } else if (!strcmp(r, "trace")) {
-            g_free(trace_file);
-            trace_file = trace_opt_parse(optarg);
+            trace_opt_parse(optarg);
         } else {
             usage();
         }
@@ -880,7 +878,7 @@ int main(int argc, char **argv)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..24d1eb73ad 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -386,11 +386,9 @@ static void handle_arg_version(const char *arg)
     exit(EXIT_SUCCESS);
 }
 
-static char *trace_file;
 static void handle_arg_trace(const char *arg)
 {
-    g_free(trace_file);
-    trace_file = trace_opt_parse(arg);
+    trace_opt_parse(arg);
 }
 
 #if defined(TARGET_XTENSA)
@@ -672,7 +670,7 @@ int main(int argc, char **argv, char **envp)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
     if (qemu_plugin_load_list(&plugins)) {
         exit(1);
     }
diff --git a/qemu-img.c b/qemu-img.c
index a968c74cba..5856811645 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5466,7 +5466,6 @@ int main(int argc, char **argv)
     const img_cmd_t *cmd;
     const char *cmdname;
     Error *local_error = NULL;
-    char *trace_file = NULL;
     int c;
     static const struct option long_options[] = {
         {"help", no_argument, 0, 'h'},
@@ -5516,8 +5515,7 @@ int main(int argc, char **argv)
             printf(QEMU_IMG_VERSION);
             return 0;
         case 'T':
-            g_free(trace_file);
-            trace_file = trace_opt_parse(optarg);
+            trace_opt_parse(optarg);
             break;
         }
     }
@@ -5535,7 +5533,7 @@ int main(int argc, char **argv)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
     qemu_set_log(LOG_TRACE);
 
     /* find the command */
diff --git a/qemu-io.c b/qemu-io.c
index 7cc832b3d6..ac88d8bd40 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -536,7 +536,6 @@ int main(int argc, char **argv)
     Error *local_error = NULL;
     QDict *opts = NULL;
     const char *format = NULL;
-    char *trace_file = NULL;
     bool force_share = false;
 
 #ifdef CONFIG_POSIX
@@ -601,8 +600,7 @@ int main(int argc, char **argv)
             }
             break;
         case 'T':
-            g_free(trace_file);
-            trace_file = trace_opt_parse(optarg);
+            trace_opt_parse(optarg);
             break;
         case 'V':
             printf("%s version " QEMU_FULL_VERSION "\n"
@@ -653,7 +651,7 @@ int main(int argc, char **argv)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
     qemu_set_log(LOG_TRACE);
 
     /* initialize commands */
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 75ced65030..a7075c5419 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -581,7 +581,6 @@ int main(int argc, char **argv)
     const char *tlscredsid = NULL;
     bool imageOpts = false;
     bool writethrough = true;
-    char *trace_file = NULL;
     bool fork_process = false;
     bool list = false;
     int old_stderr = -1;
@@ -768,8 +767,7 @@ int main(int argc, char **argv)
             imageOpts = true;
             break;
         case 'T':
-            g_free(trace_file);
-            trace_file = trace_opt_parse(optarg);
+            trace_opt_parse(optarg);
             break;
         case QEMU_NBD_OPT_TLSAUTHZ:
             tlsauthz = optarg;
@@ -816,7 +814,7 @@ int main(int argc, char **argv)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
     qemu_set_log(LOG_TRACE);
 
     socket_activation = check_socket_activation();
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d26faaf91e..2733d92f2d 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -884,7 +884,6 @@ int main(int argc, char **argv)
     int quiet = 0;
     int ch;
     Error *local_err = NULL;
-    char *trace_file = NULL;
     bool daemonize = false;
     bool pidfile_specified = false;
     bool socket_path_specified = false;
@@ -968,8 +967,7 @@ int main(int argc, char **argv)
             ++loglevel;
             break;
         case 'T':
-            g_free(trace_file);
-            trace_file = trace_opt_parse(optarg);
+            trace_opt_parse(optarg);
             break;
         case 'V':
             version(argv[0]);
@@ -992,7 +990,7 @@ int main(int argc, char **argv)
     if (!trace_init_backends()) {
         exit(EXIT_FAILURE);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
     qemu_set_log(LOG_TRACE);
 
 #ifdef CONFIG_MPATH
diff --git a/softmmu/vl.c b/softmmu/vl.c
index c0ad123e2b..8070c273b2 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2885,7 +2885,6 @@ void qemu_init(int argc, char **argv, char **envp)
     int display_remote = 0;
     const char *log_mask = NULL;
     const char *log_file = NULL;
-    char *trace_file = NULL;
     ram_addr_t maxram_size;
     uint64_t ram_slots = 0;
     FILE *vmstate_dump_file = NULL;
@@ -3687,8 +3686,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 xen_domid_restrict = true;
                 break;
             case QEMU_OPTION_trace:
-                g_free(trace_file);
-                trace_file = trace_opt_parse(optarg);
+                trace_opt_parse(optarg);
                 break;
             case QEMU_OPTION_plugin:
                 qemu_plugin_opt_parse(optarg, &plugin_list);
@@ -3938,7 +3936,7 @@ void qemu_init(int argc, char **argv, char **envp)
     if (!trace_init_backends()) {
         exit(1);
     }
-    trace_init_file(trace_file);
+    trace_init_file();
 
     /* Open the logfile at this point and set the log mask if necessary.
      */
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index e419ba9f19..7c914b0dc1 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -180,12 +180,9 @@ static void process_options(int argc, char *argv[])
             help();
             exit(EXIT_SUCCESS);
         case 'T':
-            {
-                char *trace_file = trace_opt_parse(optarg);
-                trace_init_file(trace_file);
-                g_free(trace_file);
-                break;
-            }
+            trace_opt_parse(optarg);
+            trace_init_file();
+            break;
         case 'V':
             printf("qemu-storage-daemon version "
                    QEMU_FULL_VERSION "\n" QEMU_COPYRIGHT "\n");
diff --git a/trace/control.c b/trace/control.c
index 5669db7eea..b82fb87316 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -222,8 +222,10 @@ static void trace_init_events(const char *fname)
     loc_pop(&loc);
 }
 
-void trace_init_file(const char *file)
+void trace_init_file(void)
 {
+    QemuOpts *opts = qemu_find_opts_singleton("trace");
+    const char *file = qemu_opt_get(opts, "file");
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
     if (init_trace_on_startup) {
@@ -289,9 +291,8 @@ bool trace_init_backends(void)
     return true;
 }
 
-char *trace_opt_parse(const char *optarg)
+void trace_opt_parse(const char *optarg)
 {
-    char *trace_file;
     QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("trace"),
                                              optarg, true);
     if (!opts) {
@@ -301,11 +302,8 @@ char *trace_opt_parse(const char *optarg)
         trace_enable_events(qemu_opt_get(opts, "enable"));
     }
     trace_init_events(qemu_opt_get(opts, "events"));
-    trace_file = g_strdup(qemu_opt_get(opts, "file"));
     init_trace_on_startup = true;
     qemu_opts_del(opts);
-
-    return trace_file;
 }
 
 uint32_t trace_get_vcpu_event_count(void)
diff --git a/trace/control.h b/trace/control.h
index 1f81c491b6..05b95ea453 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -167,8 +167,6 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
 
 /**
  * trace_init_backends:
- * @file:   Name of trace output file; may be NULL.
- *          Corresponds to commandline option "--trace file=...".
  *
  * Initialize the tracing backend.
  *
@@ -178,14 +176,12 @@ bool trace_init_backends(void);
 
 /**
  * trace_init_file:
- * @file:   Name of trace output file; may be NULL.
- *          Corresponds to commandline option "--trace file=...".
  *
  * Record the name of the output file for the tracing backend.
  * Exits if no selected backend does not support specifying the
- * output file, and a non-NULL file was passed.
+ * output file, and a file was specified with "-trace file=...".
  */
-void trace_init_file(const char *file);
+void trace_init_file(void);
 
 /**
  * trace_init_vcpu:
@@ -229,10 +225,8 @@ extern QemuOptsList qemu_trace_opts;
  * @optarg: A string argument of --trace command line argument
  *
  * Initialize tracing subsystem.
- *
- * Returns the filename to save trace to.  It must be freed with g_free().
  */
-char *trace_opt_parse(const char *optarg);
+void trace_opt_parse(const char *optarg);
 
 /**
  * trace_get_vcpu_event_count:
-- 
2.26.2


