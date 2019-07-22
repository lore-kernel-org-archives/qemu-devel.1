Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636CC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562A6217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562A6217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpc5w-0003DP-5Q
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hpc5b-00025R-IL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hpc5a-0004Yh-By
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hpc5Y-0004PY-6G; Mon, 22 Jul 2019 13:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B53893082126;
 Mon, 22 Jul 2019 17:26:51 +0000 (UTC)
Received: from localhost (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A039760BFB;
 Mon, 22 Jul 2019 17:26:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 22 Jul 2019 19:26:14 +0200
Message-Id: <20190722172616.28797-4-mreitz@redhat.com>
In-Reply-To: <20190722172616.28797-1-mreitz@redhat.com>
References: <20190722172616.28797-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 22 Jul 2019 17:26:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/5] block/nvme: don't touch the completion
 entries
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Completion entries are meant to be only read by the host and written by t=
he device.
The driver is supposed to scan the completions from the last point where =
it left,
and until it sees a completion with non flipped phase bit.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190716163020.13383-4-mlevitsk@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nvme.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 35ce10dc79..c28755cc31 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -318,7 +318,7 @@ static bool nvme_process_completion(BDRVNVMeState *s,=
 NVMeQueuePair *q)
     while (q->inflight) {
         int16_t cid;
         c =3D (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
-        if (!c->cid || (le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase=
) {
+        if ((le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase) {
             break;
         }
         q->cq.head =3D (q->cq.head + 1) % NVME_QUEUE_SIZE;
@@ -342,10 +342,7 @@ static bool nvme_process_completion(BDRVNVMeState *s=
, NVMeQueuePair *q)
         qemu_mutex_unlock(&q->lock);
         req.cb(req.opaque, nvme_translate_error(c));
         qemu_mutex_lock(&q->lock);
-        c->cid =3D cpu_to_le16(0);
         q->inflight--;
-        /* Flip Phase Tag bit. */
-        c->status =3D cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
         progress =3D true;
     }
     if (progress) {
--=20
2.21.0


