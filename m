Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B721C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139AF206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxUVucGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139AF206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8FW-0006JT-9X
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8D9-0001df-KS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8D8-0007T8-L5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8D8-0007SG-HF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inJcenK3LfmE6yBK2CNwYk0BFCmfLzRCvOvDSMeoni8=;
 b=WxUVucGEOxaWLxiBn6bbvLiujtEc/zgsdbf6uTuneYb4W2oOTMEXXvGL7CJ1T3gH4iWxIp
 X+Ywkvy7eeD6xlLgFxksHKyR9IzrSPULEQ6V/E8gcOF4lFxyPGJiECzZ2zQ45FeDhtUd9c
 rDadvQ5YpDS3itHVg6z6W2DCxS/VqxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-pnqr3dHXNbi5XmMWofCbVQ-1; Thu, 02 Apr 2020 18:21:12 -0400
X-MC-Unique: pnqr3dHXNbi5XmMWofCbVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 935F78017F3;
 Thu,  2 Apr 2020 22:21:11 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3C299E0D;
 Thu,  2 Apr 2020 22:21:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 3/9] hw/i386: Introduce apicid functions inside X86MachineState
Date: Thu,  2 Apr 2020 19:20:45 -0300
Message-Id: <20200402222051.523093-4-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
References: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

Introduce model specific apicid functions inside X86MachineState.
These functions will be loaded from X86CPUDefinition.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396722838.58170.5675998866484476427.stgit@naples-babu.amd.c=
om>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/x86.c         | 5 +++++
 include/hw/i386/x86.h | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6ca3cf936f..2168fc56c0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -937,6 +937,11 @@ static void x86_machine_initfn(Object *obj)
     x86ms->acpi =3D ON_OFF_AUTO_AUTO;
     x86ms->max_ram_below_4g =3D 0; /* use default */
     x86ms->smp_dies =3D 1;
+
+    x86ms->apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx;
+    x86ms->topo_ids_from_apicid =3D x86_topo_ids_from_apicid;
+    x86ms->apicid_from_topo_ids =3D x86_apicid_from_topo_ids;
+    x86ms->apicid_pkg_offset =3D apicid_pkg_offset;
 }
=20
 static void x86_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 54af8ab5cf..b522854816 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -66,6 +66,15 @@ typedef struct {
     OnOffAuto smm;
     OnOffAuto acpi;
=20
+    /* Apic id specific handlers */
+    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
+                                    unsigned cpu_index);
+    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_in=
fo,
+                                 X86CPUTopoIDs *topo_ids);
+    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
+                                      const X86CPUTopoIDs *topo_ids);
+    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
+
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.
--=20
2.24.1


