Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF66C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E3822262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atw3SFaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3822262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKq03-0008C3-Hi
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgB-0007U4-VN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgA-0006e7-7V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qYZeg0WoJ9N1k6SFDK8844HrRAj4Ho5LB+1Ts7rUPA=;
 b=atw3SFaMw8+au7Y5PMqIipCb62OcJkNAVYmwBzLFRUhhmQqfzNOYIbu1APCWPMxF5ac2yB
 O8aIF5ZI2QkdipbVLphFdLs21KhQPWAPoOduibKRyV3o3mrPS/yQWvqzceLhrRgce246Pu
 JIC9qiblq+ndRuBX5u/YwLHwjWKtiPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569--rau0TbyPBG6caQRIhOeMQ-1; Tue, 22 Sep 2020 17:18:23 -0400
X-MC-Unique: -rau0TbyPBG6caQRIhOeMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F398A802B70;
 Tue, 22 Sep 2020 21:18:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 434D05DE50;
 Tue, 22 Sep 2020 21:18:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 12/14] qapi/doc.py: Assert tag member is Enum type
Date: Tue, 22 Sep 2020 17:18:00 -0400
Message-Id: <20200922211802.4083666-13-jsnow@redhat.com>
In-Reply-To: <20200922211802.4083666-1-jsnow@redhat.com>
References: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The type system can't quite express this constraint natively: members
can envelop any type -- but tag_members may only ever envelop an
enumerated type.

For now, shrug and add an assertion.

Note: These assertions don't appear to be useful yet because schema.py
is not yet typed. Once it is, these assertions will matter.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 2914e93b1c..b96d9046d3 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -13,6 +13,7 @@
     QAPISchema,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
+    QAPISchemaEnumType,
     QAPISchemaFeature,
     QAPISchemaMember,
     QAPISchemaObjectType,
@@ -193,6 +194,7 @@ def texi_members(doc: QAPIDoc,
             desc = texi_format(section.text)
         elif variants and variants.tag_member == section.member:
             assert isinstance(section.member, QAPISchemaObjectTypeMember)
+            assert isinstance(section.member.type, QAPISchemaEnumType)
             if not section.member.type.doc_type():
                 values = section.member.type.member_names()
                 members_text = ', '.join(['@t{"%s"}' % v for v in values])
-- 
2.26.2


