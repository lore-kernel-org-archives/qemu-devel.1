Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F7C04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BB32082E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BB32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0ym-0004Al-K9
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:58:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rg-0006BX-13
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0re-0001QG-Uo
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0re-0001PC-Mp
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A4048553A
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:02 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB3135C5B0;
	Wed, 15 May 2019 20:50:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:23 +0200
Message-Id: <1557953433-19663-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 15 May 2019 20:51:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/21] hw/i386/acpi: Assert a pointer is not
 null BEFORE using it
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit 72c194f7e75c added a non-null check on the 'obj' pointer.
Later, commit 500b11ea5095 added code which uses the 'obj'
pointer _before_ the assertion check. Move the assertion
_before_ the pointer use.

Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
Message-Id: <20190427144025.22880-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 123ff2b..b4ec14e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -186,6 +186,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_io_base =3D 0;
     pm->pcihp_io_len =3D 0;
=20
+    assert(obj);
     init_common_fadt_data(obj, &pm->fadt);
     if (piix) {
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible =
*/
@@ -204,7 +205,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
         pm->fadt.flags |=3D 1 << ACPI_FADT_F_RESET_REG_SUP;
         pm->cpu_hp_io_base =3D ICH9_CPU_HOTPLUG_IO_BASE;
     }
-    assert(obj);
=20
     /* The above need not be conditional on machine type because the res=
et port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
--=20
1.8.3.1



