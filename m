Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27BC06514
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DD42189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DD42189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hik1X-0000Zy-TC
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijg5-0004hN-PL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijg3-0000aY-TP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijg3-0000a6-OT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 028663082200;
 Wed,  3 Jul 2019 18:08:19 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8824E58C94;
 Wed,  3 Jul 2019 18:08:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:07:04 -0300
Message-Id: <20190703180726.31267-22-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 03 Jul 2019 18:08:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 21/43] deprecate -mem-path fallback to
 anonymous RAM
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Fallback might affect guest or worse whole host performance
or functionality if backing file were used to share guest RAM
with another process.

Patch deprecates fallback so that we could remove it in future
and ensure that QEMU will provide expected behavior and fail if
it can't use user provided backing file.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190626074228.11558-1-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c               | 6 ++++--
 qemu-deprecated.texi | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index c1f5e84fa5..48fd43ecc6 100644
--- a/numa.c
+++ b/numa.c
@@ -495,8 +495,10 @@ static void allocate_system_memory_nonnuma(MemoryReg=
ion *mr, Object *owner,
             if (mem_prealloc) {
                 exit(1);
             }
-            error_report("falling back to regular RAM allocation.");
-
+            warn_report("falling back to regular RAM allocation");
+            error_printf("This is deprecated. Make sure that -mem-path "
+                         " specified path has sufficient resources to al=
locate"
+                         " -m specified RAM amount");
             /* Legacy behavior: if allocation failed, fall back to
              * regular RAM allocation.
              */
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2fe9b72121..9cba82d5ec 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -112,6 +112,15 @@ QEMU using implicit generic or board specific splitt=
ing rule.
 Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem=
} (if
 it's supported by used machine type) to define mapping explictly instead=
.
=20
+@subsection -mem-path fallback to RAM (since 4.1)
+Currently if guest RAM allocation from file pointed by @option{mem-path}
+fails, QEMU falls back to allocating from RAM, which might result
+in unpredictable behavior since the backing file specified by the user
+is ignored. In the future, users will be responsible for making sure
+the backing storage specified with @option{-mem-path} can actually provi=
de
+the guest RAM configured with @option{-m} and QEMU will fail to start up=
 if
+RAM allocation is unsuccessful.
+
 @section QEMU Machine Protocol (QMP) commands
=20
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
--=20
2.18.0.rc1.1.g3f1ff2140


