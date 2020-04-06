Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 22:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99DC2078C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 22:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="eYn3xDuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99DC2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLafx-0006fY-0Z
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 18:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jLaes-0005cd-4o
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jLaeq-0000Ue-A5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:55:57 -0400
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:59238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jLaep-0000TJ-M0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:55:56 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 036MqDeb029834; Mon, 6 Apr 2020 15:55:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=hnHi7WI0O0n9+r7/0qDMDTwt2YUvqYNxWeQMHhl9yl0=;
 b=eYn3xDuHvTiKpK7JJq7APmj7lzSxQ5sKhAQgiASXf5PHDFs8qHNHQgcjm1vHcILw02t4
 3ZLGuN3KZA/5yKh8MoQii8nQIPMhB6eJGXOJPclRgh0rKm0juAY2B+1NldVWJnBHv7lN
 tOHjkz4vH2Iw2iEf/E40JBk8GXG3/CxO2pxecuOzBaJTeS2ErovRqAk4jl2/qRt0MGN5
 YBYEQ/ZKfyVA5yPF2TayyvwLFVwDOmoOBDWit3z/TO8RnMOHnXRRq5n4xxZxsxE9eDcf
 X4EI9AWUHpTBf72hxZNwQ56X6Hi0L/JOekLGSVS1/Xvs36GYlaicWmT+978nJwweBwKp Cg== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 306rw2fuhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 06 Apr 2020 15:55:45 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8E003Q12CWL240@rn-mailsvcp-mta-lapp01.rno.apple.com>; 
 Mon, 06 Apr 2020 15:55:45 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8E00O002AG4Z00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 06 Apr 2020 15:55:44 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d0f689b0b1d4f2921c086db3eba98d8e
X-Va-E-CD: 323816aa3fc595e98d52185722ff1c53
X-Va-R-CD: 41358f3a55e2bff765e7dbd4153ff819
X-Va-CD: 0
X-Va-ID: 6e7056ba-c171-4961-871e-333a7612e777
X-V-A: 
X-V-T-CD: d0f689b0b1d4f2921c086db3eba98d8e
X-V-E-CD: 323816aa3fc595e98d52185722ff1c53
X-V-R-CD: 41358f3a55e2bff765e7dbd4153ff819
X-V-CD: 0
X-V-ID: 9b11ac7b-83fa-402f-9b2f-824dd6fb47e8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_10:2020-04-06,
 2020-04-06 signatures=0
Received: from pontoon.com (unknown [17.234.27.122])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8E00O2A2CWVG00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 06 Apr 2020 15:55:44 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, peter.maydell@linaro.org, clg@kaod.org, philmd@redhat.com, 
 kraxel@redhat.com
Subject: [PATCH v1] nrf51: Fix last GPIO CNF address
Date: Mon, 06 Apr 2020 15:55:43 -0700
Message-id: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_10:2020-04-06,
 2020-04-06 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.60
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

NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
valid CNF register: it's referring to the last byte of the last valid
CNF register.

This hasn't been a problem up to now, as current implementation in
memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
and the qtest only looks at the least-significant byte of the register.

But, when running with Cedric Le Goater's <clg@kaod.org> pending fix for
unaligned accesses in memory.c, the qtest breaks.

Considering NRF51 doesn't support unaligned accesses, the simplest fix
is to actually set NRF51_GPIO_REG_CNF_END to the start of the last valid
CNF register: 0x77c.

Now, qtests work with or without Cedric's patch.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 include/hw/gpio/nrf51_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 337ee534bb..1d62bbc928 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -42,7 +42,7 @@
 #define NRF51_GPIO_REG_DIRSET       0x518
 #define NRF51_GPIO_REG_DIRCLR       0x51C
 #define NRF51_GPIO_REG_CNF_START    0x700
-#define NRF51_GPIO_REG_CNF_END      0x77F
+#define NRF51_GPIO_REG_CNF_END      0x77C
 
 #define NRF51_GPIO_PULLDOWN 1
 #define NRF51_GPIO_PULLUP 3
-- 
2.24.0


