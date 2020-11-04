Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C64C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2902072E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdzwsvuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2902072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKM7-0007wF-Vj
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIY-0002yV-3S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIR-00060e-UY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LomTBw8uZZy1rA9GJor/FwuuPqnxuVYa0w37Agyn06c=;
 b=OdzwsvuZAqCbySaaPubC8HDwI4/QUZ6Lrg/M47yiJSlLPRv+tN/2YRDcQOnsxO7PQ9zJKu
 fusmpLGrnwNEqLjBbR3PkzPi0+qf6BqiA0vgIXLO8hSq5GmX8DyiB95/stNNZviVKoqd8S
 XIUQauLnfIQ3LDo5LYC/CLQiqZPdB/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-oH8T70htN--aTTXtPJUgTw-1; Wed, 04 Nov 2020 10:01:56 -0500
X-MC-Unique: oH8T70htN--aTTXtPJUgTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 340891891E8A;
 Wed,  4 Nov 2020 15:01:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D630B1002D41;
 Wed,  4 Nov 2020 15:01:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] cutils: replace strdup with g_strdup
Date: Wed,  4 Nov 2020 10:01:34 -0500
Message-Id: <20201104150153.541326-2-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Memory returned by get_relocated_path must be freed with
free or g_free depending on the path that the function
took; Coverity takes exception to this practice.  The
fix lets caller use g_free as is standard in QEMU.

While at it, mention the requirements on the caller in
the doc comment.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cutils.h | 1 +
 util/cutils.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 4bbf4834ea..986ed8e15f 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -205,6 +205,7 @@ int qemu_pstrcmp0(const char **str1, const char **str2);
  * as the prefix.  For example, if `bindir` is `/usr/bin` and @dir is
  * `/usr/share/qemu`, the function will append `../share/qemu` to the
  * directory that contains the running executable and return the result.
+ * The returned string should be freed by the caller.
  */
 char *get_relocated_path(const char *dir);
 
diff --git a/util/cutils.c b/util/cutils.c
index c395974fab..9498e28e1a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -937,7 +937,7 @@ char *get_relocated_path(const char *dir)
     /* Fail if qemu_init_exec_dir was not called.  */
     assert(exec_dir[0]);
     if (!starts_with_prefix(dir) || !starts_with_prefix(bindir)) {
-        return strdup(dir);
+        return g_strdup(dir);
     }
 
     result = g_string_new(exec_dir);
-- 
2.26.2



