Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7351C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C184223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwdlGnD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C184223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7N3-0001oS-CP
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nx-0007SP-DG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nv-0004y2-Iu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzRB4cjrp4u7lt1vcXzG7IhYHDqdOiEuFhG6Dq+h9EY=;
 b=RwdlGnD0f+k8MZ7ry2fWLiCflv2kMb7ma4vQX+8xbtHoqOI9mTXiICcMoyJqBL/bcbd+9p
 MVrGCzJNPaubTmB4Lhanwx4RQme4zE/iaZrtbiaeulkUI/bmwwIhV0mNNQjq1r9YKfQvJP
 ZJTkVXTjH8Sjo/bhyHbofiTXTfLTx0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-MblLetRpM7a0Ve_uZxc5qA-1; Tue, 03 Nov 2020 19:37:33 -0500
X-MC-Unique: MblLetRpM7a0Ve_uZxc5qA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED7A6D243
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:32 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8255E747C6;
 Wed,  4 Nov 2020 00:37:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 64/72] scripts/qmp-shell: Fix empty-transaction invocation
Date: Tue,  3 Nov 2020 19:35:54 -0500
Message-Id: <20201104003602.1293560-65-jsnow@redhat.com>
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

calling "transaction( )" is pointless, but valid. Rework the parser to
allow this kind of invocation. This helps clean up exception handling
later by removing accidental breakages of the parser that aren't
explicitly forbidden.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 3c32b576a37d..78e4eae00754 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -244,11 +244,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         cmdargs = re.findall(argument_regex, cmdline)
         qmpcmd: QMPMessage
 
-        # Transactional CLI entry/exit:
-        if cmdargs[0] == 'transaction(':
+        # Transactional CLI entry:
+        if cmdargs and cmdargs[0] == 'transaction(':
             self._transmode = True
+            self._actions = []
             cmdargs.pop(0)
-        elif cmdargs[0] == ')' and self._transmode:
+
+        # Transactional CLI exit:
+        if cmdargs and cmdargs[0] == ')' and self._transmode:
             self._transmode = False
             if len(cmdargs) > 1:
                 msg = 'Unexpected input after close of Transaction sub-shell'
@@ -257,15 +260,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 'execute': 'transaction',
                 'arguments': {'actions': self._actions}
             }
-            self._actions = list()
             return qmpcmd
 
-        # Nothing to process?
+        # No args, or no args remaining
         if not cmdargs:
             return None
 
-        # Parse and then cache this Transactional Action
         if self._transmode:
+            # Parse and cache this Transactional Action
             finalize = False
             action = {'type': cmdargs[0], 'data': {}}
             if cmdargs[-1] == ')':
-- 
2.26.2


