Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B01C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6BB208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAjkm0NL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6BB208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pTh-0006xH-Pl
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pNi-0006rz-5D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pNh-0000eu-63
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pNh-0000e2-1y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+tJ2pAChccRpSCGY8McY0DCHX6xcYqkqDoJDya3e04=;
 b=MAjkm0NLUM7VXVUiQWpWSIFoWvp9xMY0bCXkYGRfmuAtsoilkdL8yRWOXjgtPh1jITZbMK
 ALyttArASawvl+ix9oFE0DkUv7KaTkP8o+nwewfobPzcA53IqHA7UUy8ZEhjEFksUvhdof
 BIT3UqO+2qo9Gym2KKfiMOnUDtGjzMs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-OEPuXOBKNRKiMLh1mj2iFQ-1; Thu, 05 Mar 2020 07:13:35 -0500
X-MC-Unique: OEPuXOBKNRKiMLh1mj2iFQ-1
Received: by mail-ed1-f72.google.com with SMTP id p21so4173862edr.22
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1o5amSDbbIwKv6IaW3jUQVmu4OaybVeXGyKvmbAGQJk=;
 b=psgxrzvhdlK5affS7RhSAkxD1qH4coBVL4vEJhz15O3LFZoy4+UcXwECMqopYhh2lp
 MxVjjaw5Rpcl1ooOPE/mMDP2462VPCbHZ9D6kHINqWLLK5sbS4x0P1z6mlGhVVNg+kF4
 3olcViHVwI3CASBRuRNKEQlyzBv9G5PqaqMnIQ+ldK6tu57p3x8++LdySa7WONeMqYPw
 Lov7bSgjo8vrVxmVBmNLRAoqiKOFEg9pjqnfXLxYVcWBZ1qNqkUZVBNL7P5r5xBXUcbB
 HyJf9nD7w6ha8S/J7vgWuy9F/i82w8JHjz22WEHg7Tjfy0UAKiVkfWcMfAWJP4yVvuik
 TcxQ==
X-Gm-Message-State: ANhLgQ2Y0EYJxdkqYd/zhK1ctaPrSVw3p6/n8F2HIXRbuKY/dufTmNLd
 UaGva5ykHJmZt06yeF+VmZPAAjY3/MBD6m5oc2hPu13lcnqNvT88gtgFLt0X8Q585Q8rRP8QsaI
 hFfMoI9Q3sbWQf0Q=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr8232921edq.101.1583410413888; 
 Thu, 05 Mar 2020 04:13:33 -0800 (PST)
X-Google-Smtp-Source: ADFU+vteoAB98Dw3uCkJ1rFtwGx3XOkH3Ch0deCXYUipvDk0oUVTQ8U6x07xvPi4QVszaEcsn03Q7A==
X-Received: by 2002:aa7:d785:: with SMTP id s5mr8232903edq.101.1583410413732; 
 Thu, 05 Mar 2020 04:13:33 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s19sm437873edi.93.2020.03.05.04.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:13:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] hw/scsi/spapr_vscsi: Convert debug fprintf() to trace
 event
Date: Thu,  5 Mar 2020 13:12:53 +0100
Message-Id: <20200305121253.19078-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305121253.19078-1-philmd@redhat.com>
References: <20200305121253.19078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/spapr_vscsi.c | 4 +---
 hw/scsi/trace-events  | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index c4c4f31170..923488beb2 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -839,9 +839,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
     uint64_t tag =3D iu->srp.rsp.tag;
     uint8_t sol_not =3D iu->srp.cmd.sol_not;
=20
-    fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
-            iu->srp.tsk_mgmt.tsk_mgmt_func);
-
+    trace_spapr_vscsi_process_tsk_mgmt(iu->srp.tsk_mgmt.tsk_mgmt_func);
     d =3D vscsi_device_find(&s->bus,
                           be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), &lun=
);
     if (!d) {
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index b0820052f8..9a4a60ca63 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -227,6 +227,7 @@ spapr_vscsi_command_complete_status(uint32_t status) "C=
ommand complete err=3D%"PRI
 spapr_vscsi_save_request(uint32_t qtag, unsigned desc, unsigned offset) "s=
aving tag=3D%"PRIu32", current desc#%u, offset=3D0x%x"
 spapr_vscsi_load_request(uint32_t qtag, unsigned desc, unsigned offset) "r=
estoring tag=3D%"PRIu32", current desc#%u, offset=3D0x%x"
 spapr_vscsi_process_login(void) "Got login, sending response !"
+spapr_vscsi_process_tsk_mgmt(uint8_t func) "tsk_mgmt_func 0x%02x"
 spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun 0x%08" PRIx6=
4 " with no drive"
 spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int lu=
n, int ret) "Queued command tag 0x%"PRIx32" CMD 0x%x=3D%s LUN %d ret: %d"
 spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
--=20
2.21.1


