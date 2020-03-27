Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C29C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23BE20675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWSaz0N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23BE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHn0I-000788-QJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwS-0000hc-Rq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwR-0001dO-Oq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwR-0001bf-L1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFzfJ32hrPYJEd61wip0J7pOl2Rd8tBOdRTwul4UXXQ=;
 b=RWSaz0N5Yg5K/5BY2eO+QmTycpEoSaIk+l8N0PZobOALHyUgGJm53KMvDMZnMCOE1w/hrD
 QN9MMdeNZurao0LKrIPnsrq26jE7MXGUmAycvmfBfOi/ylu861n6mWWGf7BkUzDCw6tnV1
 jTWrMw4HNFyIHUeIWzyEqbfisNLidKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-StUdd3W8ME2-RVHWgbCztw-1; Fri, 27 Mar 2020 07:14:20 -0400
X-MC-Unique: StUdd3W8ME2-RVHWgbCztw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA277107ACC4;
 Fri, 27 Mar 2020 11:14:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FB75E01D;
 Fri, 27 Mar 2020 11:14:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 04/13] hw/net/e1000e_core: Let e1000e_can_receive() return a
 boolean
Date: Fri, 27 Mar 2020 19:13:58 +0800
Message-Id: <1585307647-24456-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The e1000e_can_receive() function simply returns a boolean value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 2 +-
 hw/net/e1000e_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index df957e0..d567687 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -967,7 +967,7 @@ e1000e_start_recv(E1000ECore *core)
     }
 }
=20
-int
+bool
 e1000e_can_receive(E1000ECore *core)
 {
     int i;
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 49abb13..aee32f7 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -143,7 +143,7 @@ e1000e_core_set_link_status(E1000ECore *core);
 void
 e1000e_core_pci_uninit(E1000ECore *core);
=20
-int
+bool
 e1000e_can_receive(E1000ECore *core);
=20
 ssize_t
--=20
2.5.0


