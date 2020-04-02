Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B44C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3260B20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjUYJQeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3260B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5Fx-0002kR-AY
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0002R9-22
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5Ay-0000Kr-22
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57074
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5Ax-0000Kd-UY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1G5bVnPSpqOFZhuC7mRGX6s1v8ile8pX/juVa9Lw3ZA=;
 b=RjUYJQeIJXCZkSQ0PY4WNLrkrZ4IMQghupDaAg4FSKdOuZi5MYOq2V6Fion2Ib/4xceqP5
 aq47wUJzNLdglaiQ34BXK6HhXAyC3O01xoQ1u4A72Hj/ve4dpro3zf3u4xyl+0ZbasVN5G
 UhwlM3DcJadsb9lqfguKl73VoVmeC5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-sg6b8JHCOmimJr0BexzOjg-1; Thu, 02 Apr 2020 15:06:49 -0400
X-MC-Unique: sg6b8JHCOmimJr0BexzOjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33838107ACC9;
 Thu,  2 Apr 2020 19:06:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6030DA0F2;
 Thu,  2 Apr 2020 19:06:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] util/bufferiszero: assign length_to_accel value for each
 accelerator case
Date: Thu,  2 Apr 2020 15:06:31 -0400
Message-Id: <20200402190640.1693-7-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

Because in unit test, init_accel() will be called several times, each with
different accelerator type.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/bufferiszero.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 663903553a..b8012532e4 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -254,13 +254,16 @@ static void init_accel(unsigned cache)
     bool (*fn)(const void *, size_t) =3D buffer_zero_int;
     if (cache & CACHE_SSE2) {
         fn =3D buffer_zero_sse2;
+        length_to_accel =3D 64;
     }
 #ifdef CONFIG_AVX2_OPT
     if (cache & CACHE_SSE4) {
         fn =3D buffer_zero_sse4;
+        length_to_accel =3D 64;
     }
     if (cache & CACHE_AVX2) {
         fn =3D buffer_zero_avx2;
+        length_to_accel =3D 64;
     }
 #endif
 #ifdef CONFIG_AVX512F_OPT
--=20
2.18.2



