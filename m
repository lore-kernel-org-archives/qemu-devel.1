Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021C420656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8Z9Q4du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021C420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Zs-0006GE-6h
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dn-00021g-GS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Di-0001cN-0E
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRgqJhXghNrzQYE4BiirjVUChmbcjbePOcZgluZ1vrI=;
 b=S8Z9Q4duWa5ITX9iw9PSvAZbvDTiF4+d1c51Q8apAdiIq96O4mavN95JE6T4AvwqNOiMpB
 GaAKmutgkNOEagqGAhTt6hX4c3oTYjX6FSDBRle4qBoJBNHIZhlOu81LHy5Zd56URsItTw
 iX2ZtSER0q6KEBvx/pEX9qphDWpWv/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-cdMJyJzAPyeO_cKyh8BZEg-1; Fri, 21 Aug 2020 06:24:20 -0400
X-MC-Unique: cdMJyJzAPyeO_cKyh8BZEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA81B56B5A
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 888F960BF1;
 Fri, 21 Aug 2020 10:24:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 058/152] meson: convert authz directory to Meson
Date: Fri, 21 Aug 2020 06:21:55 -0400
Message-Id: <20200821102329.29777-59-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile            |  1 -
 Makefile.objs       |  3 ++-
 Makefile.target     |  2 +-
 authz/Makefile.objs |  7 -------
 authz/meson.build   | 19 +++++++++++++++++++
 meson.build         |  5 +++++
 6 files changed, 27 insertions(+), 10 deletions(-)
 delete mode 100644 authz/Makefile.objs
 create mode 100644 authz/meson.build

diff --git a/Makefile b/Makefile
index 4b152e3587..d380271765 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                authz-obj-y \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
diff --git a/Makefile.objs b/Makefile.objs
index 84bfa2a61a..0bc361d338 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,7 +9,8 @@ ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
 
 chardev-obj-y = chardev/
 
-authz-obj-y = authz/
+authz-obj-y = authz/libauthz.fa
+authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
 block-obj-y = block/ nbd/ scsi/
 block-obj-y += block.o blockjob.o job.o
diff --git a/Makefile.target b/Makefile.target
index 1e04551a8e..79b6e02bed 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -192,9 +192,9 @@ common-obj-m :=
 
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
+              authz-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
-               authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
deleted file mode 100644
index ed7b273596..0000000000
--- a/authz/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-authz-obj-y += base.o
-authz-obj-y += simple.o
-authz-obj-y += list.o
-authz-obj-y += listfile.o
-authz-obj-$(CONFIG_AUTH_PAM) += pamacct.o
-
-pamacct.o-libs = -lpam
diff --git a/authz/meson.build b/authz/meson.build
new file mode 100644
index 0000000000..516d71f2e2
--- /dev/null
+++ b/authz/meson.build
@@ -0,0 +1,19 @@
+authz_ss = ss.source_set()
+authz_ss.add(genh)
+authz_ss.add(files(
+  'base.c',
+  'list.c',
+  'listfile.c',
+  'simple.c',
+))
+
+authz_ss.add(when: ['CONFIG_AUTH_PAM', pam], if_true: files('pamacct.c'))
+
+authz_ss = authz_ss.apply(config_host, strict: false)
+libauthz = static_library('authz', authz_ss.sources() + genh,
+                          dependencies: [authz_ss.dependencies()],
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+authz = declare_dependency(link_whole: libauthz,
+                           dependencies: qom)
diff --git a/meson.build b/meson.build
index 658d45c4c6..34363bff19 100644
--- a/meson.build
+++ b/meson.build
@@ -103,6 +103,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+pam = not_found
+if 'CONFIG_AUTH_PAM' in config_host
+  pam = cc.find_library('pam')
+endif
 libattr = not_found
 if 'CONFIG_ATTR' in config_host
   libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
@@ -341,6 +345,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 subdir('qom')
+subdir('authz')
 subdir('fsdev')
 
 # Other build targets
-- 
2.26.2



