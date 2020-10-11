Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2DC43457
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9E1207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J11BBcz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9E1207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi7d-0005U3-7Z
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4g-0000rU-4C
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4e-0005SJ-1D
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95axpi0IvDfLnJZoXZHGJcKk2SIGdhXysMCYnQ2+U+Y=;
 b=J11BBcz6UKDT3DR/6gOyc9gu26LlelKHKaPTEMTyOx0a4sPTL/1/HEPzMHGaq3SZdvC9Vg
 F7DvV/7/AsmZpE1+61+CqWjEJFSk3It2hwn+TeJOJ1x9Rus8HD8qSovBGl8889lTBIEQyf
 kWr6yvBKl9F6DUDmPr1MJ5aWzP8NRGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-fYwgFLRaMW6Hr-fLflQp-g-1; Sun, 11 Oct 2020 16:36:01 -0400
X-MC-Unique: fYwgFLRaMW6Hr-fLflQp-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E02F32FD02
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:00 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88D955DA30;
 Sun, 11 Oct 2020 20:35:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 04/15] build-sys: add a cargo-wrapper script
Date: Mon, 12 Oct 2020 00:35:02 +0400
Message-Id: <20201011203513.1621355-5-marcandre.lureau@redhat.com>
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

Introduce a script to help calling cargo from Rust.

Cargo is the most convenient way to build Rust code, with various
crates, and has many features that meson lacks in general for Rust.
Trying to convert projects to meson automatically is an option I
considered (see for ex https://github.com/badboy/bygge for ninja
conversion), but the complexity of the task and the need of build.rs
mechanism in various crates makes this endeavour out of scope at this
point.

This script will help to invoke cargo in different ways. For now, it
supports building static libraries. It sets up a common environment, run
the compiler and grep its output for the linker flags. Finally it copies
the built library to the expected meson output directory, and create a
file with the linker arguments.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build              |   1 +
 scripts/cargo_wrapper.py | 101 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 scripts/cargo_wrapper.py

diff --git a/meson.build b/meson.build
index d8526dc999..c30bb290c5 100644
--- a/meson.build
+++ b/meson.build
@@ -75,6 +75,7 @@ endif
 
 with_rust = 'CONFIG_WITH_RUST' in config_host
 cargo = find_program('cargo', required: with_rust)
+cargo_wrapper = find_program('scripts/cargo_wrapper.py')
 
 if with_rust
   rs_target_triple = config_host['CONFIG_WITH_RUST_TARGET']
diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
new file mode 100644
index 0000000000..164fad5123
--- /dev/null
+++ b/scripts/cargo_wrapper.py
@@ -0,0 +1,101 @@
+#!/usr/bin/env python3
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Marc-André Lureau <marcandre.lureau@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import argparse
+import configparser
+import distutils.file_util
+import glob
+import os
+import os.path
+import re
+import subprocess
+import sys
+from typing import List
+
+
+def get_cargo_target_dir(args: argparse.Namespace) -> str:
+    # avoid conflict with qemu "target" directory
+    return os.path.join(args.build_dir, "rs-target")
+
+
+def get_manifest_path(args: argparse.Namespace) -> str:
+    return os.path.join(args.src_dir, "Cargo.toml")
+
+
+def build_lib(args: argparse.Namespace) -> None:
+    target_dir = get_cargo_target_dir(args)
+    manifest_path = get_manifest_path(args)
+    # let's pretend it's an INI file to avoid extra dependency
+    config = configparser.ConfigParser()
+    config.read(manifest_path)
+    package_name = config["package"]["name"].strip('"')
+    liba = os.path.join(
+        target_dir, args.target_triple, args.build_type, "lib" + package_name + ".a"
+    )
+    libargs = os.path.join(args.build_dir, "lib" + package_name + ".args")
+
+    env = {}
+    env["MESON_CURRENT_BUILD_DIR"] = args.build_dir
+    env["MESON_BUILD_ROOT"] = args.build_root
+    env["WINAPI_NO_BUNDLED_LIBRARIES"] = "1"
+    cargo_cmd = [
+        "cargo",
+        "rustc",
+        "--target-dir",
+        target_dir,
+        "--manifest-path",
+        manifest_path,
+    ]
+    if args.target_triple:
+        cargo_cmd += ["--target", args.target_triple]
+    if args.build_type == "release":
+        cargo_cmd += ["--release"]
+    cargo_cmd += ["--", "--print", "native-static-libs"]
+    cargo_cmd += args.EXTRA
+    try:
+        out = subprocess.check_output(
+            cargo_cmd,
+            env=dict(os.environ, **env),
+            stderr=subprocess.STDOUT,
+            universal_newlines=True,
+        )
+        native_static_libs = re.search(r"native-static-libs:(.*)", out)
+        link_args = native_static_libs.group(1)
+        with open(libargs, "w") as f:
+            print(link_args, file=f)
+
+        distutils.file_util.copy_file(liba, args.build_dir, update=True)
+    except subprocess.CalledProcessError as e:
+        print(
+            "Environment: " + " ".join(["{}={}".format(k, v) for k, v in env.items()])
+        )
+        print("Command: " + " ".join(cargo_cmd))
+        print(e.output)
+        sys.exit(1)
+
+
+def main() -> None:
+    parser = argparse.ArgumentParser()
+    parser.add_argument("command")
+    parser.add_argument("build_dir")
+    parser.add_argument("src_dir")
+    parser.add_argument("build_root")
+    parser.add_argument("build_type")
+    parser.add_argument("target_triple")
+    parser.add_argument("EXTRA", nargs="*")
+    args = parser.parse_args()
+
+    if args.command == "build-lib":
+        build_lib(args)
+    else:
+        raise argparse.ArgumentTypeError("Unknown command: %s" % args.command)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.28.0


