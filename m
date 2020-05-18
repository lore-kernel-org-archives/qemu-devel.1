Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738C620671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voql2cjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738C620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahTC-0001Oe-K6
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS2-0008CW-Rx
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS1-0005xG-T8
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=m+oXLR/s2hsUzUabYgFwDLrpvj1T3gZYj4iuWFEwGKY=;
 b=Voql2cjRyEIkW3v4w7VQzED3Dz7ZQDHytrvUbuuNoqrCPssRegON+L7Bo3Mgxb63CdUKzG
 Nr2erfd4etPdBYErRzuL5K/fnKAw9ctm1/U5pQ9SU7bhslHPcaN7el/pe++lsqczif25ns
 PKnPhk30lNLlTHx4F4cuBvY45GekXCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-1Q3EqMwkP5yxQ8k2pWoYLg-1; Mon, 18 May 2020 11:13:06 -0400
X-MC-Unique: 1Q3EqMwkP5yxQ8k2pWoYLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA49EC1A2;
 Mon, 18 May 2020 15:13:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45515D9DD;
 Mon, 18 May 2020 15:13:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C82BE9D54; Mon, 18 May 2020 17:12:55 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] ramfb: fix size calculation
Date: Mon, 18 May 2020 17:12:55 +0200
Message-Id: <20200518151255.10785-9-kraxel@redhat.com>
In-Reply-To: <20200518151255.10785-1-kraxel@redhat.com>
References: <20200518151255.10785-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

size calculation isn't correct with guest-supplied stride, the last
display line isn't accounted for correctly.

For the typical case of stride > linesize (add padding) we error on the
safe side (calculated size is larger than actual size).

With stride < linesize (scanlines overlap) the calculated size is
smaller than the actual size though so our guest memory mapping might
end up being too small.

While being at it also fix ramfb_create_display_surface to use hwaddr
for the parameters.  That way all calculation are done with hwaddr type
and we can't get funny effects from type castings.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20200429115236.28709-7-kraxel@redhat.com
---
 hw/display/ramfb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 52dae78db48f..79b9754a5820 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -44,10 +44,10 @@ static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
 
 static DisplaySurface *ramfb_create_display_surface(int width, int height,
                                                     pixman_format_code_t format,
-                                                    int linesize, uint64_t addr)
+                                                    hwaddr stride, hwaddr addr)
 {
     DisplaySurface *surface;
-    hwaddr size;
+    hwaddr size, mapsize, linesize;
     void *data;
 
     if (width < 16 || width > VBE_DISPI_MAX_XRES ||
@@ -55,19 +55,20 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
         format == 0 /* unknown format */)
         return NULL;
 
-    if (linesize == 0) {
-        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
+    linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
+    if (stride == 0) {
+        stride = linesize;
     }
 
-    size = (hwaddr)linesize * height;
-    data = cpu_physical_memory_map(addr, &size, false);
-    if (size != (hwaddr)linesize * height) {
-        cpu_physical_memory_unmap(data, size, 0, 0);
+    mapsize = size = stride * (height - 1) + linesize;
+    data = cpu_physical_memory_map(addr, &mapsize, false);
+    if (size != mapsize) {
+        cpu_physical_memory_unmap(data, mapsize, 0, 0);
         return NULL;
     }
 
     surface = qemu_create_displaysurface_from(width, height,
-                                              format, linesize, data);
+                                              format, stride, data);
     pixman_image_set_destroy_function(surface->image,
                                       ramfb_unmap_display_surface, NULL);
 
-- 
2.18.4


