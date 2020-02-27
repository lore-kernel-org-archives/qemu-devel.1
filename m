Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F09DC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01D724695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg2Tnz77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01D724695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hno-0004Nc-3E
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7Hkp-00089I-6Z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7Hko-0001ID-5E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7Hko-0001G8-1M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582804497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bwcm6KMu5WlnA5wdfgUC+xkYru81JSdUvWZH5P60CxE=;
 b=Wg2Tnz77gcpkAsuf89cRkWUucicGelA98sXXXP6DGQjkJ0Ry8cifFAdMFHSMq8ZYRl4ilv
 5ME9PjJJ1cmyD+q7PExA253S368FfV4pg6ClUraVCqd/WoFSvA89/duCG1A7gi4K0sgrMu
 CjDQ33nUOzUrVzDCB/rkmfmkC/4PmvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-b8nGggV_PpG4iReJeHbNIg-1; Thu, 27 Feb 2020 06:54:53 -0500
X-MC-Unique: b8nGggV_PpG4iReJeHbNIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16CF800D48;
 Thu, 27 Feb 2020 11:54:51 +0000 (UTC)
Received: from localhost (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E75B101D487;
 Thu, 27 Feb 2020 11:54:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/7] s390/sclp: improve special wait psw logic
Date: Thu, 27 Feb 2020 12:54:28 +0100
Message-Id: <20200227115431.32364-5-cohuck@redhat.com>
In-Reply-To: <20200227115431.32364-1-cohuck@redhat.com>
References: <20200227115431.32364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

There is a special quiesce PSW that we check for "shutdown". Otherwise disa=
bled
wait is detected as "crashed". Architecturally we must only check PSW bits
116-127. Fix this.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1582204582-22995-1-git-send-email-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index b810ad431e44..ed726849114f 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -89,7 +89,7 @@ hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v=
addr)
 static inline bool is_special_wait_psw(uint64_t psw_addr)
 {
     /* signal quiesce */
-    return psw_addr =3D=3D 0xfffUL;
+    return (psw_addr & 0xfffUL) =3D=3D 0xfffUL;
 }
=20
 void s390_handle_wait(S390CPU *cpu)
--=20
2.21.1


