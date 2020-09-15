Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1294FC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8800A20770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dk4xIhHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8800A20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJot-0004rR-Jy
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdj-0007Ua-8b
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdh-0002hx-Bw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0kflW0u6r6RefLzAKp1dbxjN39bMVvrllfkUHodpWU=;
 b=Dk4xIhHcen9oIR9c6vgNOinHWFF5pTRlLRnqAzzCuAERCwOrKZXTraMlHEekMT/uD2EdQT
 54c/ItJFdAtdyu5G5il2Zj6v3lMv6lwyivtMtnPyqV2h/oBOSugGdByvUsuE2NmYzFQLa5
 OdbHqsbMUS9ZuvgQAoAlILCmS2S6YYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-qZHJsWqjOtOW0eFvF5XDJA-1; Tue, 15 Sep 2020 18:41:26 -0400
X-MC-Unique: qZHJsWqjOtOW0eFvF5XDJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0391902ECB;
 Tue, 15 Sep 2020 22:41:17 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4344660BE5;
 Tue, 15 Sep 2020 22:41:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 29/37] qapi/gen.py: delint with pylint
Date: Tue, 15 Sep 2020 18:40:19 -0400
Message-Id: <20200915224027.2529813-30-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:40:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'fp' and 'fd' are self-evident in context, add them to the list of OK
names.

_top and _bottom also need to stay class methods because some users
override the method and need to use `self`. Tell pylint to shush.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/gen.py   | 2 ++
 scripts/qapi/pylintrc | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index bd67f6b069..0a72aecdd0 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -46,9 +46,11 @@ def get_content(self) -> str:
         return self._top() + self._preamble + self._body + self._bottom()
 
     def _top(self) -> str:
+        # pylint: disable=no-self-use
         return ''
 
     def _bottom(self) -> str:
+        # pylint: disable=no-self-use
         return ''
 
     def write(self, output_dir: str) -> None:
diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index c50a6656b7..3aebb0d228 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -5,7 +5,6 @@
 ignore-patterns=doc.py,
                 error.py,
                 expr.py,
-                gen.py,
                 parser.py,
                 schema.py,
                 types.py,
@@ -46,7 +45,9 @@ good-names=i,
            k,
            ex,
            Run,
-           _
+           _,
+           fp,  # fp = open(...)
+           fd,  # fd = os.open(...)
 
 [VARIABLES]
 
-- 
2.26.2


