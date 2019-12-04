Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC95C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EFB20674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYY4mCcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EFB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icYZm-00081I-DV
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY6A-0005I2-4y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY67-0004fa-5K
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY67-0004SU-13
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mc1RI1X6a9TI2HtaGuOb+i8lvqAVJiC3NOsuJudvhDI=;
 b=NYY4mCcJEaagKXwV3xMCCxoC96kCqQOX0C+GS7QmBkd0ZK2NXOnLe9fo25WH+sbgRKZF7+
 znZC5Ht6xVFupG1n2JFiEzXB1SbVekj5tc7Xj0mwiOWP8iHBupYIO0YntyZQ98YbQR/IbP
 vYB9vi/fSjYtoBT0eH/K6aFOcM/ibfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-KBjbhOBNNSOoZlMNalx3Lg-1; Wed, 04 Dec 2019 12:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD957107B7D7
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85AB05D6BB;
 Wed,  4 Dec 2019 17:05:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 3/8] acpi: cpuhp: spec: clarify 'CPU selector'
 register usage and endianness
Date: Wed,  4 Dec 2019 18:05:42 +0100
Message-Id: <1575479147-6641-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: KBjbhOBNNSOoZlMNalx3Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

* Move reserved registers to the top of the section, so reader would be
  aware of effects when reading registers description.
* State registers endianness explicitly at the beginning of the section
* Describe registers behavior in case of 'CPU selector' register contains
  value that doesn't point to a possible CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index ee219c8..4e65286 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -30,6 +30,18 @@ Register block base address:
 Register block size:
     ACPI_CPU_HOTPLUG_REG_LEN =3D 12
=20
+All accesses to registers described below, imply little-endian byte order.
+
+Reserved resisters behavior:
+   - write accesses are ignored
+   - read accesses return all bits set to 0.
+
+The last stored value in 'CPU selector' must refer to a possible CPU, othe=
rwise
+  - reads from any register return 0
+  - writes to any other register are ignored until valid value is stored i=
nto it
+On QEMU start, 'CPU selector' is initialized to a valid value, on reset it
+keeps the current value.
+
 read access:
     offset:
     [0x0-0x3] reserved
@@ -86,9 +98,3 @@ write access:
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
             other values: reserved
-
-Selecting CPU device beyond possible range has no effect on platform:
-   - write accesses to CPU hot-plug registers not documented above are
-     ignored
-   - read accesses to CPU hot-plug registers not documented above return
-     all bits set to 0.
--=20
2.7.4


