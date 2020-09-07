Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B30C2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1AK9ail"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B30C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDGf-0004SQ-7j
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEh-00029x-8E
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEf-00029K-JT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iaVzSDtj2xbAOGzu8HgRwFZokiSOmmlRvyGqNZEfqc=;
 b=f1AK9ailv4wdYNPNKjRzyaoMgB6+0pMHeN2IVkzXTKK9rMJzwPW3NCotLL8J60rMixRZ1c
 lMD9MWQEFXhPxiIwHMaSG0UkTXx3yEXCqOqDaYrhalOW7BDEa7lA3ce4DhteTrVsumE6+4
 SM6qWtpCKtzksYMPyWKIR2aQWOw4QoE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-KrRulgA6N_Ow0ivwQE3YwA-1; Mon, 07 Sep 2020 05:14:46 -0400
X-MC-Unique: KrRulgA6N_Ow0ivwQE3YwA-1
Received: by mail-ej1-f72.google.com with SMTP id qn7so5403461ejb.15
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7iaVzSDtj2xbAOGzu8HgRwFZokiSOmmlRvyGqNZEfqc=;
 b=m86q7PatDGNnZd9Lg106ARcuAcCz8eFaVKAxM/g+t08UaQl17Yixmjp8Z8mJNpvg5p
 MTjx9XYFUnQamX9medpJ+QIwoQTfaxZkNTgPpi/c4g4sM88bYZRo7coSWc0lwC+tsjrA
 JOnld/VZyMi99UexzHWsoiSfBYmIxP2okFYX/mlpOBJtfemdEbQ0NLvfgYaPmlG8MAh5
 X7kcCfvpZO1Wqz44A6aDj8/uO2+RzPF1exOg2caRS6yfewqZN9FhvQe899a+zt7SPfuu
 67dMB/qtDmRaQcfJTokbTtA55LaumXQGHL6BmveLlrGoMGGTDNxi5Dej/oSnMJxtJ9fD
 cFHg==
X-Gm-Message-State: AOAM530RcG+AYo2idp1uekgrjm+y8JrnVHFXZa7yXF+aMBE3Q6d3EWap
 Z/SMB/ZpfTcapZ6K4kkwXFDX/3qxcdcHDSdnpCnpIFUSJPbxJksH09Wqivlo8hO29rpxr8GVhvh
 IwWs7Yf/bhWoIfmc=
X-Received: by 2002:a17:906:fb97:: with SMTP id
 lr23mr6005031ejb.257.1599470085126; 
 Mon, 07 Sep 2020 02:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Zp9W/F8N2Z7zj9RxiSnDWn1ywIjqD6re3HipxXVSvZZmt7EnfCJjvdeXOmExYKdzVJKyuA==
X-Received: by 2002:a17:906:fb97:: with SMTP id
 lr23mr6005018ejb.257.1599470084895; 
 Mon, 07 Sep 2020 02:14:44 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id d6sm14394910edm.31.2020.09.07.02.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:14:44 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] qga: add command guest-get-disks
Date: Mon,  7 Sep 2020 11:14:40 +0200
Message-Id: <d8573ee72572ba586c285472789243b37527e2b9.1599470071.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1599470071.git.tgolembi@redhat.com>
References: <cover.1599470071.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Add API and stubs for new guest-get-disks command.

The command guest-get-fsinfo can be used to list information about disks
and partitions but it is limited only to mounted disks with filesystem.
This new command should allow listing information about disks of the VM
regardles whether they are mounted or not. This can be usefull for
management applications for mapping virtualized devices or pass-through
devices to device names in the guest OS.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c |  6 ++++++
 qga/commands-win32.c |  6 ++++++
 qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 744c2b5a5d..f99731af51 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3042,3 +3042,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index aaa71f147b..e9976a0c46 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2229,3 +2229,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 408a662ea5..70b54e0d07 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -862,6 +862,35 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str'} }
 
+##
+# @GuestDiskInfo:
+#
+# @name: device node (Linux) or device UNC (Windows)
+# @partition: whether this is a partition or disk
+# @slaves: list of slave devices (Linux)
+# @address: disk address information (only for non-virtual devices)
+# @alias: optional alias assigned to the disk, on Linux this is a name assigned
+#         by device mapper
+#
+# Since 5.2
+##
+{ 'struct': 'GuestDiskInfo',
+  'data': {'name': 'str', 'partition': 'bool', 'slaves': ['str'],
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
2.25.0


