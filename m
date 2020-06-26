Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F8EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F42076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGDt8GyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joimL-0007QJ-No
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joiiZ-0000Jb-0K
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joiiV-0003Sc-30
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593156246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYlfhj1OTPEaIzcBYdA05uMy9bmVrgsPwAVJjLsnp5k=;
 b=BGDt8GyOmwlqM63xhOoI5GUaMBy1eJeHNZqj6/+TTSnqy9haN6/kI2QH0D+trsUds8YcCz
 Wn9meynsTxyDjSN4OSyzILwhSyAwlRGqX8VOBr6iM+y4cPQ7rWN8IwZTIMJJwdgmUWJP72
 7Sh1wpnyVj7GlAXlVnuA0BtTcFXdlTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-7Jh82G8aOGGxlw28373TdA-1; Fri, 26 Jun 2020 03:24:04 -0400
X-MC-Unique: 7Jh82G8aOGGxlw28373TdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D9E1005512;
 Fri, 26 Jun 2020 07:24:03 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-35.ams2.redhat.com [10.36.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 310241C8;
 Fri, 26 Jun 2020 07:23:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/21] target/i386: sev: Use ram_block_discard_disable()
Date: Fri, 26 Jun 2020 09:22:34 +0200
Message-Id: <20200626072248.78761-8-david@redhat.com>
In-Reply-To: <20200626072248.78761-1-david@redhat.com>
References: <20200626072248.78761-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AMD SEV will pin all guest memory, mark discarding of RAM broken. At the
time this is called, we cannot have anyone active that relies on discards
to work properly - let's still implement error handling.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/i386/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d273174ad3..f100a53231 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -680,6 +680,12 @@ sev_guest_init(const char *id)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
+    ret = ram_block_discard_disable(true);
+    if (ret) {
+        error_report("%s: cannot disable RAM discard", __func__);
+        return NULL;
+    }
+
     sev = lookup_sev_guest_info(id);
     if (!sev) {
         error_report("%s: '%s' is not a valid '%s' object",
@@ -751,6 +757,7 @@ sev_guest_init(const char *id)
     return sev;
 err:
     sev_guest = NULL;
+    ram_block_discard_disable(false);
     return NULL;
 }
 
-- 
2.26.2


