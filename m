Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA07C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295C4206CB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRq4vcxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295C4206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMFx-0001un-7E
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMA2-0004Jj-Bo
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMA0-0002ou-L4
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfseJWujaVPa0a8Aenqsf/GWeCPDNQLBt0wn/9+sZ0Q=;
 b=MRq4vcxxTLtsG7L/tcYNa1aLOCmAzjxWPW0VjrhlgN/6ew3ES9oLV8hqPprb6GKToXB2Eu
 TUmoNzI4oYdokAM5V483UeLL6PWOyIGtM0wfTKcaI6v+E5sUOMpjjOLwKk+FYlY2aIxMMV
 6YrvYxv+OM1c9QFktHeWiBQ9/DH0I4w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-QEfF0nI1MGmbga1hojh6qQ-1; Sat, 07 Nov 2020 06:13:30 -0500
X-MC-Unique: QEfF0nI1MGmbga1hojh6qQ-1
Received: by mail-wr1-f72.google.com with SMTP id h11so1583900wrq.20
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qfseJWujaVPa0a8Aenqsf/GWeCPDNQLBt0wn/9+sZ0Q=;
 b=kGRn23u1zCaD6KvMhloPATLitLy8ZGf5lQdFqGdsHf9A17gVp8A+vFyc3CLaZFjAhj
 27Blzp1qmZOwD0XTxaVBhlb14ozwPPefbRhrcne0bBZxu2w1sfykIpPBVj2WguFNMZfJ
 G3srkkESsH9tSIrnIxXX9qQp4ZB6+UmtpQ0viT4BVvLFMHmzlupFpzIgCLKiTrOIXpoZ
 S0syO+krdi+4jSCkzL/VTtVNNOyqVIL54AaOlumsmx3rHCbLgNDTdkpeEA6WZlhwnoDB
 QC2uhaLQeZAejuQiq4+ebewPq25E6nEvVzwuyMnFjwVeVAmZTAJp1koNsv2InKA4skf/
 d1Ew==
X-Gm-Message-State: AOAM532PG3mCLQowikVaL2xuSdMssvunGbamGPx0C6J6BD1PZhrePGTp
 Zb6S5r/h6TGXPEZ7398A+mSZK1lsnPsM1zFp0DzyJJuqo48B3WPMv+lPF9/yRseh5bniu2i9fNy
 s5Tph1t3usACLRnc=
X-Received: by 2002:adf:f00f:: with SMTP id j15mr3531646wro.102.1604747609283; 
 Sat, 07 Nov 2020 03:13:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQNMxxhARgrbB8iQk7h6BLzmK0BLf4IZWvJh7+aIAiergiLTRpjKEuEOQCUTAW0hfBN1H2SA==
X-Received: by 2002:adf:f00f:: with SMTP id j15mr3531630wro.102.1604747609150; 
 Sat, 07 Nov 2020 03:13:29 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v9sm6012072wrp.11.2020.11.07.03.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 4/5] hw/usb/hcd-xhci-pci: Use
 OBJECT_DECLARE_SIMPLE_TYPE() macro
Date: Sat,  7 Nov 2020 12:13:06 +0100
Message-Id: <20201107111307.262263-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107111307.262263-1-philmd@redhat.com>
References: <20201107111307.262263-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-trivial@nongnu.org

 hw/usb/hcd-xhci-pci.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index aa2e890627c..cf9a180caa4 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -28,9 +28,7 @@
 #include "hcd-xhci.h"
 
 #define TYPE_XHCI_PCI "pci-xhci"
-#define XHCI_PCI(obj) \
-    OBJECT_CHECK(XHCIPciState, (obj), TYPE_XHCI_PCI)
-
+OBJECT_DECLARE_SIMPLE_TYPE(XHCIPciState, XHCI_PCI)
 
 typedef struct XHCIPciState {
     /*< private >*/
-- 
2.26.2


