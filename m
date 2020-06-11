Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3912BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40AB206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeuCGgzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40AB206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSWd-0004Lg-7G
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSVS-00032g-Rd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31402
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSVQ-0008OC-Ut
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591902292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19y5+oGVYv3vOrrkDY3kK5mChBBSYkxqXQ2KHnNpqoU=;
 b=DeuCGgzHdQ6iAOjihJGB9m+dDNZ7zjsu4Sqg5nfm68f/BBnzThUuBpxDk15nW6df/XNAIt
 +ypkyHz+JCK+6XsS+VGDXuvSASTUx/N0bf0bQQ/9mZSGjvWQNZvpd6ehsEi120OEO0ez2y
 neB4jIFl+XNH8/LcAdW/7tP7gmdtpPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-oyb2oawJMdCWLC-Haeun2Q-1; Thu, 11 Jun 2020 15:04:48 -0400
X-MC-Unique: oyb2oawJMdCWLC-Haeun2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 420221009460
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:04:33 +0000 (UTC)
Received: from gimli.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDF6782031;
 Thu, 11 Jun 2020 19:04:30 +0000 (UTC)
Subject: [PULL 2/2] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jun 2020 13:04:29 -0600
Message-ID: <159190226979.22110.13013050033761719351.stgit@gimli.home>
In-Reply-To: <159190218710.22110.16614504111613456036.stgit@gimli.home>
References: <159190218710.22110.16614504111613456036.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
required header config-devices.h is not included, so that the legacy
IGD passthrough is currently broken. Let's include the right header
to fix this issue.

Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
Fixes: 29d62771c81d ("hw/vfio: Move the IGD quirk code to a separate file")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a1e615c54e06..d304c81148d3 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "config-devices.h"
 #include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"


