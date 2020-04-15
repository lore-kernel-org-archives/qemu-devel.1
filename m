Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 04:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F052078B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 04:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="f8iTPboY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F052078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOZoO-0001Oj-6D
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 00:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jOZnh-0000yU-AQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 00:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jOZng-0004Gq-7k
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 00:37:25 -0400
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:46240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jOZng-0004Ea-37
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 00:37:24 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 03F4ankT043753; Tue, 14 Apr 2020 21:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=mime-version :
 content-transfer-encoding : content-type : sender : from : to : cc :
 subject : date : message-id; s=20180706;
 bh=XDmELxSjQ+o5KLRWHK8+jDYRjylpjF+JDulFD0rD77Q=;
 b=f8iTPboYqItbf24hKof1ePJL1LrTPVyP7VUveFqV4sHQv+RW+P2kmbtE4yrNEyYFVeh4
 6N6e53E7KSCEdBCqdvWXV/4BwxWLu15wXb7QWVMZwL0JHL+MAsoVFicZP4jj9oYdcgIQ
 LYqDFKTdlE8TxJsZdOhY9CFLPXcmZf9fHqwbXKaGAchmdW87fmPthSJDvq540TE0ecY6
 +KKyZypgAEIK13G5T781eNE3MFkY+tasJve1cjSUFC9AEcKRe+B6NqPqnDEFTKaDjd+2
 nldHeXp+76B/jHlOL4IRKeYfqVgjxVczzC+4zNiHKPj0zRy09u3Hrbr3v3PdbJwxIIt0 tw== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 30dn6e5bh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 14 Apr 2020 21:37:18 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8T00IPABI6T920@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Tue, 14 Apr 2020 21:37:18 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8T00300B7R2200@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 14 Apr 2020 21:37:18 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d0f689b0b1d4f2921c086db3eba98d8e
X-Va-E-CD: 2e1c52973bcc393be12ee73f9d24800d
X-Va-R-CD: fa5db05249a82189bbd2eb58c4009f01
X-Va-CD: 0
X-Va-ID: 5cd2d550-994d-4b9a-a1de-b7af5ebaff0e
X-V-A: 
X-V-T-CD: d0f689b0b1d4f2921c086db3eba98d8e
X-V-E-CD: 2e1c52973bcc393be12ee73f9d24800d
X-V-R-CD: fa5db05249a82189bbd2eb58c4009f01
X-V-CD: 0
X-V-ID: acb632cd-e5a0-4ddf-9511-1c33e97ee0f5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-15_01:2020-04-14,
 2020-04-15 signatures=0
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from pontoon.com (unknown [17.234.86.21])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8T0058HBI5HT00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 14 Apr 2020 21:37:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, peter.maydell@linaro.org, clg@kaod.org, philmd@redhat.com, 
 kraxel@redhat.com
Subject: [PATCH v2] nrf51: Fix last GPIO CNF address
Date: Tue, 14 Apr 2020 21:37:17 -0700
Message-id: <51b427f06838622da783d38ba56e3630d6d85c60.1586925392.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-15_01:2020-04-14,
 2020-04-15 signatures=0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 ma1-aaemail-dr-lapp02.apple.com id 03F4ankT043753
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.68
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

But when running with patches which fix unaligned accesses in memory.c,
the qtest breaks.

Considering NRF51 doesn't support unaligned accesses, the simplest fix
is to actually set NRF51_GPIO_REG_CNF_END to the start of the last valid
CNF register: 0x77c.

Now, qtests work with or without the unaligned access patches.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
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
=20
 #define NRF51_GPIO_PULLDOWN 1
 #define NRF51_GPIO_PULLUP 3
--=20
2.24.0


