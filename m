Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C6AC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781802076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="0CbDo1ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781802076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8IK-00029Z-KE
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:28:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jU8Ck-0007A0-Rc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jU82d-0001xk-Rb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:16:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <basil@daynix.com>) id 1jU82d-0001rM-5V
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:11:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so1579886wmk.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=Ik47jTmigL0m9Na6qQAQ4RyVryDW75g+58Npmtu17e0=;
 b=0CbDo1ibcCwEiuiY9yvu/BMOEGG1iqTP55KD6AUHuD9CXffgBREQpi9MtKrwkuZngT
 4pKa0goRua3fjzI9Zx6uoI6Q76Svtxygb9wort5CVjpeX7lXbUTmAUeBuCsy+waJNSJT
 xZk3aoUkpTQj4S8qWvEMJ4ptePY2XtJrhvhQd/ITLIs8bjoOu2DKynQOrh7Yd2RA1vCJ
 WubnvkHMkY6TmCoBqOj+hQjHr+eL7kpwvNtmjTyjj6MrNWnFnJG42qt1ULrlyZuRSxSA
 zcce1hO8lj5A+6Kak/uwTR+hXJjTkIce2w55DF1xEN16/EaiZbOwI6/dCL9Mv77SQZt1
 zeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ik47jTmigL0m9Na6qQAQ4RyVryDW75g+58Npmtu17e0=;
 b=hEdiR2F7ZAVeNL3OCSleMZghXKTJ/3etgEqrSdw65QdNzaW2QbGI9Nvw5MkLLn5THG
 X0do2AFHzG0YO0CKMc3eEHZ7X8cPgrkTROyUATsu04zh7PjY1CkfTF0e/Fxv6+9HSFCK
 Bks5CGwneU72Ykzv5t7uIy7WdVLQcoQKv5Yokp+eNBB7AQ3eTLkLVnEBLAsauemkQOw8
 hdDQaAP3L/MWKnoIdOkMBk+QDNZ3zio6LeSVMxFnxoC6XhDwy+gnjsribnu+dtHSSlM6
 2TjLIL11Aee3G8yn2ISX04o3oSGz/wV3LPO7jV+KjEXkP3DU7BlAQH1VYevsY5JKrXhu
 t/jg==
X-Gm-Message-State: AGi0PuaC2gKRWQTElC6cIBxSwuc8/ZiPqp5gTVd7l1RiqEbO8nL3JDFo
 jik7n/K9+5L1tn9bRnVyhz4RIlYNu74=
X-Google-Smtp-Source: APiQypL2N0PbWn4X7KhTD90qXWt/O0qGNIhn5YRxRQyHNrkFXjfcXsvHnYrMazPO6FYEgVVyk8iehA==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr2842603wmj.137.1588248704510; 
 Thu, 30 Apr 2020 05:11:44 -0700 (PDT)
Received: from howl.redhat.com (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id 1sm12280006wmi.0.2020.04.30.05.11.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 05:11:43 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH 1/1] qga-win: fix "guest-get-fsinfo" wrong filesystem type
Date: Thu, 30 Apr 2020 15:11:40 +0300
Message-Id: <1588248700-2715-1-git-send-email-basil@daynix.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=basil@daynix.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <bsalman@redhat.com>

This patch handles the case where unmounted volumes exist,
where in that case GetVolumePathNamesForVolumeName returns
empty path, GetVolumeInformation will use the current working
directory instead.
This patch fixes the issue by opening a handle to the volumes,
and using GetVolumeInformationByHandleW instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1746667

Signed-off-by: Basil Salman <bsalman@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/commands-win32.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 82cf053..be07712 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1021,11 +1021,13 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
 {
     DWORD info_size;
     char mnt, *mnt_point;
+    wchar_t wfs_name[32];
     char fs_name[32];
-    char vol_info[MAX_PATH+1];
+    wchar_t vol_info[MAX_PATH + 1];
     size_t len;
     uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBytes;
     GuestFilesystemInfo *fs = NULL;
+    HANDLE hLocalDiskHandle = NULL;
 
     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0, &info_size);
     if (GetLastError() != ERROR_MORE_DATA) {
@@ -1040,18 +1042,27 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
         goto free;
     }
 
+    hLocalDiskHandle = CreateFile(guid, 0 , 0, NULL, OPEN_EXISTING,
+                                  FILE_ATTRIBUTE_NORMAL |
+                                  FILE_FLAG_BACKUP_SEMANTICS, NULL);
+    if (INVALID_HANDLE_VALUE == hLocalDiskHandle) {
+        error_setg_win32(errp, GetLastError(), "failed to get volume name");
+        goto free;
+    }
+
     len = strlen(mnt_point);
     mnt_point[len] = '\\';
     mnt_point[len+1] = 0;
-    if (!GetVolumeInformation(mnt_point, vol_info, sizeof(vol_info), NULL, NULL,
-                              NULL, (LPSTR)&fs_name, sizeof(fs_name))) {
+
+    if (!GetVolumeInformationByHandleW(hLocalDiskHandle, vol_info,
+                                       sizeof(vol_info), NULL, NULL, NULL,
+                                       (LPWSTR) & wfs_name, sizeof(wfs_name))) {
         if (GetLastError() != ERROR_NOT_READY) {
             error_setg_win32(errp, GetLastError(), "failed to get volume info");
         }
         goto free;
     }
 
-    fs_name[sizeof(fs_name) - 1] = 0;
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
     fs->has_total_bytes = false;
@@ -1070,9 +1081,11 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
             fs->has_used_bytes = true;
         }
     }
+    wcstombs(fs_name, wfs_name, sizeof(wfs_name));
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
 free:
+    CloseHandle(hLocalDiskHandle);
     g_free(mnt_point);
     return fs;
 }
-- 
1.8.3.1


