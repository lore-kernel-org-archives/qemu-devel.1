Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE2C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA582083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7mHX9zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA582083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4Cs-0004us-6N
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49p-0001gd-Oz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49o-0004Cw-1s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602056799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjjEh+woMUxHN2siBGMKZQinYcLvK1nXWwJmuRrQJbo=;
 b=T7mHX9zJ5W31NmPHMGeqjTjqw2jZ31O0NXK/cGPS8Y7LYsFmngrqcP8pTd2zXAtRscI3Oh
 Jn6hkt7FiO3HXj+cU5NblD5eaAz8jR6eMYXdbzMUTwdTkZTSq3TYh6/BCIFYVm3XKC4BV2
 PV0hgJ66phS0hEFO0L9+s5IlM/oNPZk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-8OR3I23ANSyoGz11r3pvCA-1; Wed, 07 Oct 2020 03:46:37 -0400
X-MC-Unique: 8OR3I23ANSyoGz11r3pvCA-1
Received: by mail-wm1-f71.google.com with SMTP id i9so226006wml.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZjjEh+woMUxHN2siBGMKZQinYcLvK1nXWwJmuRrQJbo=;
 b=our+hx69exisFeFR4a9/HLOCEAR2BeATSIu8rzs702iI/SVz3TWMWxvEDHJ0Alwe+M
 gEOr+MOSnppK0RktKHO7LDqGJzo/M4ZAduhAeYGbUSJcsdw3odmcRuieU9iy99BTxZSh
 0rR5kETrenaddR6FWEWL8qweosWuQAC/2MAP+92SHuv6s9SUNUykqSo2evDTuNEOzOv/
 0S1M3AEJ66kN3UAJPmqICLtfsaXoQbEuqPYfUNIGe2JTTYWYwYr25kf4CHiN4ErOTRQA
 SkaoiinFZ+IvCWdybrCsNvNZ3bGlMRznSx4UacgFCAyo2EMBCuJclWalAGk0ZN7lKB5N
 gybQ==
X-Gm-Message-State: AOAM530hU2SjDFheQ5jLM9aC4HXf/A/ZYunQmhqRmzgBsKkaoSABU9Pn
 2Stw4PA+B88ALutzOG4bjdmTTkyXP4zR0SRL+5YWgEnWIfozJcqSvUEZ+Z4lD2z3uaW2h+QaUNU
 NVvFSWi9AefYepHs=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr1788987wmi.120.1602056796467; 
 Wed, 07 Oct 2020 00:46:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVQgVMD/ig49zpG9iWjWgHl7+y6RBs63EiavkNMjo1AC6/0a5p7imM9WFQDjPQkXqU3/eLJw==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr1788967wmi.120.1602056796237; 
 Wed, 07 Oct 2020 00:46:36 -0700 (PDT)
Received: from auriga.redhat.com (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id o14sm1505615wmc.36.2020.10.07.00.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 00:46:35 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] qga: add implementation of guest-get-disks for Windows
Date: Wed,  7 Oct 2020 09:46:31 +0200
Message-Id: <811a746b9a55adc0293ad80989dc9939e2490c1c.1602056784.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602056784.git.tgolembi@redhat.com>
References: <cover.1602056784.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command lists all the physical disk drives. Unlike for Linux
partitions and virtual volumes are not listed.

Example output:

{
  "return": [
    {
      "name": "\\\\.\\PhysicalDrive0",
      "partition": false,
      "address": {
        "serial": "QM00001",
        "bus-type": "sata",
        ...
      },
      "dependents": []
    }
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 98 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0dd16315d7..7fe5676785 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -979,6 +979,92 @@ out:
     return list;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *new = NULL, *ret = NULL;
+    HDEVINFO dev_info;
+    SP_DEVICE_INTERFACE_DATA dev_iface_data;
+    int i;
+
+    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
+        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
+    if (dev_info == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to get device tree");
+        return NULL;
+    }
+
+    g_debug("enumerating devices");
+    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
+    for (i = 0;
+        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE_DISK,
+            i, &dev_iface_data);
+        i++) {
+        GuestDiskAddress *address = NULL;
+        GuestDiskInfo *disk = NULL;
+        Error *local_err = NULL;
+        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
+            pdev_iface_detail_data = NULL;
+        STORAGE_DEVICE_NUMBER sdn;
+        HANDLE dev_file;
+        DWORD size = 0;
+
+        g_debug("  getting device path");
+        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_data,
+                pdev_iface_detail_data,
+                size, &size,
+                NULL)) {
+            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
+                pdev_iface_detail_data = g_realloc(pdev_iface_detail_data,
+                    size);
+                pdev_iface_detail_data->cbSize =
+                    sizeof(*pdev_iface_detail_data);
+            } else {
+                g_debug("failed to get device interface details");
+                continue;
+            }
+        }
+
+        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
+        dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
+            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
+        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
+                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
+            CloseHandle(dev_file);
+            debug_error("failed to get storage device number");
+            continue;
+        }
+        CloseHandle(dev_file);
+
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+            sdn.DeviceNumber);
+
+        g_debug("  number: %lu", sdn.DeviceNumber);
+        address = g_malloc0(sizeof(GuestDiskAddress));
+        address->has_dev = true;
+        address->dev = g_strdup(disk->name);
+        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
+        if (local_err) {
+            g_debug("failed to get disk info: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            qapi_free_GuestDiskAddress(address);
+            address = NULL;
+        } else {
+            disk->address = address;
+            disk->has_address = true;
+        }
+
+        new = g_malloc0(sizeof(GuestDiskInfoList));
+        new->value = disk;
+        new->next = ret;
+        ret = new;
+    }
+
+    SetupDiDestroyDeviceInfoList(dev_info);
+    return ret;
+}
+
 #else
 
 static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
@@ -986,6 +1072,12 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     return NULL;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_QGA_NTDDSCSI */
 
 static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
@@ -2457,9 +2549,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     }
     return head;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.28.0


