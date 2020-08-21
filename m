Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD67C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4CC20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6SEspwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4CC20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97je-0000Cv-7P
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97in-0006qp-3x
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97ik-0004VD-Hd
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uHSGE1QSAmI5bNa26JHPi6ph20kehqML5uG+ym6vxA=;
 b=S6SEspwUlmLNpCIdOfpUg1sTP2wEYk3GQETkLZB2WzRARM7SI3qnwlOjxUY+O4YPvs9Lkd
 DVJ7MvfYsTXsGCKLIcv5PiHXxkkvaY7PTKiQ/FPK+hGr/+SlY/fZKdZp+123ppTxrAhulL
 6sN1NLyARL9XSdEGEnzV9jFtty/TKu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-fsbBm6SbNNeRUDZQMUsUKQ-1; Fri, 21 Aug 2020 10:08:39 -0400
X-MC-Unique: fsbBm6SbNNeRUDZQMUsUKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 394C018A2252;
 Fri, 21 Aug 2020 14:08:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3A2D7AECA;
 Fri, 21 Aug 2020 14:08:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] qcow2_format.py: support dumping metadata in JSON format
Date: Fri, 21 Aug 2020 09:08:22 -0500
Message-Id: <20200821140826.194322-11-eblake@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Implementation of dumping QCOW2 image metadata.
The sample output:
{
    "Header_extensions": [
        {
            "name": "Feature table",
            "magic": 1745090647,
            "length": 192,
            "data_str": "<binary>"
        },
        {
            "name": "Bitmaps",
            "magic": 595929205,
            "length": 24,
            "data": {
                "nb_bitmaps": 2,
                "reserved32": 0,
                "bitmap_directory_size": 64,
                "bitmap_directory_offset": 1048576,
                "bitmap_directory": [
                    {
                        "name": "bitmap-1",
                        "bitmap_table_offset": 589824,
                        "bitmap_table_size": 1,
                        "flags": 2,
                        "type": 1,
                        "granularity_bits": 15,
                        "name_size": 8,
                        "extra_data_size": 0,
                        "bitmap_table": [
                            {
                                "type": "serialized",
                                "offset": 655360
                            },
                            ...

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-11-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 5a298b2f1357..8adc9959e10b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -19,6 +19,15 @@

 import struct
 import string
+import json
+
+
+class ComplexEncoder(json.JSONEncoder):
+    def default(self, obj):
+        if hasattr(obj, 'to_json'):
+            return obj.to_json()
+        else:
+            return json.JSONEncoder.default(self, obj)


 class Qcow2Field:
@@ -110,6 +119,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
                              for i, field in enumerate(self.fields))

     def dump(self, is_json=False):
+        if is_json:
+            print(json.dumps(self.to_json(), indent=4, cls=ComplexEncoder))
+            return
+
         for f in self.fields:
             value = self.__dict__[f[2]]
             if isinstance(f[1], str):
@@ -445,6 +458,10 @@ class QcowHeader(Qcow2Struct):
         fd.write(buf)

     def dump_extensions(self, is_json=False):
+        if is_json:
+            print(json.dumps(self.extensions, indent=4, cls=ComplexEncoder))
+            return
+
         for ex in self.extensions:
             print('Header extension:')
             ex.dump()
-- 
2.28.0


