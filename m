Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E788C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C5A206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMh31jnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C5A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icSYy-0003sl-AS
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 06:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5Z-0007G6-H2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5H-0000Hv-Gm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5G-0008SZ-BB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ck8YC4RtctXQY4XvFDhEnQzwtpi+SeKk9po2VZb4n6E=;
 b=JMh31jnB4yrx8eUAhiDIdRLS3caH9BCaPxoYW1rRYu+RqA1Ye3aczEVJXUr+c2ath3IxAI
 lEEeNlers+xV95OvKD4VZPHvTZM7ADnnDm/x2ut7XiDsHOChKJND9zblLyWju1juCdCbcF
 dTq1zfg83eAkwgxWMjfCbIsMM/nkKEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-eLUV5_UrMtuHeT-s4l1ing-1; Wed, 04 Dec 2019 04:36:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7BD418543A2
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7294A19C68;
 Wed,  4 Dec 2019 09:36:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9243111366D5; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/18] exec: Fix file_ram_alloc() error API violations
Date: Wed,  4 Dec 2019 10:36:12 +0100
Message-Id: <20191204093625.14836-6-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: eLUV5_UrMtuHeT-s4l1ing-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
---
 exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index ffdb518535..45695a5f2d 100644
--- a/exec.c
+++ b/exec.c
@@ -1841,6 +1841,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             bool truncate,
                             Error **errp)
 {
+    Error *err =3D NULL;
     MachineState *ms =3D MACHINE(qdev_get_machine());
     void *area;
=20
@@ -1898,8 +1899,9 @@ static void *file_ram_alloc(RAMBlock *block,
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


