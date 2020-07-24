Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA8CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABEA2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKbzBrlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABEA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxir-0001bK-Sp
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhn-0008Ks-Pa
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhl-0000yo-AU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shCTgpNGYkADIGRbw6oJTP7PNTqIMQu6QRsgnTW+st4=;
 b=aKbzBrlqdiX+sEg1ZZl56bWlK9+S23k8rA7vIQb8VgnWJZxyDNCbgiWMPtFTZlgSnfmDhF
 N/LIK8zwhD9vYqY5uIcm99fs9AuYiy1jv7esQX3W8oeWxW7COf5fTCu+rTcGAZc9TrCn9O
 zBJwa/guhXm8xq2avZRV2BhTpS+5+/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-w8ZFVH4_Oq6TSRTqcgqB0Q-1; Fri, 24 Jul 2020 09:25:30 -0400
X-MC-Unique: w8ZFVH4_Oq6TSRTqcgqB0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8110380046D;
 Fri, 24 Jul 2020 13:25:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3997A101E1BF;
 Fri, 24 Jul 2020 13:25:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] util: rename qemu_open() to qemu_open_old()
Date: Fri, 24 Jul 2020 14:25:07 +0100
Message-Id: <20200724132510.3250311-2-berrange@redhat.com>
In-Reply-To: <20200724132510.3250311-1-berrange@redhat.com>
References: <20200724132510.3250311-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to introduce a new version of qemu_open() that uses an Error
object for reporting problems and make this it the preferred interface.
Rename the existing method to release the namespace for the new impl.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/kvm/kvm-all.c            |  2 +-
 backends/rng-random.c          |  2 +-
 backends/tpm/tpm_passthrough.c |  8 ++++----
 block/file-posix.c             | 14 +++++++-------
 block/file-win32.c             |  5 +++--
 block/vvfat.c                  |  5 +++--
 chardev/char-fd.c              |  2 +-
 chardev/char-pipe.c            |  6 +++---
 chardev/char.c                 |  2 +-
 dump/dump.c                    |  2 +-
 hw/s390x/s390-skeys.c          |  2 +-
 hw/usb/host-libusb.c           |  2 +-
 hw/vfio/common.c               |  4 ++--
 include/qemu/osdep.h           |  2 +-
 io/channel-file.c              |  2 +-
 net/vhost-vdpa.c               |  2 +-
 os-posix.c                     |  2 +-
 qga/channel-posix.c            |  4 ++--
 qga/commands-posix.c           |  6 +++---
 target/arm/kvm.c               |  2 +-
 ui/console.c                   |  2 +-
 util/osdep.c                   |  2 +-
 util/oslib-posix.c             |  2 +-
 23 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..ad8b315b35 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2013,7 +2013,7 @@ static int kvm_init(MachineState *ms)
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->vmfd = -1;
-    s->fd = qemu_open("/dev/kvm", O_RDWR);
+    s->fd = qemu_open_old("/dev/kvm", O_RDWR);
     if (s->fd == -1) {
         fprintf(stderr, "Could not access KVM kernel module: %m\n");
         ret = -errno;
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 32998d8ee7..245b12ab24 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -75,7 +75,7 @@ static void rng_random_opened(RngBackend *b, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "filename", "a valid filename");
     } else {
-        s->fd = qemu_open(s->filename, O_RDONLY | O_NONBLOCK);
+        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
         if (s->fd == -1) {
             error_setg_file_open(errp, errno, s->filename);
         }
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 7403807ec4..81e2d8f531 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -217,7 +217,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
     char path[PATH_MAX];
 
     if (tpm_pt->options->cancel_path) {
-        fd = qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
+        fd = qemu_open_old(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("tpm_passthrough: Could not open TPM cancel path: %s",
                          strerror(errno));
@@ -235,11 +235,11 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
     dev++;
     if (snprintf(path, sizeof(path), "/sys/class/tpm/%s/device/cancel",
                  dev) < sizeof(path)) {
-        fd = qemu_open(path, O_WRONLY);
+        fd = qemu_open_old(path, O_WRONLY);
         if (fd < 0) {
             if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/cancel",
                          dev) < sizeof(path)) {
-                fd = qemu_open(path, O_WRONLY);
+                fd = qemu_open_old(path, O_WRONLY);
             }
         }
     }
@@ -271,7 +271,7 @@ tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *opts)
     }
 
     tpm_pt->tpm_dev = value ? value : TPM_PASSTHROUGH_DEFAULT_DEVICE;
-    tpm_pt->tpm_fd = qemu_open(tpm_pt->tpm_dev, O_RDWR);
+    tpm_pt->tpm_fd = qemu_open_old(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
                      tpm_pt->tpm_dev, strerror(errno));
diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..bac2566f10 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -630,7 +630,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     raw_parse_flags(bdrv_flags, &s->open_flags, false);
 
     s->fd = -1;
-    fd = qemu_open(filename, s->open_flags, 0644);
+    fd = qemu_open_old(filename, s->open_flags, 0644);
     ret = fd < 0 ? -errno : 0;
 
     if (ret < 0) {
@@ -1032,13 +1032,13 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         }
     }
 
-    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
+    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open_old() */
     if (fd == -1) {
         const char *normalized_filename = bs->filename;
         ret = raw_normalize_devicepath(&normalized_filename, errp);
         if (ret >= 0) {
             assert(!(*open_flags & O_CREAT));
-            fd = qemu_open(normalized_filename, *open_flags);
+            fd = qemu_open_old(normalized_filename, *open_flags);
             if (fd == -1) {
                 error_setg_errno(errp, errno, "Could not reopen file");
                 return -1;
@@ -2411,7 +2411,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Create file */
-    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
+    fd = qemu_open_old(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
     if (fd < 0) {
         result = -errno;
         error_setg_errno(errp, -result, "Could not create file");
@@ -3335,7 +3335,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
     for (index = 0; index < num_of_test_partitions; index++) {
         snprintf(test_partition, sizeof(test_partition), "%ss%d", bsd_path,
                  index);
-        fd = qemu_open(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
+        fd = qemu_open_old(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
         if (fd >= 0) {
             partition_found = true;
             qemu_close(fd);
@@ -3653,7 +3653,7 @@ static int cdrom_probe_device(const char *filename)
     int prio = 0;
     struct stat st;
 
-    fd = qemu_open(filename, O_RDONLY | O_NONBLOCK);
+    fd = qemu_open_old(filename, O_RDONLY | O_NONBLOCK);
     if (fd < 0) {
         goto out;
     }
@@ -3787,7 +3787,7 @@ static int cdrom_reopen(BlockDriverState *bs)
      */
     if (s->fd >= 0)
         qemu_close(s->fd);
-    fd = qemu_open(bs->filename, s->open_flags, 0644);
+    fd = qemu_open_old(bs->filename, s->open_flags, 0644);
     if (fd < 0) {
         s->fd = -1;
         return -EIO;
diff --git a/block/file-win32.c b/block/file-win32.c
index ab69bd811a..8c1845830e 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -576,8 +576,9 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
         return -EINVAL;
     }
 
-    fd = qemu_open(file_opts->filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
-                   0644);
+    fd = qemu_open_old(file_opts->filename,
+                       O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+                       0644);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Could not create file");
         return -EIO;
diff --git a/block/vvfat.c b/block/vvfat.c
index 36b53c8757..5abb90e7c7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1352,7 +1352,8 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
     if(!s->current_mapping ||
             strcmp(s->current_mapping->path,mapping->path)) {
         /* open file */
-        int fd = qemu_open(mapping->path, O_RDONLY | O_BINARY | O_LARGEFILE);
+        int fd = qemu_open_old(mapping->path,
+                               O_RDONLY | O_BINARY | O_LARGEFILE);
         if(fd<0)
             return -1;
         vvfat_close_current_file(s);
@@ -2513,7 +2514,7 @@ static int commit_one_file(BDRVVVFATState* s,
     for (i = s->cluster_size; i < offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
-    fd = qemu_open(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
+    fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
     if (fd < 0) {
         fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path,
                 strerror(errno), errno);
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index c2d8101106..1cd62f2779 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -119,7 +119,7 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 {
     int fd = -1;
 
-    TFR(fd = qemu_open(src, flags, 0666));
+    TFR(fd = qemu_open_old(src, flags, 0666));
     if (fd == -1) {
         error_setg_file_open(errp, errno, src);
     }
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index fd12c9e63b..7eca5d9a56 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -132,8 +132,8 @@ static void qemu_chr_open_pipe(Chardev *chr,
 
     filename_in = g_strdup_printf("%s.in", filename);
     filename_out = g_strdup_printf("%s.out", filename);
-    TFR(fd_in = qemu_open(filename_in, O_RDWR | O_BINARY));
-    TFR(fd_out = qemu_open(filename_out, O_RDWR | O_BINARY));
+    TFR(fd_in = qemu_open_old(filename_in, O_RDWR | O_BINARY));
+    TFR(fd_out = qemu_open_old(filename_out, O_RDWR | O_BINARY));
     g_free(filename_in);
     g_free(filename_out);
     if (fd_in < 0 || fd_out < 0) {
@@ -143,7 +143,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
         if (fd_out >= 0) {
             close(fd_out);
         }
-        TFR(fd_in = fd_out = qemu_open(filename, O_RDWR | O_BINARY));
+        TFR(fd_in = fd_out = qemu_open_old(filename, O_RDWR | O_BINARY));
         if (fd_in < 0) {
             error_setg_file_open(errp, errno, filename);
             return;
diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..6b85099c03 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -235,7 +235,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
         } else {
             flags |= O_TRUNC;
         }
-        chr->logfd = qemu_open(common->logfile, flags, 0666);
+        chr->logfd = qemu_open_old(common->logfile, flags, 0666);
         if (chr->logfd < 0) {
             error_setg_errno(errp, errno,
                              "Unable to open logfile %s",
diff --git a/dump/dump.c b/dump/dump.c
index 383bc7876b..13fda440a4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1994,7 +1994,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
 #endif
 
     if  (strstart(file, "file:", &p)) {
-        fd = qemu_open(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
+        fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
         if (fd < 0) {
             error_setg_file_open(errp, errno, p);
             return;
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index db2f49cb27..5cc559fe4c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -125,7 +125,7 @@ void qmp_dump_skeys(const char *filename, Error **errp)
         return;
     }
 
-    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
     if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c474551d84..14dd4de684 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1111,7 +1111,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     if (s->hostdevice) {
         int fd;
         s->needs_autoscan = false;
-        fd = qemu_open(s->hostdevice, O_RDWR);
+        fd = qemu_open_old(s->hostdevice, O_RDWR);
         if (fd < 0) {
             error_setg_errno(errp, errno, "failed to open %s", s->hostdevice);
             return;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 33357140b8..13471ae294 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1254,7 +1254,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
     }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR);
+    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
         ret = -errno;
@@ -1479,7 +1479,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR);
+    group->fd = qemu_open_old(path, O_RDWR);
     if (group->fd < 0) {
         error_setg_errno(errp, errno, "failed to open %s", path);
         goto free_group_exit;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 45c217aa28..3a16e58932 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -494,7 +494,7 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
-int qemu_open(const char *name, int flags, ...);
+int qemu_open_old(const char *name, int flags, ...);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
diff --git a/io/channel-file.c b/io/channel-file.c
index dac21f6012..2ed3b75e8b 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -51,7 +51,7 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    ioc->fd = qemu_open(path, flags, mode);
+    ioc->fd = qemu_open_old(path, flags, mode);
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
         error_setg_errno(errp, errno,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35..e2b3ba85bf 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -184,7 +184,7 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
     nc->queue_index = 0;
     s = DO_UPCAST(VhostVDPAState, nc, nc);
-    vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
+    vdpa_device_fd = qemu_open_old(vhostdev, O_RDWR);
     if (vdpa_device_fd == -1) {
         return -errno;
     }
diff --git a/os-posix.c b/os-posix.c
index 3572db3f44..1b927c7c04 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -297,7 +297,7 @@ void os_setup_post(void)
             error_report("not able to chdir to /: %s", strerror(errno));
             exit(1);
         }
-        TFR(fd = qemu_open("/dev/null", O_RDWR));
+        TFR(fd = qemu_open_old("/dev/null", O_RDWR));
         if (fd == -1) {
             exit(1);
         }
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 8fc205ad21..0373975360 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -127,7 +127,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
     switch (c->method) {
     case GA_CHANNEL_VIRTIO_SERIAL: {
         assert(fd < 0);
-        fd = qemu_open(path, O_RDWR | O_NONBLOCK
+        fd = qemu_open_old(path, O_RDWR | O_NONBLOCK
 #ifndef CONFIG_SOLARIS
                            | O_ASYNC
 #endif
@@ -157,7 +157,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
         struct termios tio;
 
         assert(fd < 0);
-        fd = qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
+        fd = qemu_open_old(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
         if (fd == -1) {
             g_critical("error opening channel: %s", strerror(errno));
             return false;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a62a3a70d..ffe0d24bf3 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1304,7 +1304,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
             }
         }
 
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             error_setg_errno(errp, errno, "failed to open %s", mount->dirname);
             goto error;
@@ -1371,7 +1371,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     QTAILQ_FOREACH(mount, &mounts, next) {
         logged = false;
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             continue;
         }
@@ -1461,7 +1461,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
         list->next = response->paths;
         response->paths = list;
 
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             result->error = g_strdup_printf("failed to open: %s",
                                             strerror(errno));
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..f944bfa0dc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -71,7 +71,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
 
-    kvmfd = qemu_open("/dev/kvm", O_RDWR);
+    kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
         goto err;
     }
diff --git a/ui/console.c b/ui/console.c
index 0579be792f..02eca16bd7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -372,7 +372,7 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         return;
     }
 
-    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
+    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
     if (fd == -1) {
         error_setg(errp, "failed to open file '%s': %s", filename,
                    strerror(errno));
diff --git a/util/osdep.c b/util/osdep.c
index 4829c07ff6..9df1b6adec 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -282,7 +282,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 /*
  * Opens a file with FD_CLOEXEC set
  */
-int qemu_open(const char *name, int flags, ...)
+int qemu_open_old(const char *name, int flags, ...)
 {
     int ret;
     int mode = 0;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index d923674624..4706c2f744 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -125,7 +125,7 @@ bool qemu_write_pidfile(const char *path, Error **errp)
             .l_len = 0,
         };
 
-        fd = qemu_open(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+        fd = qemu_open_old(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
         if (fd == -1) {
             error_setg_errno(errp, errno, "Cannot open pid file");
             return false;
-- 
2.26.2


