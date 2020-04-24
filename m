Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7112C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7745F2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDJtsw69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7745F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRsWI-0008Pc-FA
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 03:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsV9-0006l4-D9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsV8-0001pO-OH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRsV8-0001nG-Aa
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587712313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80XR/xJdkiaSsUBlAUPNI1WZu7i2xH3uYzIz8nK16JE=;
 b=DDJtsw69uiP0kes9IFnkBkYzLHVJUOKD+BpsY7TrOEPJhFwGPLOt+5tq5xj2WEsE4zJJ4n
 ofQIaiEEC3NM8kp+VdNuUfUIft6JS0Aibjt1TejU8TzavbPA7rYPSrx7iEmfvfGB82HE7e
 avgijx+6K3Xs+rR7PrEV55SALjGlUmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-xuRwQdfzOEORcbTBR9QT0g-1; Fri, 24 Apr 2020 03:11:51 -0400
X-MC-Unique: xuRwQdfzOEORcbTBR9QT0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FF3835B42;
 Fri, 24 Apr 2020 07:11:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 934DC60300;
 Fri, 24 Apr 2020 07:11:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06DED11358BD; Fri, 24 Apr 2020 09:11:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] Makefile: Drop unused, broken target recurse-fuzz
Date: Fri, 24 Apr 2020 09:11:40 +0200
Message-Id: <20200424071142.3525-2-armbru@redhat.com>
In-Reply-To: <20200424071142.3525-1-armbru@redhat.com>
References: <20200424071142.3525-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, thuth@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Target recurse-fuzz depends on pc-bios/optionrom/fuzz, which can't be
made.  It's not used anywhere.  Added in commit c621dc3e01c, looks
like cargo cult.  Delete.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a9113e666..34275f57c9 100644
--- a/Makefile
+++ b/Makefile
@@ -582,7 +582,6 @@ $(ROM_DIRS_RULES):
=20
 .PHONY: recurse-all recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
--=20
2.21.1


