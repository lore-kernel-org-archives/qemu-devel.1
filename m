Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4524C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8EC20756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2GP7ZA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8EC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXURc-0003um-1D
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJY-0001Tx-Cm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJU-0001P6-9S
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggFlIADItJCoiCf1kDHONF0fqU+dpf6qGPMd9OFP0FI=;
 b=Q2GP7ZA4ogO85OPxUoJZZFYET1Fd/XohUxFCGFOb72nGW5gWDzLP1e+h6VGSbmTEgLEU+n
 ROSRu7nUWThZZHIDtIVFmwV0KpKJmIzDTFm1BKYWTclr637bfUkUdxgi2yiEdyKIdvrbKO
 V8gw+nW2bAlZ5M5Doyd3jXf1ljQVpUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-MCAmPDEKMRC8cT-Zis7IzQ-1; Tue, 27 Oct 2020 15:07:17 -0400
X-MC-Unique: MCAmPDEKMRC8cT-Zis7IzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52041800FFF;
 Tue, 27 Oct 2020 19:07:16 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 387AC1992F;
 Tue, 27 Oct 2020 19:07:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 13/20] iotests: Restrict some Python tests to file
Date: Tue, 27 Oct 2020 20:05:53 +0100
Message-Id: <20201027190600.192171-14-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most Python tests are restricted to the file protocol (without
explicitly saying so), but these are the ones that would break
./check -fuse -qcow2.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/206 | 3 ++-
 tests/qemu-iotests/242 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 11bc51f256..0a3ee5ef00 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -23,7 +23,8 @@
 import iotests
 from iotests import imgfmt
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_protocols=['file'])
 iotests.verify_working_luks()
 
 with iotests.FilePath('t.qcow2') as disk_path, \
diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 64f1bd95e4..a16de3085f 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -24,7 +24,8 @@ import struct
 from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
     file_path, img_info_log, log, filter_qemu_io
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_protocols=['file'])
 
 disk = file_path('disk')
 chunk = 256 * 1024
-- 
2.26.2


