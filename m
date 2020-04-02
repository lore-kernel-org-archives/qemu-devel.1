Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67394C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 02:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3831F20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 02:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3831F20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJpsh-0002wv-Cb
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 22:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1jJprH-00027x-57
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 22:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1jJprG-0005KP-0F
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 22:45:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38422 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1jJprB-0004lE-Tw; Wed, 01 Apr 2020 22:45:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0854D657555145C53158;
 Thu,  2 Apr 2020 10:45:20 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:45:00 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH v2] util/async: Add memory barrier to aio_ctx_prepare
Date: Thu, 2 Apr 2020 10:44:31 +0800
Message-ID: <20200402024431.1629-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, zhang.zhanghailiang@huawei.com, qemu-stable@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qemu main thread is found to hang up in the mainloop when doing
image format convert on aarch64 platform and it is highly
reproduceable by executing test using:

qemu-img convert -f qcow2 -O qcow2 origin.qcow2 converted.qcow2

This mysterious hang can be explained by a race condition between
the main thread and an io worker thread. There can be a chance that
the last worker thread has called aio_bh_schedule_oneshot and it is
checking against notify_me to deliver a notfiy event. At the same
time, the main thread is calling aio_ctx_prepare however it first
calls qemu_timeout_ns_to_ms, thus the worker thread did not see
notify_me as true and did not send a notify event. The time line
can be shown in the following way:

 Main Thread
 ------------------------------------------------
 aio_ctx_prepare
    atomic_or(&ctx->notify_me, 1);
    /* out of order execution goes here */
    *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));

 Worker Thread
 -----------------------------------------------
 aio_bh_schedule_oneshot -> aio_bh_enqueue
    aio_notify
	smp_mb();
	if (ctx->notify_me) {   /* worker thread checks notify_me here */
	    event_notifier_set(&ctx->notifier);
	    atomic_mb_set(&ctx->notified, true);
	}

Normal VM runtime is not affected by this hang since there is always some
timer timeout or subsequent io worker come and notify the main thead.
To fix this problem, a memory barrier is added to aio_ctx_prepare and
it is proved to have the hang fixed in our test.

This hang is not observed on the x86 platform however it can be easily
reproduced on the aarch64 platform, thus it is architecture related.
Not sure if this is revelant to Commit eabc977973103527bbb8fed69c91cfaa66=
91f8ab

Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>

---
	v2: add comments before the barrier

---
 util/async.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index b94518b..89a4f3e 100644
--- a/util/async.c
+++ b/util/async.c
@@ -250,7 +250,8 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
     AioContext *ctx =3D (AioContext *) source;
=20
     atomic_or(&ctx->notify_me, 1);
-
+    /* Make sure notify_me is set before aio_compute_timeout */
+    smp_mb();
     /* We assume there is no timeout already supplied */
     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
=20
--=20
1.8.3.1



