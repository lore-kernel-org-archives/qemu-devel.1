Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC0C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820222087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8Gkxlio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820222087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1Wv-0001L8-JV
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iz1VJ-0007uP-7A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iz1VI-0007SB-0Y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:56:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iz1VH-0007LM-T3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580835406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fvuGOYSEUPH9fg7mO8L9rN+Jrg9eS4ABkoOSqwkjJMc=;
 b=P8Gkxlio2sLgP/ZxLu9WO8Md23tMmJNRJRGwhTwg68KsjB7saxqCNsYxLF6hG+Ap6QYe9b
 +C9e07qNu9aqt9ktDypg5/9x/otsPriVU29g5Bz0qzj8H1kR56P6E5aehm3wHHhU/ty2Ln
 n8mjH3Ue0KBPUrgbbT1RHGaxKFPI9IQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Kf8vouuyOSSAeGUu1iVQxA-1; Tue, 04 Feb 2020 11:56:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C07108442D;
 Tue,  4 Feb 2020 16:56:43 +0000 (UTC)
Received: from probe.redhat.com (ovpn-125-154.rdu2.redhat.com [10.10.125.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF20E5C1D4;
 Tue,  4 Feb 2020 16:56:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-options: replace constant 1 with HAS_ARG
Date: Tue,  4 Feb 2020 11:56:38 -0500
Message-Id: <20200204165638.25051-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Kf8vouuyOSSAeGUu1iVQxA-1
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
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, John Snow <jsnow@redhat.com>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only instance of a non-zero constant not using a symbolic
constant.
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 224a8e8712..ff3e806977 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1955,7 +1955,7 @@ STEXI
 Start in full screen.
 ETEXI
=20
-DEF("g", 1, QEMU_OPTION_g ,
+DEF("g", HAS_ARG, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
     QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
 STEXI
--=20
2.21.0


