Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1934C24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYcgsjEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1934C24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51057 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnmp-0001F1-SZ
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnfd-000184-Ok
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnfc-0002Yp-Nf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnfc-0002WT-JD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6R+tH7lHFJCm0FH/ixXdJNaTFOW/B3rF19L4hUlBtlU=;
 b=CYcgsjEA4vlIMzYCwQ0YcFpXmShm2oIjBSWTEU6l+9312a3+Eh9jq9RmJVf++8OhwhKGAJ
 oY53zmg1VikzoJ1lqbVVU2F8qhaay1ZCEhMN5zuO1cJjvDjPU3gEOQjh3ewC9EwAQVrLZN
 Si5326loJL/nDIDg54QFtJKJJDIjooo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-Aw8PrsvTP1GPqC3AQwjaOA-1; Fri, 13 Dec 2019 11:19:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F31A801E72;
 Fri, 13 Dec 2019 16:19:54 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD3E601B6;
 Fri, 13 Dec 2019 16:19:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/16] s390x/tcg: clear local interrupts on reset normal
Date: Fri, 13 Dec 2019 17:18:50 +0100
Message-Id: <20191213161851.24687-16-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Aw8PrsvTP1GPqC3AQwjaOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We neglected to clean up pending interrupts and emergency signals;
fix that.

Message-Id: <20191206135404.16051-1-cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7e1c18d59696..aa829e954cbf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -98,10 +98,6 @@ struct CPUS390XState {
=20
     uint64_t cregs[16]; /* control registers */
=20
-    int pending_int;
-    uint16_t external_call_addr;
-    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
-
     uint64_t ckc;
     uint64_t cputm;
     uint32_t todpr;
@@ -117,6 +113,10 @@ struct CPUS390XState {
     struct {} start_normal_reset_fields;
     uint8_t riccb[64];     /* runtime instrumentation control */
=20
+    int pending_int;
+    uint16_t external_call_addr;
+    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
=20
--=20
2.21.0


