Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D06C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610812086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610812086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylw7-0007bB-ID
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylSB-0001bO-Nt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylSA-0007qi-Jn
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:16:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylSA-0007qF-Ei; Fri, 16 Aug 2019 19:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDDEF30A5686;
 Fri, 16 Aug 2019 23:16:13 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26ED917BB9;
 Fri, 16 Aug 2019 23:16:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:16:08 -0400
Message-Id: <20190816231609.9521-3-jsnow@redhat.com>
In-Reply-To: <20190816231609.9521-1-jsnow@redhat.com>
References: <20190816231609.9521-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 16 Aug 2019 23:16:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] Revert "ide/ahci: Check for -ECANCELED in
 aio callbacks"
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
Cc: peter.maydell@linaro.org, Shaju Abraham <shaju.abraham@nutanix.com>,
 jsnow@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 0d910cfeaf2076b116b4517166d5deb0fea76394.

It's not correct to just ignore an error code in a callback; we need to
handle that error and possible report failure to the guest so that they
don't wait indefinitely for an operation that will now never finish.

This ought to help cases reported by Nutanix where iSCSI returns a
legitimate -ECANCELED for certain operations which should be propagated
normally.

Reported-by: Shaju Abraham <shaju.abraham@nutanix.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190729223605.7163-1-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c |  3 ---
 hw/ide/core.c | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d72da85605a..d45393c019d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1025,9 +1025,6 @@ static void ncq_cb(void *opaque, int ret)
     IDEState *ide_state =3D &ncq_tfs->drive->port.ifs[0];
=20
     ncq_tfs->aiocb =3D NULL;
-    if (ret =3D=3D -ECANCELED) {
-        return;
-    }
=20
     if (ret < 0) {
         bool is_read =3D ncq_tfs->cmd =3D=3D READ_FPDMA_QUEUED;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 38b6cdac87b..e6e54c6c9a2 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -723,9 +723,6 @@ static void ide_sector_read_cb(void *opaque, int ret)
     s->pio_aiocb =3D NULL;
     s->status &=3D ~BUSY_STAT;
=20
-    if (ret =3D=3D -ECANCELED) {
-        return;
-    }
     if (ret !=3D 0) {
         if (ide_handle_rw_error(s, -ret, IDE_RETRY_PIO |
                                 IDE_RETRY_READ)) {
@@ -841,10 +838,6 @@ static void ide_dma_cb(void *opaque, int ret)
     uint64_t offset;
     bool stay_active =3D false;
=20
-    if (ret =3D=3D -ECANCELED) {
-        return;
-    }
-
     if (ret =3D=3D -EINVAL) {
         ide_dma_error(s);
         return;
@@ -976,10 +969,6 @@ static void ide_sector_write_cb(void *opaque, int re=
t)
     IDEState *s =3D opaque;
     int n;
=20
-    if (ret =3D=3D -ECANCELED) {
-        return;
-    }
-
     s->pio_aiocb =3D NULL;
     s->status &=3D ~BUSY_STAT;
=20
@@ -1059,9 +1048,6 @@ static void ide_flush_cb(void *opaque, int ret)
=20
     s->pio_aiocb =3D NULL;
=20
-    if (ret =3D=3D -ECANCELED) {
-        return;
-    }
     if (ret < 0) {
         /* XXX: What sector number to set here? */
         if (ide_handle_rw_error(s, -ret, IDE_RETRY_FLUSH)) {
--=20
2.21.0


