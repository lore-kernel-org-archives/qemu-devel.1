Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04B4C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A474120663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRYPZxRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A474120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENMe-0005KQ-RD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLJ-0003sG-GU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLI-0000NZ-G0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLI-0000N0-CS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CK5kzJ8d8O/59rh7LEbO3PEtQpsX5CEGwc3ZD2EiWog=;
 b=GRYPZxRLTIyfCafhbFCPZtPMLAiyF40oSnrl7DvIFn5hGwsSEIeSy9V8ZFIKk5e74F6mX0
 LUYvduTdmB35SZ3NHwgo67c0mhaKNXDevPAl+vdemON17LpytVTGctT5HQQa+yBZr8Wvne
 KJPAnfTBNuMkoMbbYG4vMkxiBMJ1Cyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-i-Xv86HyNEKb93M2Fw5RgA-1; Tue, 17 Mar 2020 21:17:54 -0400
X-MC-Unique: i-Xv86HyNEKb93M2Fw5RgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C721E477;
 Wed, 18 Mar 2020 01:17:52 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBFD1001938;
 Wed, 18 Mar 2020 01:17:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/13] target/i386: Add Denverton-v2 (no MPX) CPU model
Date: Tue, 17 Mar 2020 21:17:36 -0400
Message-Id: <20200318011748.2104336-2-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Because MPX is being removed from the linux kernel, remove MPX feature
from Denverton.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20200212081328.7385-2-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa2659..c3b5cf1369 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3592,6 +3592,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Atom Processor (Denverton)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                .props =3D (PropValue[]) {
+                    { "monitor", "off" },
+                    { "mpx", "off" },
+                    { /* end of list */ },
+                },
+            },
+            { /* end of list */ },
+        },
     },
     {
         .name =3D "Snowridge",
--=20
2.24.1


