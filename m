Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE9BC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DC620674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsYS+E1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DC620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxIM-00042p-O0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGw-0002H5-Ef
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxGv-0008HN-CU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxGv-0008C5-7O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPff1aAq5h+xYYQS6oaEMbpCVwyAPpdhhSZnmMWHIeg=;
 b=DsYS+E1CJSa1GCi3c2xFaFk2xhV2TOHClVQYQuOVVaJF3Xs1SJCQUyIgD1fKOO16HSNxS8
 y+kG0doUl48sGb9l6zPQEEQzU/KCFnMVMN7WaOw9h+LOyLZHR1qtTKP5ZzODIVGP0ROTgU
 gV3/AnH+9hIydm/G8rjsznyBfiCzbrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-GxPavsXNPDuXSH_mo5eF-g-1; Mon, 16 Mar 2020 17:27:38 -0400
X-MC-Unique: GxPavsXNPDuXSH_mo5eF-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE34107ACC9;
 Mon, 16 Mar 2020 21:27:37 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C9D819756;
 Mon, 16 Mar 2020 21:27:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/61] optionrom/pvh: scan entire RSDP Area
Date: Mon, 16 Mar 2020 22:26:29 +0100
Message-Id: <1584394048-44994-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Joe Richey <joerichey@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joe Richey <joerichey@google.com>

Right now the PVH option rom scans for the RSDP from 0xE0000 to
0xE1FFF. This is probobly a typo, it should scan from 0xE0000 to
0xFFFFF.

This is actually an issue on some QEMU versions/machines. For example,
when I run QEMU the RSDP is placed at 0xf5ad0 which will not be picked
up by the current implementation.

This bug still allows a Linux guest to boot (in most configurations) as
the kernel will just scan for the RSDP if one isn't provided.

Signed-off-by: Joe Richey <joerichey@google.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Fixes: 2785dc7b17 ("optionrom: add new PVH option rom")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/pvh_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
index a015e1b..28e79d7 100644
--- a/pc-bios/optionrom/pvh_main.c
+++ b/pc-bios/optionrom/pvh_main.c
@@ -29,7 +29,7 @@ asm (".code32"); /* this code will be executed in protect=
ed mode */
=20
 #define RSDP_SIGNATURE          0x2052545020445352LL /* "RSD PTR " */
 #define RSDP_AREA_ADDR          0x000E0000
-#define RSDP_AREA_SIZE          2048
+#define RSDP_AREA_SIZE          0x00020000
 #define EBDA_BASE_ADDR          0x0000040E
 #define EBDA_SIZE               1024
=20
--=20
1.8.3.1



