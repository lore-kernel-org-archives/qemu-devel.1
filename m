Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FEC2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEB62073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhKDPe2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEB62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQhj-0005Od-Mn
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHQgv-0004Zt-Ph
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHQgt-0004MV-M0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:28:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHQgt-0004Lz-IR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585222130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I0Tz7x2vDP0o46FCO+jcFASKDfptJxIOyImXfAJsDBs=;
 b=YhKDPe2YnuLFPpT70w3zgS8/3gvZF75dsv4KDdP7qbETsiXlmfWV7fPv75wr54xSXf9eNZ
 lAtBWW8fkiDzhNIHxaZfcG0UYbXf1mWVGibe67zz/oNt7jgcL9HFg57p+8HTyEm/cbgJVN
 1zN3ZldzEQXFdR6fCXLJA0kbwc8hkJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ugp5dGHyMZSKfS_RgR8LpQ-1; Thu, 26 Mar 2020 07:28:49 -0400
X-MC-Unique: ugp5dGHyMZSKfS_RgR8LpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16EB7108C314;
 Thu, 26 Mar 2020 11:28:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 245EECFDD;
 Thu, 26 Mar 2020 11:28:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] arm:virt: fix broken IPA range with KVM enabled
Date: Thu, 26 Mar 2020 07:28:29 -0400
Message-Id: <20200326112829.19989-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, gshan@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a1b18df9a4848, broke virt_kvm_type() logic, which depends on
maxram_size, ram_size, ram_slots being parsed/set on machine instance
at the time accelerator (KVM) is initialized.

set_memory_options() part was already reverted by commit 2a7b18a3205b,
so revert remaining initialization of above machine fields to make
virt_kvm_type() work as it used to.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Auger Eric <eric.auger@redhat.com>
---
 softmmu/vl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 814537bb42..132c6e73dc 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4137,6 +4137,9 @@ void qemu_init(int argc, char **argv, char **envp)
     machine_opts =3D qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
+    current_machine->ram_size =3D ram_size;
+    current_machine->maxram_size =3D maxram_size;
+    current_machine->ram_slots =3D ram_slots;
=20
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
@@ -4315,10 +4318,6 @@ void qemu_init(int argc, char **argv, char **envp)
         }
     }
=20
-    current_machine->ram_size =3D ram_size;
-    current_machine->maxram_size =3D maxram_size;
-    current_machine->ram_slots =3D ram_slots;
-
     parse_numa_opts(current_machine);
=20
     if (machine_class->default_ram_id && current_machine->ram_size &&
--=20
2.18.1


