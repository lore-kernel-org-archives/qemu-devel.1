Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA86720684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+0hqFlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA86720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE9sm-0003ec-MJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE9s2-0002Iy-41
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE9s0-0003MD-2a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599218822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hngWtsFTxn3LMsGtKA6PdjFT1F6IOvfAQrgr0SqAr5A=;
 b=W+0hqFlTmFCDjII0kHe1F3970QCPecOSjYzwD0e0yqK/eog/nCrAgh7sptQ9KHPYT3Jqxp
 2wqStcMbK6ebgS5VdjyPQf6QDEtC/6lMAdkEJPSsEKYESBU0YaL5FTWXqieSPJYIz0hnWS
 f+xk4NdtS2/hxkpcq3agfl+ujdVxU1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-rWpNN7NdMb-X3jC4c9JIdw-1; Fri, 04 Sep 2020 07:26:57 -0400
X-MC-Unique: rWpNN7NdMb-X3jC4c9JIdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1660107465A;
 Fri,  4 Sep 2020 11:26:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13FDD7E41B;
 Fri,  4 Sep 2020 11:26:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C1C245AE; Fri,  4 Sep 2020 13:26:48 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] cirrus: handle wraparound in cirrus_invalidate_region
Date: Fri,  4 Sep 2020 13:26:48 +0200
Message-Id: <20200904112648.10259-3-kraxel@redhat.com>
In-Reply-To: <20200904112648.10259-1-kraxel@redhat.com>
References: <20200904112648.10259-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@163.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code simply asserts that there is no wraparound instead of handling
it properly.  The assert() can be triggered by the guest (must be
privilidged inside the guest though).  Fix it.

Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
Cc: Li Qiang <liq3ea@163.com>
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@163.com>
Message-id: 20200901140944.24101-1-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 02d9ed0bd465..41e71af08a0f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -640,10 +640,16 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     }
 
     for (y = 0; y < lines; y++) {
-        off_cur = off_begin;
+        off_cur = off_begin & s->cirrus_addr_mask;
         off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
-        assert(off_cur_end >= off_cur);
-        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
+        if (off_cur_end >= off_cur) {
+            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
+        } else {
+            /* wraparound */
+            memory_region_set_dirty(&s->vga.vram, off_cur,
+                                    s->cirrus_addr_mask + 1 - off_cur);
+            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
+        }
         off_begin += off_pitch;
     }
 }
-- 
2.27.0


