Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6C2206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZQdnvd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6C2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGq4-0002Ou-LC
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGka-00020T-Lc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGkZ-0000V4-F0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGkZ-0000TX-Aj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcgxP654q8JrZZKpweOj7VL388Y+101SMguXVusGbCk=;
 b=IZQdnvd4colSmvGNJqO5kW7+t9pfo7n5bnbyH5PHf7pgIBmM7DJc1ConE0ErRgppW4ml7u
 2aKoSFlbOsdNKNt9kGJEFL6MldTBQYzSQ9t24/CSQhN8MiWQ+xT4Uf1XvUtFkaWz3OKuoC
 JH20Kajx+vfWxVize08To6SV1B3p3Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-sLW230SQNdO0XWtKNxKGtw-1; Tue, 17 Dec 2019 12:35:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B36E800D24;
 Tue, 17 Dec 2019 17:35:06 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C65019C4F;
 Tue, 17 Dec 2019 17:35:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/scsi/megasas: Silent GCC9 duplicated-cond warning
Date: Tue, 17 Dec 2019 18:34:24 +0100
Message-Id: <20191217173425.5082-6-philmd@redhat.com>
In-Reply-To: <20191217173425.5082-1-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sLW230SQNdO0XWtKNxKGtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC9 is confused when building with CFLAG -O3:

  hw/scsi/megasas.c: In function =E2=80=98megasas_scsi_realize=E2=80=99:
  hw/scsi/megasas.c:2387:26: error: duplicated =E2=80=98if=E2=80=99 conditi=
on [-Werror=3Dduplicated-cond]
   2387 |     } else if (s->fw_sge >=3D 128 - MFI_PASS_FRAME_SIZE) {
  hw/scsi/megasas.c:2385:19: note: previously used here
   2385 |     if (s->fw_sge >=3D MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
  cc1: all warnings being treated as errors

When this device was introduced in commit e8f943c3bcc, the author
cared about modularity, using a definition for the firmware limit.
If we modify the limit, the code is valid. Add a check if the
definition got modified to a bigger limit.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Hannes Reinecke <hare@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: qemu-block@nongnu.org
---
 hw/scsi/megasas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index de9bd20887..ece1601b66 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2382,7 +2382,8 @@ static void megasas_scsi_realize(PCIDevice *dev, Erro=
r **errp)
     if (!s->hba_serial) {
         s->hba_serial =3D g_strdup(MEGASAS_HBA_SERIAL);
     }
-    if (s->fw_sge >=3D MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
+    if (MEGASAS_MAX_SGE > 128
+        && s->fw_sge >=3D MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
         s->fw_sge =3D MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
     } else if (s->fw_sge >=3D 128 - MFI_PASS_FRAME_SIZE) {
         s->fw_sge =3D 128 - MFI_PASS_FRAME_SIZE;
--=20
2.21.0


