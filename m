Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54184C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD33E2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB6wY8hI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFvT-0000zB-Ii
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1idEjf-0007I9-Bs
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1idEjY-0007dQ-B2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1idEjS-0007Yp-9P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=64eJGQAg/h+5mo7H9IuqCvQNOWFc3drWrRJVXiaXC8s=;
 b=NB6wY8hI7LiOPWQRweAX+7t314BXFa1cQsHwZGBf30EfEQ/tLGF4MOmjtVX6t5bm3U+wwc
 zROCDPYSQBHDIRpwomsbCqKny7arkwHv15PtLILfFE9/qJoQAIIKDELLpqyeBDdfnutxMA
 7pso/aCM0D78XEIQ4n+q8W2ShPNC84c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-1_XGCQG1OVmYqL9rpEfugg-1; Fri, 06 Dec 2019 01:33:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6113D100551C
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 06:33:44 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-97.bne.redhat.com
 [10.64.54.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40ADF5D9C9;
 Fri,  6 Dec 2019 06:33:42 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] exec: Remove the duplicated check in parse_cpu_option()
Date: Fri,  6 Dec 2019 17:33:37 +1100
Message-Id: <20191206063337.39764-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1_XGCQG1OVmYqL9rpEfugg-1
X-Mimecast-Spam-Score: 0
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
Cc: gshan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The @cpu_option shouldn't be NULL, otherwise assertion from g_strsplit()
should be raised as below message indicates. So it's meaningless to validat=
e
@model_pices[0] in parse_cpu_option() as it shouldn't be NULL either.

   qemu-system-aarch64: GLib: g_strsplit: assertion 'string !=3D NULL' fail=
ed

This just removes the check and unused message.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 exec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/exec.c b/exec.c
index ffdb518535..3cff459e43 100644
--- a/exec.c
+++ b/exec.c
@@ -963,11 +963,6 @@ const char *parse_cpu_option(const char *cpu_option)
     const char *cpu_type;
=20
     model_pieces =3D g_strsplit(cpu_option, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("-cpu option cannot be empty");
-        exit(1);
-    }
-
     oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
     if (oc =3D=3D NULL) {
         error_report("unable to find CPU model '%s'", model_pieces[0]);
--=20
2.23.0


