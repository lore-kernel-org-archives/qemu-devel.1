Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376FC3F2D8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE6208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/SkwcYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE6208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pP2-0008Kg-Cc
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pNI-0005qJ-0o
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pNH-0000NG-1b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pNG-0000MN-Uq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSi8icYpglVwPM4o7Q8ZGmXm/EAEO/DibdkCD45Z2Kw=;
 b=U/SkwcYfTtdBNrlLFG5cb2aEZTcu6cUyW8G5bIyqZuC97NeV0SPRTGOjCaDcQDQDCh+m37
 t59DrnngyUuJDXzPJbo+vMk+yyGKw/YwNv4emfTOtzPLNSV32FAomXhvRF7q8t9tI0w9eA
 kTD69Cda4J+NCLGsglTSw4Fi4UyWkw4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-VWElRjn9PdqrQocgFidG7A-1; Thu, 05 Mar 2020 07:13:08 -0500
X-MC-Unique: VWElRjn9PdqrQocgFidG7A-1
Received: by mail-ed1-f71.google.com with SMTP id d12so4206922edq.16
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkhqIVIgOTcLzuFywQWIieMxU39HVlXEuJIdDpMq2pg=;
 b=Tp28etSYXUtu4Ilg1WYIKG3M0NzrBBp3REmR1jWMURUG8TJxrwWja/aFjKa/RfgrRu
 sWYVGz9XzpnwZu/ozJ/zb06KiCkPBN0D4d9bUDvtXgesSOyInE4Duuc4byAhmUUgKBJ3
 WwAGcxXmk4tgRBXKWAbKdm3xWBRJcBoqwlFR36ORkUG/c7EKvEKerVRNXcUDRS2/eEsx
 xQKBLFzJ5TEIAUBkB9ZXBlmDt6BSmPes1MQjibzzUcBGblmTjpp+jf4DAPAG6trl/mI9
 XaWTBIRAHRNvlc9Fof8oM3bUhlHLElB3sVvfX/H7VqmuduqNQTYDGMsoaNSweXIMix4L
 DctQ==
X-Gm-Message-State: ANhLgQ1EG8zpQ3ZPWo4GSSKQVmPBMv4wPFbtJecqfzDJBqS4eU7eaKAQ
 9H4fN7be0ML8NlVr1isElMRQf4/PCa+wjdrbA8wCuQCMhRB2HSQ5U7XZFV7HNBTzPsriGVkJp+9
 hh4xBkJxHCHITykU=
X-Received: by 2002:a05:6402:206e:: with SMTP id
 bd14mr8092363edb.4.1583410386715; 
 Thu, 05 Mar 2020 04:13:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtRnGuyzgI9xhlRwYcVpcuWEsVz+Bwc42U1dshtYQOQEhas40IZWOdGhBfYwr9bPJhdIvErGA==
X-Received: by 2002:a05:6402:206e:: with SMTP id
 bd14mr8092333edb.4.1583410386464; 
 Thu, 05 Mar 2020 04:13:06 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y12sm446746ejj.48.2020.03.05.04.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:13:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of
 sizeof flexible array
Date: Thu,  5 Mar 2020 13:12:48 +0100
Message-Id: <20200305121253.19078-3-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.120
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

Replace sizeof() flexible arrays union srp_iu/viosrp_iu by the
SRP_MAX_IU_LEN definition, which is what this code actually meant
to use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7d584e7732..7e397ed797 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -671,8 +671,8 @@ static void vscsi_process_login(VSCSIState *s, vscsi_re=
q *req)
      */
     rsp->req_lim_delta =3D cpu_to_be32(VSCSI_REQ_LIMIT-2);
     rsp->tag =3D tag;
-    rsp->max_it_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
-    rsp->max_ti_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
+    rsp->max_it_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
+    rsp->max_ti_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
     /* direct and indirect */
     rsp->buf_fmt =3D cpu_to_be16(SRP_BUF_FORMAT_DIRECT | SRP_BUF_FORMAT_IN=
DIRECT);
=20
@@ -1088,7 +1088,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
      * in our 256 bytes IUs. If not we'll have to increase the size
      * of the structure.
      */
-    if (crq->s.IU_length > sizeof(union viosrp_iu)) {
+    if (crq->s.IU_length > SRP_MAX_IU_LEN) {
         fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
                 crq->s.IU_length);
         vscsi_put_req(req);
--=20
2.21.1


