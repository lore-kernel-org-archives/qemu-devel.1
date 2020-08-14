Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF66C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577A420781
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7mXFyHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577A420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6W2h-0000LX-Ig
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmo-0005Xy-E7
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmc-0002tA-76
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5yZsTYnXUrXSYkZ611ffRDAvWvo/sI68mZsWYHm2vM=;
 b=i7mXFyHJdrBN/ve7pFhAryVFubRRbvCrjje1OHZCPPA7d3kAmfeKhqquNX1zLZllXmOtX7
 IeKgBnrjN8SLuDb5r3RbN8j8XjnKWKMHmVwlhXEu9oaJJu1kJyPrsEoMhjFACnHnGoBM68
 vaSKp8AS79RHYHCBjXuOMmjtHipOU0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-vZRBW5XhPUWGIcGTvwtyrw-1; Fri, 14 Aug 2020 05:13:51 -0400
X-MC-Unique: vZRBW5XhPUWGIcGTvwtyrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22E81015DBC
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FAA5747B9
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 033/150] contrib/rdmacm-mux: convert to Meson
Date: Fri, 14 Aug 2020 05:11:29 -0400
Message-Id: <20200814091326.16173-34-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

We can use config-host.mak to decide whether the tool has to be built,
apart from that the conversion is straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                         | 5 -----
 Makefile.objs                    | 1 -
 contrib/rdmacm-mux/Makefile.objs | 3 ---
 contrib/rdmacm-mux/meson.build   | 8 ++++++++
 meson.build                      | 2 ++
 5 files changed, 10 insertions(+), 9 deletions(-)
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build

diff --git a/Makefile b/Makefile
index fa7bc837f1..0a5bc1f424 100644
--- a/Makefile
+++ b/Makefile
@@ -302,7 +302,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -524,10 +523,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index ab798b08a7..0f80b63554 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
deleted file mode 100644
index 3df744af89..0000000000
--- a/contrib/rdmacm-mux/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-ifdef CONFIG_PVRDMA
-rdmacm-mux-obj-y = main.o
-endif
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
new file mode 100644
index 0000000000..1a01bb9262
--- /dev/null
+++ b/contrib/rdmacm-mux/meson.build
@@ -0,0 +1,8 @@
+if 'CONFIG_PVRDMA' in config_host
+  # if not found, CONFIG_PVRDMA should not be set
+  libumad = cc.find_library('ibumad', required: true)
+  executable('rdmacm-mux', files('main.c'),
+             dependencies: [glib, libumad],
+             build_by_default: targetos == 'linux',
+             install: false)
+endif
diff --git a/meson.build b/meson.build
index ac151bdd02..a4b8d66385 100644
--- a/meson.build
+++ b/meson.build
@@ -256,6 +256,8 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 # Other build targets
 
 if have_tools
+  subdir('contrib/rdmacm-mux')
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.26.2



