Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C207C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0975D221F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au8KAKSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0975D221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJFT-0007gE-Vi
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDw-000614-G9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0008Bo-3S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQE/Z6dWjoyKPIdOwpBAD6aWf7xfgEBvU+DWKrI/rnA=;
 b=au8KAKSOLkNE4aw0zZmRnTuxDy+acyrw0rYDQzK7wZORY8EaBRRJyK7SyTmD6D+u62Fwyp
 dPcDKsEVuRp9dW0giDXRt1mzzCgegnTixMri8MLK1HxZjRDSEInLaGMGfwVhy5Qc0QS/nS
 7xQwoUhZ3ywIqQL3GmLxANqewWA2fbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-w05vXY0cPaaIoW-Li_IPnw-1; Wed, 21 Oct 2020 14:52:21 -0400
X-MC-Unique: w05vXY0cPaaIoW-Li_IPnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F385F9C2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:20 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3423D10027A5;
 Wed, 21 Oct 2020 18:52:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] scripts/qom-fuse: move to python/qemu/qmp/qom_fuse.py
Date: Wed, 21 Oct 2020 14:52:06 -0400
Message-Id: <20201021185208.1611145-14-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move qom-fuse over to the python package now that it passes the
linter. Update the import paradigms so that it passes.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse => python/qemu/qmp/qom_fuse.py | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)
 rename scripts/qmp/qom-fuse => python/qemu/qmp/qom_fuse.py (95%)
 mode change 100755 => 100644

diff --git a/scripts/qmp/qom-fuse b/python/qemu/qmp/qom_fuse.py
old mode 100755
new mode 100644
similarity index 95%
rename from scripts/qmp/qom-fuse
rename to python/qemu/qmp/qom_fuse.py
index 22be366349..b0adcc1f8e
--- a/scripts/qmp/qom-fuse
+++ b/python/qemu/qmp/qom_fuse.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python3
 """
 QEMU Object Model FUSE filesystem tool
 
@@ -36,7 +35,6 @@
 
 import argparse
 from errno import ENOENT, EPERM
-import os
 import stat
 import sys
 from typing import (
@@ -51,10 +49,8 @@
 import fuse
 from fuse import FUSE, FuseOSError, Operations
 
-
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QMPResponseError
-from qemu.qmp.qom_common import QOMCommand
+from . import QMPResponseError
+from .qom_common import QOMCommand
 
 
 fuse.fuse_python_api = (0, 2)
@@ -209,7 +205,3 @@ def readdir(self, path: str, fh: IO[bytes]) -> Iterator[str]:
         yield '..'
         for item in self.qom_list(path):
             yield item.name
-
-
-if __name__ == '__main__':
-    sys.exit(QOMFuse.entry_point())
-- 
2.26.2


