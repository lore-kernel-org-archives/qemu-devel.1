Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7BFC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70E2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdWy2D4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA70E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqyk-0004V1-Sh
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsv-0004IU-Sd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsu-0007dJ-68
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7ZGPCpFeOKGAGDsqGCIaOZb4bSdwvi6S6v977znT0s=;
 b=LdWy2D4EKK4jcuyxKS0XNxAk9eRc+9toFrCvw113e05ebq3xjQ/FELj1xhDZM50mX3Plki
 lfVy9gGHvu86PXZokYm9Yko3HuWyAJMNFc3Bl1PHH3jRKYpP//bY1B8Tyca23qfPOO1Kyg
 fRCEiDd56Wbo8+7FMN/ifEAbKKP26X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-MDtuzdY0M9yGt3HD_r54Cg-1; Tue, 22 Sep 2020 18:35:34 -0400
X-MC-Unique: MDtuzdY0M9yGt3HD_r54Cg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD5061005E74;
 Tue, 22 Sep 2020 22:35:33 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3B0860E1C;
 Tue, 22 Sep 2020 22:35:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 06/26] qapi/parser.py: raise QAPIParseError during file opening
Date: Tue, 22 Sep 2020 18:35:05 -0400
Message-Id: <20200922223525.4085762-7-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can have exception contexts that don't specify a specific
line, we can use that context to raise errors when opening the file.

If we don't have a parent context, we can simply use our own.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index fc0b1516cc..5a7233bc76 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -67,11 +67,13 @@ def __init__(self, fname, previously_included=None, incl_info=None):
             with open(self._fname, 'r', encoding='utf-8') as fp:
                 self.src = fp.read()
         except IOError as e:
-            raise QAPISemError(incl_info or QAPISourceInfo(None),
-                               "can't read %s file '%s': %s"
-                               % ("include" if incl_info else "schema",
-                                  self._fname,
-                                  e.strerror))
+            msg = "can't read {kind:s} file '{fname:s}': {errmsg:s}".format(
+                kind='include' if incl_info else 'schema',
+                fname=self._fname,
+                errmsg=e.strerror
+            )
+            context = incl_info or self.info
+            raise QAPIParseError(context, msg) from e
         self._parse()
 
     def _parse(self):
-- 
2.26.2


