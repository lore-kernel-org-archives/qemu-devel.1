Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37236C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E5B20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gifKuGnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E5B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59165 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwDZ-0004K2-RM
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1igwCU-000378-Ui
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1igwCS-0001W4-Vf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1igwCS-0001Vt-ST
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576525116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juymJHEO7Dq1mNyWmoAiZX/S+P7Tk+Bgtm+EHc4pPGI=;
 b=gifKuGnhMH30NX94jFX7p66guD7/xXxTuq+8hfGaMtx2X9EMwMEZhz+83tlZGxsPVinQvl
 JaL+h/GaM0wCnol32T7UBIHAslE3NgjCCb6zs7WMlfpGgNyxtKV/q1rWdIcfZ6gYy9Jh11
 srGhddXur05E0WB2d09ZNwcSwKRHXG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-wstoBMZJMHykNMIz9Hw_IA-1; Mon, 16 Dec 2019 14:38:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B13D107ACC5;
 Mon, 16 Dec 2019 19:38:33 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87DEC60BE0;
 Mon, 16 Dec 2019 19:38:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/4] i386: Add MSR feature bit for MDS-NO
Date: Mon, 16 Dec 2019 16:38:22 -0300
Message-Id: <20191216193825.1794153-2-ehabkost@redhat.com>
In-Reply-To: <20191216193825.1794153-1-ehabkost@redhat.com>
References: <20191216193825.1794153-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wstoBMZJMHykNMIz9Hw_IA-1
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

Define MSR_ARCH_CAP_MDS_NO in the IA32_ARCH_CAPABILITIES MSR to allow
CPU models to report the feature when host supports it.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <1571729728-23284-2-git-send-email-cathy.zhang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b94..39d37e1225 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -838,6 +838,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define MSR_ARCH_CAP_RSBA       (1U << 2)
 #define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
 #define MSR_ARCH_CAP_SSB_NO     (1U << 4)
+#define MSR_ARCH_CAP_MDS_NO     (1U << 5)
=20
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
=20
--=20
2.23.0


