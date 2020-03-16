Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0690C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6993F20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+8sYLjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6993F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxkm-0007XH-Lu
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxII-0004Y5-SK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIG-0007l2-PT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxIG-0007i4-Ia
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2wF3F3WBpzvnwxC3O9zi1T8Ykf2Sx26HpXYGZHJQto=;
 b=O+8sYLjc+R9DAgvqimwh0aCBCIFXPlf+EDhlm+zA6FVDRx7sEaeufv4QJ59niAMjUOETdE
 pRkoQzIcvlJL3kO95QHhEW8cO+InA6+73E7UsEXvT/HFMxsrNahf96MQZgNLZDkstUa02i
 dkE5n9cg/fQKEDLt4ya7062nzmFQ6cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-4nBALNHUO7iQeEwZaf7FcA-1; Mon, 16 Mar 2020 17:29:02 -0400
X-MC-Unique: 4nBALNHUO7iQeEwZaf7FcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60269149C4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:01 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 683AA19C4F;
 Mon, 16 Mar 2020 21:29:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/61] scripts/cocci: Patch to detect potential use of
 memory_region_init_rom
Date: Mon, 16 Mar 2020 22:27:17 +0100
Message-Id: <1584394048-44994-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add a semantic patch to detect potential replacement of
memory_region_init_ram(readonly) by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/memory-region-housekeeping.cocci | 19 +++++++++++++++++=
++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index ee3923d..9cdde71 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -29,6 +29,25 @@ symbol true;
 )
=20
=20
+@possible_memory_region_init_rom@
+expression E1, E2, E3, E4, E5;
+position p;
+@@
+(
+  memory_region_init_ram@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+|
+  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+)
+@script:python@
+p << possible_memory_region_init_rom.p;
+@@
+cocci.print_main("potential use of memory_region_init_rom*() in ", p)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
--=20
1.8.3.1



