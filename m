Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23808C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01B720663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT1YKFmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01B720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieItj-0005lO-JS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieImr-0006bA-Rm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieImq-0006RK-RX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieImq-0006RE-Nl
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/zL+oUPazEV3yrIgIQGktVpOAKbjraCKyyj25RYVAw=;
 b=PT1YKFmGCpoAnU95opNPyEZq+weDLSoI2h6iNCP2th+s3qhAPUEcShPN1pPHR+nyLHzNVC
 ZJBJpaO8lDIuouIqa4xJ6vDb5E2dtBQIVcyBgRDKk4hx0rSm9j5eYZKUzhUB9NWdbtEj//
 2u1zSKxcCFp1X9hSyExtlxczW4Du7l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-EBxk-X8dPKeK6pft9d85Sg-1; Mon, 09 Dec 2019 08:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534C9800D41
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:09:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC35D5D9D6;
 Mon,  9 Dec 2019 13:09:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 6/9] acpi: cpuhp: spec: clarify store into 'Command
 data' when 'Command field' == 0
Date: Mon,  9 Dec 2019 14:08:59 +0100
Message-Id: <1575896942-331151-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EBxk-X8dPKeK6pft9d85Sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Write section of 'Command data' register should describe what happens
when it's written into. Correct description in case the last stored
'Command field' value is equal to 0, to reflect that currently it's not
supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index d510872..8fb9ad2 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -90,8 +90,7 @@ write access:
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
-          current 'Command field' value:
-              0: OSPM reads value of CPU selector
+          if last stored 'Command field' value:
               1: stores value into OST event register
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
--=20
2.7.4


