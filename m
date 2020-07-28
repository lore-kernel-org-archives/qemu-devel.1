Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF452065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4NtsvI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF452065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JNd-00015a-TU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 02:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghammer@redhat.com>)
 id 1k0JLi-0007QB-Ix
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:44:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ghammer@redhat.com>)
 id 1k0JLh-0004B3-7g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595918668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZRL5TZyK96tHtFN4rVoroLqaASp+5exyGUAPbwD9B4=;
 b=i4NtsvI1tGfGtt8fp/bgf7yM398y8Wp/8kaKAK3KBMgmN9P2hpVIIEnIuCZQAXKLESdoxS
 EMFSdoCuPPsI6cMQOgRD6nekDkzHaoU/xIbsCexpSEHepl1u1fkafd/7/AYXvQmbsBKnFg
 3wdN3j6whZkiNyHEfStUJiKDAKPQBRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-qUX3-sIiPsyvi7ULez0TtA-1; Tue, 28 Jul 2020 02:43:18 -0400
X-MC-Unique: qUX3-sIiPsyvi7ULez0TtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E5121902EA0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:43:17 +0000 (UTC)
Received: from wolverine.usersys.redhat.com (unknown [10.35.206.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA45A69326;
 Tue, 28 Jul 2020 06:43:15 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Add PDCM feature bit when when CPU's pmu
 property is enabled
Date: Tue, 28 Jul 2020 09:42:50 +0300
Message-Id: <20200728064250.168368-1-ghammer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ghammer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
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
Cc: Gal Hammer <ghammer@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PDCM feature bit is not enabled when adding the pmu property to a CPU
without this capability (e.g. -cpu qemu64,pmu).

Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..6e1c8b6019 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5535,6 +5535,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
+        } else {
+            *ecx |= CPUID_EXT_PDCM;
         }
         break;
     case 2:
-- 
2.26.2


