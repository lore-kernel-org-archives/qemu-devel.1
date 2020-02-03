Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96BBC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51622080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qPsr2uzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51622080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV25-0002Bt-TD
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxQ-0002Vg-6Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxO-0002c4-9U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:40 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43131 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxN-0002XC-S4; Mon, 03 Feb 2020 01:11:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBp1L23z9sRm; Mon,  3 Feb 2020 17:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710290;
 bh=/gMtryY5Y8bw1UckL7OkaDAyp68AQ1ZkrQyBfh5fIBQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qPsr2uzpdA06lHZrK8HZwnCOlTBZ12Dw48DclsgTQqfws7LhZIAVXnkpnaYJ+PQ40
 +C6g7zSSz41viGe7aVuayPwNWnmUCUINtGxlIDd6jUBrZNKBjqnvlBRNxDl5g+PwNm
 w/rYQyOigFvBycbcAFmWrp4CssT055paeIjk6mPg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/35] tpm: Move tpm_tis_show_buffer to tpm_util.c
Date: Mon,  3 Feb 2020 17:11:01 +1100
Message-Id: <20200203061123.59150-14-david@gibson.dropbear.id.au>
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
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200121152935.649898-2-stefanb@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/tpm/tpm_tis.c    | 32 ++++----------------------------
 hw/tpm/tpm_util.c   | 25 +++++++++++++++++++++++++
 hw/tpm/tpm_util.h   |  3 +++
 hw/tpm/trace-events |  2 +-
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 5362df2711..31facb896d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -107,30 +107,6 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr add=
r)
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
=20
-static void tpm_tis_show_buffer(const unsigned char *buffer,
-                                size_t buffer_size, const char *string)
-{
-    size_t len, i;
-    char *line_buffer, *p;
-
-    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
-
-    /*
-     * allocate enough room for 3 chars per buffer entry plus a
-     * newline after every 16 chars and a final null terminator.
-     */
-    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
-
-    for (i =3D 0, p =3D line_buffer; i < len; i++) {
-        if (i && !(i % 16)) {
-            p +=3D sprintf(p, "\n");
-        }
-        p +=3D sprintf(p, "%.2X ", buffer[i]);
-    }
-    trace_tpm_tis_show_buffer(string, len, line_buffer);
-
-    g_free(line_buffer);
-}
=20
 /*
  * Set the given flags in the STS register by clearing the register but
@@ -156,8 +132,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t =
flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
     }
=20
     /*
@@ -325,8 +301,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
     s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
     s->rw_offset =3D 0;
=20
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
     }
=20
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 62b091f0c0..c0a0f3d71f 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -350,3 +350,28 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
     tsb->buffer =3D NULL;
     tsb->size =3D 0;
 }
+
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string)
+{
+    size_t len, i;
+    char *line_buffer, *p;
+
+    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
+
+    /*
+     * allocate enough room for 3 chars per buffer entry plus a
+     * newline after every 16 chars and a final null terminator.
+     */
+    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
+
+    for (i =3D 0, p =3D line_buffer; i < len; i++) {
+        if (i && !(i % 16)) {
+            p +=3D sprintf(p, "\n");
+        }
+        p +=3D sprintf(p, "%.2X ", buffer[i]);
+    }
+    trace_tpm_util_show_buffer(string, len, line_buffer);
+
+    g_free(line_buffer);
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index f397ac21b8..7889081fba 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -79,4 +79,7 @@ typedef struct TPMSizedBuffer {
=20
 void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
=20
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string);
+
 #endif /* TPM_TPM_UTIL_H */
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 89804bcd64..357c9e9a84 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -14,6 +14,7 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expec=
ted) "tpm_resp->len =3D %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_r=
esp->hdr.len =3D %u, expected =3D %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp-=
>len =3D %u, expected =3D %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+tpm_util_show_buffer(const char *direction, size_t len, const char *buf)=
 "direction: %s len: %zu\n%s"
=20
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
@@ -36,7 +37,6 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
=20
 # tpm_tis.c
-tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) =
"direction: %s len: %zu\nbuf: %s"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
--=20
2.24.1


