Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E9C4363D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC0120BED
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acJxCMyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC0120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4bx-0002sT-L8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W4-0002Xe-Sd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W2-0002dm-GE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSyw73szb3g8uurmtJul54UDRlIS1kAbBlyTUq/1f6M=;
 b=acJxCMyS+Cl2zR5bM43sosRmNZoKH8SyF/PTqMe+8EVzmS9euH8VGMTx1d6FGwm9LcQbLO
 mqGNCkNlwDteQ/Oe7PBhch/e9XJ3x8Qio4BzVS50iZiwb833lmyTRnRPodITIwDD+TDQdS
 v6zVSG2+lirLb5Vm8OEvYPMJOrqfShs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-POh-pzvVN-GoKyrA9ZFKqQ-1; Mon, 12 Oct 2020 16:33:52 -0400
X-MC-Unique: POh-pzvVN-GoKyrA9ZFKqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B47B1084CB7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46B6B1A8EC;
 Mon, 12 Oct 2020 20:33:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/38] chardev: Move the creation of the library to the main
 meson.build
Date: Mon, 12 Oct 2020 16:33:09 -0400
Message-Id: <20201012203343.1105018-5-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Be consistent creating all the libraries in the main meson.build file.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201006125602.2311423-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/meson.build | 6 ------
 meson.build         | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/chardev/meson.build b/chardev/meson.build
index 54e88d0310..dd2699a11b 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -1,4 +1,3 @@
-chardev_ss = ss.source_set()
 chardev_ss.add(files(
   'char-fe.c',
   'char-file.c',
@@ -25,11 +24,6 @@ chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
 ))
 
 chardev_ss = chardev_ss.apply(config_host, strict: false)
-libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
-                            build_by_default: false)
-
-chardev = declare_dependency(link_whole: libchardev)
 
 softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
 softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
diff --git a/meson.build b/meson.build
index 6c760b4163..39fc074977 100644
--- a/meson.build
+++ b/meson.build
@@ -1185,6 +1185,7 @@ sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
 blockdev_ss = ss.source_set()
 block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
+chardev_ss = ss.source_set()
 common_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
@@ -1469,6 +1470,12 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+libchardev = static_library('chardev', chardev_ss.sources() + genh,
+                            name_suffix: 'fa',
+                            build_by_default: false)
+
+chardev = declare_dependency(link_whole: libchardev)
+
 libhwcore = static_library('hwcore', sources: hwcore_files + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
-- 
2.26.2



