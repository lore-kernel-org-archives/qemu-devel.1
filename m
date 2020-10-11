Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A04C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22572145D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNKYe3W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22572145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi7a-0005Lq-N3
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5F-0001hC-80
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5D-0005WS-JR
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egvCJt14G0LEvqg5zPm7LF3yH6IbcZwusrSLXxHeOH0=;
 b=fNKYe3W6qhBAXV3LJ/AAsbczFD3Xh7cNerTi6e2HUBlTQNueN2vc5UtXyi/+uhUt4bG214
 ImC3H94UJU4lzB94khLg5Sbj3krpVljVvMBt1HTeWQj6UiyiaIB1TlVZMwQi9Kih56H90f
 p6r9LPPJnf6Ca80wtnKxL5uMcQh2TdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-N9K3a7k0OLuLHCVYud_OxQ-1; Sun, 11 Oct 2020 16:36:40 -0400
X-MC-Unique: N9K3a7k0OLuLHCVYud_OxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B58107ACF9
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:39 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 418DA5DA30;
 Sun, 11 Oct 2020 20:36:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 08/15] qga/rust: generate QGA QAPI sys bindings
Date: Mon, 12 Oct 2020 00:35:06 +0400
Message-Id: <20201011203513.1621355-9-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:35:36
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use qapi-gen to generate low-level C sys bindings for QAPI types,
include them to the build.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/Cargo.toml  |  4 ++++
 qga/lib.rs      |  1 +
 qga/meson.build | 11 +++++++++++
 qga/qapi_sys.rs |  5 +++++
 4 files changed, 21 insertions(+)
 create mode 100644 qga/qapi_sys.rs

diff --git a/qga/Cargo.toml b/qga/Cargo.toml
index 50c3415ab2..9966057594 100644
--- a/qga/Cargo.toml
+++ b/qga/Cargo.toml
@@ -4,6 +4,10 @@ version = "0.1.0"
 edition = "2018"
 license = "GPLv2"
 
+[dependencies]
+common = { path = "../rust/common" }
+libc = "^0.2.76"
+
 [lib]
 path = "lib.rs"
 crate-type = ["staticlib"]
diff --git a/qga/lib.rs b/qga/lib.rs
index e69de29bb2..050a47e2a3 100644
--- a/qga/lib.rs
+++ b/qga/lib.rs
@@ -0,0 +1 @@
+mod qapi_sys;
diff --git a/qga/meson.build b/qga/meson.build
index 62e13a11b3..dbc8f1623b 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -47,10 +47,21 @@ qga_ss = qga_ss.apply(config_host, strict: false)
 
 qga_rs = declare_dependency()
 if with_rust
+  qga_qapi_rs_outputs = [
+    'qga-qapi-sys-types.rs',
+  ]
+
+  qapi_gen_rs_files = custom_target('QGA QAPI Rust bindings',
+                                    output: qga_qapi_rs_outputs,
+                                    input: 'qapi-schema.json',
+                                    command: [ qapi_gen, '-r', '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
+                                    depend_files: qapi_gen_depends)
+
   cargo_qga = custom_target('cargo-qga',
                             build_by_default: true,
                             output: ['libqga.args', 'libqga.a'],
                             build_always_stale: true,
+                            depends: [qapi_gen_rs_files],
                             command: [cargo_wrapper,
                                       'build-lib',
                                       meson.current_build_dir(),
diff --git a/qga/qapi_sys.rs b/qga/qapi_sys.rs
new file mode 100644
index 0000000000..06fc49b826
--- /dev/null
+++ b/qga/qapi_sys.rs
@@ -0,0 +1,5 @@
+#![allow(dead_code)]
+include!(concat!(
+    env!("MESON_BUILD_ROOT"),
+    "/qga/qga-qapi-sys-types.rs"
+));
-- 
2.28.0


