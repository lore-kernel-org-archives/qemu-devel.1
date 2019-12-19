Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EFB24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRes72Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EFB24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtbz-0002HB-Bp
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtYp-0006mw-Ii
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtYo-0000uN-AQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtYo-0000k3-3o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GN3BOXoY+K3lCkpEd8ZedRLEqb9ptuEu3tYT9xjH8uM=;
 b=XRes72Eeq1BEbucKhXMN6vdCLebZTraWFji+QEDcYym911XdU9INGmef3PA1bm5aUrJpG6
 WniLMA8wQ7ReYqyBkZFsESnJmXU7sxowKZnBdrIeJteSya90MYJOisMbtSdBScHqC+bdq2
 b9krM5GN7YpgCOpKCUqp5L1izanKAz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-LvIVz8PuNqazKSncH7aZ6w-1; Thu, 19 Dec 2019 06:01:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40FA9190D349;
 Thu, 19 Dec 2019 11:01:33 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D45AE675B8;
 Thu, 19 Dec 2019 11:01:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/6] pc-bios/s390x: Fix reset psw mask
Date: Thu, 19 Dec 2019 12:01:10 +0100
Message-Id: <20191219110112.8343-5-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
References: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LvIVz8PuNqazKSncH7aZ6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

We need to set the short psw indication bit in the reset psw, as it is
a short psw.

Exposed by "s390x: Properly fetch and test the short psw on diag308
subc 0/1".

Fixes: 962982329029 ("pc-bios/s390-ccw: do a subsystem reset before running=
 the guest")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20191203132813.2734-5-frankja@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 266f1502b967..da13c43cc047 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -12,11 +12,11 @@
 #define KERN_IMAGE_START 0x010000UL
 #define PSW_MASK_64 0x0000000100000000ULL
 #define PSW_MASK_32 0x0000000080000000ULL
-#define IPL_PSW_MASK (PSW_MASK_32 | PSW_MASK_64)
+#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
+#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
=20
 typedef struct ResetInfo {
-    uint32_t ipl_mask;
-    uint32_t ipl_addr;
+    uint64_t ipl_psw;
     uint32_t ipl_continue;
 } ResetInfo;
=20
@@ -50,7 +50,9 @@ void jump_to_IPL_code(uint64_t address)
     ResetInfo *current =3D 0;
=20
     save =3D *current;
-    current->ipl_addr =3D (uint32_t) (uint64_t) &jump_to_IPL_2;
+
+    current->ipl_psw =3D (uint64_t) &jump_to_IPL_2;
+    current->ipl_psw |=3D RESET_PSW_MASK;
     current->ipl_continue =3D address & 0x7fffffff;
=20
     debug_print_int("set IPL addr to", current->ipl_continue);
@@ -82,7 +84,7 @@ void jump_to_low_kernel(void)
     }
=20
     /* Trying to get PSW at zero address */
-    if (*((uint64_t *)0) & IPL_PSW_MASK) {
+    if (*((uint64_t *)0) & RESET_PSW_MASK) {
         jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
     }
=20
--=20
2.21.0


