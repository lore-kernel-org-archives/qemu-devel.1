Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90A12078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK4jnPKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90A12078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRTU-0001t0-S5
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKp-0002UH-J1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27983
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKn-0006wn-Tz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4ucpgSsbloViuaz3qwZxuvfwHfzz+ptEuSfhEPoAuw=;
 b=PK4jnPKyMFaplcStT+UqSARTZr0RkMA9mv0DfM2VuSku4rt2bZYmLQ786F6cwH6O6Y7Ead
 wkqJflg2vXlzmEcC7QPsVTIOInb9mIB022SxBBLnj6dyHvaNlj0Dpty8cCETQrCofxI+2o
 ko5hK49KqNUiEH1T4EIJGLlJIoplkZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-yBGZo2cKO92lhjcd0DxowA-1; Wed, 02 Sep 2020 07:53:46 -0400
X-MC-Unique: yBGZo2cKO92lhjcd0DxowA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DDC41DE0F;
 Wed,  2 Sep 2020 11:53:45 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31EBE1055A43;
 Wed,  2 Sep 2020 11:53:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/20] Revert "hw/i386: Introduce apicid functions inside
 X86MachineState"
Date: Wed,  2 Sep 2020 07:53:17 -0400
Message-Id: <20200902115323.850385-15-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

This reverts commit 6121c7fbfd98dbc3af1b00b56ff2eef66df87828.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <159889935648.21294.8095493980805969544.stgit@naples-babu.amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/x86.h | 9 ---------
 hw/i386/x86.c         | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b79f24e285..4d9a26326d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -63,15 +63,6 @@ typedef struct {
     OnOffAuto smm;
     OnOffAuto acpi;
 
-    /* Apic id specific handlers */
-    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
-                                    unsigned cpu_index);
-    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
-                                 X86CPUTopoIDs *topo_ids);
-    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
-                                      const X86CPUTopoIDs *topo_ids);
-    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
-
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3cc2318212..727c4a0f1d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -896,11 +896,6 @@ static void x86_machine_initfn(Object *obj)
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->acpi = ON_OFF_AUTO_AUTO;
     x86ms->smp_dies = 1;
-
-    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
-    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
-    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
-    x86ms->apicid_pkg_offset = apicid_pkg_offset;
 }
 
 static void x86_machine_class_init(ObjectClass *oc, void *data)
-- 
2.26.2


