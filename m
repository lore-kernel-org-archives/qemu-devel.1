Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B520207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bry2SMkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B520207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVe5-0006qS-Bw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:31:29 -0500
Received: from [2001:470:142:3::10] (port=59770 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5A-0007zy-6c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV58-0001oU-Ut
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV58-0001jq-6x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:22 -0500
Received: by mail-wr1-x431.google.com with SMTP id w15so17137995wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LMZiYWum7K5FFftwGEHqxzP9jxnxtuhS2JjQK1I+4dg=;
 b=bry2SMkg+aOeqbx9Wph87sODEbLIQjqukHRjPcqT4j1UST5ZE2jrWA/fr1YbwFce/0
 bbAOOzQyU3ijQIHfNSSFqbLYsQLhae8cWFKLinEDlz/JV9BjkDQOeQowMVRk5sEI/EZ4
 pzE0yG5w7bAPJ4h3c78J1Dd1W+PbgTC/BylBzbFRfNe67OQZlmN5DbjOrL7YVTMiAz9B
 DjtmEsyBrcPQ7A7t188AlUje112v0Ira63YWrNodlbXkfjS0DoHUx3Y3nGB7Y9mzll38
 IzbWgDwFb3Ss+3k+6EQhZyev+HnA3qQzUc3ldj+eAwMd5eQfCdbKy2EFB0XkLZyDLp0U
 1j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LMZiYWum7K5FFftwGEHqxzP9jxnxtuhS2JjQK1I+4dg=;
 b=mpdXdEOT6FWWVj40LFg1kOjBWdNwJj4weUbPFxXAAI7u1CRoDLLYLESrm6k/Ds2qAA
 txlceSc95vkpSUytlQxnseiH471UE+4nta5LVxYlcxy3coFEgMD/NZqspiRzzccuaTf6
 9vshSNIr4UteLf9dhoyHtaTloYQBr6rvMUrrWgp7zCs9pCOksC5vPdCjcwqiS96v+t5t
 gz0GIHhf6cS4YO7AzkzINOSbBfblOM7D3Q9vpsnDIPVNteOadSWQK5OmVRs7fMGn5hny
 cd1x9CqCpJ+VnCxncQTB2nE9qHYNz35s/d84XekHEZJG0nttKdjugCkQItPvl+Vtww0R
 nqfw==
X-Gm-Message-State: APjAAAVggc3qYIdRc1Xhy8wPwnD359vS7GfiLy3gsfDN1sW358zudj0o
 bEx/usai2mEoF8pWnXajX1b9BOmp
X-Google-Smtp-Source: APXvYqx3+wRRfJZFD7BZQuWnFHDOT2nBDB9//wros/hHAHW9VoA3I+a88+9EREtmn42itFj2QAp/Bw==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr29998882wrr.266.1580234119833; 
 Tue, 28 Jan 2020 09:55:19 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 038/142] build-sys hack: link with whole .fa archives
Date: Tue, 28 Jan 2020 18:51:58 +0100
Message-Id: <20200128175342.9066-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
index 52891849c8..a10a972521 100644
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
2.21.0



