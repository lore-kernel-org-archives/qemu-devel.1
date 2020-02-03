Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F0C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629F52080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hyTxChGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629F52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV3e-0005dW-Do
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxR-0002aX-VT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxQ-0002fy-E5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:41 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38663 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxQ-0002Z7-1z; Mon, 03 Feb 2020 01:11:40 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBp4qCMz9sSX; Mon,  3 Feb 2020 17:11:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710290;
 bh=U+wz4tpMQershG/v0k5XFHf47IX4TK/gQB/3vxIqD/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hyTxChGguM6nbp0MDq3jdqWNF/rYWIm2EirNUu0t5Sf/dIbNUexM4clCj5tfkB7+A
 h7mntcoEPEFWl3tHeSKrWogb7BW3F9JqNkKQGi35VvbVE0nirps28wJzEBc/BY1MDR
 l8U7zRAyOWb2ua0vJY9vTZYUsCTknOlIW1wwdi9E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/35] tpm_spapr: Support suspend and resume
Date: Mon,  3 Feb 2020 17:11:04 +1100
Message-Id: <20200203061123.59150-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the tpm_spapr frontend with VM suspend and resume support.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Message-Id: <20200121152935.649898-5-stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/tpm/tpm_spapr.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/tpm/trace-events |  2 ++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 2ac4cb061c..ce65eb2e45 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -76,6 +76,8 @@ typedef struct {
=20
     unsigned char *buffer;
=20
+    uint32_t numbytes; /* number of bytes to deliver on resume */
+
     TPMBackendCmd cmd;
=20
     TPMBackend *be_driver;
@@ -240,6 +242,14 @@ static void tpm_spapr_request_completed(TPMIf *ti, i=
nt ret)
=20
     /* a max. of be_buffer_size bytes can be transported */
     len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
+
+    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        trace_tpm_spapr_caught_response(len);
+        /* defer delivery of response until .post_load */
+        s->numbytes =3D len;
+        return;
+    }
+
     rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
                              s->buffer, len);
=20
@@ -288,6 +298,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
     SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
=20
     s->state =3D SPAPR_VTPM_STATE_NONE;
+    s->numbytes =3D 0;
=20
     s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
=20
@@ -309,9 +320,48 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
     return tpm_backend_get_tpm_version(s->be_driver);
 }
=20
+/* persistent state handling */
+
+static int tpm_spapr_pre_save(void *opaque)
+{
+    SpaprTpmState *s =3D opaque;
+
+    tpm_backend_finish_sync(s->be_driver);
+    /*
+     * we cannot deliver the results to the VM since DMA would touch VM =
memory
+     */
+
+    return 0;
+}
+
+static int tpm_spapr_post_load(void *opaque, int version_id)
+{
+    SpaprTpmState *s =3D opaque;
+
+    if (s->numbytes) {
+        trace_tpm_spapr_post_load();
+        /* deliver the results to the VM via DMA */
+        tpm_spapr_request_completed(TPM_IF(s), 0);
+        s->numbytes =3D 0;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_vtpm =3D {
     .name =3D "tpm-spapr",
-    .unmigratable =3D 1,
+    .pre_save =3D tpm_spapr_pre_save,
+    .post_load =3D tpm_spapr_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
+
+        VMSTATE_UINT8(state, SpaprTpmState),
+        VMSTATE_UINT32(numbytes, SpaprTpmState),
+        VMSTATE_VBUFFER_UINT32(buffer, SpaprTpmState, 0, NULL, numbytes)=
,
+        /* remember DMA address */
+        VMSTATE_UINT32(crq.data, SpaprTpmState),
+        VMSTATE_END_OF_LIST(),
+    }
 };
=20
 static Property tpm_spapr_properties[] =3D {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 9143a8eaa3..439e514787 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "respons=
e: version %u"
 tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
 tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
 tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
+tpm_spapr_post_load(void) "Delivering TPM response after resume"
+tpm_spapr_caught_response(uint32_t v) "Caught response to deliver after =
resume: %u bytes"
--=20
2.24.1


