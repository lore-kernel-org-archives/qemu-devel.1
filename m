Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B78AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176AB206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdRbVQdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176AB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZAt-00024X-E5
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyZ9o-0001F9-F4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:13:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyZ9m-0005Z8-T9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595502777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zArdPZ48zQVltFozMgldyOmKDSrKn9ZwxDbDc5wTCMY=;
 b=UdRbVQdYZBH55d0APuzIOAzUUPyAdcKW4MAHYDGhK1yqwgqRwuTSQZgGos3U5+YET9eNOj
 vAFSH/B+j11UBY73DTzkxtz+mlBOLL5X2Ic3P6sYQ5G3KBCJPx8Mt1GVVKCsIqPHkfvIdL
 NOYVzdD/kDbMg7QmrjDc0K2hf8kvw6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-wbVeP6gEPUCAp3z3_F6xYA-1; Thu, 23 Jul 2020 07:12:54 -0400
X-MC-Unique: wbVeP6gEPUCAp3z3_F6xYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B91B57;
 Thu, 23 Jul 2020 11:12:53 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1732C5D9D3;
 Thu, 23 Jul 2020 11:12:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qapi: enable use of g_autoptr with QAPI types
Date: Thu, 23 Jul 2020 12:12:50 +0100
Message-Id: <20200723111250.2650203-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently QAPI generates a type and function for free'ing it:

  typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
  void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions *obj);

This is used in the traditional manner:

  QCryptoBlockCreateOptions *opts = NULL;

  opts = g_new0(QCryptoBlockCreateOptions, 1);

  ....do stuff with opts...

  qapi_free_QCryptoBlockCreateOptions(opts);

Since bumping the min glib to 2.48, QEMU has incrementally adopted the
use of g_auto/g_autoptr. This allows the compiler to run a function to
free a variable when it goes out of scope, the benefit being the
compiler can guarantee it is freed in all possible code ptahs.

This benefit is applicable to QAPI types too, and given the seriously
long method names for some qapi_free_XXXX() functions, is much less
typing. This change thus makes the code generator emit:

 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlockCreateOptions,
                              qapi_free_QCryptoBlockCreateOptions)

The above code example now becomes

  g_autoptr(QCryptoBlockCreateOptions) opts = NULL;

  opts = g_new0(QCryptoBlockCreateOptions, 1);

  ....do stuff with opts...

Note, if the local pointer needs to live beyond the scope holding the
variable, then g_steal_pointer can be used. This is useful to return the
pointer to the caller in the success codepath, while letting it be freed
in all error codepaths.

  return g_steal_pointer(&opts);

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/crypto/block.h | 2 --
 scripts/qapi/types.py  | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/crypto/block.h b/include/crypto/block.h
index d274819791..7a65e8e402 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -311,7 +311,5 @@ uint64_t qcrypto_block_get_sector_size(QCryptoBlock *block);
 void qcrypto_block_free(QCryptoBlock *block);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlock, qcrypto_block_free)
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlockCreateOptions,
-                              qapi_free_QCryptoBlockCreateOptions)
 
 #endif /* QCRYPTO_BLOCK_H */
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3ad33af4ee..3640f17cd6 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -213,6 +213,7 @@ def gen_type_cleanup_decl(name):
     ret = mcgen('''
 
 void qapi_free_%(c_name)s(%(c_name)s *obj);
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(%(c_name)s, qapi_free_%(c_name)s)
 ''',
                 c_name=c_name(name))
     return ret
-- 
2.26.2


