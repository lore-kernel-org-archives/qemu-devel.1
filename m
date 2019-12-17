Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA0C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2019206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+ILku8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2019206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6YP-0003Gi-JA
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jz-0000kQ-1c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-00017O-Gn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jx-00014H-AQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HKGEEN/2k71Y/eOrbi6sjc52VczmaHxNAwUf3PdFXI=;
 b=c+ILku8eYu8Z+OOUenVMzszvlWv78A3o7BBNzbukPAdr4u5OlAfxZXNlsAfUXeht2YMPpN
 w9dvbEOlmETTel/7aSk4nicKFKJNFAk18BkoPtGZ7nvINnZ/hS1Z+uIpu2e+HllWLJ/zog
 spARefXSX8076uVtadrR+5mOEZ02hGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-sFt5TXRtMX-pKPVf_rjSGQ-1; Tue, 17 Dec 2019 01:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6EE91005510
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EBAB60BE0;
 Tue, 17 Dec 2019 06:26:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5741111385CB; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] exec: Fix file_ram_alloc() error API violations
Date: Tue, 17 Dec 2019 07:26:23 +0100
Message-Id: <20191217062651.9687-7-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sFt5TXRtMX-pKPVf_rjSGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When os_mem_prealloc() fails, file_ram_alloc() calls qemu_ram_munmap()
and returns null.  Except it doesn't when its @errp argument is null,
because it checks for failure with (errp && *errp).  Introduced in
commit 056b68af77 "fix qemu exit on memory hotplug when allocation
fails at prealloc time".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20191204093625.14836-6-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index a34c348184..6bd4aa1d87 100644
--- a/exec.c
+++ b/exec.c
@@ -1843,6 +1843,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             bool truncate,
                             Error **errp)
 {
+    Error *err =3D NULL;
     MachineState *ms =3D MACHINE(qdev_get_machine());
     void *area;
=20
@@ -1900,8 +1901,9 @@ static void *file_ram_alloc(RAMBlock *block,
     }
=20
     if (mem_prealloc) {
-        os_mem_prealloc(fd, area, memory, ms->smp.cpus, errp);
-        if (errp && *errp) {
+        os_mem_prealloc(fd, area, memory, ms->smp.cpus, &err);
+        if (err) {
+            error_propagate(errp, err);
             qemu_ram_munmap(fd, area, memory);
             return NULL;
         }
--=20
2.21.0


