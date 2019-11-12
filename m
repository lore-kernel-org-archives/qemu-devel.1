Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFE2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281FA2084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I84Xr5Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281FA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZ98-0003ea-0R
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUZ7m-00035I-NV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUZ7j-0005iU-RR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:34:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUZ7j-0005iJ-O7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573576475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b3SMrYxnvckf37Kdq1BzVr9OthfuhBasECOwaXNmd50=;
 b=I84Xr5YiLXyK3+l1INbC/kQRsijP40Uc49o5nRvKszyzbD2pP0qgI6Qy2m95DFMGqZXZVv
 oQJBMEzNq4VgTIcPPFpR4seKy1rmrsYaKF3h2LFnKFh3i9KGGIsbnHgHz4IyLTNxi4Voi4
 O539oMAbODrkbOFTM7qb0PJaBXqHEsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-sZzqbAD_PHyinUmjQtO5Ag-1; Tue, 12 Nov 2019 11:34:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A55B107AD44;
 Tue, 12 Nov 2019 16:34:31 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 357381B477;
 Tue, 12 Nov 2019 16:34:23 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] microvm: fix memory leak in microvm_fix_kernel_cmdline
Date: Tue, 12 Nov 2019 17:34:23 +0100
Message-Id: <20191112163423.91884-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sZzqbAD_PHyinUmjQtO5Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In microvm_fix_kernel_cmdline(), fw_cfg_modify_string() is duplicating
cmdline instead of taking ownership of it. Free it afterwards to avoid
leaking it.

Reported-by: Coverity (CID 1407218)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/microvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 8aacd6c8d1..def37e60f7 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -331,6 +331,8 @@ static void microvm_fix_kernel_cmdline(MachineState *ma=
chine)
=20
     fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) =
+ 1);
     fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
+
+    g_free(cmdline);
 }
=20
 static void microvm_machine_state_init(MachineState *machine)
--=20
2.23.0


