Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C86C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB972083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyQhokcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB972083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4B7-00032c-LO
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49p-0001gT-9A
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49n-0004Cj-4R
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602056798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sR5mn4bQJJE0Ne9QOQvXAtaQXB/HYzeQrERET50OrMo=;
 b=KyQhokcpT6NHiGsSR0kWeyWn1Xz3CgppWbLz8gtMtb2A3Y8TgUfir9yP8LInzqVKWKiwql
 RToShAPMDnTw/z48kcelgcMEhPaau5qwvFbdH78lhlffDSGnG26An39ZeWkusHhL/1oYmk
 11trWtHDIAe0X5SCaf/XTe8VfSvCsP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-90WvdGpmP3-qe9udmQR8KQ-1; Wed, 07 Oct 2020 03:46:37 -0400
X-MC-Unique: 90WvdGpmP3-qe9udmQR8KQ-1
Received: by mail-wr1-f70.google.com with SMTP id 33so613285wrf.22
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sR5mn4bQJJE0Ne9QOQvXAtaQXB/HYzeQrERET50OrMo=;
 b=Sz6b6xgEDTz0lVHwXzznIY1PSQwnTZGyuLDGYe0lfeIm+J6bCLBnVNtO1+ZuukudiB
 CBSI5oCG4KhL8QGMr9naJR5WiRsFsQHov+Th1Phjd5LqFmCWXugCWdaQnohiVQyVTnzv
 6w3nDt66vbvHSHvzGwWqFHyedEwQTMKF48TM3WKf53yGdTC8+TGw2oGO40inFvBZ7AjA
 s1UBF+eQzymI+DDIcE4y+6E0T06fLa8Xi2D4IWqGBjoQqVvkRulCsOgtdrnSvBZI9Xyt
 yQtZFoAJfxGjaKZFFP9v2mybhZGwQ0ua5S1Jk26dgayFUsCkjPk4Peal14rVmpdPWRmW
 pzCQ==
X-Gm-Message-State: AOAM530L/AMtcPYy8BG7wDVbXdPX3ZLBjzN2pNqblLDCaTWjHNdvI/KA
 GrFy6NX42L+TJhq069UWRQZdLd9Cd2JQZJd2jDnaw+gyjuTpMoQHzEhnHu03HrFHa74XYNrrEjC
 RNvJ1sOEvmnv0uH0=
X-Received: by 2002:a1c:9987:: with SMTP id b129mr1617659wme.16.1602056795622; 
 Wed, 07 Oct 2020 00:46:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiN5hZ+8WWAJeaxHfQn+/U7updlBgkLSSkJzEeW6Wp0ZZJD2s4KCyYvK+1k4L3BHhppIiRgQ==
X-Received: by 2002:a1c:9987:: with SMTP id b129mr1617634wme.16.1602056795306; 
 Wed, 07 Oct 2020 00:46:35 -0700 (PDT)
Received: from auriga.redhat.com (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id o14sm1505615wmc.36.2020.10.07.00.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 00:46:34 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] qga: add implementation of guest-get-disks for Linux
Date: Wed,  7 Oct 2020 09:46:30 +0200
Message-Id: <2d80f5dc64cadd1ba87af9d8ec7a8161bd8a5e74.1602056784.git.tgolembi@redhat.com>
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

The command lists all disks (real and virtual) as well as disk
partitions. For each disk the list of dependent disks is also listed and
/dev path is used as a handle so it can be matched with "name" field of
other returned disk entries. For disk partitions the "dependents" list
is populated with the the parent device for easier tracking of
hierarchy.

Example output:
{
  "return": [
    ...
    {
      "name": "/dev/dm-0",
      "partition": false,
      "dependents": [
        "/dev/sda2"
      ],
      "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
    },
    {
      "name": "/dev/sda2",
      "partition": true,
      "dependents": [
        "/dev/sda"
      ]
    },
    {
      "name": "/dev/sda",
      "partition": false,
      "address": {
        "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
        "bus-type": "sata",
        ...
        "dev": "/dev/sda",
        "target": 0
      },
      "dependents": []
    },
    ...
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c | 293 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 284 insertions(+), 9 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 422144bcff..b0ec1223c9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1150,12 +1150,25 @@ static void build_guest_fsinfo_for_virtual_device(char const *syspath,
     closedir(dir);
 }
 
+static bool is_disk_virtual(const char *devpath, Error **errp)
+{
+    g_autofree char *syspath = realpath(devpath, NULL);
+
+    if (!syspath) {
+        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
+        return false;
+    }
+    return strstr(syspath, "/devices/virtual/block/") != NULL;
+}
+
 /* Dispatch to functions for virtual/real device */
 static void build_guest_fsinfo_for_device(char const *devpath,
                                           GuestFilesystemInfo *fs,
                                           Error **errp)
 {
+    ERRP_GUARD();
     char *syspath = realpath(devpath, NULL);
+    bool is_virtual = false;
 
     if (!syspath) {
         error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
@@ -1167,8 +1180,11 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     }
 
     g_debug("  parse sysfs path '%s'", syspath);
-
-    if (strstr(syspath, "/devices/virtual/block/")) {
+    is_virtual = is_disk_virtual(syspath, errp);
+    if (*errp != NULL) {
+        return;
+    }
+    if (is_virtual) {
         build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
     } else {
         build_guest_fsinfo_for_real_device(syspath, fs, errp);
@@ -1177,6 +1193,270 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     free(syspath);
 }
 
+#ifdef CONFIG_LIBUDEV
+
+/*
+ * Wrapper around build_guest_fsinfo_for_device() for getting just
+ * the disk address.
+ */
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **errp)
+{
+    g_autoptr(GuestFilesystemInfo) fs = NULL;
+
+    fs = g_new0(GuestFilesystemInfo, 1);
+    build_guest_fsinfo_for_device(syspath, fs, errp);
+    if (fs->disk != NULL) {
+        return g_steal_pointer(&fs->disk->value);
+    }
+    return NULL;
+}
+
+static char *get_alias_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        const char *alias = udev_device_get_property_value(
+            udevice, "DM_NAME");
+        /*
+         * NULL means there was an error and empty string means there is no
+         * alias. In case of no alias we return NULL instead of empty string.
+         */
+        if (alias == NULL) {
+            g_debug("failed to query udev for device alias for: %s",
+                syspath);
+        } else if (*alias != 0) {
+            ret = g_strdup(alias);
+        }
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static char *get_device_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        ret = g_strdup(udev_device_get_devnode(udevice));
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
+{
+    g_autofree char *deps_dir = NULL;
+    const gchar *dep;
+    GDir *dp_deps = NULL;
+
+    /* List dependent disks */
+    deps_dir = g_strdup_printf("%s/slaves", disk_dir);
+    g_debug("  listing entries in: %s", deps_dir);
+    dp_deps = g_dir_open(deps_dir, 0, NULL);
+    if (dp_deps == NULL) {
+        g_debug("failed to list entries in %s", deps_dir);
+        return;
+    }
+    while ((dep = g_dir_read_name(dp_deps)) != NULL) {
+        g_autofree char *dep_dir = NULL;
+        strList *dep_item = NULL;
+        char *dev_name;
+
+        /* Add dependent disks */
+        dep_dir = g_strdup_printf("%s/%s", deps_dir, dep);
+        dev_name = get_device_for_syspath(dep_dir);
+        if (dev_name != NULL) {
+            g_debug("  adding dependent device: %s", dev_name);
+            dep_item = g_new0(strList, 1);
+            dep_item->value = dev_name;
+            dep_item->next = disk->dependents;
+            disk->dependents = dep_item;
+        }
+    }
+    g_dir_close(dp_deps);
+}
+
+/*
+ * Detect partitions subdirectory, name is "<disk_name><number>" or
+ * "<disk_name>p<number>"
+ *
+ * @disk_name -- last component of /sys path (e.g. sda)
+ * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
+ * @disk_dev -- device node of the disk (e.g. /dev/sda)
+ */
+static GuestDiskInfoList *get_disk_partitions(
+    GuestDiskInfoList *list,
+    const char *disk_name, const char *disk_dir,
+    const char *disk_dev)
+{
+    GuestDiskInfoList *item, *ret = list;
+    struct dirent *de_disk;
+    DIR *dp_disk = NULL;
+    size_t len = strlen(disk_name);
+
+    dp_disk = opendir(disk_dir);
+    while ((de_disk = readdir(dp_disk)) != NULL) {
+        g_autofree char *partition_dir = NULL;
+        char *dev_name;
+        GuestDiskInfo *partition;
+
+        if (!(de_disk->d_type & DT_DIR)) {
+            continue;
+        }
+
+        if (!(strncmp(disk_name, de_disk->d_name, len) == 0 &&
+            ((*(de_disk->d_name + len) == 'p' &&
+            isdigit(*(de_disk->d_name + len + 1))) ||
+                isdigit(*(de_disk->d_name + len))))) {
+            continue;
+        }
+
+        partition_dir = g_strdup_printf("%s/%s",
+            disk_dir, de_disk->d_name);
+        dev_name = get_device_for_syspath(partition_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        partition = g_new0(GuestDiskInfo, 1);
+        partition->name = dev_name;
+        partition->partition = true;
+        /* Add parent disk as dependent for easier tracking of hierarchy */
+        partition->dependents = g_new0(strList, 1);
+        partition->dependents->value = g_strdup(disk_dev);
+
+        item = g_new0(GuestDiskInfoList, 1);
+        item->value = partition;
+        item->next = ret;
+        ret = item;
+
+    }
+    closedir(dp_disk);
+
+    return ret;
+}
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *item, *ret = NULL;
+    GuestDiskInfo *disk;
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
+            *size_path = NULL, *deps_dir = NULL;
+        char *dev_name;
+        Error *local_err = NULL;
+        if (de->d_type != DT_LNK) {
+            g_debug("  skipping entry: %s", de->d_name);
+            continue;
+        }
+
+        /* Check size and skip zero-sized disks */
+        g_debug("  checking disk size");
+        size_path = g_strdup_printf("/sys/block/%s/size", de->d_name);
+        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
+            g_debug("  failed to read disk size");
+            continue;
+        }
+        if (g_strcmp0(line, "0\n") == 0) {
+            g_debug("  skipping zero-sized disk");
+            continue;
+        }
+
+        g_debug("  adding %s", de->d_name);
+        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
+        dev_name = get_device_for_syspath(disk_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = dev_name;
+        disk->partition = false;
+        disk->alias = get_alias_for_syspath(disk_dir);
+        disk->has_alias = (disk->alias != NULL);
+        item = g_new0(GuestDiskInfoList, 1);
+        item->value = disk;
+        item->next = ret;
+        ret = item;
+
+        /* Get address for non-virtual devices */
+        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
+        if (local_err != NULL) {
+            g_debug("  failed to check disk path, ignoring error: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+            /* Don't try to get the address */
+            is_virtual = true;
+        }
+        if (!is_virtual) {
+            disk->address = get_disk_address(disk_dir, &local_err);
+            if (local_err != NULL) {
+                g_debug("  failed to get device info, ignoring error: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+                local_err = NULL;
+            } else if (disk->address != NULL) {
+                disk->has_address = true;
+            }
+        }
+
+        get_disk_deps(disk_dir, disk);
+        ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
+    }
+    return ret;
+}
+
+#else
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
+#endif
+
 /* Return a list of the disk device(s)' info which @mount lies on */
 static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
@@ -2809,7 +3089,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
+            "guest-fsfreeze-thaw", "guest-get-fsinfo",
+            "guest-get-disks", NULL};
         char **p = (char **)list;
 
         while (*p) {
@@ -3051,9 +3332,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 
     return NULL;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.28.0


