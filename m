Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34254C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F031F2464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ppr67Agj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F031F2464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icoY7-0003Ny-52
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icoXA-0002tq-UB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icoX7-0005SU-Vg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:38:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icoX7-0005P1-L1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575542332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NvXYUt3kbX50wTTHWvyKFSs9y84c4dcAN3RWzUhoSTI=;
 b=Ppr67AgjCxDC20Fdg+Sv65AxvjMjzzYOrYK0jzzOmVvEH3HLSixx6hXNMvUBHjQNxGPZfD
 cHsfKtawZJDifLeHtqe/bRzXPnXIEzIVEnwzPhomKuJCQiKVgeQqSCZvYWtRISJm0dNazk
 +WlG6E3L80e6s3ouyFY5eVWE+CDwXe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-26j_tc35PTy7BPl_ZFAieQ-1; Thu, 05 Dec 2019 05:38:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38C99801E72;
 Thu,  5 Dec 2019 10:38:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1C5600F0;
 Thu,  5 Dec 2019 10:38:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
Subject: [PATCH] s390x/tcg: clear local interrupts on reset normal
Date: Thu,  5 Dec 2019 11:38:44 +0100
Message-Id: <20191205103844.10404-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 26j_tc35PTy7BPl_ZFAieQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We neglected to clean up pending interrupts and emergency signals;
fix that.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Noted while looking at the fixes for the kvm reset handling.

We now clear some fields twice in the paths for clear or initial reset;
but (a) we already do that for other fields and (b) it does not really
hurt. Maybe we should give the cpu structure some love in the future,
as it's not always clear whether some fields are tcg only.

---
 target/s390x/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 829ce6ad5491..f2572961dc3a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -133,6 +133,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type =
type)
     case S390_CPU_RESET_NORMAL:
         env->pfault_token =3D -1UL;
         env->bpbc =3D false;
+        env->pending_int =3D 0;
+        env->external_call_addr =3D 0;
+        bitmap_zero(env->emergency_signals, S390_MAX_CPUS);
         break;
     default:
         g_assert_not_reached();
--=20
2.21.0


