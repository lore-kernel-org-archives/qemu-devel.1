Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A76C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0641220897
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/DePV7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0641220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PyV-0003g2-BR
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8Pvv-0008LI-H8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8Pvt-0000I9-Ml
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597850600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGorU/6GZMWrstCQWJaP84CHFXi4dSIi8ZH+Ss2AFdE=;
 b=D/DePV7BIOfngpezC2oSkX+PxJ3KaMwh+HsHB0j57HnDrk/pIL7T0V/2MVlTBYpUIjIlOx
 6fYJ8ZAq4fojvhnMUvdtbWtxCymN4xCGS9iZ0GOVFlVlw7FDtJD4MWCTtoUFvjCxyiMhmE
 aCcugLnjOrKOcDulV96WZipuVLrpkD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-fXf2v10JNJKrtgKKQYWdZQ-1; Wed, 19 Aug 2020 11:23:15 -0400
X-MC-Unique: fXf2v10JNJKrtgKKQYWdZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E0181CB07;
 Wed, 19 Aug 2020 15:23:13 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5359D5D9D5;
 Wed, 19 Aug 2020 15:23:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/3] qmp: Expose MachineClass::default_ram_id
Date: Wed, 19 Aug 2020 11:22:57 -0400
Message-Id: <20200819152258.703874-3-ehabkost@redhat.com>
In-Reply-To: <20200819152258.703874-1-ehabkost@redhat.com>
References: <20200819152258.703874-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

If a management application (like Libvirt) want's to preserve
migration ability and switch to '-machine memory-backend' it
needs to set exactly the same RAM id as QEMU would. Since the id
is machine type dependant, expose it under 'query-machines'
result. Some machine types don't have the attribute set (riscv
family for example), therefore the QMP attribute must be
optional.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <9384422f63fe594a54d801f9cb4539b1d2ce9b67.1590481402.git.mprivozn@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[ehabkost: updated doc to "since 5.2"]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/machine.json          | 5 ++++-
 hw/core/machine-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 481b1f07ec..abc6fd0477 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -357,13 +357,16 @@
 # @default-cpu-type: default CPU model typename if none is requested via
 #                    the -cpu argument. (since 4.2)
 #
+# @default-ram-id: the default ID of initial RAM memory backend (since 5.2)
+#
 # Since: 1.2.0
 ##
 { 'struct': 'MachineInfo',
   'data': { 'name': 'str', '*alias': 'str',
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
-            'deprecated': 'bool', '*default-cpu-type': 'str' } }
+            'deprecated': 'bool', '*default-cpu-type': 'str',
+            '*default-ram-id': 'str' } }
 
 ##
 # @query-machines:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 963088b798..21551221ad 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -238,6 +238,10 @@ MachineInfoList *qmp_query_machines(Error **errp)
             info->default_cpu_type = g_strdup(mc->default_cpu_type);
             info->has_default_cpu_type = true;
         }
+        if (mc->default_ram_id) {
+            info->default_ram_id = g_strdup(mc->default_ram_id);
+            info->has_default_ram_id = true;
+        }
 
         entry = g_malloc0(sizeof(*entry));
         entry->value = info;
-- 
2.26.2


