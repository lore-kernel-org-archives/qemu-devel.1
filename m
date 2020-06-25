Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E3F2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlgUlIHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E3F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRSn-00082E-3i
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQH-0002jT-AK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQE-0003Ft-67
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d//rYIbCwWdhmLKDSSCRHcgxJk2B7bvxxTpZ1y64v7Q=;
 b=UlgUlIHv5jq+T98wy2GJgtjq1gRO+KM5WEfNIBWBxmgvgFRER9/GWbCqV1NDRaj4O+qLYU
 KDn9CP4EDt91WWeyGQPbSZ1B31C+NIPH0MIcFe7s4nAtaWx/Xvtzuym/BzYH48kYKQ0tzq
 X3XlMvJmx3nQN1o8RJdNmVtb5bsQzjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-1K9kF27hPzeJPE1C_cK0aA-1; Thu, 25 Jun 2020 08:56:02 -0400
X-MC-Unique: 1K9kF27hPzeJPE1C_cK0aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B795718A8220;
 Thu, 25 Jun 2020 12:56:01 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5948D579A3;
 Thu, 25 Jun 2020 12:56:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/19] iotests.py: Add (verify|has)_working_luks()
Date: Thu, 25 Jun 2020 14:55:34 +0200
Message-Id: <20200625125548.870061-6-mreitz@redhat.com>
In-Reply-To: <20200625125548.870061-1-mreitz@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to _require_working_luks for bash tests, these functions can be
used to check whether our luks driver can actually create images.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index eee94e18cc..039170a8a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1052,6 +1052,45 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
 
+def has_working_luks() -> Tuple[bool, str]:
+    """
+    Check whether our LUKS driver can actually create images
+    (this extends to LUKS encryption for qcow2).
+
+    If not, return the reason why.
+    """
+
+    img_file = f'{test_dir}/luks-test.luks'
+    (output, status) = \
+        qemu_img_pipe_and_status('create', '-f', 'luks',
+                                 '--object', luks_default_secret_object,
+                                 '-o', luks_default_key_secret_opt,
+                                 '-o', 'iter-time=10',
+                                 img_file, '1G')
+    try:
+        os.remove(img_file)
+    except OSError:
+        pass
+
+    if status != 0:
+        reason = output
+        for line in output.splitlines():
+            if img_file + ':' in line:
+                reason = line.split(img_file + ':', 1)[1].strip()
+                break
+
+        return (False, reason)
+    else:
+        return (True, '')
+
+def verify_working_luks():
+    """
+    Skip test suite if LUKS does not work
+    """
+    (working, reason) = has_working_luks()
+    if not working:
+        notrun(reason)
+
 def qemu_pipe(*args):
     """
     Run qemu with an option to print something and exit (e.g. a help option).
-- 
2.26.2


