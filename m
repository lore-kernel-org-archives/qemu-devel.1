Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E5C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE1620733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNPEXhlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE1620733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdF2-00028s-RE
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVdEG-0001Ti-M0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVdEE-00088j-Of
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:09:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVdEE-00088C-J9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573830582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/C08I94E41LhRbG7BjaHY25aetPMw9QUs0aFH5/d2/c=;
 b=MNPEXhlISZpPPR+Zomn3TInjoMOaSlzBtQsgaMkAQ/iEMJ4Und0vP7Bj+fjqkT6U7SZh6e
 5tkjSzmvZCMKYTMU8kOgjwEEOF6QLrWDZGKy/Sci5gjqVbru6htSz4zm3NYf8tS2EYKN0v
 uSbacfeFatml5fzo6p5n1Cy583CEjJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-xqQ2s-ssNjCwKT03Gb6qhA-1; Fri, 15 Nov 2019 10:09:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25CF2649B;
 Fri, 15 Nov 2019 15:09:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-84.ams2.redhat.com
 [10.36.117.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 628FF60C81;
 Fri, 15 Nov 2019 15:09:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH for-4.2] hw/i386: Fix compiler warning when CONFIG_IDE_ISA is
 disabled
Date: Fri, 15 Nov 2019 15:50:49 +0100
Message-Id: <20191115145049.26868-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xqQ2s-ssNjCwKT03Gb6qhA-1
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When CONFIG_IDE_ISA is disabled, compilation currently fails:

 hw/i386/pc_piix.c: In function =E2=80=98pc_init1=E2=80=99:
 hw/i386/pc_piix.c:81:9: error: unused variable =E2=80=98i=E2=80=99 [-Werro=
r=3Dunused-variable]

Move the variable declaration to the right code block to avoid
this problem.

Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2aefa3b8df..d187db761c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
     X86MachineState *x86ms =3D X86_MACHINE(machine);
     MemoryRegion *system_memory =3D get_system_memory();
     MemoryRegion *system_io =3D get_system_io();
-    int i;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     PCII440FXState *i440fx_state;
@@ -253,7 +252,7 @@ static void pc_init1(MachineState *machine,
     }
 #ifdef CONFIG_IDE_ISA
 else {
-        for(i =3D 0; i < MAX_IDE_BUS; i++) {
+        for (int i =3D 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] =3D "ide.0";
             dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
--=20
2.23.0


