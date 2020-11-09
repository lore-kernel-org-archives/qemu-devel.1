Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A2EC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737C820665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDeUVrH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737C820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7j9-0003MJ-75
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bh-00032T-Cq
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bf-0005C6-H6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AwdT5nD9C6a2wsBgla1NUJAfuZdmUfnrRvAnSbIFbU=;
 b=YDeUVrH+Su3ILu0p8M27M2aRjbHpWiH2SnJ3rz9EOUhp806YjplHHDtrUBnKifEG+iL0bu
 ylhLMjCwPuZicUTsD4FoEvg7NPD/8qglmAoXqA0+C0fKG9PQNi+uigTSZ76AnEAIe/4Ep1
 JtvuNMoun4aMwSO9UrhuwMudWXEIbIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-B0sOD3WMNb2QQ58HiCS7aA-1; Mon, 09 Nov 2020 08:53:13 -0500
X-MC-Unique: B0sOD3WMNb2QQ58HiCS7aA-1
Received: by mail-wr1-f70.google.com with SMTP id f11so4353564wro.15
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0AwdT5nD9C6a2wsBgla1NUJAfuZdmUfnrRvAnSbIFbU=;
 b=tryYpHjW6gB28F/KUXjOIUs3eGLaeyH2gORUHXwF27BlvH/aQeyD//uzJyhEbcNDQa
 9xTkcNZPLPBQO4NAKhFN+hgQpph1zrgjvbre6Q0FfK/iDAB73jqsoE6zL3zqW3iaM0VN
 3yVGltgR2Mm1Qi7hITGPI8sQUWVkDl8FgDvFjXQVNWMShXJhxIhThSmlDL7oLW4IQBHD
 /JmJ59L71K3LfngH1Q3m9yFKkPobfzCO6Dh3yQQ/ETnXpvHFLlnsbbNt0c9OTsy/YZeY
 C+ymJbuyMfHHlPX1G/hKhNrqielp6YWk5tFZsghHkatGwrmKCFqjMa3DAI3RtY3+zB07
 9FhA==
X-Gm-Message-State: AOAM532O1lL6BLJE692luc5iAtReeRlqnZVrHl8nyO8qnLTN3cVEovQ8
 xopXEFxK1x8tAr4Tfh7NCmCpfwyTlZUOxtARRR0hAldg7MV6aJVevF8WE6vsCXAf2zUGXwYPp1r
 ZRtRJlN9poB9WzjM=
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr17434010wrp.332.1604929991700; 
 Mon, 09 Nov 2020 05:53:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS13YtWVGV4xyRVW/8sdcn1Yh9NSAnalNkNNnI7imRHv0kEIVO1b6rNDIHmsB1kLS3hNASvw==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr17433999wrp.332.1604929991583; 
 Mon, 09 Nov 2020 05:53:11 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d63sm12759895wmd.12.2020.11.09.05.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:53:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v2 2/4] hw/usb/hcd-xhci: Restrict TYPE_XHCI to hw/usb/
Date: Mon,  9 Nov 2020 14:52:58 +0100
Message-Id: <20201109135300.2592982-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109135300.2592982-1-philmd@redhat.com>
References: <20201109135300.2592982-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_XHCI is not a generic device meant to be instantiated by
QOM objects outside of hw/usb/. Do not expose the type in public
namespace (via include/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-xhci.h     | 1 +
 include/hw/usb/xhci.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index ccf50ae28be..f7150a7e12b 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -27,6 +27,7 @@
 #include "hw/usb/xhci.h"
 #include "sysemu/dma.h"
 
+#define TYPE_XHCI "base-xhci"
 OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
 
 /* Very pessimistic, let's hope it's enough for all cases */
diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
index 5c90e1373e5..90b56429199 100644
--- a/include/hw/usb/xhci.h
+++ b/include/hw/usb/xhci.h
@@ -1,7 +1,6 @@
 #ifndef HW_USB_XHCI_H
 #define HW_USB_XHCI_H
 
-#define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
 #define TYPE_XHCI_SYSBUS "sysbus-xhci"
-- 
2.26.2


