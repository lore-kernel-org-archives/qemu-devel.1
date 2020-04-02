Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C9AC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF012082F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6UL09wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8Hc-0001be-7t
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8Dc-0002Vj-3A
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8Da-0007kL-UF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8Da-0007jP-Q2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrbPIW5gqhRnCWEkG5j7mbFg1TQSaM8JXVuIcl0GLaI=;
 b=i6UL09wnXKjFTeQtEbDkms5/+2dtnIK2P0rzJmYxUWaV4IiZK5lUEliI5RFvkY+1ZWRD3R
 aqPfliT46tke6z1EIRmLKoXf7ran7trPvD9Q7y9fqelpywT4roxxp4pFJnjdYY7N8Si5vm
 r4w6xi/aAQjJHBpR5oizQ3MT040O8Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-oiR23EhBNQid18D10zwgmQ-1; Thu, 02 Apr 2020 18:21:42 -0400
X-MC-Unique: oiR23EhBNQid18D10zwgmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 425F38018A8;
 Thu,  2 Apr 2020 22:21:41 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52DC089F0A;
 Thu,  2 Apr 2020 22:21:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 9/9] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
Date: Thu,  2 Apr 2020 19:20:51 -0300
Message-Id: <20200402222051.523093-10-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
References: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

Current Icelake-Server CPU model lacks all the features enumerated by
MSR_IA32_ARCH_CAPABILITIES.

Add them, so that guest of "Icelake-Server" can see all of them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20200316095605.12318-1-xiaoyao.li@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3b25c7301..90ffc5f3b1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3471,6 +3471,19 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                     { /* end of list */ }
                 },
             },
+            {
+                .version =3D 3,
+                .props =3D (PropValue[]) {
+                    { "arch-capabilities", "on" },
+                    { "rdctl-no", "on" },
+                    { "ibrs-all", "on" },
+                    { "skip-l1dfl-vmentry", "on" },
+                    { "mds-no", "on" },
+                    { "pschange-mc-no", "on" },
+                    { "taa-no", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
--=20
2.24.1


