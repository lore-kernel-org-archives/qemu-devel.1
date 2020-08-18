Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248E20786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMvvbbmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D248E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82VT-0006xv-2y
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KB-0003Cd-8f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82K6-0007Jw-2X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dspYanX3zf7a9yxolnnruaw1M3atSamdkc1hvEVqzGE=;
 b=DMvvbbmVfsguPajx+Kpq4lKqAsAcjmAN99yY9DWMpkAHEKI3acQX8uue+eRfbilDyKmid2
 k1yIKa9y0Ealt5fohRRibR05Bi2ehm7lxUPv0gInkZ/UmUCmgvJEjoPFWPXVfnppP+U2Mf
 gqFKqIUGse5YgcSwySagzByy0fv6fig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-34P-wrjfNKmGvweJ1_VyiA-1; Tue, 18 Aug 2020 10:10:43 -0400
X-MC-Unique: 34P-wrjfNKmGvweJ1_VyiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B456018B9F5A
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:10:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71B00BA63;
 Tue, 18 Aug 2020 14:10:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 018/150] build-sys hack: link with whole .fa archives
Date: Tue, 18 Aug 2020 10:08:13 -0400
Message-Id: <20200818141025.21608-19-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In order to link the *-obj-y files into tests, we will make static
libraries of them in Meson, and then link them as whole archives
into the tests.  To separate regular static libraries from link-whole
libraries, give them a different file extension.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rules.mak | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/rules.mak b/rules.mak
index e79a4005a7..5ab42def82 100644
--- a/rules.mak
+++ b/rules.mak
@@ -39,6 +39,13 @@ find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
 defined-symbols = $(call find-symbols,$1,awk '$$2!="U"{print $$1}')
 undefined-symbols = $(call find-symbols,$1,awk '$$2=="U"{print $$1}')
 
+WL := -Wl,
+ifdef CONFIG_DARWIN
+whole-archive = $(WL)-force_load,$1
+else
+whole-archive = $(WL)--whole-archive $1 $(WL)--no-whole-archive
+endif
+
 # All the .mo objects in -m variables are also added into corresponding -y
 # variable in unnest-vars, but filtered out here, when LINK is called.
 #
@@ -54,11 +61,12 @@ undefined-symbols = $(call find-symbols,$1,awk '$$2=="U"{print $$1}')
 # This is necessary because the exectuable itself may not use the function, in
 # which case the function would not be linked in. Then the DSO loading will
 # fail because of the missing symbol.
-process-archive-undefs = $(filter-out %.a %.mo,$1) \
+process-archive-undefs = $(filter-out %.a %.fa %.mo,$1) \
                 $(addprefix $(WL_U), \
-                     $(filter $(call defined-symbols,$(filter %.a, $1)), \
+                     $(filter $(call defined-symbols,$(filter %.a %.fa, $1)), \
                               $(call undefined-symbols,$(filter %.mo,$1)))) \
-                $(filter %.a,$1)
+		$(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
+		$(filter %.a,$1)
 
 extract-libs = $(strip $(foreach o,$(filter-out %.mo,$1),$($o-libs)))
 expand-objs = $(strip $(sort $(filter %.o,$1)) \
@@ -122,7 +130,7 @@ LD_REL := $(CC) -nostdlib $(LD_REL_FLAGS)
 modules:
 
 %$(EXESUF): %.o
-	$(call LINK,$(filter %.o %.a %.mo, $^))
+	$(call LINK,$(filter %.o %.a %.mo %.fa, $^))
 
 %.a:
 	$(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@")
@@ -378,7 +386,7 @@ define unnest-vars
                 $(error $o added in $v but $o-objs is not set)))
         $(shell mkdir -p ./ $(sort $(dir $($v))))
         # Include all the .d files
-        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
+        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
         $(eval $v := $(filter-out %/,$($v))))
 endef
 
-- 
2.26.2



