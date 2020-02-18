Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072DCC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52D620659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOLN9yr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52D620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zbu-000582-TI
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQg-00024Y-Ir
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQf-00067A-F5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQf-00066N-9k
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTgf94kcfqSZ8hoLehGhAHOfOM4ZjXUraqazHdrIszo=;
 b=OOLN9yr84AS9rJHiV1Jp8hF4j+8F8lB+kYGkAuAbFTZsQma+2k9fTFrETI4OPo3PgF97A5
 e9iXQrJSjZDCTMbrC6EAQMXF9dCldLfZk9W+oSSC3LD7ywpltENQQdMx8WAMY5UAweXmPo
 1ZqrIArnc+AXANZDrZ9niu33U/NXvJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ZUGtjG4hM0K4r-hy_knljw-1; Tue, 18 Feb 2020 04:44:31 -0500
Received: by mail-wr1-f72.google.com with SMTP id t6so10538734wru.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JB0VIXdKqYha385dFm6Nf/XSPsPS/89dyx6biXJISb4=;
 b=rG4O4cQY1zHrxnZ2S1iY+rR11bJ9PfDt9S85DLRwVA6Rb11FDEcuGJlwtWvZNRFfz5
 HZAodftOldFjr/2c4frrb8+GQyR7jrnKCv223ZI1lUMUC34Xtsj9UB07qmj3tRhoCi6H
 W28kO2P8G4HhMVaHx15tslyPIejvrhV/J0a+cbBq+FM4CP1ab23AtP8q/VhzljyULQcD
 DoZcSx3QDQlclw4RNThw9SAIXar0FS7Rz/iL/w9SJfpEbPyGtveO3Xor1wJIl2QQhAr8
 QDTSx4wY0zLzqbYeKWlosmK1sdKF2dpdvxftwlGQ4oB8+SZp65TB0KbKrA4mm4kLjUGk
 DgQw==
X-Gm-Message-State: APjAAAW/GBSt/3U3SB74I9+EAtTG6mR+hSv+SdYqi4pVGdM23Mtrr8Rp
 NBtMr7PRLWKYBxhxDvfZ3D6m4JCwPIXwOAVawWrEroiUlujZxGYEw8B38NZwHFn7+zxXLZbsTCJ
 AOD5xm+c2hRGlkL4=
X-Received: by 2002:a05:600c:149:: with SMTP id
 w9mr2049941wmm.132.1582019069932; 
 Tue, 18 Feb 2020 01:44:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnFCOD91POciOMTASDtCIuoeJf2e54H4Bms3bKGGaIUFJS8YQBdVHc1g4og/fenKxGkrsntQ==
X-Received: by 2002:a05:600c:149:: with SMTP id
 w9mr2049912wmm.132.1582019069668; 
 Tue, 18 Feb 2020 01:44:29 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 12/13] tests/qtest/libqos/qgraph: Remove superfluous
 semicolons
Date: Tue, 18 Feb 2020 10:44:01 +0100
Message-Id: <20200218094402.26625-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ZUGtjG4hM0K4r-hy_knljw-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: fc281c80202
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/qtest/libqos/qgraph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 7a7ae2a19e..ca01de0743 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -474,7 +474,7 @@ QOSEdgeType qos_graph_edge_get_type(QOSGraphEdge *edge)
     if (!edge) {
         return -1;
     }
-    return edge->type;;
+    return edge->type;
 }
=20
 char *qos_graph_edge_get_dest(QOSGraphEdge *edge)
@@ -590,7 +590,7 @@ void qos_add_test(const char *name, const char *interfa=
ce,
                   QOSTestFunc test_func, QOSGraphTestOptions *opts)
 {
     QOSGraphNode *node;
-    char *test_name =3D g_strdup_printf("%s-tests/%s", interface, name);;
+    char *test_name =3D g_strdup_printf("%s-tests/%s", interface, name);
     QOSGraphTestOptions def_opts =3D { };
=20
     if (!opts) {
--=20
2.21.1


