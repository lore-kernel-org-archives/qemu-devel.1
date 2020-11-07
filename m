Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43DC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6D6206CB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeTvekEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6D6206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMEX-0000wS-C3
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9u-0004Cj-4i
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9p-0002lT-UZ
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdMhzZg76PnY9+y/GdSAdPfqjiUTrwxbBgq5YBusWDU=;
 b=WeTvekELTSxlaAi5YHJNW0zOmaxZXygaUehmAtGwpUWsqWoX5mlgLYjnNrwtWnI1qMhNOt
 vVdHcvltn48X9hIZqfrwdzQk6+Px2KO7SgjK3OHRe3gNT0kXrotQU6OxyWbFnrga8xOyAp
 WAd9NOA5+tGJP5lWmHJtbNQneJ4Ho90=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-bpS5xVudPm-MmtZ69I4XiA-1; Sat, 07 Nov 2020 06:13:16 -0500
X-MC-Unique: bpS5xVudPm-MmtZ69I4XiA-1
Received: by mail-wr1-f70.google.com with SMTP id d8so621461wrr.10
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jdMhzZg76PnY9+y/GdSAdPfqjiUTrwxbBgq5YBusWDU=;
 b=GTTJvNouvrPskwTDg5cMJ05OXxvtqZHACQEPP/9XIfDrclOxmycCzfNB+DOHm+3uAX
 7SlAXZpjTIFs8udsUmviYjKkBQWs79GeapquOEviA139n/tE05J4ro/YT3onkkwGOGY+
 sFl5JPVEB/+VaYj/LCjoBkHokAX5JA/DgU030jbuGehTKPBVkb33/TQwrGMZJrahbpBa
 kskRTcqvzGP6FMXzsa/MZA+EBoU2U7UDPF8j1fvVJOP63JND9FCnKwWx8pwfmXxfvyzK
 Cy6nBWJogtDIqfhjs3/5yVMJ+cW7wfTX9+Kfc7N+9YakZRD89O7LXkyIYDldFtU6Xd0j
 lMzg==
X-Gm-Message-State: AOAM533tkLH8ZEh9pBo/L6uYpXbr9o1mlDpDtb2I+H8vHG/lY5hg8bgk
 nfzhTAuzWRPiVIfWsSE+Wh7I+bJTOB6CF4Fs05QYV/p4XHs7ufNvauq+U+GwyTOf47MDLDKfb5R
 rnPnEEFnoLJ7IG3k=
X-Received: by 2002:a7b:c937:: with SMTP id h23mr4172035wml.19.1604747595088; 
 Sat, 07 Nov 2020 03:13:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdIsa0Qb4BX9x1+b5iJnNfHBqXMYMlgqVuFAr+UW6+1U+v1i8joiTSD0vl8DlDq+sJxof/0g==
X-Received: by 2002:a7b:c937:: with SMTP id h23mr4172025wml.19.1604747594954; 
 Sat, 07 Nov 2020 03:13:14 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e6sm5863006wrs.7.2020.11.07.03.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/5] hw/usb/hcd-xhci: Make xhci base model abstract
Date: Sat,  7 Nov 2020 12:13:03 +0100
Message-Id: <20201107111307.262263-2-philmd@redhat.com>
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TYPE_XHCI model is abstract and can not be used as it.
It is meant to be overloaded by children classes. Restore
it as abstract type.

Fixes: 8ddab8dd3d8 ("usb/hcd-xhci: Split pci wrapper for xhci base model")
Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 79ce5c4be6c..57b692ad849 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3595,6 +3595,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .abstract      = true,
 };
 
 static void xhci_register_types(void)
-- 
2.26.2


