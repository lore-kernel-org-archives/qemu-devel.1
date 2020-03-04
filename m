Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5511E215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPz6Zqt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5511E215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W50-0004JT-FP
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W1a-00070z-GD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W1Z-0003hf-GI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W1Z-0003gW-Bz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSi8icYpglVwPM4o7Q8ZGmXm/EAEO/DibdkCD45Z2Kw=;
 b=JPz6Zqt7Tp1a/t+t+g9NatAjYa/57p3IkEI08zvMGQjRlSHYd/DJFCdk3iwskFShWKTxAj
 MatXEUtCqo51OjTn74tYrUEvjanV7MWZGoWPSFiwnPSWhCfW6zZVERw4sWhSNgfyuVivg3
 OF5Ve/UJaYfG5XvNZda/x97LGPkvoG0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ABfHAalFMVeAdR_g3vSoQw-1; Wed, 04 Mar 2020 10:33:27 -0500
X-MC-Unique: ABfHAalFMVeAdR_g3vSoQw-1
Received: by mail-wm1-f70.google.com with SMTP id y7so1005998wmd.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkhqIVIgOTcLzuFywQWIieMxU39HVlXEuJIdDpMq2pg=;
 b=HFkFZPo6Z5PKbcsoyU3TABTw3bLgCHr3W9D7NF8o/VBJuCzNfssX2DFTUoG/oTWwyy
 xRj4z/jgKjVm+owpmbtrRRWa+ZXyaVjlL0irQjZzvpkz1gUa6Ewbhi2D5riMUrbD/pi+
 XIq6KweXC3w35e9xfGCbxt0RI6/+oFy+puQdYk1OYSYYCSfPylnm/Z9ah1uXxu8ilue0
 d1TAlnVwh+S618i4btxJX11dlOeAWH5o4yuJbjjKxMDdfHmxGbMosmZL1jOtlPVoPkQH
 ERJwFMGZKvLCSmDQaM/SfvCmtNb82MYDYMggkMM5IlNgtT+yO0Ste4lhim+TmzfUYW5z
 So0w==
X-Gm-Message-State: ANhLgQ1X/SucUwAjpApiPyxzY3DIKM8TI4g0xljTjZxOGzwiLrvcOZeE
 JwWXAosLLM7GKC2JBxfODmSkcAUchEYaGcIDVhspASl9NSzt+lmyccjgQ1qg039LNxbJwkNvJ+l
 mPLs4nAPidmbQsTU=
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr4390999wml.105.1583336005985; 
 Wed, 04 Mar 2020 07:33:25 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtwz9+DmWBd1+B9vH79rxKAxMTDcTxndbAh+V+CTSMCjRy09DnZptZdXUuzSXBw8b189ttXTw==
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr4390974wml.105.1583336005728; 
 Wed, 04 Mar 2020 07:33:25 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t124sm5172965wmg.13.2020.03.04.07.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:33:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof
 flexible array
Date: Wed,  4 Mar 2020 16:33:08 +0100
Message-Id: <20200304153311.22959-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304153311.22959-1-philmd@redhat.com>
References: <20200304153311.22959-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
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


