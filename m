Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD0BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980FB2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwnMZoqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980FB2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFcg-0005zP-QM
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZFbf-0003wn-NA
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:17:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jZFbe-0002ca-Po
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589469425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZdoSemO+CEcJZ8IM7vaGir0gUiR19EhUeUGylY0GoVU=;
 b=JwnMZoqtmP5wx82knoCbk46ZkGjzyhBSFgajj7ql7DcnqEeOyN5vY0sOtvEbqPwBbfm5SU
 wBBzq6CjNgy3owfT+R+gwYamQHEBhwYL3THj/4vWwPYlQ9ELxdIfLj65Ka5RF6CVYnIo+/
 IqXi1FLXMJwU8HW6/1INWwYrfuQJIJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-xMoGqGjNNQOsn3Gf3h3-jQ-1; Thu, 14 May 2020 11:17:02 -0400
X-MC-Unique: xMoGqGjNNQOsn3Gf3h3-jQ-1
Received: by mail-wr1-f72.google.com with SMTP id x8so1721801wrl.16
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ZdoSemO+CEcJZ8IM7vaGir0gUiR19EhUeUGylY0GoVU=;
 b=rPxpsfCjQ6ul6NFQtLxbi28zCc8NOycmIBtS/3aaONZUZL53iOjQNYqw7Yec0Q8w90
 vAdutMspzJoFL5P+qgFNx+jaPNDRkHloIlOW7s0G673oSKNo1AUKlWsQEStIKAq4zupn
 SPFe+ncysIv7brbHFr5ypFnxsB6rYCIUEuMM+AFJK2WcNVVKRnrPdnP/TluxsZjXLJ9z
 KKZriLExG1ZRbVSEY7NY0ZKLTnbmflI6pKZy3MXP6oWmjGJlr1b4PCJSeUeqXMjJUto3
 RbXP/OpiPDOgsxad1Gzr7Ir7yxuFitk9vgENn5rMzSA9LgEx2sF3EMgOIJKOaGYPetfv
 0+2Q==
X-Gm-Message-State: AOAM531x+DsQD4TMbRCmqktFtYAEA9HLmG0pj1t0peHWI/D74oecQbyY
 dynX2DC1TZHSAIj7FqN8iXOWXOJkgdsceASItQYQuqDsaRoQEaHSJ2Z6asBWhHBS/ymHZo0pZXO
 YSBMb0Y4rLB02QzE=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6025606wrq.61.1589469421045; 
 Thu, 14 May 2020 08:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAvCmOEMRJsZ/HRx1Sqe/Y/3PWekTh0cQ6tg2SJCCXH9lYM3H82/uayxMROdVro1k14nkJ7A==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6025589wrq.61.1589469420831; 
 Thu, 14 May 2020 08:17:00 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id 60sm4583208wrp.92.2020.05.14.08.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 08:17:00 -0700 (PDT)
Date: Thu, 14 May 2020 11:16:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] msix: allow qword MSI-X table accesses
Message-ID: <20200514151648.877882-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: jusual@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PCI spec says:

For all accesses to MSI-X Table and MSI-X PBA fields, software must use
aligned full DWORD or aligned full QWORD transactions; otherwise, the
result is undefined.

However, since MSI-X was converted to use memory API, QEMU
started blocking qword transactions, only allowing DWORD
ones. Guests do not seem to use QWORD accesses, but let's
be spec compliant.

Fixes: 95524ae8dc8f ("msix: convert to memory API")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..e6a5559038 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -199,6 +199,9 @@ static const MemoryRegionOps msix_table_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
@@ -227,6 +230,9 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
-- 
MST


