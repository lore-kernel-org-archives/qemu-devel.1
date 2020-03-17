Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF9C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAD2206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k6YbDP7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD2206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9JH-0001Rn-01
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE968-0001j8-TU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE967-0005mu-OK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE967-00030h-DZ; Tue, 17 Mar 2020 06:05:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKz4Hnbz9sTP; Tue, 17 Mar 2020 21:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439479;
 bh=D29V9qAZgS7/TrioIy7viFrcpIYypxn45k8+wQFRzEA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k6YbDP7Pm05r97t7GJLZslld2Wkl4m4Mo+Ki19SLRDO+CtLxxHOK+vof+dg0mhM6b
 uDRYgK92yv37BZIzAyd78B1lUi3zQdWa54LXOVxhFcHZwlEurWt1MiZ+wyaFik8QOD
 CO58mWfCemNGsYdhvTpI+ZXuq95g+h0ha1usLZZ4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 28/45] hw/scsi/spapr_vscsi: Convert debug fprintf() to trace
 event
Date: Tue, 17 Mar 2020 21:04:06 +1100
Message-Id: <20200317100423.622643-29-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-8-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 4 +---
 hw/scsi/trace-events  | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index c4c4f31170..923488beb2 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -839,9 +839,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
     uint64_t tag =3D iu->srp.rsp.tag;
     uint8_t sol_not =3D iu->srp.cmd.sol_not;
=20
-    fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
-            iu->srp.tsk_mgmt.tsk_mgmt_func);
-
+    trace_spapr_vscsi_process_tsk_mgmt(iu->srp.tsk_mgmt.tsk_mgmt_func);
     d =3D vscsi_device_find(&s->bus,
                           be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), &l=
un);
     if (!d) {
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index b0820052f8..9a4a60ca63 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -227,6 +227,7 @@ spapr_vscsi_command_complete_status(uint32_t status) =
"Command complete err=3D%"PRI
 spapr_vscsi_save_request(uint32_t qtag, unsigned desc, unsigned offset) =
"saving tag=3D%"PRIu32", current desc#%u, offset=3D0x%x"
 spapr_vscsi_load_request(uint32_t qtag, unsigned desc, unsigned offset) =
"restoring tag=3D%"PRIu32", current desc#%u, offset=3D0x%x"
 spapr_vscsi_process_login(void) "Got login, sending response !"
+spapr_vscsi_process_tsk_mgmt(uint8_t func) "tsk_mgmt_func 0x%02x"
 spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun 0x%08" PRI=
x64 " with no drive"
 spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int =
lun, int ret) "Queued command tag 0x%"PRIx32" CMD 0x%x=3D%s LUN %d ret: %=
d"
 spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
--=20
2.24.1


