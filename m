Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE23C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A012223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0lWrdP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A012223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzQN-00048F-5u
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOo-0002PL-AN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOm-0006an-Im
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=V0PRhaPjLl3QP5oLM98HuwMXBLJa28Xqbdj0nuobKHE=;
 b=K0lWrdP+cGJJzBmF4BK/AvXlBiJyfio9ui532fa/gm/4Gi0AB701tVWZx4pg1ER4H2ZYci
 iyCidmJptr8WyAIhNq5Nycx72dXg+h9LANUoamRWFuSimXeLvd00C74P2XBXx38OR7rhjm
 qrluHM1MpXsrOw1odlGMAUv9dp6ypmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-uKTaoNz9NzC6lHhY_ahv3Q-1; Mon, 26 Oct 2020 06:06:41 -0400
X-MC-Unique: uKTaoNz9NzC6lHhY_ahv3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7976123B;
 Mon, 26 Oct 2020 10:06:40 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43B6F8B841;
 Mon, 26 Oct 2020 10:06:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/31] accel: Remove _WIN32 ifdef from qtest-cpus.c
Date: Mon, 26 Oct 2020 11:06:04 +0100
Message-Id: <20201026100632.212530-4-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

dummy-cpus.c is only compiled with CONFIG_POSIX, so the _WIN32 condition
will never evaluate true.  Remove it.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-Id: <20201013140511.5681-2-jandryuk@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/qtest/qtest-cpus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
index 7c5399ed9d..db094201c1 100644
--- a/accel/qtest/qtest-cpus.c
+++ b/accel/qtest/qtest-cpus.c
@@ -29,10 +29,6 @@
 
 static void *qtest_cpu_thread_fn(void *arg)
 {
-#ifdef _WIN32
-    error_report("qtest is not supported under Windows");
-    exit(1);
-#else
     CPUState *cpu = arg;
     sigset_t waitset;
     int r;
@@ -69,7 +65,6 @@ static void *qtest_cpu_thread_fn(void *arg)
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
-#endif
 }
 
 static void qtest_start_vcpu_thread(CPUState *cpu)
-- 
2.18.2


