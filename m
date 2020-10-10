Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0392C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24F3207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K23yNxYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24F3207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9pP-0000lI-SW
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lE-0003ut-7j
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lB-0006fF-5r
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCCnsWNbL+KCVorOLSUvOky8MZiWqJDfjxk/Gaew6NQ=;
 b=K23yNxYR0SzFPu8Z1WFeMSgnWsqs5FT/ZfemEp6+9iZDn6lKr2+No/RZ6i6rJ6wQ/giJaH
 Pwk4kNdbqEiUEbnw3lkZRVdVP/ox3QOsR8X7qJIIw2l24eHxgp6iMUydF8O8DtHXLt7DaD
 EEqhlg0KzxrCbLgFHEZjziL5EqZUE/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-g14P4bwLP76q6h3CDUSmxw-1; Sat, 10 Oct 2020 03:57:42 -0400
X-MC-Unique: g14P4bwLP76q6h3CDUSmxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2B60107B471
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FAE35576E;
 Sat, 10 Oct 2020 07:57:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/39] migration: Move the creation of the library to the main
 meson.build
Date: Sat, 10 Oct 2020 03:57:05 -0400
Message-Id: <20201010075739.951385-6-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
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
Message-Id: <20201006125602.2311423-6-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           | 7 +++++++
 migration/meson.build | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 39fc074977..dce48d8304 100644
--- a/meson.build
+++ b/meson.build
@@ -1451,6 +1451,13 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+libmigration = static_library('migration', sources: migration_files + genh,
+                              name_suffix: 'fa',
+                              build_by_default: false)
+migration = declare_dependency(link_with: libmigration,
+                               dependencies: [zlib, qom, io])
+softmmu_ss.add(migration)
+
 block_ss = block_ss.apply(config_host, strict: false)
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
diff --git a/migration/meson.build b/migration/meson.build
index b5b71c8060..980e37865c 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -8,13 +8,7 @@ migration_files = files(
   'qemu-file.c',
   'qjson.c',
 )
-
-libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
-                              build_by_default: false)
-migration = declare_dependency(link_with: libmigration,
-                               dependencies: [zlib, qom, io])
-softmmu_ss.add(migration)
+softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.26.2



