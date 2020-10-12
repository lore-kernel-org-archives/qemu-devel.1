Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7ABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EE3208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlxDTjVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EE3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4bp-0002gQ-3j
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W7-0002cS-E0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W5-0002eV-L0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWVQ1khUuGiBpanaJLbZkSnEUewoTefNmh5Aj8Y3FUM=;
 b=IlxDTjVYDkLMECRtXukSbmzCCvFpN9p/CSota4OQXuD8E7tUuMMMtKTUpt+nY3zTILG0cR
 O1zqRyXX+1iIdllryrlPiJKFR7B6rXfxv72VgDf1KunmYzVOVBnmv2jKYuxqmHHee48UA0
 ZSzg+30VQy8Q0jQylWXpJ0LhY9XQs7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-lNXWYXPDPb-QOZBoJWKebA-1; Mon, 12 Oct 2020 16:33:55 -0400
X-MC-Unique: lNXWYXPDPb-QOZBoJWKebA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954CD185A0C1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40A3C2AA9C;
 Mon, 12 Oct 2020 20:33:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] io: Move the creation of the library to the main
 meson.build
Date: Mon, 12 Oct 2020 16:33:11 -0400
Message-Id: <20201012203343.1105018-7-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <20201006125602.2311423-7-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 io/meson.build | 10 ----------
 meson.build    | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/io/meson.build b/io/meson.build
index 768c1b5ec3..bcd8b1e737 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -1,4 +1,3 @@
-io_ss = ss.source_set()
 io_ss.add(genh)
 io_ss.add(files(
   'channel-buffer.c',
@@ -14,12 +13,3 @@ io_ss.add(files(
   'net-listener.c',
   'task.c',
 ))
-
-io_ss = io_ss.apply(config_host, strict: false)
-libio = static_library('io', io_ss.sources() + genh,
-                       dependencies: [io_ss.dependencies()],
-                       link_with: libqemuutil,
-                       name_suffix: 'fa',
-                       build_by_default: false)
-
-io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
diff --git a/meson.build b/meson.build
index dce48d8304..28f31e6022 100644
--- a/meson.build
+++ b/meson.build
@@ -1187,6 +1187,7 @@ block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
 chardev_ss = ss.source_set()
 common_ss = ss.source_set()
+io_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
 softmmu_ss = ss.source_set()
@@ -1451,6 +1452,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+io_ss = io_ss.apply(config_host, strict: false)
+libio = static_library('io', io_ss.sources() + genh,
+                       dependencies: [io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
+
 libmigration = static_library('migration', sources: migration_files + genh,
                               name_suffix: 'fa',
                               build_by_default: false)
-- 
2.26.2



