Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B4C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 06:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB1920873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 06:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9KjADon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoiUE-0004E4-M5
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 02:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hikarupsp@gmail.com>) id 1hoiU4-0003pl-HV
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 02:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1hoiU3-0006Ek-Id
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 02:04:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1hoiU3-0006Dx-At
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 02:04:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id i18so15363148pgl.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZST8hHeVxn10C+xoTazpqC2/5O7pM7tEsmAgjWWAMP8=;
 b=T9KjADonGa4aIKC5Hmf18ADohnfA21UvqEQQqrhvKi4f2V7zhKtB/rkkHyj6vV2JyT
 /qB150P/GOGSlcFq1GaXFfHR/mM+fxl6JZCWe21hhpQFsUnYk/NQ5aaJf2TxwM46oeGc
 dZiRcUeYt3a38W+NaTkWMb0U3h08Ca/RIC6LROVwHZOPAf+H/P6JTnq8D1Mlt7Vec0BX
 y7/Hi4Ii4W9eeINGcyPqmdVEKeY/qiv0wXrJWApnIXkC0cqwoaFfghouiaMFQmm/siuO
 Wy2ZVPeiw/FcL54PV0hPr/HO6+JBNXYn20A2QL1hPL32IHNDw9y/i+3tKmoscxQeEMyR
 jDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZST8hHeVxn10C+xoTazpqC2/5O7pM7tEsmAgjWWAMP8=;
 b=dvTpkHahpdZdS1GjjdL78MzF/xOljD3/muvUF25wRPntZD5s6zB+Z+dyHyV7TofqFH
 8GwY632RV3GEhSGhaHB4Bypn0mQN91PyruDQ4oxGmXNofIqfex/vLjSmARdjFmxmRTOz
 H71R95ZvUiALGVU70rwnclnUqnhzGxStRMXEZKC4TLj0G4VmZ57yWDtTn5WvkcQZjC00
 ZBW/mEOC7qMawA4MtbzAd1GX6PpBjoswLrV9iNdvLysPUQDUpY21AFZBy8Uz0aoKmP3T
 q52gzKYX/ev1epeuyJhIVMH9ZH1Q89ZnkxaJ/RXVhEc5/1l+apFCo+nHR8WsToNgj9vy
 etEw==
X-Gm-Message-State: APjAAAVFw1C+qsUd+b0dVMAKlfPZ0wWvEm34r3De9dI4l/XV2am3cTbN
 jrnHXCBF2KaUkyHzE8dn2V3m3L/g
X-Google-Smtp-Source: APXvYqxCUkCEe65Mvk8nYBOi6PcpP6aW2UbJnmScpa0TLRn0ZD7U/mzRuf8dyO1akR4F4wJMyLmK6Q==
X-Received: by 2002:a63:455c:: with SMTP id u28mr39078632pgk.416.1563602676627; 
 Fri, 19 Jul 2019 23:04:36 -0700 (PDT)
Received: from localhost.localdomain (72.65.214.202.bf.2iij.net.
 [202.214.65.72])
 by smtp.gmail.com with ESMTPSA id 64sm33557998pfe.128.2019.07.19.23.04.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 23:04:34 -0700 (PDT)
From: hikarupsp@gmail.com
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 15:04:27 +0900
Message-Id: <20190720060427.50457-1-hikarupsp@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH] xhci: Add No Op Command
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
Cc: Hikaru Nishida <hikarupsp@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hikaru Nishida <hikarupsp@gmail.com>

This commit adds No Op Command (23) to xHC for verifying the operation
of the Command Ring mechanisms.
No Op Command is defined in XHCI spec (4.6.2) and just reports Command
Completion Event with Completion Code == Success.
Before this commit, No Op Command is not implemented so xHC reports
Command Completion Event with Completion Code == TRB Error. This commit
fixes this behaviour to report Completion Code correctly.

Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
---
 hw/usb/hcd-xhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5894a18663..5ceff78280 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2542,6 +2542,9 @@ static void xhci_process_commands(XHCIState *xhci)
         case CR_GET_PORT_BANDWIDTH:
             event.ccode = xhci_get_port_bandwidth(xhci, trb.parameter);
             break;
+        case CR_NOOP:
+            event.ccode = CC_SUCCESS;
+            break;
         case CR_VENDOR_NEC_FIRMWARE_REVISION:
             if (xhci->nec_quirks) {
                 event.type = 48; /* NEC reply */
-- 
2.20.1 (Apple Git-117)


