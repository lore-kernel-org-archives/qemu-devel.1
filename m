Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B1C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5AB2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW6xINBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5AB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkbm-00070Y-VE
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVr-0005C3-DK
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVq-00025I-Gd
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfGg3kD91LblaJiUxEahY+a0L+gOksKbyNf7iAAUl/w=;
 b=BW6xINBArEs/SSbzyDHZR1SOvWbuFY/PwNqxKCsViT3BmDjj/LeEHm8osAIkrjK1Jk6liA
 fVDNwCVMYjJQlqlcGstUXe5v3qvTENyKtHT9D5XY58qngF9CZVJ3QhKYJjDznVslV+PNiW
 FBttF1ZbrqqPyrs+p4zyCqwlYX/av4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-_YpH8kkLP1WXAotjkdH5TQ-1; Thu, 07 May 2020 13:40:41 -0400
X-MC-Unique: _YpH8kkLP1WXAotjkdH5TQ-1
Received: by mail-wm1-f69.google.com with SMTP id h184so3819863wmf.5
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8GZ9evEjqSbQp71zi/MCbGrxdqesaAm1q8b0adEaVIA=;
 b=ETHgveNAY3BmbF/Qd9YweuevFaQmBOmfe9Da3/1HjxSnqW5Nd4Q+KFgkOubT5kpT8q
 azWH8J7iN4rQwBJxC4SyqgrfkoWYd8xJFlYjcIAkjAocNXVx9fh2XY1H4KD1mBmq7rxr
 x59FYH3i3NaRGWAKj/95F3OS2ZdLHj/3TWHkIzpFu3RBasFia6ss4ho8nvaROAa6YPQE
 AxvhNRZfyo2e/xB2WOzfghH/iTQ+V/hJDRDV2zODr2jjXH/Pcwf9vFBeZvWyHWIS0k9+
 BomSXOoQTxK9SDWBonGY6EhJIAbJqHaaDKpjKBV01yJWf8mi6Dqn/buAi0BZDb+B6vaF
 VDIA==
X-Gm-Message-State: AGi0PuZVDRZnqyvNZcLbz9oJKQqreW4KcwlXtgQVGNKfxTAjDFh2Rv9C
 eJzg/JyiE8JFy9Vv35qnRfDAEPFG/drGh4pXDoiVtYanmR1kGc5abiZHbbJn2S36Wmnn1oE43B8
 ZvvD2bBNWIQ9pXD4=
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr4544925wmi.15.1588873240732; 
 Thu, 07 May 2020 10:40:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLSBpY37naOL9t4hrxGVypcm4L6awh25/jHiKIkWfDIJaw3sqjnYKe/o6M9skN5Zo6pP3sGYg==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr4544910wmi.15.1588873240502; 
 Thu, 07 May 2020 10:40:40 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z132sm6553880wmc.29.2020.05.07.10.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 06/10] exec: Move ramblock_recv_bitmap_offset() to
 migration/ram.c
Date: Thu,  7 May 2020 19:39:54 +0200
Message-Id: <20200507173958.25894-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ramblock_recv_bitmap_offset() function is only used once
in migration/ram.c, move it there.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ram_addr.h | 8 --------
 migration/ram.c         | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 195b67d3c8..c61d5188f7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -83,14 +83,6 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_ad=
dr_t offset)
     return (char *)block->host + offset;
 }
=20
-static inline unsigned long int ramblock_recv_bitmap_offset(void *host_add=
r,
-                                                            RAMBlock *rb)
-{
-    uint64_t host_addr_offset =3D
-            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
-    return host_addr_offset >> TARGET_PAGE_BITS;
-}
-
 bool ramblock_is_pmem(RAMBlock *rb);
=20
 /**
diff --git a/migration/ram.c b/migration/ram.c
index 53166fc279..0cd16d0519 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -190,6 +190,14 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, v=
oid *opaque)
     return ret;
 }
=20
+static inline unsigned long int ramblock_recv_bitmap_offset(void *host_add=
r,
+                                                            RAMBlock *rb)
+{
+    uint64_t host_addr_offset =3D
+            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
+    return host_addr_offset >> TARGET_PAGE_BITS;
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
--=20
2.21.3


