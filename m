Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB41206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imV7/iy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB41206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFtZ-0001YK-SO
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFrc-0007Sq-0o
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFra-0003MN-AC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598288549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxySJVrnEnh7ML01Y3qGldicKlwFsU6fSDsmzi00OZ8=;
 b=imV7/iy7oZ8vFmCLP9wpqDBBXnTzs9/d3edulnDjMvBBDWo+c6ECaY2fbOu2gkhxCHieHl
 1g5CCLIgwUzrS9buWcMawC0cmSZvN5v1LoT59/t/IA64GqFtNh9kLXhCcr5WVxi8ubW6UB
 /5xvhxKdPlL3heAt9ZAyX2ZLf7k3U1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-I0uoE8YsOmCOIqKYN7chMQ-1; Mon, 24 Aug 2020 13:02:26 -0400
X-MC-Unique: I0uoE8YsOmCOIqKYN7chMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA74801AC9;
 Mon, 24 Aug 2020 17:02:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-223.ams2.redhat.com
 [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7DFC5C1BB;
 Mon, 24 Aug 2020 17:02:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] nbd: disable signals and forking on Windows builds
Date: Mon, 24 Aug 2020 18:02:18 +0100
Message-Id: <20200824170218.106255-3-berrange@redhat.com>
In-Reply-To: <20200824170218.106255-1-berrange@redhat.com>
References: <20200824170218.106255-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:48:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disabling these parts are sufficient to get the qemu-nbd program
compiling in a Windows build.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build |  7 ++-----
 qemu-nbd.c  | 10 +++++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..1071871605 100644
--- a/meson.build
+++ b/meson.build
@@ -1074,12 +1074,9 @@ if have_tools
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
-  qemu_block_tools += [qemu_img, qemu_io]
-  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
-    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+  qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-    qemu_block_tools += [qemu_nbd]
-  endif
+  qemu_block_tools += [qemu_img, qemu_io, qemu_nbd]
 
   subdir('storage-daemon')
   subdir('contrib/rdmacm-mux')
diff --git a/qemu-nbd.c b/qemu-nbd.c
index b102874f0f..c6fd6524d3 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -155,12 +155,13 @@ QEMU_COPYRIGHT "\n"
     , name);
 }
 
+#ifndef WIN32
 static void termsig_handler(int signum)
 {
     atomic_cmpxchg(&state, RUNNING, TERMINATE);
     qemu_notify_event();
 }
-
+#endif
 
 static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
                                 const char *hostname)
@@ -587,6 +588,7 @@ int main(int argc, char **argv)
     unsigned socket_activation;
     const char *pid_file_name = NULL;
 
+#ifndef WIN32
     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
      */
@@ -594,6 +596,7 @@ int main(int argc, char **argv)
     memset(&sa_sigterm, 0, sizeof(sa_sigterm));
     sa_sigterm.sa_handler = termsig_handler;
     sigaction(SIGTERM, &sa_sigterm, NULL);
+#endif
 
 #ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
@@ -896,6 +899,7 @@ int main(int argc, char **argv)
 #endif
 
     if ((device && !verbose) || fork_process) {
+#ifndef WIN32
         int stderr_fd[2];
         pid_t pid;
         int ret;
@@ -959,6 +963,10 @@ int main(int argc, char **argv)
              */
             exit(errors);
         }
+#else /* WIN32 */
+        error_report("Unable to fork into background on Windows hosts");
+        exit(EXIT_FAILURE);
+#endif /* WIN32 */
     }
 
     if (device != NULL && sockpath == NULL) {
-- 
2.26.2


