Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E338C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CCB207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CCB207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHES-0000jK-EJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBHAY-0004kB-7H
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBHAX-00018d-7m
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBHAX-00017b-2V
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3375D81F0D;
 Fri, 20 Sep 2019 11:33:43 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB3A104B500;
 Fri, 20 Sep 2019 11:33:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Justin Terry <juterry@microsoft.com>
Subject: [PATCH v2 1/3] target/i386: Fix broken build with WHPX enabled
Date: Fri, 20 Sep 2019 13:33:27 +0200
Message-Id: <20190920113329.16787-2-philmd@redhat.com>
In-Reply-To: <20190920113329.16787-1-philmd@redhat.com>
References: <20190920113329.16787-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 20 Sep 2019 11:33:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ilias Maratos <i.maratos@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The WHPX build is broken since commit 12e9493df92 which removed the
"hw/boards.h" where MachineState is declared:

  $ ./configure \
     --enable-hax --enable-whpx

  $ make x86_64-softmmu/all
  [...]
    CC      x86_64-softmmu/target/i386/whpx-all.o
  target/i386/whpx-all.c: In function 'whpx_accel_init':
  target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
  incomplete type 'MachineState' {aka 'struct MachineState'}
       whpx->mem_quota =3D ms->ram_size;
                           ^~
  make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
    CC      x86_64-softmmu/trace/generated-helpers.o
  make[1]: Target 'all' not remade because of errors.
  make: *** [Makefile:471: x86_64-softmmu/all] Error 2

Restore this header, partially reverting commit 12e9493df92.

Fixes: 12e9493df92
Reported-by: Ilias Maratos <i.maratos@gmail.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 0c15241ae4..def0c28480 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -18,6 +18,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
+#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
--=20
2.20.1


