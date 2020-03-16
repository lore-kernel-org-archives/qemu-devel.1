Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB471C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955DD205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LopQyfnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955DD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxbb-00083h-PJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHs-00044I-2C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHo-0006CQ-M6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHo-00068b-GG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxC1eILjyyD4vXLg01tF8j7MmRukmacLFrXLAYZM6r4=;
 b=LopQyfnfFRMwh55F3fxmeLAgjmyAFye3GLLHkQLFUszkq0SzjPgCYPHnjqeuTndrJ6aeO+
 czPtQ7Fu7ROj/aDth0I8CUclW8tAXKwycH4eJV1n2wjTcxoswCR2HNbQTOLrDYTThf8RvD
 mbLLvDhuQQSuRa7MNoVmmoYEmkrN3u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-iAUgFsVKNAiTFCetGgpXDA-1; Mon, 16 Mar 2020 17:28:32 -0400
X-MC-Unique: iAUgFsVKNAiTFCetGgpXDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E023149CF;
 Mon, 16 Mar 2020 21:28:31 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46AD319C4F;
 Mon, 16 Mar 2020 21:28:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/61] softmmu/vl.c: Handle '-cpu help' and '-device help'
 before 'no default machine'
Date: Mon, 16 Mar 2020 22:26:58 +0100
Message-Id: <1584394048-44994-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently if you try to ask for the list of CPUs for a target
architecture which does not specify a default machine type
you just get an error:

  $ qemu-system-arm -cpu help
  qemu-system-arm: No machine specified, and there is no default
  Use -machine help to list supported machines

Since the list of CPUs doesn't depend on the machine, this is
unnecessarily unhelpful. "-device help" has a similar problem.

Move the checks for "did the user ask for -cpu help or -device help"
up so they precede the select_machine() call which checks that the
user specified a valid machine type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ff2685d..6a28592 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3789,6 +3789,22 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     loc_set_none();
=20
+    /*
+     * Check for -cpu help and -device help before we call select_machine(=
),
+     * which will return an error if the architecture has no default machi=
ne
+     * type and the user did not specify one, so that the user doesn't nee=
d
+     * to say '-cpu help -machine something'.
+     */
+    if (cpu_option && is_help_option(cpu_option)) {
+        list_cpus(cpu_option);
+        exit(0);
+    }
+
+    if (qemu_opts_foreach(qemu_find_opts("device"),
+                          device_help_func, NULL, NULL)) {
+        exit(0);
+    }
+
     user_register_global_props();
=20
     replay_configure(icount_opts);
@@ -3877,11 +3893,6 @@ void qemu_init(int argc, char **argv, char **envp)
         qemu_set_hw_version(machine_class->hw_version);
     }
=20
-    if (cpu_option && is_help_option(cpu_option)) {
-        list_cpus(cpu_option);
-        exit(0);
-    }
-
     if (!trace_init_backends()) {
         exit(1);
     }
@@ -4112,11 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
                       fsdev_init_func, NULL, &error_fatal);
 #endif
=20
-    if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_help_func, NULL, NULL)) {
-        exit(0);
-    }
-
     /*
      * Note: we need to create block backends before
      * machine_set_property(), so machine properties can refer to
--=20
1.8.3.1



