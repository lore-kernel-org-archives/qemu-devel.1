Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69162C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCE42067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3woHUNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCE42067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFOB-0005FY-AN
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFNP-0004HX-8S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:31:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFNM-0006Gh-JK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598286674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GW4qz1I/FzXOsbatKU+6faRDJlxG5rUhQK5vNBkNNic=;
 b=Z3woHUNr0URjBMsx3CMMjch9cCejZ84X/GX2tAWbFs9thIMup74HYpYfTJ5+R0CihN40AB
 F4x867zF9A8M6r+jmNPYmKBVdL6LntII2N4G6T1oe3BkgnBrZWVzVzX7D8mo0FwmqlFau5
 jDL9I3ueAD7WsfryexJwq/eD7AiuUvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-nTQFzan-MA-h3O6d79S6xA-1; Mon, 24 Aug 2020 12:31:13 -0400
X-MC-Unique: nTQFzan-MA-h3O6d79S6xA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0808010ABDA5;
 Mon, 24 Aug 2020 16:31:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-223.ams2.redhat.com
 [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A33225C1BB;
 Mon, 24 Aug 2020 16:31:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: default to PIE disabled on Windows platforms
Date: Mon, 24 Aug 2020 17:31:09 +0100
Message-Id: <20200824163109.96938-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If Windows EXE files are built with -pie/-fpie they will fail to
launch. Historically QEMU defaulted to disabling PIE for Windows,
but this setting was accidentally lost when the configure summary
text was removed in

  commit f9332757898a764d85e19d339ec421236e885b68
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Mon Feb 3 13:28:38 2020 +0100

    meson: move summary to meson.build

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Fixes: f9332757898a764d85e19d339ec421236e885b68
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 67832e3bab..b6f3b6e191 100755
--- a/configure
+++ b/configure
@@ -857,6 +857,7 @@ MINGW32*)
     audio_drv_list=""
   fi
   supported_os="yes"
+  pie="no"
 ;;
 GNU/kFreeBSD)
   bsd="yes"
-- 
2.26.2


