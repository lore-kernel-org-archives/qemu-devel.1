Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23392C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47962076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNiwjnjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47962076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFWT-0000eP-P3
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUP-0006VL-ON
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUM-00036i-AB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUL-00032c-Rn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Flbegfe+XvQdIALgmwjud+bmSRqDw+xWJxrHvvD5T5c=;
 b=iNiwjnjl37XE94rLwo8a2bZjfZOMwhUClEss3Kvi318ESsk3t/fycrV6g8rjDkCYBGAVwZ
 3H7VhucekKB6IGQQzKoNao5Utnqwx8UiHG0rhufdXL1/Cp+uYoJt7gVhKJObNtwqcSEF38
 Pr/rVhAI6dVMhmsxYrckPBxxtIg8lMU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-MJLkgs73OHGSiNB18O8OKQ-1; Wed, 22 Apr 2020 09:32:26 -0400
X-MC-Unique: MJLkgs73OHGSiNB18O8OKQ-1
Received: by mail-wr1-f70.google.com with SMTP id m5so1038733wru.15
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IDUYtKOADkWG3CN25Uq5JJobV9Wdj+VxIMt3IxDdn/o=;
 b=JglobhJhsqNJJ+WooicgLoDMJ0rYCbc+R0S4XooRxjs8tmvlWg8kSd4biQnGO/qTZQ
 xuqZMya/sB4wGfhP/x4PQsp9EjVFb02HiG3q4BOdPfUlpFtRTffgWi/SOxLoia0GxDoJ
 LTZnPyB/NZfOOp7/lJ0rW5VSF9rkzd5KyZGGhgZ0xmd/JciR9V/qLqvS5cp3ip8nN3DO
 5tJs1etl3zP/uKI2MLKtSBJ3kNyhMihG6lrOl8sb6fzSn8CKV43UeM4dyN1V6M9Jr9Xt
 JjpOP7kKtbK8r+UuxC/VABTruPn3op+vMfuIZkUC8ssqIVFIYRZsxwSRvTyuDxQQLvwz
 HgsQ==
X-Gm-Message-State: AGi0PuahOTq8owNYO9StUbChMPfP3VT0FxF78xxyR54FF4JIP3uZrEbZ
 bW6O2ak5sQoJSkgrdKB26iNt0ao3s3sKSMBt+vRLGo83uTke4TPNaggGFvE97kbQtQzKtUf6FhN
 VGSlRm0oRL9V4llc=
X-Received: by 2002:a05:600c:2941:: with SMTP id
 n1mr10810675wmd.25.1587562344696; 
 Wed, 22 Apr 2020 06:32:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypK7XDTD/6gL7xOy+W7IIyAp8MGKyH7Nh9z0DkzZBiiFlF4pLRNLxX+BVWqJa70s13YF7ZBNHA==
X-Received: by 2002:a05:600c:2941:: with SMTP id
 n1mr10810659wmd.25.1587562344515; 
 Wed, 22 Apr 2020 06:32:24 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z1sm7749395wmf.15.2020.04.22.06.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] hw/isa/i82378: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:49 +0200
Message-Id: <20200422133152.16770-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 "open list:PReP" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the unique variable assigned as 'pit' which better
represents what it holds, to fix a warning reported by the
Clang static code analyzer:

    CC      hw/isa/i82378.o
  hw/isa/i82378.c:108:5: warning: Value stored to 'isa' is never read
      isa =3D isa_create_simple(isabus, "i82374");
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/i82378.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index dcb6b479ea..d9e6c7fa00 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -67,7 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     I82378State *s =3D I82378(dev);
     uint8_t *pci_conf;
     ISABus *isabus;
-    ISADevice *isa;
+    ISADevice *pit;
=20
     pci_conf =3D pci->config;
     pci_set_word(pci_conf + PCI_COMMAND,
@@ -99,13 +99,13 @@ static void i82378_realize(PCIDevice *pci, Error **errp=
)
     isa_bus_irqs(isabus, s->i8259);
=20
     /* 1 82C54 (pit) */
-    isa =3D i8254_pit_init(isabus, 0x40, 0, NULL);
+    pit =3D i8254_pit_init(isabus, 0x40, 0, NULL);
=20
     /* speaker */
-    pcspk_init(isabus, isa);
+    pcspk_init(isabus, pit);
=20
     /* 2 82C37 (dma) */
-    isa =3D isa_create_simple(isabus, "i82374");
+    isa_create_simple(isabus, "i82374");
 }
=20
 static void i82378_init(Object *obj)
--=20
2.21.1


