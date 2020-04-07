Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B2C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAF920719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ6u0D3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAF920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLouJ-0002AM-Rf
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLotR-0000XT-NS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLotQ-000137-6p
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31061
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLotP-00011V-Un
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586268475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRLWXRytzTGVO0r/GudLCTGjNoCUKmXsKyZKPig2BiY=;
 b=MQ6u0D3Y/BJmx5f7Ahjl7hoJR1NzXtXq3nVmgJDIS2lJb7+h+5ct9Z2RUGxQopG95GM2Jx
 3RzJl7Ke8jT1x88v5uDqoaI9jW/L3LWTMgCnly4b+Yy3x0P6k6EhKFyZvFdVkfXJCcbiDo
 DjQPewgkNhPETW5Ds5cAFx8dLuukKIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-xn0n26WHNKC0s4Vj2PZjmA-1; Tue, 07 Apr 2020 10:07:53 -0400
X-MC-Unique: xn0n26WHNKC0s4Vj2PZjmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7B618A8C94;
 Tue,  7 Apr 2020 14:07:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5341A5C1BB;
 Tue,  7 Apr 2020 14:07:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] rcu: do not mention atomic_mb_read/set in documentation
Date: Tue,  7 Apr 2020 10:07:44 -0400
Message-Id: <20200407140746.8041-4-pbonzini@redhat.com>
In-Reply-To: <20200407140746.8041-1-pbonzini@redhat.com>
References: <20200407140746.8041-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fangying1@huawei.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rcu.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.txt
index d83fed2f79..0ce15ba198 100644
--- a/docs/devel/rcu.txt
+++ b/docs/devel/rcu.txt
@@ -132,7 +132,7 @@ The core RCU API is small:
=20
      typeof(*p) atomic_rcu_read(p);
=20
-        atomic_rcu_read() is similar to atomic_mb_read(), but it makes
+        atomic_rcu_read() is similar to atomic_load_acquire(), but it make=
s
         some assumptions on the code that calls it.  This allows a more
         optimized implementation.
=20
@@ -154,7 +154,7 @@ The core RCU API is small:
=20
      void atomic_rcu_set(p, typeof(*p) v);
=20
-        atomic_rcu_set() is also similar to atomic_mb_set(), and it also
+        atomic_rcu_set() is similar to atomic_store_release(), though it a=
lso
         makes assumptions on the code that calls it in order to allow a mo=
re
         optimized implementation.
=20
--=20
2.18.2



