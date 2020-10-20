Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F95C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8483921D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjJNKNCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8483921D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvcm-0002FH-A1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOE-0007FI-0B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOC-00087k-5J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5a5Qtly5s7u76u/yf9nlzhnNv2l8V+1UybhgW6H3apI=;
 b=ZjJNKNCXxLJHU7tt9yJJ4KYluMOYKMwitTGtE5/dIdFMn2cIkvD5QziKDAgIDLFbk86KTa
 wstTw8sGmh/6chfKmYQXazlsGo9SOEKibvDHyo8pM7KDLbmB+4bPMXKOdZB9+JtmVsL94b
 61stGm2ZcaeTBwRYg3gu7+zV+hhHfIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-nr8dZpi_PZCkXP98sp8NVA-1; Tue, 20 Oct 2020 13:25:33 -0400
X-MC-Unique: nr8dZpi_PZCkXP98sp8NVA-1
Received: by mail-wr1-f69.google.com with SMTP id t17so1076623wrm.13
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5a5Qtly5s7u76u/yf9nlzhnNv2l8V+1UybhgW6H3apI=;
 b=Zz8+hsEYCO6CwsnF1YpOxieRvB8usRx3r3h9X/EHA5PnTmAz6+AhZshBdAYsdIW/st
 /EM9V8Gx14/Omg6yaLeHCo0FjX1LdV6YsYyGiqIR0LoRBrgJonz8PJhqPIiCTiyIJpXH
 POO5V6Hx+nbAGoZqS6zV3he73XvhWSLSAk3Sg4uhIYtf7WMVuB6cVTs+qXw4C0I9wOYU
 Qh01t/ljZhWwlzqK2DAzz4ukKrmnjBVeeiC2hqyDib37BBbl0i44XGlyD+amZVqzX/ME
 /6JvK339TmZy7Siu/jfGfAoIz6FlTSWy0wqBEXwjUkoMQrjylwonQNKJr9ClMuc4lqh/
 Xdmw==
X-Gm-Message-State: AOAM532An5SW6tn8BYa5FSKgySo82CIyl9oRyWZGJEAIrg2zRMAkdvr3
 /5v3qqn1e0xbdCtCMas7y5fN4GLCzXb2jZ0ftpdrYQC6gQ0x6Z6mN/NBJvtFcimn6i9IBFA3zZP
 fBzWOtdeVXkgiQUA=
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr4006428wmg.74.1603214731953; 
 Tue, 20 Oct 2020 10:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNO6zieAEOVpRkAAZXHzH2TRDOFEjvVim9G2bC4wnC7CtCOxOX4XTYh9uYJnJAzriwgN4DAQ==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr4006409wmg.74.1603214731750; 
 Tue, 20 Oct 2020 10:25:31 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 30sm4074936wrr.35.2020.10.20.10.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] util/vfio-helpers: Let qemu_vfio_verify_mappings() use
 error_report()
Date: Tue, 20 Oct 2020 19:24:24 +0200
Message-Id: <20201020172428.2220726-13-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of displaying the error on stderr, use error_report()
which also report to the monitor.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index fb180becc4f..874d76c2a2a 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -691,13 +691,13 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
     if (QEMU_VFIO_DEBUG) {
         for (i = 0; i < s->nr_mappings - 1; ++i) {
             if (!(s->mappings[i].host < s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d not sorted!\n", i);
+                error_report("item %d not sorted!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
             if (!(s->mappings[i].host + s->mappings[i].size <=
                   s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d overlap with next!\n", i);
+                error_report("item %d overlap with next!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
-- 
2.26.2


