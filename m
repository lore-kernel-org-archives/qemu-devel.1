Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DDC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE7A21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE7A21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQGf-0002TB-R5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEk-0000ra-5g
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEi-0003oG-V0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:10 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:35934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hOQEi-0003mx-P2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:08 -0400
Received: from player711.ha.ovh.net (unknown [10.108.35.74])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id ECBC41C1B0C
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 19:20:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player711.ha.ovh.net (Postfix) with ESMTPSA id BBF7A5769380;
	Wed,  8 May 2019 17:20:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 May 2019 19:19:45 +0200
Message-Id: <20190508171946.657-3-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508171946.657-1-clg@kaod.org>
References: <20190508171946.657-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1136595958010645478
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeefgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.228
Subject: [Qemu-devel] [PATCH 2/3] spapr/xive: fix EQ page addresses above
 64GB
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The high order bits of the address of the OS event queue is stored in
bits [4-31] of word2 of the XIVE END internal structures and the low
order bits in word3. This structure is using Big Endian ordering and
computing the value requires some simple arithmetic which happens to
be wrong. The mask removing bits [0-3] of word2 is applied to the
wrong value and the resulting address is bogus when above 64GB.

Guests with more than 64GB of RAM will allocate pages for the OS event
queues which will reside above the 64GB limit. In this case, the XIVE
device model will wake up the CPUs in case of a notification, such as
IPIs, but the update of the event queue will be written at the wrong
place in memory. The result is uncertain as the guest memory is
trashed and IPI are not delivered.

Introduce a helper xive_end_qaddr() to compute this value correctly in
all places where it is used.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h | 6 ++++++
 hw/intc/spapr_xive.c       | 3 +--
 hw/intc/xive.c             | 9 +++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index bf36678a242c..1a8c5b5e64f0 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -208,6 +208,12 @@ typedef struct XiveEND {
 #define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
=20
+static inline uint64_t xive_end_qaddr(XiveEND *end)
+{
+    return ((uint64_t) be32_to_cpu(end->w2) & 0x0fffffff) << 32 |
+        be32_to_cpu(end->w3);
+}
+
 /* Notification Virtual Target (NVT) */
 typedef struct XiveNVT {
         uint32_t        w0;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 666e24e9b447..810435c30cc7 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1150,8 +1150,7 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
     }
=20
     if (xive_end_is_enqueue(end)) {
-        args[1] =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) << 32
-            | be32_to_cpu(end->w3);
+        args[1] =3D xive_end_qaddr(end);
         args[2] =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
     } else {
         args[1] =3D 0;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a0b87001da25..dcf2fcd10893 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1042,8 +1042,7 @@ static const TypeInfo xive_source_info =3D {
=20
 void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qentries =3D 1 << (qsize + 10);
@@ -1072,8 +1071,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, ui=
nt32_t width, Monitor *mon)
=20
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
@@ -1101,8 +1099,7 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t=
 end_idx, Monitor *mon)
=20
 static void xive_end_enqueue(XiveEND *end, uint32_t data)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
--=20
2.20.1


