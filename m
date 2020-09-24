Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF57C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF1C212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpqQAbzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1C212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNUJ-0001s2-7E
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTG-00006w-4S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTE-0005y0-7q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnyjZGsqRbbPt12X0NACZz8vmfAX9gsJo64TD+RO6CM=;
 b=EpqQAbzHrB3A6GantP//aPXCBQQ93hjaTJSbNYibKcN4W1Xns1Y9vCfhvSwIas7Lnf7Ud5
 khITkFFGYOF5UxPeYylQ4YAKrHRziM7AKvu2EfXHDbdsSm2VpcTGnHk/lxl+VGUV+jkqO8
 kE74+WUo6U/aSj+BQVQytDzqH9G4THk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-nDERCLWKPT6XvUcxY_Iw0Q-1; Thu, 24 Sep 2020 05:23:17 -0400
X-MC-Unique: nDERCLWKPT6XvUcxY_Iw0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A63C64158
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA8F073662;
 Thu, 24 Sep 2020 09:23:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/92] meson: clean up build_by_default
Date: Thu, 24 Sep 2020 05:21:44 -0400
Message-Id: <20200924092314.1722645-3-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
index 70203890a1..116d9a2654 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -248,12 +248,11 @@ foreach bench_name, deps: benchs
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



