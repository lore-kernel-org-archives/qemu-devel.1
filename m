Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49455C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA52321738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Y+3i/bif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52321738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqINY-0003RX-2v
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqINL-0002x3-6K
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hqINK-0008Nz-45
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:36:15 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:44366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hqINH-0008Jp-C1; Wed, 24 Jul 2019 10:36:11 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 11EFB96F51;
 Wed, 24 Jul 2019 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1563978968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KUurv/KQaHtXORkxGqb0dU1d7NJ5+71uYGLwWNlG2hI=;
 b=Y+3i/bif+o99Uor3vTkcEH7yR9iWCWLrUjYaQAeYq0L0fd2vlDQX0xtWpV9cXa/TFYmf6l
 w+ypNuzmqq6IMUV+2tVJ4IiJtTf0SbgH4Kitukm6b0/OBm+tShRCidTsJXYNEpnMnzS7hT
 Xk8oqeuEpjY8xMNcHQiMahISyl2mxdo=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 16:35:53 +0200
Message-Id: <20190724143553.21557-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1563978968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KUurv/KQaHtXORkxGqb0dU1d7NJ5+71uYGLwWNlG2hI=;
 b=4wpMEr021XD0hMVbulDG6wTO+FlpLQVrxdJ94hueM2/mTsASn7pQYSYoKoeYWoJvHb6v/p
 lzWEiPsamiN6fHXe8CNT94m6UUhmtVp7eLm0T8IySZEfAjInGzwt+vkUZolk9LRQh5DPO+
 kAhWhIHshrKPIlf/aqUgREfzhI8v00w=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1563978968; a=rsa-sha256; cv=none;
 b=ic1ek3cXPpEdtxhEagFf9PbCZYG3bOhv/BvA2RYQwHK3j07IyJXznAKIBTPTQkDyj77PXE
 LrucliYHki1kH3lhVtFmaN16qfHef5NqHB2NwaNvtlfg/YOl1afw1825VrYdvsOa2fuZ5A
 wMMiUfqqd/ymyNJBDqWZ4HCkXKyHj1U=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH for 4.1?] pl330: fix vmstate description
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the pl330 main and queue vmstate description.
There were missing POINTER flags causing crashes during
incoming migration because:
+ PL330State chan field is a pointer to an array
+ PL330Queue queue field is a pointer to an array

Also bump corresponding vmsd version numbers.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

I found this while working on reset with xilinx-zynq machine.

I'm not sure what's the vmsd version policy in such cases (for
backward compatibility). I've simply bumped them since migration
was not working anyway (vmstate_load_state was erasing critical part
of PL330State and causing segfaults while loading following fields).

Tested doing migration with the xilinx-zynq-a9 machine.

---
 hw/dma/pl330.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 58df965a46..a56a3e7771 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -218,11 +218,12 @@ typedef struct PL330Queue {
=20
 static const VMStateDescription vmstate_pl330_queue =3D {
     .name =3D "pl330_queue",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_UINT32(queue, PL330Queue, queue_size, 1,
-                                 vmstate_pl330_queue_entry, PL330QueueEn=
try),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(queue, PL330Queue, queue_si=
ze,
+                                             vmstate_pl330_queue_entry,
+                                             PL330QueueEntry),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -278,12 +279,12 @@ struct PL330State {
=20
 static const VMStateDescription vmstate_pl330 =3D {
     .name =3D "pl330",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_STRUCT(manager, PL330State, 0, vmstate_pl330_chan, PL330=
Chan),
-        VMSTATE_STRUCT_VARRAY_UINT32(chan, PL330State, num_chnls, 0,
-                                     vmstate_pl330_chan, PL330Chan),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(chan, PL330State, num_chnls=
,
+                                             vmstate_pl330_chan, PL330Ch=
an),
         VMSTATE_VBUFFER_UINT32(lo_seqn, PL330State, 1, NULL, num_chnls),
         VMSTATE_VBUFFER_UINT32(hi_seqn, PL330State, 1, NULL, num_chnls),
         VMSTATE_STRUCT(fifo, PL330State, 0, vmstate_pl330_fifo, PL330Fif=
o),
--=20
2.22.0


