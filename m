Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F273FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE142072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmJ20a2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE142072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTOS-0001A1-1r
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTK2-0001XV-LI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTK0-0004sh-Qv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqbjq2eSEV+Z/U6UkFGjrSQIABqGIU5R3iUFws37JAY=;
 b=QmJ20a2/sD161kWgLArsrYXvWGkZ80krPlIXHMy/aeTA++8tyQFDdFU1T5nVn/OTUMaVDq
 o5yIQYKGQ8xrgO40XQK4+Xvn4048U+nqk0+qgTZ3k2wWycdOL/A3+Lumcy1VMVsI603DtE
 YZ9EkFLSU/TMGjWZ9Rqexpm9IBb8ZQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-1yOtK8oUOZKQ54ZyAxLYWQ-1; Tue, 14 Jul 2020 18:22:42 -0400
X-MC-Unique: 1yOtK8oUOZKQ54ZyAxLYWQ-1
Received: by mail-wr1-f72.google.com with SMTP id b8so18304wro.19
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uqbjq2eSEV+Z/U6UkFGjrSQIABqGIU5R3iUFws37JAY=;
 b=GOzypodTAha2SGUxjA++hXKpww4EUSDtQ734q+Y7OxocXsyUdk/jHJxf3YWXaOwxQs
 87S4V26IhDE0fuoRWpIsIhBKJdqK5QcMBFWSpLIjQK/A/3V+Q2skLj2BlzqLE6UN7kAs
 5s7SPUj2Lve11WefBvEi+O+4KaPdCMPnILm514W7sMCyQFZDIP0xeFb+8eUCCeFbZkff
 nkHQZ4U2hqGgVNQ08C7tn0GNYIsZXLOc4AVR5ImN2/UVlfGVHHgjs9nx6EJ4M4mVelpO
 /sGM3a3r9w4kM9coAxOpmBlXFl/BCzHCBTrccWNs8RdFv0qNAi8kCdzkuNBMpDR/79h8
 L7XA==
X-Gm-Message-State: AOAM531gFCdT76C8ukWNcbGqc/fzr0HwjvBhtBYqDdM94PyyBXlLZTUZ
 o9G6m3W/MMi59jYfEQvCqzPkhD1FCmvqRYGTo+UkeWe3R2egGfKxOJcKzDp0MWzffXGNjIhmvos
 wldt2YK4gvognx4o=
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr8046335wrr.211.1594765361131; 
 Tue, 14 Jul 2020 15:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgw8+a9oaIkhkITRQEjINbjIs+0+n0DnAHgVxNPI4gCYRDO4i3daoVIKpHcyUjPf0DaYki/w==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr8046313wrr.211.1594765360916; 
 Tue, 14 Jul 2020 15:22:40 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q5sm173563wrp.60.2020.07.14.15.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] python/qmp.py: Define common types
Date: Wed, 15 Jul 2020 00:21:27 +0200
Message-Id: <20200714222132.10815-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Define some common types that we'll need to annotate a lot of other
functions going forward.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710052220.3306-2-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index e64b6b5faa..8388c7b603 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -12,13 +12,31 @@
 import socket
 import logging
 from typing import (
+    Any,
+    Dict,
     Optional,
     TextIO,
     Type,
+    Tuple,
+    Union,
 )
 from types import TracebackType
 
 
+# QMPMessage is a QMP Message of any kind.
+# e.g. {'yee': 'haw'}
+#
+# QMPReturnValue is the inner value of return values only.
+# {'return': {}} is the QMPMessage,
+# {} is the QMPReturnValue.
+QMPMessage = Dict[str, Any]
+QMPReturnValue = Dict[str, Any]
+
+InternetAddrT = Tuple[str, str]
+UnixAddrT = str
+SocketAddrT = Union[InternetAddrT, UnixAddrT]
+
+
 class QMPError(Exception):
     """
     QMP base exception
-- 
2.21.3


