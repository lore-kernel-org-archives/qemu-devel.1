Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E5C43446
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C1D2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huWTxdwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C1D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04JI-0007Hk-Qh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Gm-0002zu-Rh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25316
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Gl-0001y4-8P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hh9LJtAcD8yfBtfgVQBLyGwCXVMcdCKr9QdU3U8ZNac=;
 b=huWTxdwx/lL+CCcvsm7hGeSm4rSmU6cldEYs7ZhmRmWEPJQb8Du9yckzSbkpoP1iUz+dWd
 +lvie8G3i4xIjaQkqEvAB38lUafPoW7xeIhCfBwORimiCbHrKIKPB+ukFwmmbrJtNIldQ2
 5fcNAs1bmlb8/1tgy49AWqeAZBYOCHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-Ybfvm2thNBKwbn7emV1B3g-1; Mon, 27 Jul 2020 10:38:19 -0400
X-MC-Unique: Ybfvm2thNBKwbn7emV1B3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC78A800466;
 Mon, 27 Jul 2020 14:38:18 +0000 (UTC)
Received: from localhost (ovpn-113-45.ams2.redhat.com [10.36.113.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F8875C1C3;
 Mon, 27 Jul 2020 14:38:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/3] iotests: Select a default machine for the rx and avr
 targets
Date: Mon, 27 Jul 2020 16:38:11 +0200
Message-Id: <20200727143812.1101547-3-mreitz@redhat.com>
In-Reply-To: <20200727143812.1101547-1-mreitz@redhat.com>
References: <20200727143812.1101547-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

If you are building only with either the new rx-softmmu or avr-softmmu
target, "make check-block" fails a couple of tests since there is no
default machine defined in these new targets. We have to select a machine
in the "check" script for these, just like we already do for the arm- and
tricore-softmmu targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200722161908.25383-1-thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e0d8049012..0657f7286c 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -595,15 +595,19 @@ then
 fi
 export QEMU_PROG="$(type -p "$QEMU_PROG")"
 
+export QEMU_OPTIONS="-nodefaults -display none -accel qtest"
 case "$QEMU_PROG" in
     *qemu-system-arm|*qemu-system-aarch64)
-        export QEMU_OPTIONS="-nodefaults -display none -machine virt -accel qtest"
+        export QEMU_OPTIONS="$QEMU_OPTIONS -machine virt"
         ;;
-    *qemu-system-tricore)
-        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard -accel qtest"
+    *qemu-system-avr)
+        export QEMU_OPTIONS="$QEMU_OPTIONS -machine mega2560"
+        ;;
+    *qemu-system-rx)
+        export QEMU_OPTIONS="$QEMU_OPTIONS -machine gdbsim-r5f562n8"
         ;;
-    *)
-        export QEMU_OPTIONS="-nodefaults -display none -accel qtest"
+    *qemu-system-tricore)
+        export QEMU_OPTIONS="-$QEMU_OPTIONS -machine tricore_testboard"
         ;;
 esac
 
-- 
2.26.2


