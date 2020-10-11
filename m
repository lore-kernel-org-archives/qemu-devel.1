Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B6C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D6820756
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDGotNuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D6820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi6A-00022E-Ty
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4N-0000FD-JS
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4L-0005RK-JY
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLHeBMskUZtqp132SdnBx+YQ+oQMCEZflKukbUd3w2w=;
 b=NDGotNuN3dOAS9G9KcUr6veFjB1UtcbuLk6fwOvkupILsz6a6PJTUaSdiBLzYP/VGEU4uE
 CyDU/7NXgQDSRPv3lzC1cFahH5DqP6wMXAjYAN+ts7OQfr/dys9oaAou101V2ZwyVSPrw3
 EusGPmOv8M+6Ba8lplSkMl8ICg1XT78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-VGHrBFH8ORGgjotoD5yijQ-1; Sun, 11 Oct 2020 16:35:46 -0400
X-MC-Unique: VGHrBFH8ORGgjotoD5yijQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AEB3107ACF5
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:35:45 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD2060C05;
 Sun, 11 Oct 2020 20:35:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 02/15] scripts/qapi: teach c_param_type() to return const
 argument type
Date: Mon, 12 Oct 2020 00:35:00 +0400
Message-Id: <20201011203513.1621355-3-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As it should be, since the argument isn't owned by the callee,
but a lot of code in QEMU rely on non-const arguments to tweak it.

Since Rust types / bindings are derived from the C version, we have to
be more accurate there to do correct ownership conversions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/schema.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d1307ec661..ca85c7273a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -167,8 +167,14 @@ class QAPISchemaType(QAPISchemaEntity):
         pass
 
     # Return the C type to be used in a parameter list.
-    def c_param_type(self):
-        return self.c_type()
+    #
+    # The argument should be considered const, since no ownership is given to the callee,
+    # but qemu C code frequently tweaks it. Set const=True for a stricter declaration.
+    def c_param_type(self, const=False):
+        c_type = self.c_type()
+        if const and c_type.endswith(pointer_suffix):
+            c_type = 'const ' + c_type
+        return c_type
 
     # Return the C type to be used where we suppress boxing.
     def c_unboxed_type(self):
@@ -221,10 +227,10 @@ class QAPISchemaBuiltinType(QAPISchemaType):
     def c_type(self):
         return self._c_type_name
 
-    def c_param_type(self):
+    def c_param_type(self, const=False):
         if self.name == 'str':
             return 'const ' + self._c_type_name
-        return self._c_type_name
+        return super().c_param_type(const)
 
     def json_type(self):
         return self._json_type_name
-- 
2.28.0


