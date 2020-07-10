Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6840C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijZh+43b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6840C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvyI-0005jJ-Jg
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtvxO-00044s-10
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:33:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtvxM-0007vh-G6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594398779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvyzzuBWOhSh/D2b/DAr+rl5JnwWsbc2V629CLjsrqI=;
 b=ijZh+43bbf/ZpAN2OwgJfF22XY+Wvn8C8KmC4wSrLx5A5yw6xUM/7lcB/AJ2Xgd33h8Eej
 8hsau9TUF4fnxj8aN+w9kKUMIICztRssppgN0lHsTRJI1sWgGKzCQ7pvI8n+/brJ8vEavS
 R/mHv9suNdqvbhX0iVUjTr6bYdBCVZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-krdl1TxwMjqcSqRuSs_jpw-1; Fri, 10 Jul 2020 12:32:58 -0400
X-MC-Unique: krdl1TxwMjqcSqRuSs_jpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17525107BEF5;
 Fri, 10 Jul 2020 16:32:57 +0000 (UTC)
Received: from localhost (ovpn-113-127.ams2.redhat.com [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B050C17D82;
 Fri, 10 Jul 2020 16:32:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] iotests: Drop readarray from _do_filter_img_create
Date: Fri, 10 Jul 2020 18:32:51 +0200
Message-Id: <20200710163253.381630-2-mreitz@redhat.com>
In-Reply-To: <20200710163253.381630-1-mreitz@redhat.com>
References: <20200710163253.381630-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some systems where we run tests on do not have a 4.x bash, so they do
not have readarray.  While it looked a bit nicer than messing with
`head` and `tail`, we do not really need it, so we might as well not use
it.

Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 3833206327..345c3ca03e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -138,13 +138,13 @@ _do_filter_img_create()
     # Split the line into the pre-options part ($filename_part, which
     # precedes ", fmt=") and the options part ($options, which starts
     # with "fmt=")
-    # (And just echo everything before the first "^Formatting")
-    readarray formatting_line < <($SED -e 's/, fmt=/\n/')
+    read formatting_line
 
-    filename_part=${formatting_line[0]}
-    unset formatting_line[0]
+    # Split line at the first ", fmt="
+    formatting_line=$(echo "$formatting_line" | $SED -e 's/, fmt=/\nfmt=/')
 
-    options="fmt=${formatting_line[@]}"
+    filename_part=$(echo "$formatting_line" | head -n 1)
+    options=$(echo "$formatting_line" | tail -n +2)
 
     # Set grep_data_file to '\|data_file' to keep it; make it empty
     # to drop it.
-- 
2.26.2


