Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF0320719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEMq1ke8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuso-00072q-1o
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpL-00038J-Bs
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpK-0002xd-4S
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:59 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:46846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jDtpJ-0002vc-Ub
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:58 -0400
Received: by mail-qk1-x741.google.com with SMTP id f28so27692461qkk.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vXpqImZ9HhTVPRFT9YH5x3h0Eo+XU4wDDNqk/6QRGAQ=;
 b=iEMq1ke87oNoziyEUmggvse/h/xHauvq+vOWMRidX/eys/GfmrOk9f79q+A1Hx9tRM
 M+jgDXyz/iAuBGGYh8RUh9051jkY348AJj2pmlhvq2LdJ60VGX84F7cQVBNb2d8vZas2
 ZD+1WgwqTHS4RXUFo6ttQ61Hzz7x9bKBAKap3mLk1cokQ7akQw3jOZ0QNbOMQlLthoan
 ByMcGHdyTYrY3WFrJNH4+QFkC50478h3LSOzirWEQypiILkG03cKBSMuKj/9nCcPCfHj
 UfyI5x88JoQ2vtDsT11K/qL/TRlsBl/C362TPYRcnzswAK4UCEoWfV780BKO15HTISiC
 yH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vXpqImZ9HhTVPRFT9YH5x3h0Eo+XU4wDDNqk/6QRGAQ=;
 b=XElN0WnaiNcEMI8dHUc6sYGcHGPbkQ+QXla/cPZF4/Pgp9Re77w8K7DhICrAdsL/nO
 O7xDc4H9ut3AOhIXL/P5AA+YeR5wD38qGrzH6WejbHcphnsjJ1FfhPZTjh69y4kKJ+zW
 9B5mtWiruHMCi4VND3qjF+0cSmlOLXMnETzs/RqJ+Bh7cS/jjQQydsowhxI+h3rGFcPI
 LyCECutvE71gJt7hIlWGLCmsPBc4rh38HLjBA26b5cCayVxmuYMrAHdAzB5YtBT7vKy1
 JxzMMGuAETwpSpjAVLTHBydsrHQyEcyD9hV51Hz+x2n2NdX3Eny0tjMFIubcuK0mnR2j
 ofzA==
X-Gm-Message-State: ANhLgQ3xpJcZuC8Ym3NrkSCfxyu8h5gjza/NlnzynLUa+hInZO9LrKFy
 U8xF/J9BaZVgjSPci08SwudbvoHC
X-Google-Smtp-Source: ADFU+vt4CySAYCuz16d0L5wFeLo+2GcNFJT83nnpBbczZjgPvODSO7oFLevudnqv9c5fRxRJ45yQUg==
X-Received: by 2002:a05:620a:1125:: with SMTP id
 p5mr787196qkk.425.1584380816561; 
 Mon, 16 Mar 2020 10:46:56 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:7408:9006:8741:9ceb])
 by smtp.gmail.com with ESMTPSA id
 g7sm218422qki.64.2020.03.16.10.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:46:55 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v2 4/4] usb-serial: Fix timeout closing the device
Date: Mon, 16 Mar 2020 13:46:10 -0400
Message-Id: <20200316174610.115820-5-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316174610.115820-1-jandryuk@gmail.com>
References: <20200316174610.115820-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux guests wait ~30 seconds when closing the emulated /dev/ttyUSB0.
During that time, the kernel driver is sending many control URBs
requesting GetModemStat (5).  Real hardware returns a status with
FTDI_THRE (Transmitter Holding Register) and FTDI_TEMT (Transmitter
Empty) set.  QEMU leaves them clear, and it seems Linux is waiting for
FTDI_TEMT to be set to indicate the tx queue is empty before closing.

Set the bits when responding to a GetModemStat query and avoid the
shutdown delay.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Looking at a USB dump for a real FTDI USB adapter, I see these bits set
in all the bulk URBs where QEMU currently has them clear.
---
 hw/usb/dev-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 77b964588b..d2c03681b7 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -332,7 +332,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
     case DeviceInVendor | FTDI_GET_MDM_ST:
         data[0] = usb_get_modem_lines(s) | 1;
-        data[1] = 0;
+        data[1] = FTDI_THRE | FTDI_TEMT;
         p->actual_length = 2;
         break;
     case DeviceOutVendor | FTDI_SET_EVENT_CHR:
-- 
2.24.1


