Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787EF204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT4APYdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787EF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3b3X-0005ZB-Lz
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3b0J-0000UM-Rt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:12:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3b0H-0006Am-Ke
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596701516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+vkL/rWmSLNgGXHOv1NU1qrwCDKsI4zH1RF4xW5wW4=;
 b=GT4APYdCrAKr4tIS79aUkLjQN9hykyVYT8J6JG0gFyP3H4F6iPMC8khNSZuoRTXgleEqKS
 +62CbPq9tB9Of5RuBtGJh/A0l7BhRClVo2t0ccygnlO0GFoGTnKAP4xxXko9pFkmBbTI9n
 LYyDP1aWteT4HBqTa3IIUE/DvCiBvh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-eUb1pmDNONaY8-4wc5fJPg-1; Thu, 06 Aug 2020 04:11:53 -0400
X-MC-Unique: eUb1pmDNONaY8-4wc5fJPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7059458;
 Thu,  6 Aug 2020 08:11:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5D96179D;
 Thu,  6 Aug 2020 08:11:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A633010FDD9E; Thu,  6 Aug 2020 10:11:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docs/qdev-device-use: Don't suggest -drive and -net can
 do USB
Date: Thu,  6 Aug 2020 10:11:47 +0200
Message-Id: <20200806081147.3123652-4-armbru@redhat.com>
In-Reply-To: <20200806081147.3123652-1-armbru@redhat.com>
References: <20200806081147.3123652-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 480324ec8d "docs/qdev-device-use: Clean up the sentences
related to -usbdevice" deleted the information on syntax that no
longer works.  Unfortunately, the resulting text suggests you can
configure USB block devices with -drive, and USB network devices with
-net, which is misleading.

Instead of rephrasing the now misleading text, I'm putting the
information back, and just make clear it's about old versions of QEMU.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qdev-device-use.txt | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index f8d0d2fe29..8532ba5224 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -125,7 +125,14 @@ The -device argument differs in detail for each type of drive:
 
 * if=pflash, if=mtd, if=sd, if=xen are not yet available with -device
 
-For USB storage devices, you can use something like:
+For USB devices, the old way was actually different:
+
+    -usbdevice disk:format=FMT:FILENAME
+
+"Was" because "disk:" is gone since v2.12.0.
+
+The old way provided much less control than -drive's OPTS...  The new
+way fixes that:
 
     -device usb-storage,drive=DRIVE-ID,removable=RMB
 
@@ -178,6 +185,9 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
 
   -device usb-braille,chardev=braille -chardev braille,id=braille
 
+* -usbdevice serial::chardev is gone since v2.12.0.  It became
+  -device usb-serial,chardev=dev.
+
 LEGACY-CHARDEV translates to -chardev HOST-OPTS... as follows:
 
 * null becomes -chardev null
@@ -231,6 +241,12 @@ The old way to define the guest part looks like this:
 
     -net nic,netdev=NET-ID,macaddr=MACADDR,model=MODEL,name=ID,addr=STR,vectors=V
 
+Except for USB it looked like this:
+
+    -usbdevice net:netdev=NET-ID,macaddr=MACADDR,name=ID
+
+"Looked" because "net:" is gone since v2.12.0.
+
 The new way is -device:
 
     -device DEVNAME,netdev=NET-ID,mac=MACADDR,DEV-OPTS...
@@ -327,6 +343,13 @@ The new way is -device DEVNAME,DEV-OPTS...  Details depend on DRIVER:
 * wacom-tablet    -device usb-wacom-tablet
 * braille         See "Character Devices"
 
+Until v2.12.0, we additionally had
+
+* host:...        See "Host Device Assignment"
+* disk:...        See "Block Devices"
+* serial:...      See "Character Devices"
+* net:...         See "Network Devices"
+
 === Watchdog Devices ===
 
 Host and guest part of watchdog devices have always been separate.
@@ -342,7 +365,14 @@ and host USB devices.  PCI devices can only be assigned with -device:
 
     -device vfio-pci,host=ADDR,id=ID
 
-To assign a host USB device use:
+The old way to assign a USB host device
+
+    -usbdevice host:auto:BUS.ADDR:VID:PRID
+
+was removed in v2.12.0.  Any of BUS, ADDR, VID, PRID could be the
+wildcard *.
+
+The new way is
 
     -device usb-host,hostbus=BUS,hostaddr=ADDR,vendorid=VID,productid=PRID
 
-- 
2.26.2


