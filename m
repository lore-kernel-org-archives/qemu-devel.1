Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D8720FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmaVq/yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D8720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97lM-0003h2-5r
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iu-000763-IC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97is-0004W9-Qu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGA1OwgdJtJFHMQOYUPRrEoY0FpOkOV+pPbvZU7ogLM=;
 b=JmaVq/yjvEPVIS3hXX5rc2+9UQcW70m3AfHPIWuPcmjerhio30hPhsfssq0+VgDt0P2taB
 Pztudt4yNt89pIbbH8YJcl/vDVstqizXQQGIlLHmcsYnUyhTkltm8eY4fwOlxSUNkup5w/
 hFFoJDiJtcx5yfmBpUOqQA/iKni5oGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-nJXqKfJPOEueYHCDMsOJvw-1; Fri, 21 Aug 2020 10:08:31 -0400
X-MC-Unique: nJXqKfJPOEueYHCDMsOJvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B26080EDA4;
 Fri, 21 Aug 2020 14:08:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 033BA7AEC9;
 Fri, 21 Aug 2020 14:08:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] qcow2_format.py: make printable data an extension class
 member
Date: Fri, 21 Aug 2020 09:08:14 -0500
Message-Id: <20200821140826.194322-3-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Let us differ binary data type from string one for the extension data
variable and keep the string as the QcowHeaderExtension class member.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index cc432e7ae06c..2f3681bb5f7c 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -165,6 +165,13 @@ class QcowHeaderExtension(Qcow2Struct):
             self.data = fd.read(padded)
             assert self.data is not None

+        data_str = self.data[:self.length]
+        if all(c in string.printable.encode('ascii') for c in data_str):
+            data_str = f"'{ data_str.decode('ascii') }'"
+        else:
+            data_str = '<binary>'
+        self.data_str = data_str
+
         if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
             self.obj = Qcow2BitmapExt(data=self.data)
         else:
@@ -174,12 +181,7 @@ class QcowHeaderExtension(Qcow2Struct):
         super().dump()

         if self.obj is None:
-            data = self.data[:self.length]
-            if all(c in string.printable.encode('ascii') for c in data):
-                data = f"'{ data.decode('ascii') }'"
-            else:
-                data = '<binary>'
-            print(f'{"data":<25} {data}')
+            print(f'{"data":<25} {self.data_str}')
         else:
             self.obj.dump()

-- 
2.28.0


