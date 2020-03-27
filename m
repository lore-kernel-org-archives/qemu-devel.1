Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1161C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8994820578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSJqm0xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmYK-0003AF-TS
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHmXY-0002ke-Ty
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHmXX-0007wj-UB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:48:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHmXX-0007u4-Pj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O14UB8kYFdJc5NqohKbJDOn5wMszsZHcqvXSROgaNUo=;
 b=SSJqm0xWpzlisyre798Ah27ApITDypN5p0cLzFpGH8yv1z4gX7XQN9Due16Fv5r/+WRIX8
 t1ziRUhbKdK2cJ6s1UKNcfc7FQb6crpq3lOZciFjusjAeo2OcOObRMaOUpwxyZKsM58xz9
 gz0EXtK5D3DXhHHXlcRKQL63PAABqio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-sg6_7G6CNPykihl_AOlZGg-1; Fri, 27 Mar 2020 06:48:37 -0400
X-MC-Unique: sg6_7G6CNPykihl_AOlZGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D48DDB61;
 Fri, 27 Mar 2020 10:48:36 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01E6760BF3;
 Fri, 27 Mar 2020 10:48:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] xen: fixup RAM memory region initialization
Date: Fri, 27 Mar 2020 06:48:28 -0400
Message-Id: <20200327104828.12647-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
machine fails to start with:
   qemu-system-i386: xen: failed to populate ram at 0

The reason is that xen_ram_alloc() which is called by
memory_region_init_ram(), compares memory region with
statically allocated 'global' ram_memory memory region
that it uses for RAM, and does nothing in case it matches.

While it's possible feed machine->ram to xen_ram_alloc()
in the same manner to keep that hack working, I'd prefer
not to keep that circular dependency and try to untangle that.

However it doesn't look trivial to fix, so as temporary
fixup opt out Xen machine from memdev based RAM allocation,
and let xen_ram_alloc() do its trick for now.

Reported-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
   - compile tested only

 hw/i386/pc_piix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e6756216f9..6cb352363d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -953,6 +953,10 @@ static void xenfv_machine_options(MachineClass *m)
     m->desc =3D "Xen Fully-virtualized PC";
     m->max_cpus =3D HVM_MAX_VCPUS;
     m->default_machine_opts =3D "accel=3Dxen";
+    /*
+     * opt out of system RAM being allocated by generic code
+     */
+    m->default_ram_id =3D NULL;
 }
=20
 DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
--=20
2.18.1


