Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0731AC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 07:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58B320896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 07:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58B320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbKL4-0005QH-Qs
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 03:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hbKJn-00044C-2B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hbKJl-00064a-UR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:38:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hbKJl-00063s-OR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:38:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B4C330001DD;
 Thu, 13 Jun 2019 07:38:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A018600C0;
 Thu, 13 Jun 2019 07:38:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4C16017510; Thu, 13 Jun 2019 09:38:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 09:38:33 +0200
Message-Id: <20190613073834.22001-2-kraxel@redhat.com>
In-Reply-To: <20190613073834.22001-1-kraxel@redhat.com>
References: <20190613073834.22001-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 07:38:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] edid: add xmax + ymax properties
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new properties to allow setting the maximum display resolution.
Resolutions larger than that will not be included in the mode list.
In linux guests xrandr can be used to list modes.

Note: The existing xres and yres properties set the preferred display
resolution, i.e. the mode should be first in the mode list and guests
should use it by default.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190607083429.31943-1-kraxel@redhat.com
---
 include/hw/display/edid.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index bacf1708894b..7948bd2c40f8 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -22,6 +22,8 @@ void qemu_edid_region_io(MemoryRegion *region, Object *owner,
 
 #define DEFINE_EDID_PROPERTIES(_state, _edid_info)              \
     DEFINE_PROP_UINT32("xres", _state, _edid_info.prefx, 0),    \
-    DEFINE_PROP_UINT32("yres", _state, _edid_info.prefy, 0)
+    DEFINE_PROP_UINT32("yres", _state, _edid_info.prefy, 0),    \
+    DEFINE_PROP_UINT32("xmax", _state, _edid_info.maxx, 0),     \
+    DEFINE_PROP_UINT32("ymax", _state, _edid_info.maxy, 0)
 
 #endif /* EDID_H */
-- 
2.18.1


