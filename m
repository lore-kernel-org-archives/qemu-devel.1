Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BCC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD502087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nrlsv+Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD502087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLzV-00004v-3S
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlM-0005wj-7p
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlK-0004h3-Do
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tECdwUYF+oIp0oxRe5fDNiplM/uofWjCiUmXCFNzxbM=;
 b=Nrlsv+PjG3D+7qvviR5t/oBnT6xuVb3V0NfzHhk/fbAOdZ0+26dlhyuhcQzgSDVcb7smnu
 Zcvmd0ucc1AkjAUwlP1yPbpP+6O5KcxUUgip9ZDf/AlpdjCSvc/AN/WdRfuWRpLLRLlG0M
 54BShhmlpGnRPeD7AU8wZhqy4cv135Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-j7KVAvCRPBeQthJ0W7AJ7A-1; Mon, 07 Sep 2020 14:21:03 -0400
X-MC-Unique: j7KVAvCRPBeQthJ0W7AJ7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02791801F98;
 Mon,  7 Sep 2020 18:21:03 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE2E60BF3;
 Mon,  7 Sep 2020 18:21:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 27/29] nbd: Deprecate nbd-server-add/remove
Date: Mon,  7 Sep 2020 20:20:09 +0200
Message-Id: <20200907182011.521007-28-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These QMP commands are replaced by block-export-add/del.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json     | 11 +++++++++--
 docs/system/deprecated.rst |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ebdfa978e0..ace0d66e17 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -108,13 +108,16 @@
 #
 # The export name will be used as the id for the resulting block export.
 #
+# Features:
+# @deprecated: This command is deprecated. Use @block-export-add instead.
+#
 # Returns: error if the server is not running, or export with the same name
 #          already exists.
 #
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': 'NbdServerAddOptions', 'boxed': true }
+  'data': 'NbdServerAddOptions', 'boxed': true, 'features': ['deprecated'] }
 
 ##
 # @BlockExportRemoveMode:
@@ -147,6 +150,9 @@
 # @mode: Mode of command operation. See @BlockExportRemoveMode description.
 #        Default is 'safe'.
 #
+# Features:
+# @deprecated: This command is deprecated. Use @block-export-del instead.
+#
 # Returns: error if
 #            - the server is not running
 #            - export is not found
@@ -155,7 +161,8 @@
 # Since: 2.12
 ##
 { 'command': 'nbd-server-remove',
-  'data': {'name': 'str', '*mode': 'BlockExportRemoveMode'} }
+  'data': {'name': 'str', '*mode': 'BlockExportRemoveMode'},
+  'features': ['deprecated'] }
 
 ##
 # @nbd-server-stop:
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 851dbdeb8a..9a2e083f00 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -303,6 +303,14 @@ chardev client socket with ``wait`` option (since 4.0)
 Character devices creating sockets in client mode should not specify
 the 'wait' field, which is only applicable to sockets in server mode
 
+``nbd-server-add`` and ``nbd-server-remove`` (since 5.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use the more generic commands ``block-export-add`` and ``block-export-del``
+instead.
+
+Use argument value ``null`` instead.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
-- 
2.25.4


