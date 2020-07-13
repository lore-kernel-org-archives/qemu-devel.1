Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1123A206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaBPoEBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1123A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwY2-000353-C8
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juwXS-0002bO-5V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:22:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juwXP-0008NJ-HT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594639342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwZD3jfIwnUJurp2wnmlqiAdampJH1c0R94rxtPPGbs=;
 b=KaBPoEBXPl6pMDOXjweIYA3V8m8dtJElYXvEtdqBSnaArfAZWhwzHoRLw+nzz1O+9H2DVD
 ICPRZ3+DArbvXemG6zjQnlfsrNvLCiEPKElVtfChWiPqSt6RnSsBmtFYpB4MuMi/CR5ir5
 FRQNV8JwLAwTqWGlJVEf0ElDKCUFXac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-C_kGOyalMi-CPfzMPUSc_A-1; Mon, 13 Jul 2020 07:22:20 -0400
X-MC-Unique: C_kGOyalMi-CPfzMPUSc_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F167100960F;
 Mon, 13 Jul 2020 11:22:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2DBE27DE83;
 Mon, 13 Jul 2020 11:22:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fixup! qemu-img: Flush stdout before before potential stderr
 messages
Date: Mon, 13 Jul 2020 06:22:07 -0500
Message-Id: <20200713112208.126775-1-eblake@redhat.com>
In-Reply-To: <20200709121713.283092-1-kwolf@redhat.com>
References: <20200709121713.283092-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max noticed that I didn't run iotests on -luks...

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/282.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/282.out b/tests/qemu-iotests/282.out
index 5d079dabce1d..67db7ab15aff 100644
--- a/tests/qemu-iotests/282.out
+++ b/tests/qemu-iotests/282.out
@@ -1,11 +1,11 @@
 QA output created by 282
 == Create non-UTF8 secret ==
 == Throws an error because of invalid UTF-8 secret ==
-qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
 Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
 == Image file should not exist after the error ==
 == Create a stub image file and run qemu-img again ==
-qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
 Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
 == Pre-existing image file should also be deleted after the error ==
- *** done
+*** done
-- 
2.27.0


