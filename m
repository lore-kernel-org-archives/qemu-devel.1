Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F71C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183B8205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvSpgwja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183B8205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6vy-0003d8-7T
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pO-0005Ml-J1
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pN-0001fD-7w
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLopj5+tE2Im0zOun4FriY1g+NiPrVStSQhtAYK0hb4=;
 b=VvSpgwjaUY7wK9wdWdUvXVJBEEZBLfQsTtbJGtqj3c41Or/MeCdrQGlIwYLUfaHDEs7fII
 Jyo2mwtzRZ33pY5CjkGcERTQmc/eFQQjYNJqQdmX1cqpqfIclfpZ2VpLevw4den9OWkUHZ
 Mi/MQhzCCIxzIJ38kUeNAnLdKCFRCoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-ttWxpgxoM3GekPSRDjqL8g-1; Thu, 14 May 2020 01:54:39 -0400
X-MC-Unique: ttWxpgxoM3GekPSRDjqL8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7BDA1054F90;
 Thu, 14 May 2020 05:54:37 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B0F16A977;
 Thu, 14 May 2020 05:54:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 15/32] python//qmp.py: Define common types
Date: Thu, 14 May 2020 01:53:46 -0400
Message-Id: <20200514055403.18902-16-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define some common types that we'll need to annotate a lot of other
functions going forward.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/qmp.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
index a634c4e26c..911da59888 100644
--- a/python/qemu/lib/qmp.py
+++ b/python/qemu/lib/qmp.py
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
2.21.1


