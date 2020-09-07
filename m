Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450B72078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEyAjq13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDl2-0003ni-7l
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkN-0002zE-KY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkM-00069S-2u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599472053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PhPG/yGONraFLO3yXduMzVJbRtrhIzHfX4XWGSf8YCQ=;
 b=HEyAjq13ImhIdCWvwI0qgaIHLrpbN741ZTolYf357uy7BKV9/RvMW21+dZN6dAWA/pZB9n
 WrIkWUgm3cUtedI+FQf9fU1vriCWOdDt8kF0r/LEbyQnKMe6ePiMvcWHoXPWoc7kekkMTX
 D4vIL1S19D8dIGGOXbAX3l1wYnZ1U0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-IcH2ZUvuNhCbJJA6lOVtnw-1; Mon, 07 Sep 2020 05:47:31 -0400
X-MC-Unique: IcH2ZUvuNhCbJJA6lOVtnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B656800470
 for <qemu-devel@nongnu.org>; Mon,  7 Sep 2020 09:47:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C57E5C26A;
 Mon,  7 Sep 2020 09:47:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 462F07828; Mon,  7 Sep 2020 11:47:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] object_initialize: try module load
Date: Mon,  7 Sep 2020 11:47:17 +0200
Message-Id: <20200907094719.12850-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed to allow virtio-gpu-pci initialize the
virtio-gpu-device child device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qom/object.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 00fdf89b3b0a..f85740001520 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -518,6 +518,12 @@ void object_initialize(void *data, size_t size, const char *typename)
 {
     TypeImpl *type = type_get_by_name(typename);
 
+#ifdef CONFIG_MODULES
+    if (!type) {
+        module_load_qom_one(typename);
+        type = type_get_by_name(typename);
+    }
+#endif
     if (!type) {
         error_report("missing object type '%s'", typename);
         abort();
-- 
2.27.0


