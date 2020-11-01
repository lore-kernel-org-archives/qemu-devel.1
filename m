Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B69C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904D42224E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB1vVdAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904D42224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZG30-0006zL-Jy
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1J-0005tI-1I
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1D-0004T7-49
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604247345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsH6C6yhR4/WIsRbz4nkasXx3roTg46Lxsi9bJKtc7E=;
 b=KB1vVdAHcF3aTZGvT5X59YZt+8vvnRf4POjdxS2Dui5yE7HjnOb9cLvQAbkvgkuLaTwraQ
 82t9ZFHl1KOrBAUzmjVWMtuQxaPj9pWpTuuivXJeRKAeu1dX0lBIJXJkvWA4Mx48G0Phq1
 bKRIp9tf3+d9jttUvX2VW+EXlPX514w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-qGUm0qLBOU6HFvUdOf20mw-1; Sun, 01 Nov 2020 11:15:43 -0500
X-MC-Unique: qGUm0qLBOU6HFvUdOf20mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C5A802B72;
 Sun,  1 Nov 2020 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD93C5C1A3;
 Sun,  1 Nov 2020 16:15:38 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] iotests: add filter_qmp_virtio_scsi function
Date: Sun,  1 Nov 2020 18:15:31 +0200
Message-Id: <20201101161532.259609-2-mlevitsk@redhat.com>
In-Reply-To: <20201101161532.259609-1-mlevitsk@redhat.com>
References: <20201101161532.259609-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 11:15:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

filter_qmp_virtio_scsi can be used to filter virtio-scsi-pci/ccw differences.
Note that this patch was only tested on x86.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/iotests.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 63d2ace93c..18b7437600 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -392,6 +392,16 @@ def filter_qmp_testfiles(qmsg):
         return value
     return filter_qmp(qmsg, _filter)
 
+def filter_virtio_scsi(output: str) -> str:
+    return re.sub(r'(virtio-scsi)-(ccw|pci)', r'\1', output)
+
+def filter_qmp_virtio_scsi(qmsg):
+    def _filter(_key, value):
+        if is_str(value):
+            return filter_virtio_scsi(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def filter_generated_node_ids(msg):
     return re.sub("#block[0-9]+", "NODE_NAME", msg)
 
-- 
2.26.2


