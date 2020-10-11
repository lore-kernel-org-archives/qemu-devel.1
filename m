Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791EA207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDWDE7X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791EA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi7a-0005MH-Ht
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4q-00012b-TD
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4m-0005UA-Vx
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHft3RD80FkUI2fpCOWT/+7Xhsx9FIeU/vkqD1Xscrk=;
 b=VDWDE7X8u37yYQSuN5vg2swYu05L7ACnMyaf6AQcnIy59Iy5ZGcuqqhzaSpFdwz8U4p5SJ
 pu6Pu/jdY79oyHdXsX9nE8hi0TQYq36Gv7PbDcZpS7sm3mQJBNKBURZXOpo/nYh81lp5sJ
 irIe84l3OGTY2HnQvIOZAyjoW84MN3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-d9gvnVZqNh6Ri1XzLgyBEA-1; Sun, 11 Oct 2020 16:36:12 -0400
X-MC-Unique: d9gvnVZqNh6Ri1XzLgyBEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72071107ACF5
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:11 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF06B55790;
 Sun, 11 Oct 2020 20:36:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 05/15] qga/rust: build and link an empty static library
Date: Mon, 12 Oct 2020 00:35:03 +0400
Message-Id: <20201011203513.1621355-6-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Meson doesn't integrate very smoothly with Cargo. Use the cargo-wrapper
script as a custom_target() always stale to build the Rust code. The
"build-lib" command will produce a static library in the meson expected
output directory, as well as link flags that must be employed to do the
final link.

Those link flags can't be queried during configure time (Cargo doesn't
have a user-queriable configure step), so we pass them to the linker
thanks to @file argument support at build time.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Cargo.toml      |  2 +-
 qga/Cargo.toml  |  9 +++++++++
 qga/lib.rs      |  0
 qga/meson.build | 18 +++++++++++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 qga/Cargo.toml
 create mode 100644 qga/lib.rs

diff --git a/Cargo.toml b/Cargo.toml
index c4b464ff15..e69b04200f 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -1,2 +1,2 @@
 [workspace]
-members = []
+members = ["qga"]
diff --git a/qga/Cargo.toml b/qga/Cargo.toml
new file mode 100644
index 0000000000..50c3415ab2
--- /dev/null
+++ b/qga/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "qga"
+version = "0.1.0"
+edition = "2018"
+license = "GPLv2"
+
+[lib]
+path = "lib.rs"
+crate-type = ["staticlib"]
diff --git a/qga/lib.rs b/qga/lib.rs
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/qga/meson.build b/qga/meson.build
index cd08bd953a..62e13a11b3 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -45,9 +45,25 @@ qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
 
 qga_ss = qga_ss.apply(config_host, strict: false)
 
+qga_rs = declare_dependency()
+if with_rust
+  cargo_qga = custom_target('cargo-qga',
+                            build_by_default: true,
+                            output: ['libqga.args', 'libqga.a'],
+                            build_always_stale: true,
+                            command: [cargo_wrapper,
+                                      'build-lib',
+                                      meson.current_build_dir(),
+                                      meson.current_source_dir(),
+                                      meson.build_root(),
+                                      rs_build_type,
+                                      rs_target_triple])
+  qga_rs = declare_dependency(link_args: '@' + cargo_qga.full_path(), sources: cargo_qga)
+endif
+
 qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
-                 dependencies: [qemuutil, libudev],
+                 dependencies: [qemuutil, libudev, qga_rs],
                  install: true)
 all_qga = [qga]
 
-- 
2.28.0


