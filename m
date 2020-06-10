Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 03:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA32A20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 03:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYOdP0c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA32A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jirme-0006n7-0D
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 23:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jirlm-00062z-JR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 23:51:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jirll-0001i9-Ae
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 23:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591761075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=vs3FzAUf+ReHoBBXFePlOtCd3KPFBPufyrKfXSuCiP0=;
 b=GYOdP0c3kz/cuEZGPBBwPY+JxVXbqz6mojDD7+OOOlby7Md4NDTmcHLbhX/N3XZNbTg86S
 mF/uG3+BeHFXSONA/sXQgp5zdThkMk6SJuqAVS1be3liYfBUCvpw+z46ve8ojovY/ysbYY
 vtEfT3afs7QoztfBEYR7azQLuFHrxc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-VqKC98vsNxehw_AkleXuqQ-1; Tue, 09 Jun 2020 23:51:11 -0400
X-MC-Unique: VqKC98vsNxehw_AkleXuqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92214107ACCA;
 Wed, 10 Jun 2020 03:51:10 +0000 (UTC)
Received: from thuth.com (unknown [10.40.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3FB310013D0;
 Wed, 10 Jun 2020 03:51:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
Date: Wed, 10 Jun 2020 05:51:02 +0200
Message-Id: <20200610035102.20192-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
required header config-devices.h is not included, so that the legacy
IGD passthrough is currently broken. Let's include the right header
to fix this issue.

Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
       ("hw/vfio: Move the IGD quirk code to a separate file")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/pci-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f2155ddb1d..3158390db1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "config-devices.h"
 #include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-- 
2.18.1


