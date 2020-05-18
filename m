Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62DEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11EC20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpBIZIMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11EC20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jailW-0004aw-R5
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigo-0005LU-55
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaign-0003I0-83
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DaVhlUUMzLKCmXvrlPg1FK7qEoUxfS7ou598eeRodQ=;
 b=WpBIZIMQ8/QMicW0OA8rQPdYFldl9KJMuHI4QdT8YwqTtUiPhB2jA0pQfdWRmvslEPEiXg
 vjfgj6MJPMiHoIxiOwRfck/IhbjIY0eYqWdtoSGE18iu+2uZeFStsqQtBt5kqKJktg38ji
 dvfiQ5doV06jFYiLRAOlDk9kWaQpvIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-nZMhFrT7MP6RjvcBdaSVxQ-1; Mon, 18 May 2020 12:32:25 -0400
X-MC-Unique: nZMhFrT7MP6RjvcBdaSVxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A8A1B18BC1;
 Mon, 18 May 2020 16:32:24 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CCB65D9DC;
 Mon, 18 May 2020 16:32:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] iotests: Enhance 223 to cover qemu-img map improvements
Date: Mon, 18 May 2020 11:32:18 -0500
Message-Id: <20200518163218.649412-7-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since qemu-img map + x-dirty-bitmap remains the easiest way to read
persistent bitmaps at the moment, it makes a reasonable place to add
coverage to ensure we do not regress on the just-added parameters to
qemu-img map.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513181455.295267-1-eblake@redhat.com>
---
 tests/qemu-iotests/223     | 6 ++++--
 tests/qemu-iotests/223.out | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 56fbc5fb09a0..d68bc3cb6f1a 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -2,7 +2,7 @@
 #
 # Test reading dirty bitmap over NBD
 #
-# Copyright (C) 2018-2019 Red Hat, Inc.
+# Copyright (C) 2018-2020 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -206,7 +206,9 @@ $QEMU_IMG map --output=json --image-opts \

 nbd_server_start_unix_socket -f $IMGFMT -B b2 "$TEST_IMG"
 IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
-$QEMU_IMG map --output=json --image-opts \
+$QEMU_IMG map --output=json --image-opts --max-length=12345 \
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+$QEMU_IMG map --output=json --image-opts --start-offset=12345 \
   "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map

 # success, all done
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 80c0cf65095b..e1eaaedb55b3 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -201,6 +201,7 @@ read 2097152/2097152 bytes at offset 2097152
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
 [{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 512, "length": 512, "depth": 0, "zero": false, "data": false},
-{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 1024, "length": 11321, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 12345, "length": 2084807, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
 *** done
-- 
2.26.2


