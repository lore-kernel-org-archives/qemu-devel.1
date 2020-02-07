Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB51AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951352082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUid7UpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951352082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izxQp-0003HW-Of
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 01:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izxPd-0002kb-LQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izxPb-0005rC-6x
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:46:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izxPb-0005q6-2l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581058006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfiMKctqhjdwd1D2LZap/x6StrUEy5cXEeAQ/7gAuLk=;
 b=bUid7UpZMcMFKfMQd2vHHh6VwhsvI7mNFKVSoDMyP7cPAhPgSg9YzTrlDSWaEUbtOE4WwZ
 09lqpo/ivtNfnjcnIPliSGtgXdC/N7FkEw0r6OPaGNbFiRYek5I+4cuACAHUHjU4hvLwPi
 ENop4AtFxpAxiXSNPZNdLnFf1DxJcqw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-MfSDPUOIMrSjL_nLKpUAvw-1; Fri, 07 Feb 2020 01:46:41 -0500
Received: by mail-qk1-f199.google.com with SMTP id q135so748078qke.22
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 22:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=caOSvPGo6ztdT+lrJkWh9sG+yrPfmF1JMzVqHIi/AXc=;
 b=C6gf72D52M1BKEYbSJ9F1tlm1N66cepnoI4zXLtwRW0BLo+XflllF7N45tfhigkcn0
 rjIlrHzxTh1aYszVUR5o4xCORgCy73kZbNc9G7Ib+4HVvd1DKcoN3yzIC7s6j58eGiPI
 9FOMAhTnza8q/M8y9yqFGrFLBhBCh+uCjiQT4ZudBdYGBVDPaorBgV9dTDEK/7LEVjfo
 JhEiS6u6W6kADWJiXyUfaM7/DyTU8PRGqdFUeREkatSYDIThKRVCgO9W9rL8kynsGbtW
 xmVMdsprSbINBFsJfTnozEy+e/asfX60cgt5sy+3WItsQI2axes1Sx1h3o5FZYHwJ74l
 a6Eg==
X-Gm-Message-State: APjAAAXJb8wxj4mwa6+kivrIzDy7MbRoQXDezxUkgwoq+VV+eoHaNNe5
 s0nVBH3qHXV052I8cV1J10pZg7oAATasybxLsBUs9Aq//LLYGPLPP7Wr+OQHqo8jRRwNeMdYHmq
 q7SFO3YRqMi44u+k=
X-Received: by 2002:ac8:6f63:: with SMTP id u3mr6135100qtv.39.1581058001152;
 Thu, 06 Feb 2020 22:46:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5GQp02c0EQZ672MSvayDiXkiKGJ9QGzP2kZES3QB2wUr3+ijjr68efb1Egvg32R/OTe/R6g==
X-Received: by 2002:ac8:6f63:: with SMTP id u3mr6135086qtv.39.1581058000851;
 Thu, 06 Feb 2020 22:46:40 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id s42sm906581qtk.87.2020.02.06.22.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:46:40 -0800 (PST)
Date: Fri, 7 Feb 2020 01:46:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ppc: function to setup latest class options
Message-ID: <20200207064628.1196095-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: MfSDPUOIMrSjL_nLKpUAvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to add more init for the latest machine, so move the setup
to a function so we don't have to change the DEFINE_SPAPR_MACHINE macro
each time.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 02cf53fc5b..4cf2a992a5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4428,6 +4428,12 @@ static const TypeInfo spapr_machine_info =3D {
     },
 };
=20
+static void spapr_machine_latest_class_options(MachineClass *mc)
+{
+    mc->alias =3D "pseries";
+    mc->is_default =3D 1;
+}
+
 #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
     static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
                                                     void *data)      \
@@ -4435,8 +4441,7 @@ static const TypeInfo spapr_machine_info =3D {
         MachineClass *mc =3D MACHINE_CLASS(oc);                        \
         spapr_machine_##suffix##_class_options(mc);                  \
         if (latest) {                                                \
-            mc->alias =3D "pseries";                                   \
-            mc->is_default =3D 1;                                      \
+            spapr_machine_latest_class_options(mc);                  \
         }                                                            \
     }                                                                \
     static const TypeInfo spapr_machine_##suffix##_info =3D {          \
--=20
MST


