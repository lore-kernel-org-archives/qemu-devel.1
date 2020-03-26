Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC5CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4D020714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCKuqMy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4D020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHW0a-0002Ze-J0
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHVzO-0001aa-Ag
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHVzM-0003F0-FD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:08:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHVzM-0003Dw-80
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585242495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yzwQQY8P0vqqev25+cuAzypnx4ZAy2PAsI1HzOaH5SA=;
 b=fCKuqMy0OzmupXbXknyZxK+3rer4ax276Q1eYjIL+O4nudY/ZmUjtclW2Wt7EBP8xrUr01
 WlR8whQjDvo/1EsCP/Iol8tTUwJx2RwoyeK+cxM4rfSiJBrvWUrjK9hYpTd7Rx4PQGTF/F
 CrgQKye1z73Sfd0WxZ4Bs+sEgKumf74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-bdC00XYhPi25LjN-dAk3zQ-1; Thu, 26 Mar 2020 13:08:13 -0400
X-MC-Unique: bdC00XYhPi25LjN-dAk3zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B9D0800D5C;
 Thu, 26 Mar 2020 17:08:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-205.ams2.redhat.com
 [10.36.112.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79433101D482;
 Thu, 26 Mar 2020 17:08:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] qcow2: Remove unused fields from BDRVQcow2State
Date: Thu, 26 Mar 2020 18:07:57 +0100
Message-Id: <20200326170757.12344-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These fields were already removed in commit c3c10f72, but then commit
b58deb34 revived them probably due to bad merge conflict resolution.
They are still unused, so remove them again.

Fixes: b58deb344ddff3b9d8b265bf73a65274767ee5f4
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 0942126232..f4de0a27d5 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -301,9 +301,6 @@ typedef struct BDRVQcow2State {
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;
=20
-    uint8_t *cluster_cache;
-    uint8_t *cluster_data;
-    uint64_t cluster_cache_offset;
     QLIST_HEAD(, QCowL2Meta) cluster_allocs;
=20
     uint64_t *refcount_table;
--=20
2.20.1


