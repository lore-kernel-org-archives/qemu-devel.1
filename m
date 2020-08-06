Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEA2204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acZr2suN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEA2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3brV-0001m2-8R
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k3bp3-0007p1-RL
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k3bp1-0003lJ-Np
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596704662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGxLKgUNvUTwLjwqCcrfUUVls/sXJ3WF/pkHfkqfgsM=;
 b=acZr2suNGTYP/rk/qs5WYyqHH+T2YWyBCcSX2/fJY3cKCaFkT2WGURkH62gblDzkN0ZQNT
 Qe7QJ/Rhy/ZNxoLVYLl6l/X1JrpwzRfdIQ27IpP9d5JjFcR36Ke93TJ6gC0qP9rIH6wP00
 ljMro7QqEJgxaNv0lgDLbaWwT7FwuU8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-9wKG6BfWP76K6BCYkz8UDQ-1; Thu, 06 Aug 2020 05:03:11 -0400
X-MC-Unique: 9wKG6BfWP76K6BCYkz8UDQ-1
Received: by mail-ej1-f69.google.com with SMTP id bx27so13634543ejc.15
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGxLKgUNvUTwLjwqCcrfUUVls/sXJ3WF/pkHfkqfgsM=;
 b=HHrVp2rR0ZSMwK51xuFzA/Vvo7cAwBl+VuTLoi3KAYC+I8E/A2cotjw8PEDp/QMLo6
 hI3f4p9EFH2iqROlUozSW2+opeIl6QayzUk/IBS0FUYi3PWGHSj2c26hzbEAJs0KvHVW
 cxJCq4ct91wnE3k3coOX7wLrJHEluclMI3KoU/cmRsVE8ykI6zt7HEUjNVnYT/+DOWnT
 flXBJzzrZfnU5XaDcrHC1mcuZxQMFq8grg3r+rhOvzIvdUlpp8itzGJlAoW8LxFMPZDa
 kH8FVeYJp3ezlqfSTWNuFjnjn2lAnuqFM8qRNZApwo+gzBl1e0upZ3OMScPGaxGJFg2a
 6hfQ==
X-Gm-Message-State: AOAM533GiKc6vj8o59cXQsrKH4/qbyl1cQTW2xPiMaCTgtIWjtDQVubN
 m0Rerk7JmS0MipNGm/xnyTA14wft2yvSSRDKhJ5L4qPsSV04Igyve07J/9kg9Tjbtr0GkHnwzFH
 eQz8qsfr/bohKLSQ=
X-Received: by 2002:a17:906:d8b6:: with SMTP id
 qc22mr3503467ejb.468.1596704589556; 
 Thu, 06 Aug 2020 02:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiH88D69hml+secf0W5VwI2l/HmBzE1+34jp/oO8RRGhgm4IMfRoCEkd860S5kejp1O/IUxA==
X-Received: by 2002:a17:906:d8b6:: with SMTP id
 qc22mr3503444ejb.468.1596704589318; 
 Thu, 06 Aug 2020 02:03:09 -0700 (PDT)
Received: from auriga.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 g24sm3035681eds.42.2020.08.06.02.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 02:03:08 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/1] qga: add command guest-get-disks
Date: Thu,  6 Aug 2020 11:03:06 +0200
Message-Id: <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1596704579.git.tgolembi@redhat.com>
References: <cover.1596704579.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=tgolembi@redhat.com;
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command guest-get-fsinfo can be used to list information about disks and
partitions but it is limited only to mounted disks with filesystem. This new
command allows listing information about attached root disks of the VM. This is
usefull for management applications for mapping virtualized devices or
pass-through devices to device names in the guest OS.

Output is similar to the list of partitions of guest-get-fsinfo, except that
the disks are mapped instead of partitions.

Example output:

{
  "return": [
    {
      "serial": "SAMSUNG_123456789",
      "bus-type": "sata",
      "bus": 0,
      "unit": 0,
      "pci-controller": {
        "bus": 0,
        "slot": 31,
        "domain": 0,
        "function": 2
      },
      "dev": "/dev/sda",
      "target": 0
    },
    ...
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 13 +++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 744c2b5a5d..4cebec96a6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -62,6 +62,8 @@ extern char **environ;
 #endif
 #endif
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo, qapi_free_GuestFilesystemInfo)
+
 static void ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
@@ -1177,6 +1179,92 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     free(syspath);
 }
 
+GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskAddressList *item, *ret = NULL;
+    DIR *dp = NULL;
+    struct dirent *de = NULL;
+
+    g_debug("listing /sys/block directory");
+    dp = opendir("/sys/block");
+    if (dp == NULL) {
+        error_setg_errno(errp, errno, "Can't open directory \"/sys/block\"");
+        return NULL;
+    }
+    while ((de = readdir(dp)) != NULL) {
+        g_autofree char *disk_dir = NULL, *line = NULL,
+            *size_path = NULL, *slaves_dir = NULL;
+        g_autoptr(GuestFilesystemInfo) fs = NULL;
+        uint64_t slaves = 0;
+        struct dirent *de_slaves;
+        DIR *dp_slaves = NULL;
+        FILE *fp = NULL;
+        size_t n;
+        Error *local_err = NULL;
+        if (de->d_type != DT_LNK) {
+            g_debug("  skipping entry: %s", de->d_name);
+            continue;
+        }
+
+        slaves_dir = g_strdup_printf("/sys/block/%s/slaves", de->d_name);
+        if (slaves_dir == NULL) {
+            g_debug("  failed to open directory %s", slaves_dir);
+            continue;
+        }
+        g_debug("  counting entries in: %s", slaves_dir);
+        dp_slaves = opendir(slaves_dir);
+        while ((de_slaves = readdir(dp_slaves)) != NULL) {
+            if ((strcmp(".", de_slaves->d_name) == 0) ||
+                (strcmp("..", de_slaves->d_name) == 0)) {
+                continue;
+            }
+            slaves++;
+        }
+        closedir(dp_slaves);
+        g_debug("    counted %lu items", slaves);
+        if (slaves != 0) {
+            continue;
+        }
+
+        g_debug("  checking disk size");
+        size_path = g_strdup_printf("/sys/block/%s/size", de->d_name);
+        fp = fopen(size_path, "r");
+        if (!fp) {
+            g_debug("  failed to read disk size");
+            continue;
+        }
+        if (getline(&line, &n, fp) == -1) {
+            g_debug("  failed to read disk size");
+            fclose(fp);
+            continue;
+        }
+        fclose(fp);
+        if (strcmp(line, "0\n") == 0) {
+            g_debug("  skipping zero-sized disk");
+            continue;
+        }
+
+        fs = g_malloc0(sizeof(*fs));
+        g_debug("  adding %s", de->d_name);
+        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
+        build_guest_fsinfo_for_device(disk_dir, fs, &local_err);
+        if (local_err != NULL) {
+            g_debug("  failed to get device info, ignoring error: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            continue;
+        } else if (fs->disk == NULL) {
+            g_debug("  skipping unknown disk");
+            continue;
+        }
+        item = g_steal_pointer(&fs->disk);
+        g_assert(item->next == NULL); /* expecting just a single disk */
+        item->next = ret;
+        ret = item;
+    }
+    return ret;
+}
+
 /* Return a list of the disk device(s)' info which @mount lies on */
 static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
@@ -2809,7 +2897,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
+            "guest-fsfreeze-thaw", "guest-get-fsinfo",
+            "guest-get-disks", NULL};
         char **p = (char **)list;
 
         while (*p) {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index aaa71f147b..0bafa2dc4c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -945,6 +945,83 @@ out:
     return list;
 }
 
+GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskAddressList *new = NULL, *ret = NULL;
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
+        GuestDiskAddress *disk = NULL;
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
+                pdev_iface_detail_data = g_malloc(size);
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
+        g_debug("  number: %lu", sdn.DeviceNumber);
+        disk = g_malloc0(sizeof(GuestDiskAddress));
+        disk->has_dev = true;
+        disk->dev = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+            sdn.DeviceNumber);
+        get_single_disk_info(sdn.DeviceNumber, disk, &local_err);
+        if (local_err) {
+            g_debug("failed to get disk info: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            g_free(disk);
+            continue;
+        }
+        new = g_malloc0(sizeof(GuestDiskAddressList));
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
@@ -952,6 +1029,12 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     return NULL;
 }
 
+GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_QGA_NTDDSCSI */
 
 static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 408a662ea5..5d8fa1c283 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -862,6 +862,19 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str'} }
 
+##
+# @guest-get-disks:
+#
+# Returns: The list of disks in the guest. For Windows these are only the
+#          physical disks. On Linux these are all root block devices of
+#          non-zero size including e.g. removable devices, loop devices,
+#          NBD, etc.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-get-disks',
+  'returns': ['GuestDiskAddress'] }
+
 ##
 # @GuestFilesystemInfo:
 #
-- 
2.25.0


