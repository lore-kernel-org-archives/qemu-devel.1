Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40923C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D302146E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+v51Uky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D302146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwDh-0004Y7-0S
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1igwCZ-0003Dj-8k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1igwCY-0001iu-4o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1igwCY-0001hp-1a
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576525121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awU1QKKLg8eVSkA+topw8q8tnD6Jtyr7XMVPpT/Xrko=;
 b=Z+v51UkygdEBrRX1N+CI7SOGQXBMXTHvUStxvzI2pufEssNnwW393z4zVR0aoEPO0f3T/m
 ALDi44ogTBGqgdgDGSzdN3Gkw/QH0yKtSY6WvKJbmIIPh61rjlJY/AVPsCFHDImaIBZW7b
 mhFc6AzOPY5OLl8DJ9/jVXE8agbbVwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-c1Jg1C6GPEiU7cjvA-ILWQ-1; Mon, 16 Dec 2019 14:38:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 957648017DF;
 Mon, 16 Dec 2019 19:38:38 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26540381;
 Mon, 16 Dec 2019 19:38:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/4] i386: Add macro for stibp
Date: Mon, 16 Dec 2019 16:38:23 -0300
Message-Id: <20191216193825.1794153-3-ehabkost@redhat.com>
In-Reply-To: <20191216193825.1794153-1-ehabkost@redhat.com>
References: <20191216193825.1794153-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c1Jg1C6GPEiU7cjvA-ILWQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cathy Zhang <cathy.zhang@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cathy Zhang <cathy.zhang@intel.com>

stibp feature is already added through the following commit.
https://github.com/qemu/qemu/commit/0e8916582991b9fd0b94850a8444b8b80d0a095=
5

Add a macro for it to allow CPU models to report it when host supports.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <1571729728-23284-3-git-send-email-cathy.zhang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 39d37e1225..af282936a7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -771,6 +771,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
 /* Speculation Control */
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
+/* Single Thread Indirect Branch Predictors */
+#define CPUID_7_0_EDX_STIBP             (1U << 27)
 /* Arch Capabilities */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)
 /* Core Capability */
--=20
2.23.0


