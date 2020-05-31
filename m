Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F15C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95692074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQO9oomH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95692074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRD8-0005ij-Vo
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0s-0003lt-BL
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0r-00077Z-GS
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtnVaYYGa7/aqTUYxIxdKhEN8NJpUIW8xv7x+iz9PNM=;
 b=PQO9oomHuKQXAetbNgAG2bFhyMYaVLgaIEhbWrbaxERj8G+zmR4/rsz9J7D9T6zvUPOb3k
 EQUVcTkbQX4GFgkpG5dAHWIpRXnynEXahueYwh4UkpyZaw6fpYeHg7FDfxsMIcFbX1u3hg
 2w8eizMPrw4oDMLqyn8EVvg97QGo5NM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-WYOkyo1POT6I94oeh47AYw-1; Sun, 31 May 2020 12:40:37 -0400
X-MC-Unique: WYOkyo1POT6I94oeh47AYw-1
Received: by mail-wr1-f69.google.com with SMTP id h6so3649462wrx.4
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VtnVaYYGa7/aqTUYxIxdKhEN8NJpUIW8xv7x+iz9PNM=;
 b=AZD8Ilbz5Fyz/9qVoBwWNhQ5FfIScy2murvKY21qnfJCoIilWWOKA5mYzl38zoPQoe
 VUBmSPEPKeAUrhAtiKCgoIocOwFWzpL3Ydb8whI8brTn57mjHL9GmCRK8G+V07IkZ1O0
 SxUGlxWODvdcNYKWYRkPZbExo7DU0ODPd1pzDCyJ81s5840livT/qwaGuurNZnwWtOD8
 7veEDYAEm/vZ5QEKrZILW+qvOD7ANqPgYqfwOHxbaqeYHxCn6aP5h9mCiuEvpkNsQT27
 IkJ2VivswpvgUFTjBD5wbrEsbTYsDiHfRgRGOb89BpoEatcvDywdfcxX6c2FHcOrVtk0
 z/ZA==
X-Gm-Message-State: AOAM533GxlGlzoOcXImw5CnZ+52WHnjgWqFV1FyVKPFBwv+1fgCnmhsm
 y9Cvbd8i6HPJFS+Lbdbbe8WO3HNktFQg9P5kP31Zppn9r3sTHldAZTHlLD6Q49xmE/ViQYzb3NP
 RGvmGX5kFWWyiazY=
X-Received: by 2002:a5d:4484:: with SMTP id j4mr17681268wrq.325.1590943236590; 
 Sun, 31 May 2020 09:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgZwwOTcr688HaliXjwVILCgXMwwdoueLVIOVtH/2dXXqGIkOpERxl7rjGuHjeNfqMMGldnQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr17681252wrq.325.1590943236436; 
 Sun, 31 May 2020 09:40:36 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d13sm8390301wmb.39.2020.05.31.09.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/25] tests/migration/guestperf: Use Python 3 interpreter
Date: Sun, 31 May 2020 18:38:42 +0200
Message-Id: <20200531163846.25363-22-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200512103238.7078-7-philmd@redhat.com>
---
 tests/migration/guestperf-batch.py | 2 +-
 tests/migration/guestperf-plot.py  | 2 +-
 tests/migration/guestperf.py       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index cb150ce804..f1e900908d 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test batch comparison invokation
 #
diff --git a/tests/migration/guestperf-plot.py b/tests/migration/guestperf-plot.py
index d70bb7a557..907151011a 100755
--- a/tests/migration/guestperf-plot.py
+++ b/tests/migration/guestperf-plot.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test graph plotting command
 #
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index 99b027e8ba..ba1c4bc4ca 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test direct invokation command
 #
-- 
2.21.3


