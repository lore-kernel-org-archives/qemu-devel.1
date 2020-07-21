Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE4BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8FA2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hv+HMTHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8FA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuQo-0000vj-EC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1jxuOP-0006Kn-M1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1jxuON-00009v-7L
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mzQCmOqxa454LuAgpNeFbK0d95FnlBERa0ehc2C5aDE=;
 b=hv+HMTHU/EPiop5403/53SYQZwSOhnJbTPOtf9PGTy3kip6/KDboRaZ8ATeExIiFTp/KQi
 Zgh/hRI8Rjzt0yvhMt93sqGH2SdLvIA1RESYmEOYj30lqTU+tadcjZPauXwmOMQQrcuR49
 NLQ+Fa8DVALUZTWwm80BEikbkMZZk9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-qkMlKHbIMEWuf_hVovt82g-1; Tue, 21 Jul 2020 11:40:45 -0400
X-MC-Unique: qkMlKHbIMEWuf_hVovt82g-1
Received: by mail-wr1-f71.google.com with SMTP id 5so2135484wrc.17
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mzQCmOqxa454LuAgpNeFbK0d95FnlBERa0ehc2C5aDE=;
 b=kwJIwkXsZIh0eCS8QhRFtZIEtQ7UDvo5xA8r1j1u/3KONNHdsqqGoI53C0fIgqLmeg
 M20YCEfaUvHegIqczoS0xKtCJS/Rrvu+KOha0Uje0aNbEtbsS0fR+OvtvqwjENyFJ3Br
 S8WUh7om681UKVnRpSBq7bUEO29svlz/n+jxcnoVRrVM5tPhd79uyfamAnJISuM9mPHk
 8hhlmvPRd97WPB5otCSdDsz7SFw0JVk85Dou5q6PbdADwCRTTVFThEtqSZNKRzbMx3GO
 awGWmhCf214st1a8nIous55re8yjxSXBVMTNl6ZsbF6KBq05z9sp2u3WC+gArlC2CULm
 gjow==
X-Gm-Message-State: AOAM5335dP7FczB2/aqfknjF6/j/vK/HAOyKH7dQ3ZgH3qMlAY425zeS
 aE9D6YaFTunaiskozpxjIAv+Drpib9jRQ4sNOQYHsjRpnR8Vd/CW7HqxzhlvN8zeLwObF+06Z8F
 3IoykeRXuZdkJIJ0=
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr4847243wmf.38.1595346043373; 
 Tue, 21 Jul 2020 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt4A0rpGpJD7gwBgn2LQb480Juo3hFuctBj2GTZPJtHiewbjSx3vk4NhNPeB64Ezvp0Osccg==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr4847214wmf.38.1595346043036; 
 Tue, 21 Jul 2020 08:40:43 -0700 (PDT)
Received: from auriga.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 u2sm3682925wml.16.2020.07.21.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 08:40:42 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10] qga: add command guest-get-devices for reporting VirtIO
 devices
Date: Tue, 21 Jul 2020 17:40:41 +0200
Message-Id: <24edfdd5ff980abc0b66889246d88ab25ebee1fa.1595345951.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add command for reporting devices on Windows guest. The intent is not so
much to report the devices but more importantly the driver (and its
version) that is assigned to the device. This gives caller the
information whether VirtIO drivers are installed and/or whether
inadequate driver is used on a device (e.g. QXL device with base VGA
driver).

Example:
[
    {
      "driver-date": "2019-08-12",
      "driver-name": "Red Hat VirtIO SCSI controller",
      "driver-version": "100.80.104.17300",
      "address": {
        "type": "pci",
        "data": {
          "device-id": 4162,
          "vendor-id": 6900
        }
      }
    },
    ...
]

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v10:
- rebased to current master
- changed `since` tag in schema to 5.2

 qga/commands-posix.c |   9 ++
 qga/commands-win32.c | 212 ++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  51 +++++++++++
 3 files changed, 271 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a62a3a70d..f509a1f525 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2761,6 +2761,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
     blacklist = g_list_append(blacklist, g_strdup("guest-fstrim"));
 #endif
 
+    blacklist = g_list_append(blacklist, g_strdup("guest-get-devices"));
+
     return blacklist;
 }
 
@@ -2981,3 +2983,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+
+    return NULL;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index aaa71f147b..1302bae9eb 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -21,10 +21,11 @@
 #ifdef CONFIG_QGA_NTDDSCSI
 #include <winioctl.h>
 #include <ntddscsi.h>
+#endif
 #include <setupapi.h>
 #include <cfgmgr32.h>
 #include <initguid.h>
-#endif
+#include <devpropdef.h>
 #include <lm.h>
 #include <wtsapi32.h>
 #include <wininet.h>
@@ -39,6 +40,36 @@
 #include "qemu/base64.h"
 #include "commands-common.h"
 
+/*
+ * The following should be in devpkey.h, but it isn't. The key names were
+ * prefixed to avoid (future) name clashes. Once the definitions get into
+ * mingw the following lines can be removed.
+ */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
+    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
+    /* DEVPROP_TYPE_STRING */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
+    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
+    /* DEVPROP_TYPE_STRING_LIST */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
+    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
+    /* DEVPROP_TYPE_FILETIME */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
+    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
+    /* DEVPROP_TYPE_STRING */
+/* The following shoud be in cfgmgr32.h, but it isn't */
+#ifndef CM_Get_DevNode_Property
+CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
+    DEVINST          dnDevInst,
+    CONST DEVPROPKEY * PropertyKey,
+    DEVPROPTYPE      * PropertyType,
+    PBYTE            PropertyBuffer,
+    PULONG           PropertyBufferSize,
+    ULONG            ulFlags
+);
+#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
+#endif
+
 #ifndef SHTDN_REASON_FLAG_PLANNED
 #define SHTDN_REASON_FLAG_PLANNED 0x80000000
 #endif
@@ -93,6 +124,8 @@ static OpenFlags guest_file_open_modes[] = {
     g_free(suffix); \
 } while (0)
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDeviceInfo)
+
 static OpenFlags *find_open_flag(const char *mode_str)
 {
     int mode;
@@ -2229,3 +2262,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+/*
+ * Safely get device property. Returned strings are using wide characters.
+ * Caller is responsible for freeing the buffer.
+ */
+static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propName,
+    PDEVPROPTYPE propType)
+{
+    CONFIGRET cr;
+    g_autofree LPBYTE buffer = NULL;
+    ULONG buffer_len = 0;
+
+    /* First query for needed space */
+    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr != CR_SUCCESS && cr != CR_BUFFER_SMALL) {
+
+        slog("failed to get property size, error=0x%lx", cr);
+        return NULL;
+    }
+    buffer = g_new0(BYTE, buffer_len + 1);
+    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr != CR_SUCCESS) {
+        slog("failed to get device property, error=0x%lx", cr);
+        return NULL;
+    }
+    return g_steal_pointer(&buffer);
+}
+
+static GStrv ga_get_hardware_ids(DEVINST devInstance)
+{
+    GArray *values = NULL;
+    DEVPROPTYPE cm_type;
+    LPWSTR id;
+    g_autofree LPWSTR property = (LPWSTR)cm_get_property(devInstance,
+        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
+    if (property == NULL) {
+        slog("failed to get hardware IDs");
+        return NULL;
+    }
+    if (*property == '\0') {
+        /* empty list */
+        return NULL;
+    }
+    values = g_array_new(TRUE, TRUE, sizeof(gchar *));
+    for (id = property; '\0' != *id; id += lstrlenW(id) + 1) {
+        gchar *id8 = g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
+        g_array_append_val(values, id8);
+    }
+    return (GStrv)g_array_free(values, FALSE);
+}
+
+/*
+ * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/identifiers-for-pci-devices
+ */
+#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
+
+GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
+{
+    GuestDeviceInfoList *head = NULL, *cur_item = NULL, *item = NULL;
+    HDEVINFO dev_info = INVALID_HANDLE_VALUE;
+    SP_DEVINFO_DATA dev_info_data;
+    int i, j;
+    GError *gerr = NULL;
+    g_autoptr(GRegex) device_pci_re = NULL;
+    DEVPROPTYPE cm_type;
+
+    device_pci_re = g_regex_new(DEVICE_PCI_RE,
+        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
+        &gerr);
+    g_assert(device_pci_re != NULL);
+
+    dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
+    dev_info = SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLCLASSES);
+    if (dev_info == INVALID_HANDLE_VALUE) {
+        error_setg(errp, "failed to get device tree");
+        return NULL;
+    }
+
+    slog("enumerating devices");
+    for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
+        bool skip = true;
+        SYSTEMTIME utc_date;
+        g_autofree LPWSTR name = NULL;
+        g_autofree LPFILETIME date = NULL;
+        g_autofree LPWSTR version = NULL;
+        g_auto(GStrv) hw_ids = NULL;
+        g_autoptr(GuestDeviceInfo) device = g_new0(GuestDeviceInfo, 1);
+        g_autofree char *vendor_id = NULL;
+        g_autofree char *device_id = NULL;
+
+        name = (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_NAME, &cm_type);
+        if (name == NULL) {
+            slog("failed to get device description");
+            continue;
+        }
+        device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL, NULL);
+        if (device->driver_name == NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver name)");
+            continue;
+        }
+        slog("querying device: %s", device->driver_name);
+        hw_ids = ga_get_hardware_ids(dev_info_data.DevInst);
+        if (hw_ids == NULL) {
+            continue;
+        }
+        for (j = 0; hw_ids[j] != NULL; j++) {
+            GMatchInfo *match_info;
+            GuestDeviceAddressPCI *address;
+            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)) {
+                continue;
+            }
+            skip = false;
+
+            address = g_new0(GuestDeviceAddressPCI, 1);
+            vendor_id = g_match_info_fetch(match_info, 1);
+            device_id = g_match_info_fetch(match_info, 2);
+            address->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            address->device_id = g_ascii_strtoull(device_id, NULL, 16);
+
+            device->address = g_new0(GuestDeviceAddress, 1);
+            device->has_address = true;
+            device->address->type = GUEST_DEVICE_ADDRESS_KIND_PCI;
+            device->address->u.pci.data = address;
+
+            g_match_info_free(match_info);
+            break;
+        }
+        if (skip) {
+            continue;
+        }
+
+        version = (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
+        if (version == NULL) {
+            slog("failed to get driver version");
+            continue;
+        }
+        device->driver_version = g_utf16_to_utf8(version, -1, NULL,
+            NULL, NULL);
+        if (device->driver_version == NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver version)");
+            continue;
+        }
+        device->has_driver_version = true;
+
+        date = (LPFILETIME)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverDate, &cm_type);
+        if (date == NULL) {
+            slog("failed to get driver date");
+            continue;
+        }
+        FileTimeToSystemTime(date, &utc_date);
+        device->driver_date = g_strdup_printf("%04d-%02d-%02d",
+            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
+        device->has_driver_date = true;
+
+        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
+            device->driver_date, device->driver_version);
+        item = g_new0(GuestDeviceInfoList, 1);
+        item->value = g_steal_pointer(&device);
+        if (!cur_item) {
+            head = cur_item = item;
+        } else {
+            cur_item->next = item;
+            cur_item = item;
+        }
+        continue;
+    }
+
+    if (dev_info != INVALID_HANDLE_VALUE) {
+        SetupDiDestroyDeviceInfoList(dev_info);
+    }
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 4be9aad48e..a1ebe1e91b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1252,3 +1252,54 @@
 ##
 { 'command': 'guest-get-osinfo',
   'returns': 'GuestOSInfo' }
+
+##
+# @GuestDeviceAddressPCI:
+#
+# @vendor-id: vendor ID
+# @device-id: device ID
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestDeviceAddressPCI',
+  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
+
+##
+# @GuestDeviceAddress:
+#
+# Address of the device
+# - @pci: address of PCI device, since: 5.2
+#
+# Since: 5.2
+##
+{ 'union': 'GuestDeviceAddress',
+  'data': { 'pci': 'GuestDeviceAddressPCI' } }
+
+##
+# @GuestDeviceInfo:
+#
+# @driver-name: name of the associated driver
+# @driver-date: driver release date in format YYYY-MM-DD
+# @driver-version: driver version
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestDeviceInfo',
+  'data': {
+      'driver-name': 'str',
+      '*driver-date': 'str',
+      '*driver-version': 'str',
+      '*address': 'GuestDeviceAddress'
+  } }
+
+##
+# @guest-get-devices:
+#
+# Retrieve information about device drivers in Windows guest
+#
+# Returns: @GuestDeviceInfo
+#
+# Since: 5.2
+##
+{ 'command': 'guest-get-devices',
+  'returns': ['GuestDeviceInfo'] }
-- 
2.25.0


