Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7026FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4C72075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvPHzjjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4C72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFWb-00022I-Ay
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFV1-0007RL-HN
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:10:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFV0-0003H9-Jx
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEOQ4vi5S+qm1E29zpIuPRDpL8RvcOrUm1/ou/Z4rkc=;
 b=GvPHzjjOZoFwHwHQXCqjPSWcZ3vmK9Y7V1uVqiorshJqz7HJmGPM+ZJ1oqmV4ifaouBQab
 nwlJgtH4Rke8KFh3YDq6Cn09+8cktXHi3gIfZIWQyrq+fFQ2EW8wpine+x+xR9vKEK0vvX
 wLT4FsPv1K6axWygVoL7DpouK/uNNYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-e4Ih1KpEPSWZWrCr4KQvhQ-1; Thu, 28 May 2020 06:10:51 -0400
X-MC-Unique: e4Ih1KpEPSWZWrCr4KQvhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B17F835B40;
 Thu, 28 May 2020 10:10:50 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31CE05D9EF;
 Thu, 28 May 2020 10:10:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/7] linux-user: limit check to HOST_LONG_BITS < TARGET_ABI_BITS
Date: Thu, 28 May 2020 12:10:33 +0200
Message-Id: <20200528101039.24600-2-thuth@redhat.com>
In-Reply-To: <20200528101039.24600-1-thuth@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Newer clangs rightly spot that you can never exceed the full address
space of 64 bit hosts with:

  linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
  long' > 18446744073709551615 is always false
  [-Werror,-Wtautological-type-limit-compare]
  4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
  4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
  4687 1 error generated.

So lets limit the check to 32 bit hosts only.

Fixes: ee94743034bf
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200525131823.715-8-thuth@redhat.com>
[thuth: Use HOST_LONG_BITS < TARGET_ABI_BITS instead of HOST_LONG_BITS == 32]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 01a9323a63..ebc663ea0b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
             exit(EXIT_FAILURE);
         }
     } else {
+#if HOST_LONG_BITS < TARGET_ABI_BITS
         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
             error_report("%s: requires more virtual address space "
                          "than the host can provide (0x%" PRIx64 ")",
                          image_name, (uint64_t)guest_hiaddr - guest_base);
             exit(EXIT_FAILURE);
         }
+#endif
     }
 
     /*
-- 
2.18.1


