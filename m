Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D06CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006B020B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZjTu6wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006B020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMp5Y-0007XT-EX
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1j-0002ik-C7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1i-0005sQ-9W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1i-0005rK-5E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvicZeuGgMc11j095K3+QYG6XC/p0SLAFGOOc9IjEnE=;
 b=PZjTu6woCIEUzo2AOFYv0OjHrwjL3DGTr19voeZdjMp92ZCyO7FtRx79dx3ghU3U+VfYYW
 jeSzSvd9sR0xbesXc4zULLxosbNq40TRGXg0XkKeTKTwji/9X6soIPVk9ffgh++AMmhaRs
 INhQAqloCMH1QpN5o0dDslxCVLBVhUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-29bL_cRVNi2yuAAVLjbOFg-1; Tue, 22 Oct 2019 03:56:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E5F1800DFE
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0724360C4E;
 Tue, 22 Oct 2019 07:56:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9279611328A8; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] qapi: Allow introspecting fix for savevm's cooperation
 with blockdev
Date: Tue, 22 Oct 2019 09:56:15 +0200
Message-Id: <20191022075615.956-13-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 29bL_cRVNi2yuAAVLjbOFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Krempa <pkrempa@redhat.com>

'savevm' was buggy as it considered all monitor-owned block device
nodes for snapshot. With the introduction of -blockdev, the common
usage made all nodes including protocol and backing file nodes be
monitor-owned and thus considered for snapshot.

This is a problem since the 'file' protocol nodes can't have internal
snapshots and it does not make sense to take snapshot of nodes
representing backing files.

This was fixed by commit 05f4aced658a02b02. Clients need to be able to
detect whether this fix is present.

Since savevm does not have an QMP alternative, add the feature for the
'human-monitor-command' backdoor which is used to call this command in
modern use.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191018081454.21369-6-armbru@redhat.com>
---
 qapi/misc.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 6bd11f50e6..33b94e3589 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1020,6 +1020,12 @@
 #
 # @cpu-index: The CPU to use for commands that require an implicit CPU
 #
+# Features:
+# @savevm-monitor-nodes: If present, HMP command savevm only snapshots
+#                        monitor-owned nodes if they have no parents.
+#                        This allows the use of 'savevm' with
+#                        -blockdev. (since 4.2)
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
+  'features': [ 'savevm-monitor-nodes' ] }
=20
 ##
 # @change:
--=20
2.21.0


