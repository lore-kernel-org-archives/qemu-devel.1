Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABCB205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVOcHED6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABCB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFS0-00051x-Cm
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwf-0003Kl-6V
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwe-0000sB-BA
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fZcSJPuDm3rgQwqx1pq50sJQ8CKF/TiPFjSTzaQEVo=;
 b=KVOcHED6ZQg/Zv6GzaQpAR6YV4OxiGkN/lLlU+rE30xB/MyDnTGcQH6OeZrxvjGFcpFcgI
 CarvCf1I1gqZIveYXrPKg5JMuKflkzD5O2Nfi0mAwi4PltCCdHMTQHzziRsTHRJCs+ZIo4
 SL6QCY9YXQ4Ih6SXHUWaWqU4XJMm+4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-S9x9ucT0P4uXYOZjaKer1g-1; Thu, 14 May 2020 10:34:41 -0400
X-MC-Unique: S9x9ucT0P4uXYOZjaKer1g-1
Received: by mail-wr1-f70.google.com with SMTP id 90so1656706wrg.23
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0fZcSJPuDm3rgQwqx1pq50sJQ8CKF/TiPFjSTzaQEVo=;
 b=eh2QxJsk6BynMgvJNeZJ4K+WdxR983xcGF2hFodkgdbXsBCvWnhTpcZoD6P7fRd04t
 Kbz/uYL51ZBsEsE84cfzT+8FnE5Ej5lD3hwoZzlB20ApZA1ti64dbptoIinRQ3crLAF2
 fOzpnOA0Jg7fPnwX9D6n6LYpGF3tPJAuEgzQ0xP2lvDJhbneVODx1glzjnEQaDXDBa5P
 MNMD1+1vgyTvvItB0irb9D+DS7zT0kS9UhuONdqnlfyHiHtvHZZyOSyjM8D57RBS7wh0
 Kct1cu8FxY1gcqvAGsovQbDmVdflf2dlNTQP6HKG6XTBDSysJ0X+ZMUReYedzzuxlZtV
 RGXw==
X-Gm-Message-State: AGi0PuZlV9oUaclfnb9ze/4+fJ3yuWQax1BHgNTWCOdEk9XncZW33oeh
 GTCf2oWmWSbrPg5uwT+cNBSlEE4PBniuCFvktD7b1wL3s4Pg/iIUA9CkQSZ+MKlOvcFAu21nb8R
 GcOTFp85muSI7AsA=
X-Received: by 2002:a1c:bbc5:: with SMTP id
 l188mr28304607wmf.163.1589466879630; 
 Thu, 14 May 2020 07:34:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypK13PQWHWc8MbuQyiea9a4gfdZCEWxdWQmg3oPs/8377GIDTWyRIkPo5A9KzhduV8A3YkXXcQ==
X-Received: by 2002:a1c:bbc5:: with SMTP id
 l188mr28304596wmf.163.1589466879479; 
 Thu, 14 May 2020 07:34:39 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q18sm6219068wmk.28.2020.05.14.07.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] tests/fuzz/Makefile: Do not link code using unavailable
 devices
Date: Thu, 14 May 2020 16:34:28 +0200
Message-Id: <20200514143433.18569-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some devices availability depends on CONFIG options.
Use these options to only link tests when requested device
is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/fuzz/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index cde3e9636c..f259d866c9 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -7,9 +7,9 @@ fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
 fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
 
 # Targets
-fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
-fuzz-obj-y += tests/qtest/fuzz/virtio_net_fuzz.o
-fuzz-obj-y += tests/qtest/fuzz/virtio_scsi_fuzz.o
+fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
+fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
+fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
 
 FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
-- 
2.21.3


