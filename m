Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDCAC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64DEC2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hjsbEjBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DEC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPgG-0001qh-Gi
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPV0-00070X-GU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUz-0000b8-9M
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:50 -0500
Received: from ozlabs.org ([203.11.71.1]:47459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixPUy-0000ZP-UP; Fri, 31 Jan 2020 01:09:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4886Hw1M9Yz9sSp; Fri, 31 Jan 2020 17:09:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580450972;
 bh=YIdqK1tRx6Js2Yz0nu83Aa0ByFCx7euikjoqWW8kzKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hjsbEjBs9RKhr7PwJ7Hp0B5Y7JXwIl6GjBqBfqc4BJ4u8QPdRIhMSCzVy6IWBvjY4
 g7K0/atKdmgPp9tsf0qYoSq578oE0z5Q/pXJGnhUKq/vEmPCp7Ff3eEIHoMjz3sxE3
 WW9xlLAMphp1cXzH1WzOYjfh0CnjNfiCKbh/nElY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 24/34] Wrapper function to wait on condition for the main loop
 mutex
Date: Fri, 31 Jan 2020 17:09:14 +1100
Message-Id: <20200131060924.147449-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131060924.147449-1-david@gibson.dropbear.id.au>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Aravinda Prasad <arawinda.p@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aravinda Prasad <arawinda.p@gmail.com>

Introduce a wrapper function to wait on condition for
the main loop mutex. This function atomically releases
the main loop mutex and causes the calling thread to
block on the condition. This wrapper is required because
qemu_global_mutex is a static variable.

Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200130184423.20519-2-ganeshgr@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 cpus.c                   | 5 +++++
 include/qemu/main-loop.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/cpus.c b/cpus.c
index b612116f95..b4f8b84b61 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1839,6 +1839,11 @@ void qemu_mutex_unlock_iothread(void)
     qemu_mutex_unlock(&qemu_global_mutex);
 }
=20
+void qemu_cond_wait_iothread(QemuCond *cond)
+{
+    qemu_cond_wait(cond, &qemu_global_mutex);
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index f6ba78ea73..a6d20b0719 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file,=
 int line);
  */
 void qemu_mutex_unlock_iothread(void);
=20
+/*
+ * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
+ *
+ * This function atomically releases the main loop mutex and causes
+ * the calling thread to block on the condition.
+ */
+void qemu_cond_wait_iothread(QemuCond *cond);
+
 /* internal interfaces */
=20
 void qemu_fd_register(int fd);
--=20
2.24.1


