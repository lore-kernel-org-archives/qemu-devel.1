Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA65C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FF82177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWmVHRbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FF82177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lTi-0007s4-Mn
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNl-0003kU-Ce
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55140
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNj-0006O4-G4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLitUbpbM6irG8a+7TtGiqB3QI3hJzEWoxne18gjXGA=;
 b=EWmVHRbMATk2oeRCNjXaDhf0UC4EYWy+5ignb3BZArQmoPXydqV8F00uou4l6OcRP2N2M+
 q1aDX+OIBWCZU/1JF+celund+QjkJto9Ec4JREDJDE3RTyvVEwTi0n5BqvFPkESsXZ5xqk
 Y1WrPnjwgcUoF0zz4qSsWSa1s3f/qVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-G-Px03K8OwGJg4idPReV3A-1; Thu, 06 Aug 2020 15:16:49 -0400
X-MC-Unique: G-Px03K8OwGJg4idPReV3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D8091DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:48 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EEE01D3;
 Thu,  6 Aug 2020 19:16:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 014/143] build-sys hack: link with whole .fa archives
Date: Thu,  6 Aug 2020 21:14:10 +0200
Message-Id: <1596741379-12902-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index e79a400..5ab42de 100644
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
1.8.3.1



