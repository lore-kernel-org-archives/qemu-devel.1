Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA22075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ+AqbuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIurb-0002Y8-Sf
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kIuZj-0000s1-1E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kIuZg-0001Lq-Ph
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600351667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/aQkfdKDYeKp+KVe5l0rvqnE/WMDo0KQmvm30c+fiOA=;
 b=OZ+AqbuR6saMb7+g+xBVRmPbG2crX7ZBjwoqqA2BlgSKF/l3zYsdRystBqhMOL3fZIQdyd
 Vi4Yl0gpPih9vFQFiE/55hsX8lG2c09zEvWgQFXm13DVCvjp8N7svvbF1JtROcJryd0aRy
 CZTm64tPkkp0SdcGOWihSRtLHkZycsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-3P0NX76aNDu0K5Qaacuqqw-1; Thu, 17 Sep 2020 10:07:26 -0400
X-MC-Unique: 3P0NX76aNDu0K5Qaacuqqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A49457053;
 Thu, 17 Sep 2020 14:07:02 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-15.ams2.redhat.com [10.36.113.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F14BD60BEC;
 Thu, 17 Sep 2020 14:07:00 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: fix static flag summary
Date: Thu, 17 Sep 2020 16:07:00 +0200
Message-Id: <20200917140700.673171-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'static build:' must display value of CONFIG_STATIC rather than value of
CONFIG_TOOLS.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5421eca66a02..c174f0ab0948 100644
--- a/meson.build
+++ b/meson.build
@@ -1374,7 +1374,7 @@ summary_info += {'gprof enabled':     config_host.has_key('CONFIG_GPROF')}
 summary_info += {'sparse enabled':    meson.get_compiler('c').cmd_array().contains('cgcc')}
 summary_info += {'strip binaries':    get_option('strip')}
 summary_info += {'profiler':          config_host.has_key('CONFIG_PROFILER')}
-summary_info += {'static build':      config_host.has_key('CONFIG_TOOLS')}
+summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
 if targetos == 'darwin'
   summary_info += {'Cocoa support': config_host.has_key('CONFIG_COCOA')}
 endif
-- 
2.26.2


