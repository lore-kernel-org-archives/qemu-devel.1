Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC12C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2E20733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pR2xB0DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2Dr-00064X-FB
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ2DB-0005Yt-3B
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ2D9-0003X6-QA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:44:48 -0400
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:52946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ2D9-0003Wo-LF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:44:47 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02ULgECk035325; Mon, 30 Mar 2020 14:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=Gsp06c4mD6b5oTAqW1wepv8IV05AmTx4NZrRvKJf03c=;
 b=pR2xB0DAznbXfWMVjKk2vkjluqwQA48v3lhlRkSTtEIK5daZ+DMgXE7N+hynveTjEZy+
 viv9/VekQKgCgo9igUKD3pgC3/ldEMhjz2eBJ+UHlsgi5NR52rvhYVTTaAS/CcAEoVqi
 Kz+VLJJy5wrjv1T7rmWuSV7q6x1qxPLXEgJiZfWclsBYWNTuViSq18OHESF+OZ6x6t6H
 c5YVOFAcv2XxLDgc2cYl+rRujJagFxmCM7MR1tFxG+dFyFuak0Ba7pPknNPpnYtZ0Yj+
 +Ma2FfrMe7etIHObqFD1wSe2CQssskTuIBShVEFnRVtpLfIllb3+gQxs7kyhsCoj5wl4 nA== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 3025juw248-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 14:44:46 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100PIN0ELDV40@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 30 Mar 2020 14:44:45 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100Q0007YC000@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 30 Mar 2020 14:44:45 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 012147316b17cd0b285d1cc34c4be8ae
X-Va-R-CD: bf920fc5652119c28bf18cc33ff3acf3
X-Va-CD: 0
X-Va-ID: 4f137540-a52b-45e3-8d46-4819406bafc4
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 012147316b17cd0b285d1cc34c4be8ae
X-V-R-CD: bf920fc5652119c28bf18cc33ff3acf3
X-V-CD: 0
X-V-ID: 553cb964-9b43-4d8a-b0a9-17a92d8cd0f3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
Received: from pontoon.com (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8100A2L0ELVA50@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 30 Mar 2020 14:44:45 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
Date: Mon, 30 Mar 2020 14:44:44 -0700
Message-id: <20200330214444.43494-1-dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.72
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

macOS will read HCIVERSION separate from CAPLENGTH.  Add a distinct
handler for that register.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 hw/usb/hcd-xhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6..061f8438de 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
     case 0x00: /* HCIVERSION, CAPLENGTH */
         ret = 0x01000000 | LEN_CAP;
         break;
+    case 0x02: /* HCIVERSION */
+        ret = 0x0100;
+        break;
     case 0x04: /* HCSPARAMS 1 */
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
             | (xhci->numintrs<<8) | xhci->numslots;
-- 
2.24.0


