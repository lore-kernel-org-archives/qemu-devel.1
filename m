Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1AC7618A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 05:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F4620868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 05:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F4620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmtzw-0005Cg-SE
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 01:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hmtzb-0004C2-2V
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hmtza-0007XN-4c
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hmtzZ-0007VX-VZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9059D3082145;
 Mon, 15 Jul 2019 05:57:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E10F51001B38;
 Mon, 15 Jul 2019 05:57:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A3751138661; Mon, 15 Jul 2019 07:57:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 07:57:36 +0200
Message-Id: <20190715055736.15214-3-armbru@redhat.com>
In-Reply-To: <20190715055736.15214-1-armbru@redhat.com>
References: <20190715055736.15214-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 15 Jul 2019 05:57:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 2/2] qemu-tech: Fix dangling @menu
 entries
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent commit 2f2c4e4731 "Convert "translator internals" docs to RST,
move to devel manual" and commit 282d36b5e2 "qemu-tech.texi: Remove
"QEMU compared to other emulators" section" removed @node, but left
their @menu entries behind.  This broke building qemu-doc.info (but
not qemu-doc.{html,pdf,txt}; how odd).  Bury the dead @menu entries.

Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Fixes: 2f2c4e4731449449a2b1aafcd73e4f9ae107d78b
Fixes: 282d36b5e27ba86d42d0638430e439c2c257367b
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-tech.texi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index 3451cfaa5b..0380de77b6 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -3,10 +3,7 @@
=20
 @menu
 * CPU emulation::
-* Translator Internals::
-* QEMU compared to other emulators::
 * Managed start up options::
-* Bibliography::
 @end menu
=20
 @node CPU emulation
--=20
2.21.0


