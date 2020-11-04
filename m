Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E3C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7342072E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffP0HVuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7342072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKJh-0004UB-Hb
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIU-0002uz-Un
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIR-000612-Kh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNJiJhP8ymRDAECfSLwUKfgEfyjNuYyRk5amk7A7dvA=;
 b=ffP0HVujZEyONTeEIMVnksdMV2o6qmZTSsK0NYLZdcUbrjlCHOecV/b5D1bAwK7gHF2T3/
 5Y2ip8IvalN+EnFIfSgfOsXPfTWwKTYf03At1FttH96fbRU7H/20zvytEBy/fsnw3zCOnN
 XB7SyATJbEASErOI8D5NvxvCTuV2L+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-lzErxlR6PiOoASMJgXmAbw-1; Wed, 04 Nov 2020 10:01:57 -0500
X-MC-Unique: lzErxlR6PiOoASMJgXmAbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B83C1006CBF
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:01:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0FDB1007501;
 Wed,  4 Nov 2020 15:01:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] exec: Remove dead code (CID 1432876)
Date: Wed,  4 Nov 2020 10:01:36 -0500
Message-Id: <20201104150153.541326-4-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We removed the global_locking field in commit 4174495408a,
leaving dead code around the 'unlocked' variable. Remove it
to fix the DEADCODE issue reported by Coverity (CID 1432876).

Fixes: 4174495408a ("exec: Remove MemoryRegion::global_locking field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201030153752.1557776-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/physmem.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index a9adedb9f8..0b31be2928 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2723,22 +2723,14 @@ static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 
 static bool prepare_mmio_access(MemoryRegion *mr)
 {
-    bool unlocked = !qemu_mutex_iothread_locked();
     bool release_lock = false;
 
-    if (unlocked) {
+    if (!qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
-        unlocked = false;
         release_lock = true;
     }
     if (mr->flush_coalesced_mmio) {
-        if (unlocked) {
-            qemu_mutex_lock_iothread();
-        }
         qemu_flush_coalesced_mmio_buffer();
-        if (unlocked) {
-            qemu_mutex_unlock_iothread();
-        }
     }
 
     return release_lock;
-- 
2.26.2



