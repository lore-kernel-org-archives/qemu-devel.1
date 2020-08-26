Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8869C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05C520737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiIl7KNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05C520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyx3-0006fD-Sw
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAywD-0004vj-7H
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:10:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAywB-0005CZ-3G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598461813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+rZci5eJ2CSJiV/RqYh9+UWJPFhGe99QBGAGaoNeHc=;
 b=CiIl7KNu5goSqjDtF05VgTkCwO5oKHhyErXE9kR1L5EOzZp2EUnbfoyBSXgPILmC+2L5GM
 exzOtT0hU8snSB8u6JlMeSQgSW11j9bw+Hgm51VyGda7lQv9b3cszIbY6rPonYqQv2zkae
 TeuPBbjgcelqOy5Vz8TNUPnRBOshN9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-zTSg_5_OMp6TqehLiPZoIA-1; Wed, 26 Aug 2020 13:10:11 -0400
X-MC-Unique: zTSg_5_OMp6TqehLiPZoIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F897801ABB
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 17:10:10 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67A5850B3F;
 Wed, 26 Aug 2020 17:10:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tls-cipher-suites: Correct instance_size
Date: Wed, 26 Aug 2020 13:10:05 -0400
Message-Id: <20200826171005.4055015-5-ehabkost@redhat.com>
In-Reply-To: <20200826171005.4055015-1-ehabkost@redhat.com>
References: <20200826171005.4055015-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do have a QCryptoTLSCipherSuites struct.  It must be used when
setting instance_size of the QOM type.  Luckily this never caused
problems because the QCryptoTLSCipherSuites struct has only a
parent_obj field and nothing else.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
---
 crypto/tls-cipher-suites.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index 0d305b684b..55fb5f7c19 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -108,7 +108,7 @@ static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
 static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .parent = TYPE_QCRYPTO_TLS_CREDS,
     .name = TYPE_QCRYPTO_TLS_CIPHER_SUITES,
-    .instance_size = sizeof(QCryptoTLSCreds),
+    .instance_size = sizeof(QCryptoTLSCipherSuites),
     .class_size = sizeof(QCryptoTLSCredsClass),
     .class_init = qcrypto_tls_cipher_suites_class_init,
     .interfaces = (InterfaceInfo[]) {
-- 
2.26.2


