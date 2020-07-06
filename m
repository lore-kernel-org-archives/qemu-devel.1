Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9462070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6I8PZSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9462070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUqq-00064H-64
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jsUS4-0005BB-ER
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:58:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jsUS2-0005lx-CW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594054721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d+awHNnQN0cvhBVX9Omo27saMLgfwp2Qps5HODapz7U=;
 b=h6I8PZSVMPAt7YLy1ARh3aGp6wHTuBJJe9btzVP6huSNov01zigPU+6TTaKOYPmml2gfc+
 JDC/U4jgHZgkxAyTEgwaQMbvjuQZp8fy2d4p/6sm8LTwv6JXXLtSyN/ejDCbBfYRcsbqV9
 zOuEaaK9RrBzuZN7fB4EraP4K/XaJLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-wR1DPRPDMzq8GoyQt3P06w-1; Mon, 06 Jul 2020 12:58:36 -0400
X-MC-Unique: wR1DPRPDMzq8GoyQt3P06w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30852461;
 Mon,  6 Jul 2020 16:58:35 +0000 (UTC)
Received: from localhost (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9707B603;
 Mon,  6 Jul 2020 16:58:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] RFC: qemu-ga: skip loop mount fs to avoid qemu-ga hang
Date: Mon,  6 Jul 2020 20:58:28 +0400
Message-Id: <20200706165828.273523-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the underlying filesystem is already frozen, ioctl(FIFREEZE) might hang.

guest-fsfreeze is done in reverse order of /proc/self/mountinfo list,
but it seems insufficient to prevent that situation.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1782626

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cdbeb59dccd..c4dce400302 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -623,6 +623,7 @@ typedef struct FsMount {
     char *dirname;
     char *devtype;
     unsigned int devmajor, devminor;
+    bool is_loop;
     QTAILQ_ENTRY(FsMount) next;
 } FsMount;
 
@@ -668,6 +669,11 @@ static int dev_major_minor(const char *devpath,
     return -1;
 }
 
+static bool
+fsname_is_loop_device(const char *fsname)
+{
+    return g_str_has_prefix(fsname, "/dev/loop");
+}
 /*
  * Walk the mount table and build a list of local file systems
  */
@@ -707,6 +713,7 @@ static void build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
         mount->devtype = g_strdup(ment->mnt_type);
         mount->devmajor = devmajor;
         mount->devminor = devminor;
+        mount->is_loop = fsname_is_loop_device(ment->mnt_fsname);
 
         QTAILQ_INSERT_TAIL(mounts, mount, next);
     }
@@ -786,6 +793,7 @@ static void build_fs_mount_list(FsMountList *mounts, Error **errp)
         mount->devtype = g_strdup(dash + type_s);
         mount->devmajor = devmajor;
         mount->devminor = devminor;
+        mount->is_loop = fsname_is_loop_device(dash + dev_s);
 
         QTAILQ_INSERT_TAIL(mounts, mount, next);
     }
@@ -1304,6 +1312,10 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
             }
         }
 
+        if (mount->is_loop) {
+            continue;
+        }
+
         fd = qemu_open(mount->dirname, O_RDONLY);
         if (fd == -1) {
             error_setg_errno(errp, errno, "failed to open %s", mount->dirname);
-- 
2.27.0.90.geebb51ba8c


