Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED87C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C7E20FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeiIEW4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C7E20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVfv-0003iY-BR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcV-0006Xm-QL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22184
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcU-0002wP-7N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fGfyxuH38HQ0qw62o/OI7Aoh3/0s3u8sMeYx6Bjzeg=;
 b=PeiIEW4bHTGWg5hND4iZU8z2SNqH5ddvnCHNpyTgUDQrw3qFkSsYbaqfIyOmvFSnCM4P29
 /AcEXD6GW16Y0L8zvIG7q879tNdfAOipUPjGQCfK1IJYSRqGYFSGMaAbTtY0q59T+SayAL
 JJC8mPAne4x5kJzmQylJEXv/KbWTQY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-5a3oS5CsP9285NlXP8cQ_w-1; Wed, 17 Jun 2020 06:48:36 -0400
X-MC-Unique: 5a3oS5CsP9285NlXP8cQ_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B9118A0793;
 Wed, 17 Jun 2020 10:48:35 +0000 (UTC)
Received: from localhost (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D4E10013D6;
 Wed, 17 Jun 2020 10:48:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/5] iotests/{190,291}: compat=0.10 is unsupported
Date: Wed, 17 Jun 2020 12:48:22 +0200
Message-Id: <20200617104822.27525-6-mreitz@redhat.com>
In-Reply-To: <20200617104822.27525-1-mreitz@redhat.com>
References: <20200617104822.27525-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 5d72c68b49769c927e90b78af6d90f6a384b26ac
Fixes: cf2d1203dcfc2bf964453d83a2302231ce77f2dc
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/190 | 2 ++
 tests/qemu-iotests/291 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index fe630918e9..c22d8d64f9 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -41,6 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # See 178 for more extensive tests across more formats
 _supported_fmt qcow2
 _supported_proto file
+# compat=0.10 does not support bitmaps
+_unsupported_imgopts 'compat=0.10'
 
 echo "== Huge file without bitmaps =="
 echo
diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 3ca83b9cd1..3ff1858d95 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -39,6 +39,8 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 _require_command QEMU_NBD
+# compat=0.10 does not support bitmaps
+_unsupported_imgopts 'compat=0.10'
 
 echo
 echo "=== Initial image setup ==="
-- 
2.26.2


