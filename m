Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD53C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 12:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BB5208B3
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgZVaPYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BB5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH4Rr-0007jj-3h
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH4QA-0006GT-0e
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 08:14:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH4Q7-0004m4-OG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 08:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599912858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=VaROtoUEqnX7X4JCDmh6/XROrLsotkJaGvtG1fWi1RE=;
 b=WgZVaPYsFmkIiRg2JH5QXhdMAeU1GyS+gXjNE3ep8CZ5NfkygplJHp4TkPuDxVj3T7Q6Qy
 IQmiHu6i9OG3E4piUnm47A5QPVO5rw4D0an0q4qeW4GAwmwjNi5ey3BUSUsyEGUMVr1Wi6
 iLiVpP7vWP4fBm2xQkoYwVruVQoDlKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-AmPggr9xMye7tsGRPuxNYw-1; Sat, 12 Sep 2020 08:14:16 -0400
X-MC-Unique: AmPggr9xMye7tsGRPuxNYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 788528030A0;
 Sat, 12 Sep 2020 12:14:15 +0000 (UTC)
Received: from thuth.com (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EEF375126;
 Sat, 12 Sep 2020 12:14:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Subject: [PATCH] tests/check-block: Do not run the iotests with old versions
 of bash
Date: Sat, 12 Sep 2020 14:14:12 +0200
Message-Id: <20200912121412.10999-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 08:14:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macOS is shipped with a very old version of the bash (3.2), which
is currently not suitable for running the iotests anymore. Add
a check to skip the iotests in this case - if someone still wants
to run the iotests on macOS, they can install a newer version from
homebrew, for example.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/check-block.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index 8e29c868e5..bfe1630c1e 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -46,6 +46,11 @@ if ! command -v bash >/dev/null 2>&1 ; then
     exit 0
 fi
 
+if bash --version | grep 'GNU bash, version [123]' > /dev/null 2>&1 ; then
+    echo "bash version too old ==> Not running the qemu-iotests."
+    exit 0
+fi
+
 if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
     if ! command -v gsed >/dev/null 2>&1; then
         echo "GNU sed not available ==> Not running the qemu-iotests."
-- 
2.18.2


