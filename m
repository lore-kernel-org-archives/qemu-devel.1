Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F2AC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 11:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF1820706
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 11:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbCeJiC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF1820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijiBj-0005Wy-7Z
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 06:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ijiBA-00055y-CF
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 06:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ijiB8-0002ba-4t
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 06:16:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ijiB7-0002b6-Qp
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 06:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577186201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Wd7Gs7rLVEYWzQiZq22G7KJajr8UQ/SE362o+TMIIc=;
 b=gbCeJiC4rvGlXe8K0WhF0mf6OSGaPRElL3FeHZ63h7BtiElwqTjBAw4xbDgCNDtMUSZI5Y
 Fg/tYOdZUGb2kqly0jC7Ef9mXBiQSZl256aI7aApkcVtcrVKdOQ0bUZkP+FjkYuVw4riZl
 o982MmdNnQ/+db4QX02KMLCxwe0D8bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-X-ueEeSaMe-_73jsvQMXvA-1; Tue, 24 Dec 2019 06:16:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEEB477
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 11:16:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-242.ams2.redhat.com [10.36.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4A5B272CC;
 Tue, 24 Dec 2019 11:16:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/rtc/mc146818: Add missing dependency on ISA Bus
Date: Tue, 24 Dec 2019 12:16:28 +0100
Message-Id: <20191224111628.3551-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X-ueEeSaMe-_73jsvQMXvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MC146818 sits on an ISA bus. Since it can not be used
without it, select ISA in the Kconfig.

Fixes: 82f5181777e
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 45daa8d655..3dc2dd6888 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -17,6 +17,7 @@ config TWL92230
     depends on I2C
=20
 config MC146818RTC
+    depends on ISA_BUS
     bool
=20
 config SUN4V_RTC
--=20
2.21.0


