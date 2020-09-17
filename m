Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6238C2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+lvZoWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6238C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoas-0004oG-Fl
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIoaE-0003yj-EP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:43:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIoaC-0004G3-GM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600328635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GwRM6QfSQQ2f/WvLuklLyFy6L+D8x/mCtxQFpC7zjKE=;
 b=d+lvZoWCGP1tlxVqnMuBk7Kiv4tgkhNEZ7vxyDNUKn1fsrLpNLsAOKmyG7K8Gtdz+dRHjJ
 0rjJf/Ftta0oFbLbHhueV+/KbwkOY8VUlb4btSW3Mm2WBdMHvsPVBjPJEQhTYKmYT4OUWR
 dDrWVoLRWUZSyVeUiRedj/T3qEwQfmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-Ec0LdK0yNAmzzi1rM0_Rgg-1; Thu, 17 Sep 2020 03:43:53 -0400
X-MC-Unique: Ec0LdK0yNAmzzi1rM0_Rgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C52805EE2;
 Thu, 17 Sep 2020 07:43:52 +0000 (UTC)
Received: from thuth.com (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8847878805;
 Thu, 17 Sep 2020 07:43:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] migration: Silence compiler warning in
 global_state_store_running()
Date: Thu, 17 Sep 2020 09:43:44 +0200
Message-Id: <20200917074344.168785-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC 9.3.0 on Ubuntu complains:

In file included from /usr/include/string.h:495,
                 from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
                 from ../migration/global_state.c:13:
In function ‘strncpy’,
    inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
 ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

... but we apparently really want to do a strncpy here - the size is already
checked with the assert() statement right in front of it. To silence the
warning, simply replace it with our strpadcpy() function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use strpadcpy instead of QEMU_NONSTRING (and yes, this time it seems
     to really silence the compiler warning :-))

 migration/global_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 25311479a4..a33947ca32 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -44,8 +44,8 @@ void global_state_store_running(void)
 {
     const char *state = RunState_str(RUN_STATE_RUNNING);
     assert(strlen(state) < sizeof(global_state.runstate));
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
+              state, '\0');
 }
 
 bool global_state_received(void)
-- 
2.18.2


