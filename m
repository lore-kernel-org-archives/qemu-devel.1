Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A02521D24
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii6A64mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02521D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDmQ-0005cx-GU
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJDj7-00025i-Rf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJDj5-0005CI-07
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600425286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVUCVNO4APeMaNsoKSKvJekSTv+7JAP5Fuqg/doiR1U=;
 b=ii6A64mS/fC7hSSxmfWfIl1++n8D82K1OLIQsukUPbmeC0SwNiYWYz4HlVnoKR6TimmYxm
 IPaLUeCu593waY0rcQTP0S0RHl2Bf22KH43DvaozDdGH34ug5Mxjp8iSAsVyslOn3+fQRC
 1lh12QUktKI2CMGHD42j3VcMCCd7GUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-R7NwxjSuPSiaN-K5fa1uZw-1; Fri, 18 Sep 2020 06:34:44 -0400
X-MC-Unique: R7NwxjSuPSiaN-K5fa1uZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8F9188C12D;
 Fri, 18 Sep 2020 10:34:43 +0000 (UTC)
Received: from thuth.com (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C23166198C;
 Fri, 18 Sep 2020 10:34:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/6] migration: Silence compiler warning in
 global_state_store_running()
Date: Fri, 18 Sep 2020 12:34:27 +0200
Message-Id: <20200918103430.297167-4-thuth@redhat.com>
In-Reply-To: <20200918103430.297167-1-thuth@redhat.com>
References: <20200918103430.297167-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
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

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com> (two years ago)
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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


