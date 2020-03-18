Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D7CC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892E320663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNLqiC7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892E320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENOf-0008R3-Jr
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLV-00046i-9w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLU-0001M7-0v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLT-0001JV-SL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eZa9tGnyx4UMUgM4w4jYdF3/wPJuRSgyMAtCXfsWWo=;
 b=CNLqiC7hQKMxnkdkhM9RbNw5eNW5hdfT3dEUjW3dqCoyIAeG5GRhj0nn+MK51V3wn9C8Np
 db9dc5rzRKmQqkUHTq4wD6ZQ8SjnZ9UE8VD2M2BKMGWCbnmtejP5sGEQNFPzY4uTzOgYet
 ZMQCZls2dsO1Gex0SfwcRhakG/9tcyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ALIwUM0VPG6SGfxMgsGqZw-1; Tue, 17 Mar 2020 21:18:05 -0400
X-MC-Unique: ALIwUM0VPG6SGfxMgsGqZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74B29477;
 Wed, 18 Mar 2020 01:18:04 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1366873865;
 Wed, 18 Mar 2020 01:18:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/13] machine/memory encryption: Disable mem merge
Date: Tue, 17 Mar 2020 21:17:41 -0400
Message-Id: <20200318011748.2104336-7-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When a host is running with memory encryption, the memory isn't visible
to the host kernel; attempts to merge that memory are futile because
what it's really comparing is encrypted memory, usually encrypted
with different keys.

Automatically turn mem-merge off when memory encryption is specified.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1796356

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200130175046.85850-1-dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036f..4778bc6b08 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -425,6 +425,14 @@ static void machine_set_memory_encryption(Object *obj,=
 const char *value,
=20
     g_free(ms->memory_encryption);
     ms->memory_encryption =3D g_strdup(value);
+
+    /*
+     * With memory encryption, the host can't see the real contents of RAM=
,
+     * so there's no point in it trying to merge areas.
+     */
+    if (value) {
+        machine_set_mem_merge(obj, false, errp);
+    }
 }
=20
 static bool machine_get_nvdimm(Object *obj, Error **errp)
--=20
2.24.1


