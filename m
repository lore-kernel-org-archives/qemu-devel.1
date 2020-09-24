Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BD7C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29362311E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5fflALv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29362311E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from [::1] (port=38622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTke-0001lY-MY
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTB3-000282-6Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAl-0005cs-GA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFRRiDWAtrVAgcDdjyzK1wV37h5mwxiZTlXZqCd+6ec=;
 b=M5fflALvQVXvfc8UF9Ut7HOuF/7mgw5dPYatR42YgcgFM1OhYqioYhuEn28++dU18dBt9z
 LKjfjyk8xjFf4nFbrfJI+DLA4BCSdTu+pihHWzs6FONjbQ7J0GGlJg0cbPZ9d5WBm0M2Bv
 6NPW8vmbYqfQnDvbq7jScgW5JsdQq0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-5VB9lzqkPgCRCMq5GUUHkg-1; Thu, 24 Sep 2020 11:28:22 -0400
X-MC-Unique: 5VB9lzqkPgCRCMq5GUUHkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB72884E49;
 Thu, 24 Sep 2020 15:28:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F60660C04;
 Thu, 24 Sep 2020 15:28:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 27/31] nbd: Deprecate nbd-server-add/remove
Date: Thu, 24 Sep 2020 17:27:13 +0200
Message-Id: <20200924152717.287415-28-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These QMP commands are replaced by block-export-add/del.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json     | 11 +++++++++--
 docs/system/deprecated.rst |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ad01e9f8aa..2291d6cb0c 100644
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
index 808c334fe7..71276c08f3 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -303,6 +303,12 @@ chardev client socket with ``wait`` option (since 4.0)
 Character devices creating sockets in client mode should not specify
 the 'wait' field, which is only applicable to sockets in server mode
 
+``nbd-server-add`` and ``nbd-server-remove`` (since 5.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use the more generic commands ``block-export-add`` and ``block-export-del``
+instead.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
-- 
2.25.4


