Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5762C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B692076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNuM219I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B692076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr0c-0007qh-G3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt0-0004Un-1U
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsy-0007e1-9m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRADnjcvuYBbKImJ2ASizBGrKG22BEIAUr5NiDqqnjo=;
 b=JNuM219IC43QWEaLLSvDUFrcpqoXZCD8T03vgrtL55/N4gSAUHabyaklkppGHW/cqcMUhR
 nkTzrqueXAlnHTrVf8PRzu2K14AUikwhDyBSTICBPK6PTaARGw2LaaKytbzcBXVvL5Z6gE
 TBTSwrwNt1hfC6EXHZouZ7mSVRG6/eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-M6TWuIsJOveOnkxQ2NpgkA-1; Tue, 22 Sep 2020 18:35:41 -0400
X-MC-Unique: M6TWuIsJOveOnkxQ2NpgkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AF9801AE8;
 Tue, 22 Sep 2020 22:35:40 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C83D60BF4;
 Tue, 22 Sep 2020 22:35:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 12/26] qapi/parser.py: add casts to pragma checks
Date: Tue, 22 Sep 2020 18:35:11 -0400
Message-Id: <20200922223525.4085762-13-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This kind of type checking at runtime is not something mypy can
introspect, so add a do-nothing cast to help mypy out.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 75a693a9d7..9a1007f779 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -17,7 +17,7 @@
 import os
 import re
 from collections import OrderedDict
-from typing import Type, TypeVar
+from typing import List, Type, TypeVar, cast
 
 from .error import QAPIError, QAPISourceError, QAPISemError
 from .source import QAPISourceInfo
@@ -176,14 +176,14 @@ def _pragma(cls, name, value, info):
                 raise QAPISemError(
                     info,
                     "pragma returns-whitelist must be a list of strings")
-            info.pragma.returns_whitelist = value
+            info.pragma.returns_whitelist = cast(List[str], value)
         elif name == 'name-case-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value])):
                 raise QAPISemError(
                     info,
                     "pragma name-case-whitelist must be a list of strings")
-            info.pragma.name_case_whitelist = value
+            info.pragma.name_case_whitelist = cast(List[str], value)
         else:
             raise QAPISemError(info, "unknown pragma '%s'" % name)
 
-- 
2.26.2


