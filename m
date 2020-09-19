Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0BC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D126D208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsAN/NU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D126D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfMD-0002As-VP
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGr-00056M-63
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGk-0007JE-E1
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TDtpDoi6g/JCHZNQbHoZqXqqkMVqDBmjt877as1geg=;
 b=SsAN/NU9sJMWbzEnPlR5eFiey4K908PAGAlLo5egDsYf4Xba7X1kzeJ6kMXNXYb5/EcgNh
 4FjbfSOtRNU7EAr531JMPlc1GajlSQQCUPqudPCORtsA4vvqEJ+QbnA/d4UrYZNEvI4MJ3
 BMXCIxQW5qKzw0h5rujgZXqsi4RMZnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-6BrAhE8lNYiH5aO3ZAPoeA-1; Sat, 19 Sep 2020 11:59:19 -0400
X-MC-Unique: 6BrAhE8lNYiH5aO3ZAPoeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4368712D9
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 043F01002388;
 Sat, 19 Sep 2020 15:59:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/57] meson: clean up build_by_default
Date: Sat, 19 Sep 2020 11:58:22 -0400
Message-Id: <20200919155916.1046398-4-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:26:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build all executables by default except for the known-broken ones.

This also allows running qemu-iotests without manually building
socket_scm_helper.

Reported-by: Max Reitz <mreitz@redhat.com>
Tested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst    | 5 +++++
 tests/fp/meson.build           | 2 --
 tests/meson.build              | 5 ++---
 tests/qemu-iotests/meson.build | 3 +--
 trace/meson.build              | 1 -
 ui/shader/meson.build          | 1 -
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 08e85c69e1..2ee368fad6 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -193,6 +193,11 @@ compilation as possible. The Meson "sourceset" functionality is used
 to list the files and their dependency on various configuration  
 symbols.
 
+All executables are built by default, except for some `contrib/`
+binaries that are known to fail to build on some platforms (for example
+32-bit or big-endian platforms).  Tests are also built by default,
+though that might change in the future.
+
 Various subsystems that are common to both tools and emulators have
 their own sourceset, for example `block_ss` for the block device subsystem,
 `chardev_ss` for the character device subsystem, etc.  These sourcesets
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 8779a17aab..24739ad421 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -541,7 +541,6 @@ fpcflags += [
 fptest = executable(
   'fp-test',
   ['fp-test.c', tfdir / 'slowfloat.c', '../../fpu/softfloat.c'],
-  build_by_default: false,
   link_with: [libtestfloat, libsoftfloat],
   dependencies: [qemuutil],
   include_directories: [sfinc, include_directories(tfdir)],
@@ -628,7 +627,6 @@ test('fp-test:mulAdd', fptest,
 fpbench = executable(
   'fp-bench',
   ['fp-bench.c', '../../fpu/softfloat.c'],
-  build_by_default: false,
   link_with: [libtestfloat, libsoftfloat],
   dependencies: [qemuutil],
   include_directories: [sfinc, include_directories(tfdir)],
diff --git a/tests/meson.build b/tests/meson.build
index 7585d75982..f1d474c8a9 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -242,12 +242,11 @@ foreach bench_name, deps: benchs
             suite: ['speed'])
 endforeach
 
-if have_tools and 'CONFIG_VHOST_USER' in config_host
+if have_tools and 'CONFIG_VHOST_USER' in config_host and 'CONFIG_LINUX' in config_host
   executable('vhost-user-bridge',
              sources: files('vhost-user-bridge.c'),
              link_with: [libvhost_user],
-             dependencies: [qemuutil],
-             build_by_default: false)
+             dependencies: [qemuutil])
 endif
 
 if have_system and 'CONFIG_POSIX' in config_host
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 60470936b4..67aed1e492 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -1,6 +1,5 @@
 if 'CONFIG_LINUX' in config_host
-    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c',
-                                    build_by_default: false)
+    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c')
 else
     socket_scm_helper = []
 endif
diff --git a/trace/meson.build b/trace/meson.build
index b36937d3a6..d5fc45c628 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -70,7 +70,6 @@ foreach d : [
                 output: d[0],
                 input: meson.source_root() / 'trace-events',
                 command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
-                build_by_default: true, # to be removed when added to a target
                 capture: true)
   specific_ss.add(gen)
 endforeach
diff --git a/ui/shader/meson.build b/ui/shader/meson.build
index f69e44ed89..592bf596b9 100644
--- a/ui/shader/meson.build
+++ b/ui/shader/meson.build
@@ -9,7 +9,6 @@ foreach e : shaders
   genh += custom_target(output,
                 output: output,
                 capture: true,
-                build_by_default: true, # to be removed when added to a target
                 input: files('@0@.@1@'.format(e[0], e[1])),
                 command: [shaderinclude, '@INPUT0@'])
 endforeach
-- 
2.26.2



