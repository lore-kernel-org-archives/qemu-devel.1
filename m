Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC71020758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiYYI9Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC71020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRPv-0004hw-VZ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKl-0002Hx-97
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKj-0006vt-5O
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzlHTm9VPweSTqTF3u6j3Gos0lCLdQmjxNjKFe4vKvE=;
 b=HiYYI9BopCzNvK/7IgqVXBfLqLZFWVcFZVE1yPKmwmcOg9KAaLKssB5T5+GFv16ybobnpP
 SOF2Tqm+HruiCrBdzOa89yPOJRHkb8LxrGzFwcQlMwiiXzBTuXdHqariPVLrPNySHAP7UB
 Qty0nSUiwg2mKJidDDSzSGdR73zMOQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-55gXcV06PaOeCpb7zaR4QA-1; Wed, 02 Sep 2020 07:53:41 -0400
X-MC-Unique: 55gXcV06PaOeCpb7zaR4QA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AE0681F00F;
 Wed,  2 Sep 2020 11:53:40 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1A978B20;
 Wed,  2 Sep 2020 11:53:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/20] tls-cipher-suites: Correct instance_size
Date: Wed,  2 Sep 2020 07:53:12 -0400
Message-Id: <20200902115323.850385-10-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do have a QCryptoTLSCipherSuites struct.  It must be used when
setting instance_size of the QOM type.  Luckily this never caused
problems because the QCryptoTLSCipherSuites struct has only a
parent_obj field and nothing else.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200826171005.4055015-5-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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


