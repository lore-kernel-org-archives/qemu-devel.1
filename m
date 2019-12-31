Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A6C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96C1205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hN9BOPmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96C1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imI87-0006mB-Il
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCs-0006Mx-7v
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCr-0005hr-41
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCq-0005dj-VI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVkKlRH3RCq8RkLAivZKk7H3y7MvONdSXCX3tNEU9SU=;
 b=hN9BOPmzOXEuiavdvBsRVRfS1nJvQ67/NfwHMH/RvyJxsCKnD7kkm7QGutAkzv+MZ1EkBp
 qoG5zunQlMzFYd8242yt0LzMytI1hMYoJ1ado8OdWK4IEMy/z3fTgWBJTOpZpMhOzkaMQI
 1trEn7plDKZguXWJHfiOk8QKQ3/LGZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-zf-ngDGgP3m_YsO9XgcyGQ-1; Tue, 31 Dec 2019 08:04:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B1D800EBF
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82AAB620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 85/86] numa: make exit() usage consistent
Date: Tue, 31 Dec 2019 14:04:09 +0100
Message-Id: <1577797450-88458-86-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zf-ngDGgP3m_YsO9XgcyGQ-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index beb6d2e..96776ff 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -421,7 +421,7 @@ void numa_complete_configuration(MachineState *ms)
         /* Report large node IDs first, to make mistakes easier to spot */
         if (!numa_info[i].present) {
             error_report("numa: Node ID missing: %d", i);
-            exit(1);
+            exit(EXIT_FAILURE);
         }
     }
=20
@@ -462,7 +462,7 @@ void numa_complete_configuration(MachineState *ms)
             error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
                          " should equal RAM size (0x" RAM_ADDR_FMT ")",
                          numa_total, ram_size);
-            exit(1);
+            exit(EXIT_FAILURE);
         }
=20
         if (!numa_uses_legacy_mem()) {
--=20
2.7.4


