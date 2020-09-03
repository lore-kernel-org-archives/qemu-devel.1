Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F58C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7997520897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9q1QnIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7997520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkb3-00035d-Lp
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXK-0003SF-2x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:24:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXI-0008VM-Cu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8ubN+tdCrhRxUlksdxzuiplGfIIQAvNh+Rl+aXl8u4=;
 b=E9q1QnIUzjPZEqR0CvlZ0AFy0nlwfRgEoDh701kcFuOUTLvokzfJRDqm1DJiC38UEHCLnY
 TYgEBf+ZiRfpmaBHu4SNEHWpVqOQVpgqa4UchNi+EJyEyg6J6gYds2Q0aqhU0z9CSUyAsM
 3E/bd2EQLNqoROUUHPO8OHBt2NLnCy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-iHzBjFC9OlSlD6ZkWhbMbg-1; Thu, 03 Sep 2020 04:23:47 -0400
X-MC-Unique: iHzBjFC9OlSlD6ZkWhbMbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EDB1091064;
 Thu,  3 Sep 2020 08:23:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42D3C60250;
 Thu,  3 Sep 2020 08:23:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB3D01144226; Thu,  3 Sep 2020 10:23:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] scripts/qmp/qom-fuse: Unbreak import of QEMUMonitorProtocol
Date: Thu,  3 Sep 2020 10:23:39 +0200
Message-Id: <20200903082344.1877175-4-armbru@redhat.com>
In-Reply-To: <20200903082344.1877175-1-armbru@redhat.com>
References: <20200903082344.1877175-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit c7b942d7f8 "scripts/qmp: Fix shebang and imports" messed with
it for reasons I don't quite understand.  I do understand how it fails
now: it neglects to import sys.  Fix that.

It now fails because it expects an old version of module fuse.  That's
next.

Fixes: c7b942d7f84ef54f266921bf7668d43f1f2c7c79
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200723142738.1868568-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 5fa6b3bf64..b7dabe8d65 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -13,7 +13,7 @@
 
 import fuse, stat
 from fuse import Fuse
-import os, posix
+import os, posix, sys
 from errno import *
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
@@ -134,7 +134,7 @@ class QOMFS(Fuse):
             yield fuse.Direntry(str(item['name']))
 
 if __name__ == '__main__':
-    import sys, os
+    import os
 
     fs = QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET']))
     fs.main(sys.argv)
-- 
2.26.2


