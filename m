Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D117BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96930207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMX2jmXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96930207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDV7R-0000I9-Mx
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1J-0000xZ-74
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:49:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1H-0005Sp-Gx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAvWGVgRdXH+V07442qtZdl0dTJeBpHCDS2KpP1OZpc=;
 b=EMX2jmXxjrVJpb9Q1x0ejG2K6WnpV8lAFMxlTpKq40aACrgGgsNuhvPf7Z+9QhtTQa4mpJ
 4jDjGlMYoNCv5XbLc3y4RGJerhm5pqY0X84QwwBQ/o7jSsOkEaIvxc0RmOIE+a1H4sgmUu
 9RLiLSdfQf4jLc9y1AyW+qPaZXpYZes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-tPe4Ve6MMSqNPCpa70XKmQ-1; Wed, 02 Sep 2020 11:49:52 -0400
X-MC-Unique: tPe4Ve6MMSqNPCpa70XKmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93764805EE8;
 Wed,  2 Sep 2020 15:49:51 +0000 (UTC)
Received: from thuth.com (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD3445D9CC;
 Wed,  2 Sep 2020 15:49:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 09/15] tests/qtest/ahci: Improve error handling
 (NEGATIVE_RETURNS)
Date: Wed,  2 Sep 2020 17:49:26 +0200
Message-Id: <20200902154932.390595-10-thuth@redhat.com>
In-Reply-To: <20200902154932.390595-1-thuth@redhat.com>
References: <20200902154932.390595-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix an error handling issue reported by Coverity:

  /qemu/tests/qtest/ahci-test.c: 1452 in prepare_iso()
  1444         int fd = mkstemp(cdrom_path);
  >>>     CID 1432375:  Error handling issues  (NEGATIVE_RETURNS)
  >>>     "fd" is passed to a parameter that cannot be negative.
  1452         ret = write(fd, patt, size);

Reported-by: Coverity (CID 1432375)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902080552.159806-1-philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/ahci-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index ca4294f44f..5e1954852e 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1443,6 +1443,7 @@ static int prepare_iso(size_t size, unsigned char **buf, char **name)
     ssize_t ret;
     int fd = mkstemp(cdrom_path);
 
+    g_assert(fd != -1);
     g_assert(buf);
     g_assert(name);
     patt = g_malloc(size);
-- 
2.18.2


