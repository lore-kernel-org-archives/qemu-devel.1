Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48519C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E7B206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYBNV+F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E7B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeYv-0002tv-Bl
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFeYJ-00027g-Hw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:24:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFeYI-0006Tl-3P
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6QJYEtm1xVzUkuKTCKPw21gxeWoD6cNZIMmUSK7duE=;
 b=QYBNV+F+oxGZUgB8UZjX8yRgGsa+LzHILyoTYYdD1ybUC6g5HVFTdZKWMHHCxtOIui+HFG
 CKhuq+W7PkgzI5bmYs636LwS6cJUQ7C0y4rykJAAIyb3S/u6BfNDkG9FDBjd01FSqbpv2b
 BMY8zDFj23TfHNm1tzXUkgadGs2nYm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155--JTnZOQsNnaxp0q4NzYpXw-1; Tue, 08 Sep 2020 10:24:51 -0400
X-MC-Unique: -JTnZOQsNnaxp0q4NzYpXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8481C393BE
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 14:24:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2C7D5D9E8;
 Tue,  8 Sep 2020 14:24:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 9/10] fixup! x68: acpi: trigger SMI before sending hotplug
 Notify event to OSPM
Date: Tue,  8 Sep 2020 10:24:44 -0400
Message-Id: <20200908142444.546924-1-imammedo@redhat.com>
In-Reply-To: <20200907112348.530921-10-imammedo@redhat.com>
References: <20200907112348.530921-10-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add comment explaining why while_ctx2 restarts from the last processed CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/acpi/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 1283972001..8dd4d8ebbf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -601,6 +601,15 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     aml_append(while_ctx, aml_increment(cpu_idx));
                 }
                 aml_append(while_ctx2, while_ctx);
+                /*
+                 * If another batch is needed, then it will resume scanning
+                 * exactly at -- and not after -- the last CPU that's currently
+                 * in CPU_ADDED_LIST. In other words, the last CPU in
+                 * CPU_ADDED_LIST is going to be re-checked. That's OK: we've
+                 * just cleared the insert event for *all* CPUs in
+                 * CPU_ADDED_LIST, including the last one. So the scan will
+                 * simply seek past it.
+                 */
             }
             aml_append(method, while_ctx2);
             aml_append(method, aml_release(ctrl_lock));
-- 
2.27.0


