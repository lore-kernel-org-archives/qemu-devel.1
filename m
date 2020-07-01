Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56E82067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdcUdgYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56E82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdbl-00018S-4O
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqdNt-0002By-8l
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:06:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqdNq-0007Uz-4Z
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593612401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IdL0+cqpCKbYkoB0YZEy9wwctaF1+C6EUzgg6BzqkYw=;
 b=GdcUdgYyCZlxb2agqfUx+/2jkwcAFHxrM40uB5CywZAvER7acXzfNjIHWn8FlbVyTCcu7d
 OmG6mKxJGIXqRHyJ/WiNj3NdnixATYn60X9Y6oyED3BqYUa6Ahad5RdzKozEh73+oLHSCD
 sq5Bmjxo3tfkRuJoGTY0TlJYp+Zmhz0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-wWo8QloiOKWvqwj8rAY95Q-1; Wed, 01 Jul 2020 10:06:39 -0400
X-MC-Unique: wWo8QloiOKWvqwj8rAY95Q-1
Received: by mail-ed1-f70.google.com with SMTP id j15so16744546edq.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IdL0+cqpCKbYkoB0YZEy9wwctaF1+C6EUzgg6BzqkYw=;
 b=md272GDNl8VDVk+p7KUINYsYPF/NTAGjZlri1zRMXsWRyFoGwMLBNwNJTDSItNuWK2
 v41niRWGadxBnxnSDm/xITVj+qFlOdqk19XW9KWM5H4tUarEXhmxViJ16/TnqOceQSHN
 kQoqH9UXROTbpL2VSUF3UIedtyM7DjXv6oGVqbcBVTrSLFYuCQGYKvcptH03JMeIFBa6
 IJ0F/kWVeSH2Xv9aNhVcgORJxDCxu0hVbBfClU8zJWDT1exIGC48iXc1TOPlM6Ro8kJG
 S/W95RjBk9ig/O/IeKiwu3OCwAbEO/84z30ugDR+3cCZhU/+3Vjzf09n2Yy3Nu03M/+y
 T/1Q==
X-Gm-Message-State: AOAM53207jb1rxXSr0gQMtW1wkkgaHDerNufHVtDuq02TY4BhgMEnutv
 n5uBGK+kjXhNFRZd/rijeT2Ay2JBY/AxillnvqnI/gTtZIf1GSttI4fm8Y6KZ4cfiGbANaDYdQv
 1ya6Pq8DgPB7hMsA=
X-Received: by 2002:a50:aacc:: with SMTP id r12mr29162469edc.219.1593612397834; 
 Wed, 01 Jul 2020 07:06:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYiK+cJTVSG/SsYKLXwurq1hZ+IbN/aXiLGQVwm5Wao0Cz6tMOXHZ+eyqDENfWjFwkF5VDKg==
X-Received: by 2002:a50:aacc:: with SMTP id r12mr29162369edc.219.1593612397203; 
 Wed, 01 Jul 2020 07:06:37 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id mf24sm4673653ejb.58.2020.07.01.07.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:06:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Cover "block/nvme.h" file
Date: Wed,  1 Jul 2020 16:06:34 +0200
Message-Id: <20200701140634.25994-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "block/nvme.h" header is shared by both the NVMe block
driver and the NVMe emulated device. Add the 'F:' entry on
both sections, so all maintainers/reviewers are notified
when it is changed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Fam Zheng <fam@euphon.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Klaus Jensen <its@irrelevant.dk>
Cc: Klaus Jensen <k.jensen@samsung.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..9995cdc805 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1795,6 +1795,7 @@ M: Keith Busch <kbusch@kernel.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
+F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
 
 megasas
@@ -2804,6 +2805,7 @@ M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
+F: include/block/nvme.h
 
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
-- 
2.21.3


