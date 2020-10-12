Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CD7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DB82074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihGPjvx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DB82074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRtNY-0005q0-Ep
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kRtJX-00013K-8L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kRtJS-00006w-Jj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602491769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8tYXi3g5F74GoT0lgG+2tf3jMZcKVc3qwVYcue1dVg=;
 b=ihGPjvx8tILtbYN9ftSfnSCMl0YuEKpWJd/Q733eZWPkntpM+yGXP+NTmX48kILQ8St7j7
 PiQOrXdN8kzYuEmRUYb+zVzCxcbOVnMZb8dLDQqewjazeJTisHLDeskh9tGF/3xUBgW1ul
 zkzzXU6Vqp1HmavXcXpzFq/FowlVsXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-Pp-weeJtOxavyrKKAqBCXg-1; Mon, 12 Oct 2020 04:36:08 -0400
X-MC-Unique: Pp-weeJtOxavyrKKAqBCXg-1
Received: by mail-wm1-f70.google.com with SMTP id z7so970529wme.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 01:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E8tYXi3g5F74GoT0lgG+2tf3jMZcKVc3qwVYcue1dVg=;
 b=g064AIcHnzPBPh95FAEpsxGgxktJoZ5OI5KVZhpFg3iiUv99vytiiTngguC11A1Joe
 f7wJ7rXxXfCbaJZj2G/OjFwtemdhTdMVl7wnRXtUoRzfFi7WMsqGsbzQJCPQv1rc+8V2
 A4e0Ja3RzEhCqRKa2pIeIWAR+p1C/suSbk8m/1OH79WoUfSsMrxNadPsx152wwG4neBx
 ZZeNQk6R2DOD7ThsvRKXo1tHPl9IzJQlnCe1JIC8zNPtr3GIczMLMERBvmKyjaz96kDa
 IUvb2yN47rOSLJMyueyhEoNQZb4lkg41HOPftS39rJoqvs+5snV2qg1IFC3CyCskFlfP
 DArw==
X-Gm-Message-State: AOAM532fXFniG7fRH7fb/yqa6Y+L2zzOGFThOBYUllDiWs0vh3PiZXr0
 zi6/3I5JGt8O4mQgrggRl/bt16UtJZuaqdIS99nAolbqwgSJNl6L+ena2xxM4iLfH0kiU20j42/
 okvHQJTiVeT7djSA=
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr9607096wmk.134.1602491766551; 
 Mon, 12 Oct 2020 01:36:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfVO4NunZS+DWNwp+rJlJsR/n1u7biL1zYeOes+wnE8DCMRRk28dKm//gH3oiOi9LUIw1Itg==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr9607080wmk.134.1602491766389; 
 Mon, 12 Oct 2020 01:36:06 -0700 (PDT)
Received: from auriga.redhat.com (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id u2sm25040217wre.7.2020.10.12.01.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 01:36:05 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] qga: add command guest-get-disks
Date: Mon, 12 Oct 2020 10:36:01 +0200
Message-Id: <2e6124e94e56dc7c5e914e645998d435ad92de06.1602491752.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602491752.git.tgolembi@redhat.com>
References: <cover.1602491752.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add API and stubs for new guest-get-disks command.

The command guest-get-fsinfo can be used to list information about disks
and partitions but it is limited only to mounted disks with filesystem.
This new command should allow listing information about disks of the VM
regardles whether they are mounted or not. This can be usefull for
management applications for mapping virtualized devices or pass-through
devices to device names in the guest OS.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix.c |  6 ++++++
 qga/commands-win32.c |  6 ++++++
 qga/qapi-schema.json | 31 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3bffee99d4..422144bcff 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3051,3 +3051,9 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 
     return NULL;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f..0dd16315d7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2457,3 +2457,9 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     }
     return head;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index cec98c7e06..1ba8f19efc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -865,6 +865,37 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str'} }
 
+##
+# @GuestDiskInfo:
+#
+# @name: device node (Linux) or device UNC (Windows)
+# @partition: whether this is a partition or disk
+# @dependents: list of dependent devices; e.g. for LVs of the LVM this will
+#              hold the list of PVs, for LUKS encrypted volume this will
+#              contain the disk where the volume is placed.     (Linux)
+# @address: disk address information (only for non-virtual devices)
+# @alias: optional alias assigned to the disk, on Linux this is a name assigned
+#         by device mapper
+#
+# Since 5.2
+##
+{ 'struct': 'GuestDiskInfo',
+  'data': {'name': 'str', 'partition': 'bool', 'dependents': ['str'],
+           '*address': 'GuestDiskAddress', '*alias': 'str'} }
+
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
+  'returns': ['GuestDiskInfo'] }
+
 ##
 # @GuestFilesystemInfo:
 #
-- 
2.28.0


