Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACFF206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACFF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWJ4-0007yW-G8
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIWGF-0005Ga-Jc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIWGA-0000tg-KO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIWGA-0000t0-F0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADF973CA00
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:05:29 +0000 (UTC)
Received: from angien.brq.redhat.com (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FFA60BE1;
 Thu, 10 Oct 2019 11:05:28 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] qapi: Allow introspecting fix for savevm's cooperation
 with blockdev
Date: Thu, 10 Oct 2019 13:05:24 +0200
Message-Id: <be94d24847d38cb5a1172ed22d0f86e7c0ec8562.1570705279.git.pkrempa@redhat.com>
In-Reply-To: <cover.1570705279.git.pkrempa@redhat.com>
References: <cover.1570705279.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 11:05:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'savevm' was buggy as it considered all monitor-owned block device nodes
for snapshot. With introduction of -blockdev the common usage made all
nodes including protocol and backing file nodes monitor-owned and thus
considered for snapshot.

This is a problem since the 'file' protocol nodes can't have internal
snapshots and it does not make sense to take snapshot of nodes
representing backing files.

This was fixed by commit 05f4aced658a02b02 clients need to be able to
detect whether this fix is present.

Since savevm does not have an QMP alternative, add the feature for the
'human-monitor-command' backdoor which is used to call this command in
modern use.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 qapi/misc.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 6bd11f50e6..5d0070aa43 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1020,6 +1020,12 @@
 #
 # @cpu-index: The CPU to use for commands that require an implicit CPU
 #
+# Features:
+# @savevm-blockdev-monitor-nodes: If present, the HMP command savevm onl=
y
+#                                 snapshots monitor-owned nodes if they =
have no
+#                                 parents. This allows to use 'savevm' w=
ith
+#                                 -blockdev. (since 4.2)
+#
 # Returns: the output of the command as a string
 #
 # Since: 0.14.0
@@ -1047,7 +1053,8 @@
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
-  'returns': 'str' }
+  'returns': 'str',
+  'features': [ 'savevm-blockdev-monitor-nodes' ] }

 ##
 # @change:
--=20
2.21.0


