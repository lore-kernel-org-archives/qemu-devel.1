Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4D4C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF30B24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="V8iMZCKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF30B24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I7O-0008PC-2j
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6D-00072Q-F6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6B-00019x-LT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:04 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:64917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1j7I6B-00014m-0Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1582805823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8IRbE7fi2zeIru+YNuSvtho8VZpqQ7qeuz/NZSjvevc=;
 b=V8iMZCKEziZn8Y4BIkJgJOEx8iaDiZJLUehIRLPq0qNaHuo0s9HlOGxq
 QnavSOQhmSVRV6qW8Uo9BzRkDXQl3i8bdQFguWu1n5N5cFh+S6ijbAzN5
 8NU3Et38UbnIX6U1YJMR9+aMpbGygNp+wCy8SWRlgi2imM8Q7zuNQaCc7 4=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: X6WABXO5my6vAqtmL3fiBTbQmtsXko+bec88TVAPgHel1loM5pe9b6lDJYGMLFykzkQJD3LscV
 pvpiVbdBGJSKyKaZGxq3MQJs6/Eb+AGJd4l9F5UMRiD7zaBjc3trGFsdIxOC9FvchDq004U5Sd
 qpUVchZJbN70SsEnDjFqRYRi107x+aNi6eoz4n8SOpRUc7kEMEDFe+zE0GudVz5M3wHmdyoxAI
 vvq3K+dVY6/byyAbyAPJhAfzx+5rsOR4a/rpu56dzTanZlMtYxfMj1SiAbYXCd+w5pPbfmUark
 vJ0=
X-SBRS: 2.7
X-MesageID: 13277762
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,492,1574139600"; d="scan'208";a="13277762"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 1/3] hw/xen/xen_pt_load_rom: Remove unused includes
Date: Thu, 27 Feb 2020 12:16:43 +0000
Message-ID: <20200227121645.2601280-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227121645.2601280-1-anthony.perard@citrix.com>
References: <20200227121645.2601280-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

xen_pt_load_rom.c does not use any of these includes, remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20191014142246.4538-9-philmd@redhat.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_pt_load_rom.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 307a5c93e235..a50a80837ea2 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -3,12 +3,8 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/i386/pc.h"
 #include "qemu/error-report.h"
-#include "ui/console.h"
 #include "hw/loader.h"
-#include "monitor/monitor.h"
-#include "qemu/range.h"
 #include "hw/pci/pci.h"
 #include "xen_pt.h"
 
-- 
Anthony PERARD


