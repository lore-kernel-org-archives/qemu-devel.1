Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A1C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC638221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWfVsnhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC638221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8PA-0005Sc-TH
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LQ-0001sI-4c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LK-0005gv-8J
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603264528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=py4dCIAOe2HNi9oJ5WNPRqfKpIGOexZ50KvSEt9WNmE=;
 b=eWfVsnhT+DCM+n2gfjHu88QSWY17UuXGer83MTomsfaqWB8bA4igbcKabWTn9I+N93vUvr
 hRtKX0vaftcU5wJB7WBrIw2KhpLyRt5RslurqCs8U4BirrkJKC+OFxffx/Yi6tQl1hPCOM
 pFRhpLPDVn0e2bg6nI7E3ldXtVGnIWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-4OJeCcAtOsCnUHpIYB1KRg-1; Wed, 21 Oct 2020 03:15:26 -0400
X-MC-Unique: 4OJeCcAtOsCnUHpIYB1KRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02459107ACF7;
 Wed, 21 Oct 2020 07:15:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB3265B4C0;
 Wed, 21 Oct 2020 07:15:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F57C11329AD; Wed, 21 Oct 2020 09:15:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qga: Rename guest-get-devices return member 'address' to
 'id'
Date: Wed, 21 Oct 2020 09:15:17 +0200
Message-Id: <20201021071520.2168877-2-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-1-armbru@redhat.com>
References: <20201021071520.2168877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, philmd@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Member 'address' is union GuestDeviceAddress with a single branch
GuestDeviceAddressPCI, containing PCI vendor ID and device ID.  This
is not a PCI address.  Type GuestPCIAddress is.  Messed up in recent
commit 2e4211cee4 "qga: add command guest-get-devices for reporting
VirtIO devices".

Rename type GuestDeviceAddressPCI to GuestDeviceIdPCI, type
GuestDeviceAddress to GuestDeviceId, and member 'address' to 'id'.

Document the member properly while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 17 +++++++++--------
 qga/commands-win32.c | 16 ++++++++--------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index cec98c7e06..f2c81cda2b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1257,26 +1257,26 @@
   'returns': 'GuestOSInfo' }
 
 ##
-# @GuestDeviceAddressPCI:
+# @GuestDeviceIdPCI:
 #
 # @vendor-id: vendor ID
 # @device-id: device ID
 #
 # Since: 5.2
 ##
-{ 'struct': 'GuestDeviceAddressPCI',
+{ 'struct': 'GuestDeviceIdPCI',
   'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
 
 ##
-# @GuestDeviceAddress:
+# @GuestDeviceId:
 #
-# Address of the device
-# - @pci: address of PCI device, since: 5.2
+# Id of the device
+# - @pci: PCI ID, since: 5.2
 #
 # Since: 5.2
 ##
-{ 'union': 'GuestDeviceAddress',
-  'data': { 'pci': 'GuestDeviceAddressPCI' } }
+{ 'union': 'GuestDeviceId',
+  'data': { 'pci': 'GuestDeviceIdPCI' } }
 
 ##
 # @GuestDeviceInfo:
@@ -1284,6 +1284,7 @@
 # @driver-name: name of the associated driver
 # @driver-date: driver release date in format YYYY-MM-DD
 # @driver-version: driver version
+# @id: device ID
 #
 # Since: 5.2
 ##
@@ -1292,7 +1293,7 @@
       'driver-name': 'str',
       '*driver-date': 'str',
       '*driver-version': 'str',
-      '*address': 'GuestDeviceAddress'
+      '*id': 'GuestDeviceId'
   } }
 
 ##
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f..879b02b6c3 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2390,22 +2390,22 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         }
         for (j = 0; hw_ids[j] != NULL; j++) {
             GMatchInfo *match_info;
-            GuestDeviceAddressPCI *address;
+            GuestDeviceIdPCI *id;
             if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)) {
                 continue;
             }
             skip = false;
 
-            address = g_new0(GuestDeviceAddressPCI, 1);
+            id = g_new0(GuestDeviceIdPCI, 1);
             vendor_id = g_match_info_fetch(match_info, 1);
             device_id = g_match_info_fetch(match_info, 2);
-            address->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
-            address->device_id = g_ascii_strtoull(device_id, NULL, 16);
+            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
-            device->address = g_new0(GuestDeviceAddress, 1);
-            device->has_address = true;
-            device->address->type = GUEST_DEVICE_ADDRESS_KIND_PCI;
-            device->address->u.pci.data = address;
+            device->id = g_new0(GuestDeviceId, 1);
+            device->has_id = true;
+            device->id->type = GUEST_DEVICE_ID_KIND_PCI;
+            device->id->u.pci.data = id;
 
             g_match_info_free(match_info);
             break;
-- 
2.26.2


