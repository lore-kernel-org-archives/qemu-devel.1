Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7950F20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHulftrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7950F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUPH-0001L2-Md
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdUOa-0000Kn-Gu
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:53:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdUOZ-0002Ba-KD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2IzxrkhExVmTF7Y1W/4xKmgeGVhygIWpTlLDJmW6/O0=;
 b=KHulftrI9MTm9d69U8WRpgaTShMBVcHRyGB9Tjb9phUS5R4jeJBlXM4iGwOJyASm0fThFD
 g7hAEa0uZAF5L0oqbFlHoxDQzRwPUnkcQwu71KUldFMZ4ZXf+eYcr/8EyHtTk4uuPi3Pva
 AkfwwkVkq0NrnI4p8U/34H5v5l8dnF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-cn6Wd7jOOtOXkIdKTQk0cA-1; Tue, 26 May 2020 03:53:03 -0400
X-MC-Unique: cn6Wd7jOOtOXkIdKTQk0cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2745C460;
 Tue, 26 May 2020 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE1419D7C;
 Tue, 26 May 2020 07:52:47 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3] exec: set map length to zero when returning NULL
Date: Tue, 26 May 2020 13:20:42 +0530
Message-Id: <20200526075042.420162-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Ding Ren <rding@gatech.edu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When mapping physical memory into host's virtual address space,
'address_space_map' may return NULL if BounceBuffer is in_use.
Set and return '*plen = 0' to avoid later NULL pointer dereference.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

Update v3: set *plen = 0;
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06249.html

diff --git a/exec.c b/exec.c
index 5162f0d12f..4eea84bf66 100644
--- a/exec.c
+++ b/exec.c
@@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
+            *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
-- 
2.26.2


