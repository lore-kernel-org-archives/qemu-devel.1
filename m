Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FEC83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A2320728
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmzHm6B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A2320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTFyT-0003rG-7O
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFv8-0005DH-Ch
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFv7-0002jP-RK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jTFv7-0002j4-E2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id k18so7740913pll.6
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=tmzHm6B6bu19y7fviz5MyUZd9robGhK6Et5kJLPLgjbLYAOsEkd1qoG5zU6xIdptzX
 N+Gp1/fklAOuv5gX7bc/603W2VzqNBQTRW8xV7CtMwwqv5DThUoPNIzJXfIKbc2WXv4L
 ElgQ+9L5bz5ZpcAdfuKRQXOo16GWIt0PaQfMfgKdBIfLWDdDv2SURtYbF61fXFD/7a3W
 BbWQtmn/BC0YglMu8s0/8u/voVApO1FxuAkDHjn3Zzj3RisUJk7SbijMiaWt1hMv5Z1I
 xA3Hk0OkbsLZxxgdiSNxwXzN0nEyVmVkeeIAAoUgV1EKmMZ56hd1QEaC8+NotKBspWCp
 SHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=K41pQSY8MH7ZhCl0aLHKL4IsTg/yP+ShyrHN/Gc6H5fmHOUD3ZMyMJaTldudAY2BLd
 Ol5VgSdQv3xO/mwTZNhUcWq8LIYl0vbt0kMXGBwaeM56m633IBd9jjkJldIK3Kga5F29
 obthK8/seuUAoy5Q1VvCIudC/anE88XTtmknqYAxn51OKOE4ycpqLrkOPZx47Q3hokUf
 hnWHU9756ULY9wnjMUBygV/NRD2WHveGdswLnaHGVF2k/1vsfcodlBfiw7rnwkRh27lw
 BvFxQfWKJamHGOuG5hp/I9IznnYiX8tMkRZXJjkq+ByandOF9GK01jp0OD0YdX3KDnD/
 xhpg==
X-Gm-Message-State: AGi0PuZGXpOzR5/PMc/E1y72mQhz64WEejoXF2AxjD+5UI/6/bPj1TS3
 K8e/4g3Og7xUgP+ZLIl1c4TOge5BahCSAQ==
X-Google-Smtp-Source: APiQypKBTc5meP5268YW5i33ZMYPxRBQRoUcxn7ioNeVWkMD/j2TTqrMlrVKqkdMCYe7vgEXO19koQ==
X-Received: by 2002:a17:902:b088:: with SMTP id
 p8mr14227334plr.244.1588040664032; 
 Mon, 27 Apr 2020 19:24:24 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id z190sm11695649pgz.73.2020.04.27.19.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:24:23 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 5/7] usb: add short-packet handling to usb-storage driver
Date: Mon, 27 Apr 2020 19:22:30 -0700
Message-Id: <20200428022232.18875-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428022232.18875-1-pauldzim@gmail.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dwc-hsotg (dwc2) USB host depends on a short packet to
indicate the end of an IN transfer. The usb-storage driver
currently doesn't provide this, so fix it.

I have tested this change rather extensively using a PC
emulation with xhci, ehci, and uhci controllers, and have
not observed any regressions.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/usb/dev-storage.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 5c4b57b06b..ae3c550042 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -229,6 +229,9 @@ static void usb_msd_copy_data(MSDState *s, USBPacket *p)
     usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
     s->scsi_len -= len;
     s->scsi_off += len;
+    if (len > s->data_len) {
+        len = s->data_len;
+    }
     s->data_len -= len;
     if (s->scsi_len == 0 || s->data_len == 0) {
         scsi_req_continue(s->req);
@@ -303,6 +306,9 @@ static void usb_msd_command_complete(SCSIRequest *req, uint32_t status, size_t r
             if (s->data_len) {
                 int len = (p->iov.size - p->actual_length);
                 usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
+                }
                 s->data_len -= len;
             }
             if (s->data_len == 0) {
@@ -469,6 +475,9 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
@@ -528,13 +537,17 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
                     }
                 }
             }
-            if (p->actual_length < p->iov.size) {
+            if (p->actual_length < p->iov.size && (p->short_not_ok ||
+                    s->scsi_len >= p->ep->max_packet_size)) {
                 DPRINTF("Deferring packet %p [wait data-in]\n", p);
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
-- 
2.17.1


