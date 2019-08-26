Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED3C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF322087E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF322087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i29sa-0007PD-NR
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 03:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i29nA-0000Ed-9c
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i29n8-0002uZ-7b
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i29n8-0002uJ-2l; Mon, 26 Aug 2019 03:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 571B1C058CA4;
 Mon, 26 Aug 2019 07:51:53 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE3A6CE58;
 Mon, 26 Aug 2019 07:51:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 09:51:12 +0200
Message-Id: <20190826075112.25637-8-david@redhat.com>
In-Reply-To: <20190826075112.25637-1-david@redhat.com>
References: <20190826075112.25637-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 26 Aug 2019 07:51:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/7] s390x/tcg: Pass a size to probe_write()
 in do_csst()
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

... and also call it for CONFIG_USER_ONLY. This function probably will
also need some refactoring in regards to probing, however, we'll have to
come back to that later, once cleaning up the other mem helpers.

The alignment check always makes sure that the write access falls into a
single page.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index fdff60ce5d..29fcce426e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1443,9 +1443,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_=
t r3, uint64_t a1,
     }
=20
     /* Sanity check writability of the store address.  */
-#ifndef CONFIG_USER_ONLY
-    probe_write(env, a2, 0, mem_idx, ra);
-#endif
+    probe_write(env, a2, 1 << sc, mem_idx, ra);
=20
     /*
      * Note that the compare-and-swap is atomic, and the store is atomic=
,
--=20
2.21.0


