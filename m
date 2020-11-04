Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06584C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BD4223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvRImPQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BD4223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7LZ-0007ir-Qn
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nv-0007NR-Pc
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nt-0004xp-9u
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIFuMouv3BevsTrVSomuc/EthhkE99OcgJhVE2XMzY8=;
 b=IvRImPQvAHmzTxlHhwT8QN0hfiomj2uDij75/m8vn4bpT4hTSVhJh2CUv71xyNkNMng+qb
 c8MSup/zoYTny8nYlHABAfCY9Yqg8XVFSbirmZFPpA8DIhhSGTF/AQDCgimSrqqwxSpxDG
 wGBEfGjFzTQuRF7SC+zSmSILuXE0jJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-qEaK0t9-Peei9aKrMiv0tg-1; Tue, 03 Nov 2020 19:37:31 -0500
X-MC-Unique: qEaK0t9-Peei9aKrMiv0tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29E301009E26
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:30 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36C7E55766;
 Wed,  4 Nov 2020 00:37:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 62/72] scripts/qmp-shell: use logging to show warnings
Date: Tue,  3 Nov 2020 19:35:52 -0500
Message-Id: <20201104003602.1293560-63-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Perfect candidate is non-fatal shell history messages.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index ec028d662e8e..0199a13a3428 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -67,6 +67,7 @@
 import argparse
 import ast
 import json
+import logging
 import os
 import re
 import readline
@@ -85,6 +86,9 @@ from qemu import qmp
 from qemu.qmp import QMPMessage
 
 
+LOG = logging.getLogger(__name__)
+
+
 class QMPCompleter:
     # NB: Python 3.9+ will probably allow us to subclass list[str] directly,
     # but pylint as of today does not know that List[str] is simply 'list'.
@@ -167,13 +171,15 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         except FileNotFoundError:
             pass
         except IOError as err:
-            print(f"Failed to read history '{self._histfile}': {err!s}")
+            msg = f"Failed to read history '{self._histfile}': {err!s}"
+            LOG.warning(msg)
 
     def _save_history(self) -> None:
         try:
             readline.write_history_file(self._histfile)
         except IOError as err:
-            print(f"Failed to save history file '{self._histfile}': {err!s}")
+            msg = f"Failed to save history file '{self._histfile}': {err!s}"
+            LOG.warning(msg)
 
     @classmethod
     def __parse_value(cls, val: str) -> object:
-- 
2.26.2


