Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F8C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1692B206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1692B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hucVM-00027i-1f
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mprivozn@redhat.com>) id 1hucV0-0001iH-2M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1hucUz-0000yC-49
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hucUy-0000x2-VX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2D47308212F
 for <qemu-devel@nongnu.org>; Mon,  5 Aug 2019 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-137.brq.redhat.com
 [10.40.204.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1CEC600CC;
 Mon,  5 Aug 2019 12:53:52 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 14:53:37 +0200
Message-Id: <350c3150b25e0c44e24e0a3bd15dacc7284684c9.1565009145.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 05 Aug 2019 12:53:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Makefile: Drop $(DESTDIR) from generated FW
 paths
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
Cc: philmd@redhat.com, imammedo@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The way that generating firmware descriptor files work is that
for every input file, every occurrence of @DATADIR@ within the
file is replaced with $(DESTDIR)$(qemu_datadir). This works as
long as DESTDIR is empty. But in some cases (e.g. on my Gentoo
box), compilation is done in one dir, then the installation is
done to another dir and then package manager copies over the
installed files. It's obvious that $(DESTDIR) must be ignored
otherwise the generated FW descriptor files will refer to old
installation directory and ignore --prefix given to ./configure.

Steps to reproduce:
1) qemu.git $ mkdir _build _install; cd _build && \
   ../configure --prefix=3D/usr && make && \
   make DESTDIR=3D../_install install

2) Observe wrong path:
   qemu.git/_build $ grep filename ../_install/usr/share/qemu/firmware/*

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cfab1561b9..85862fb81a 100644
--- a/Makefile
+++ b/Makefile
@@ -881,7 +881,7 @@ ifneq ($(DESCS),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
 	set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
 	for x in $(DESCS); do \
-		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
+		sed -e 's,@DATADIR@,$(qemu_datadir),' \
 			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
 		$(INSTALL_DATA) "$$tmpf" \
 			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
--=20
2.21.0


