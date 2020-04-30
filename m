Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B172EC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797032082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wmx5Qpt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797032082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5lu-0007Zj-Hv
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5km-0005iR-1j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kl-0002u3-7Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5kk-0002tZ-QX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwQ/OeGY6Ptl5tK+cFbboAmdsz5+gAikP0NdjvwGUI8=;
 b=Wmx5Qpt05UvJuxj5VuC+v1W7K4iCY47qz2NNeMpAQhNFH0eupvAyb1CNlhHgxyZrTKPCRl
 t473GjgAcpEi/5MiblJDW/Run86eyQ7XCezBcW+mtZt8HGMPTAow7T1PQszl1PDmGp/AHu
 0nRWGpHW5lYK+ey8Vju50wKHuVy0Xfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-3sWtF1D_OQSv1c1R8k3Vbw-1; Thu, 30 Apr 2020 05:45:07 -0400
X-MC-Unique: 3sWtF1D_OQSv1c1R8k3Vbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A10B6835B41;
 Thu, 30 Apr 2020 09:45:06 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6DED1C950;
 Thu, 30 Apr 2020 09:45:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/20] s390x: Move diagnose 308 subcodes and rcs into ipl.h
Date: Thu, 30 Apr 2020 11:44:28 +0200
Message-Id: <20200430094445.25943-4-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

They are part of the IPL process, so let's put them into the ipl
header.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200319131921.2367-2-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.h      | 11 +++++++++++
 target/s390x/diag.c | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 3e44abe1c651..a5665e6bfde2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -159,6 +159,17 @@ struct S390IPLState {
 typedef struct S390IPLState S390IPLState;
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wr=
ong");
=20
+#define DIAG_308_RC_OK              0x0001
+#define DIAG_308_RC_NO_CONF         0x0102
+#define DIAG_308_RC_INVALID         0x0402
+
+#define DIAG308_RESET_MOD_CLR       0
+#define DIAG308_RESET_LOAD_NORM     1
+#define DIAG308_LOAD_CLEAR          3
+#define DIAG308_LOAD_NORMAL_DUMP    4
+#define DIAG308_SET                 5
+#define DIAG308_STORE               6
+
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 54e5670b3fd6..8aba6341f948 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -49,17 +49,6 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uin=
t64_t r3)
     return diag288_class->handle_timer(diag288, func, timeout);
 }
=20
-#define DIAG_308_RC_OK              0x0001
-#define DIAG_308_RC_NO_CONF         0x0102
-#define DIAG_308_RC_INVALID         0x0402
-
-#define DIAG308_RESET_MOD_CLR       0
-#define DIAG308_RESET_LOAD_NORM     1
-#define DIAG308_LOAD_CLEAR          3
-#define DIAG308_LOAD_NORMAL_DUMP    4
-#define DIAG308_SET                 5
-#define DIAG308_STORE               6
-
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t ad=
dr,
                               uintptr_t ra, bool write)
 {
--=20
2.21.1


