Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7570C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B198E20675
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYLJNUd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B198E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRUX-0002l1-Qh
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQF-0002hD-QR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQA-0003F9-K8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihmxd0CO3ZOTOwj0EkMFdc9CfMZNBqpvrsG268qXdwk=;
 b=BYLJNUd8Mqz5jz7MrBvqaS+f58c4PNSkDEqFg6tolzw3xajjSyDUD7O3XtQAx3F2FGD+u5
 3M2uhyyFFexwa0oiHfJ2NgcJ7JC/2C+50p9yjYr6S+8GT2xFv8zOLymvc7QUkUmBvonb4/
 xMcobOYkCi3e1vMXVsCTRewsX9SI0iM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-sF5YBoDGNB2p0vkZoYhBlw-1; Thu, 25 Jun 2020 08:55:58 -0400
X-MC-Unique: sF5YBoDGNB2p0vkZoYhBlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4794E18A8220;
 Thu, 25 Jun 2020 12:55:57 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA40579A3;
 Thu, 25 Jun 2020 12:55:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 03/19] iotests/common.rc: Add _require_working_luks
Date: Thu, 25 Jun 2020 14:55:32 +0200
Message-Id: <20200625125548.870061-4-mreitz@redhat.com>
In-Reply-To: <20200625125548.870061-1-mreitz@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

That the luks driver is present is little indication on whether it is
actually working.  Without the crypto libraries linked in, it does not
work.  So add this function, which tries to create a luks image to see
whether that actually works.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index ba912555ca..f3667f48ab 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -740,6 +740,33 @@ _unsupported_imgopts()
     done
 }
 
+# Caution: Overwrites $TEST_DIR/t.luks
+_require_working_luks()
+{
+    file="$TEST_DIR/t.luks"
+
+    output=$(
+        $QEMU_IMG create -f luks \
+            --object secret,id=sec0,data=hunter0 \
+            -o key-secret=sec0 \
+            -o iter-time=10 \
+            "$file" \
+            1M \
+            2>&1
+    )
+    status=$?
+
+    IMGFMT='luks' _rm_test_img "$file"
+
+    if [ $status != 0 ]; then
+        reason=$(echo "$output" | grep "$file:" | $SED -e "s#.*$file: *##")
+        if [ -z "$reason" ]; then
+            reason="Failed to create a LUKS image"
+        fi
+        _notrun "$reason"
+    fi
+}
+
 # this test requires that a specified command (executable) exists
 #
 _require_command()
-- 
2.26.2


