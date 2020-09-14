Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF0AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C438821741
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWYlaH7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmp6-0000U1-T3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHmoM-0008EG-QA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:38:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHmoL-0001ae-3U
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600083495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2i9ZjR5CG4NvOolwpPQRKkGo4Mxm85LqFUH7MDl/wNA=;
 b=eWYlaH7pXdBRdUnOa5MP+e1olpBzuYYkmclSD9GfPZgti3oVCCxcCZwFM9vkRcTmKvHlJE
 TJb1IqEyymS6Re6+OE9NuXzQUvfFHz+4L9OpVUPpaTGcS+P/iDeF2MLT1F1zpcqy88hCaU
 xHzV0Ol7O9NzDMgsgrglYNfSkaVhKAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-6_dxEqHHMFe2mJMguUnpwg-1; Mon, 14 Sep 2020 07:38:13 -0400
X-MC-Unique: 6_dxEqHHMFe2mJMguUnpwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10DC28030CD;
 Mon, 14 Sep 2020 11:38:12 +0000 (UTC)
Received: from localhost (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E54360BE2;
 Mon, 14 Sep 2020 11:38:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: Work around failing readlink -f
Date: Mon, 14 Sep 2020 13:38:09 +0200
Message-Id: <20200914113809.63640-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On macOS, (out of the box) readlink does not have -f.  If the recent
"readlink -f" call introduced by b1cbc33a397 fails, just fall back to
the old behavior (which means you can run the iotests only from the
build tree, but that worked fine for six years, so it should be fine
still).

Keep any potential error message on stderr.  If users want to run the
iotests from outside the build tree, this may point them to what's wrong
(with their system).

Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
       ("iotests: Allow running from different directory")
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Hi Thomas,

I thought this would be quicker than writing a witty response on whether
you or me should write this patch. O:)
---
 tests/qemu-iotests/check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e14a1f354d..75675e1a18 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -45,6 +45,10 @@ then
     fi
     source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
     build_iotests=$(readlink -f $(dirname "$0"))
+    if [ "$?" -ne 0 ]; then
+        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavior
+        build_iotests=$PWD
+    fi
 else
     # called from the source tree
     source_iotests=$PWD
-- 
2.26.2


