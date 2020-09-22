Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC7020BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbXaK48k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC7020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrCV-00015F-GE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2U-00027U-OC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2K-0000Ph-Qd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBijeGAKoDq7dT3e/GZlWqc9oTnLltAN10cidVcI3Ck=;
 b=PbXaK48k0uteNSeueveTpFyecEy97qi4/KVOiqIbiwl4lPd+dAb2LY6yIMA+zEy/Gh77zQ
 VB8RovIoPEW/ssTsCZVXxCCqiaCEn9i/dKJt6UKOVQt1qvbbz1+EDxWSJUzwtUSkmxK0c6
 /aiySaLn2n/Ipg7/DAaE0F0TeUb7INU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-DOLV6BUYP2ugOshofI2UPQ-1; Tue, 22 Sep 2020 18:45:21 -0400
X-MC-Unique: DOLV6BUYP2ugOshofI2UPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E79D1005E64;
 Tue, 22 Sep 2020 22:45:20 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDFE15C1A3;
 Tue, 22 Sep 2020 22:45:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 12/25] qapi/schema.py: remove 'and' from non-bool rvalue
 expressions
Date: Tue, 22 Sep 2020 18:44:48 -0400
Message-Id: <20200922224501.4087749-13-jsnow@redhat.com>
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's nothing inherently wrong with using 'and' in this manner, but
the type returned is more loose than you might expect. Any value can be
false-ish, so mypy assumes that the type of the expression must be the
Union of both types, because a type can always be false-ish.

To tighten the static analysis type, we have to use the slightly
clunkier but more formally correct ternary.

Fixes these errors:

qapi/schema.py:103: error: Argument 1 to "module_by_fname" of "QAPISchema" has
    incompatible type "Union[QAPISourceInfo, str]"; expected "Optional[str]"

qapi/schema.py:380: error: Argument 3 to "resolve_type" of "QAPISchema" has
    incompatible type "Union[QAPISourceInfo, str]";
    expected "Union[str, Callable[[Optional[QAPISourceInfo]], str], None]"

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 57343a1002..943f234ee2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -81,7 +81,7 @@ def check_doc(self):
 
     def _set_module(self, schema, info):
         assert self._checked
-        self._module = schema.module_by_fname(info and info.fname)
+        self._module = schema.module_by_fname(info.fname if info else None)
         self._module.add_entity(self)
 
     def set_module(self, schema):
@@ -305,7 +305,7 @@ def check(self, schema):
         super().check(schema)
         self.element_type = schema.resolve_type(
             self._element_type_name, self.info,
-            self.info and self.info.defn_meta)
+            self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
     def set_module(self, schema):
-- 
2.26.2


