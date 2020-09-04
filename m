Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A797C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6563214F1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6563214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAKd-0003e9-UJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6e-0000jj-1h
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6b-0005Gl-M4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-NdjqO0EINfi5sdugqyqT1Q-1; Fri, 04 Sep 2020 07:42:07 -0400
X-MC-Unique: NdjqO0EINfi5sdugqyqT1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E468EC16C
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0433C6024E
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/46] meson: compute config_all_devices directly
Date: Fri,  4 Sep 2020 07:41:04 -0400
Message-Id: <20200904114122.31307-29-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no need anymore to produce config-all-devices.mak, compute
the resulting dictionary directly instead of going through grepy.sh.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore       |  1 -
 meson.build      | 14 ++------------
 scripts/grepy.sh |  3 ---
 3 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100755 scripts/grepy.sh

diff --git a/.gitignore b/.gitignore
index 4ccb9ed975..f3fbd87ce4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,7 +2,6 @@
 /build/
 /.doctrees
 /config-devices.*
-/config-all-devices.*
 /config-all-disas.*
 /config-host.*
 /config-target.*
diff --git a/meson.build b/meson.build
index b71f561c96..037ccd3f4c 100644
--- a/meson.build
+++ b/meson.build
@@ -455,6 +455,7 @@ endforeach
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
+config_all_devices = {}
 config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
@@ -523,11 +524,11 @@ foreach target : target_dirs
     config_devices_h += {target: configure_file(output: target + '-config-devices.h',
                                                 configuration: config_devices_data)}
     config_target += config_devices
+    config_all_devices += config_devices
   endif
   config_target_mak += {target: config_target}
 endforeach
 
-grepy = find_program('scripts/grepy.sh')
 # This configuration is used to build files that are shared by
 # multiple binaries, and then extracted out of the "common"
 # static_library target.
@@ -537,17 +538,6 @@ grepy = find_program('scripts/grepy.sh')
 # targets that are not built for this compilation.  The CONFIG_ALL
 # pseudo symbol replaces it.
 
-if have_system
-  config_all_devices_mak = configure_file(
-    output: 'config-all-devices.mak',
-    input: config_devices_mak_list,
-    capture: true,
-    command: [grepy, '@INPUT@'],
-  )
-  config_all_devices = keyval.load(config_all_devices_mak)
-else
-  config_all_devices = {}
-endif
 config_all = config_all_devices
 config_all += config_host
 config_all += config_all_disas
diff --git a/scripts/grepy.sh b/scripts/grepy.sh
deleted file mode 100755
index aee46ddc8d..0000000000
--- a/scripts/grepy.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-
-grep -h '=y$' "$@" | sort -u
-- 
2.26.2



