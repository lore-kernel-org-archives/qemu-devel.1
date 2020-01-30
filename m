Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC17EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D532063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmkEmYbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D532063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9yT-0001Z0-Or
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ix9xp-0001A0-5U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ix9xn-0003B1-TY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:34:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ix9xn-0003AH-QM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580391271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uz+5CoGd99CGAytNffZG4M2b0ELVSOjDvFez/NLXXvA=;
 b=BmkEmYbdbh7i4NEUUVw8EXdj6K5+ILFUm9q2rE5OYnFAIcBjCL2v1nhkUGhgeyjXCFhtyc
 42AZvZ/mH0VZDdwFYkKBH6RBFK/G0JzQE5ssEfiP4RdxmgapLgRUDW/bGUjc5Fgs8wvSol
 glRxVRaSEsjWFzVaP/qPzb/ud0A1dU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-8D5F_nhsNNK8mkzDG0htHw-1; Thu, 30 Jan 2020 08:34:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09FCE1403;
 Thu, 30 Jan 2020 13:34:25 +0000 (UTC)
Received: from thuth.com (ovpn-117-117.ams2.redhat.com [10.36.117.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1728660C84;
 Thu, 30 Jan 2020 13:34:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH] target/s390x/translate: Fix RNSBG instruction
Date: Thu, 30 Jan 2020 14:34:17 +0100
Message-Id: <20200130133417.10531-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8D5F_nhsNNK8mkzDG0htHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RNSBG is handled via the op_rosbg() helper function. But RNSBG has
the opcode 0xEC54, i.e. 0x54 as second byte, while op_rosbg() currently
checks for 0x55. This seems to be a typo, fix it to use 0x54 instead,
so that op_rosbg() does not abort() anymore if a program uses RNSBG.

I've checked with a simply test function that I now get the same results
with KVM and with TCG:

 static void test_rnsbg(void)
 {
=09uint64_t r1, r2;

=09r2 =3D 0xffff000000000000UL;
=09r1 =3D 0x123456789bdfaaaaUL;
=09asm volatile (" rnsbg %0,%1,12,61,16 " : "+r"(r1) : "r"(r2));

=09printf("r1 afterwards: 0x%lx\n", r1);
 }

Buglink: https://bugs.launchpad.net/qemu/+bug/1860920
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 0bd2073718..4f6f1e31cd 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3874,7 +3874,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasO=
ps *o)
=20
     /* Operate.  */
     switch (s->fields.op2) {
-    case 0x55: /* AND */
+    case 0x54: /* AND */
         tcg_gen_ori_i64(o->in2, o->in2, ~mask);
         tcg_gen_and_i64(o->out, o->out, o->in2);
         break;
--=20
2.18.1


