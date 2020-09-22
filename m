Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A02C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B2A20757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oiik6lsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B2A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpv2-0000lW-52
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpg2-00079d-2U
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpfx-0006ce-UR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b74oJYdLoSfqHVygXt9kzKk9vHZ6c5Y1WDerG8Zn2u0=;
 b=Oiik6lsA6p6shqs/Ews+8yBQWDpL0ezEpwqLnF1KfZaNWKDywYE4REHLlSeN9h7UgCpm2P
 eD2/bU2LxDqYdeqI8ZhEHeIoYtWiBdMsJ0af9MzT75vmbBk0st8dKHrt2W4B7BtI+vyaSx
 Nu4nU3zGHnw3jK9iWykD1Fqg2UEksS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-PJ5FyfKQNcSybBGAgJwCtw-1; Tue, 22 Sep 2020 17:18:10 -0400
X-MC-Unique: PJ5FyfKQNcSybBGAgJwCtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB5C580ED9A;
 Tue, 22 Sep 2020 21:18:09 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28A95DE50;
 Tue, 22 Sep 2020 21:18:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 02/14] qapi/doc.py: avoid unnecessary keyword arguments
Date: Tue, 22 Sep 2020 17:17:50 -0400
Message-Id: <20200922211802.4083666-3-jsnow@redhat.com>
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keyword Callables are hard to type in Python 3.6, avoid them if there's
no urgent need to use them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 4743beb89a..66333629d6 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -164,7 +164,8 @@ def texi_members(doc, what, base=None, variants=None,
             desc = 'One of ' + members_text + '\n'
         else:
             desc = 'Not documented\n'
-        items += member_func(section.member, desc, suffix='')
+
+        items += member_func(section.member, desc, '')
     if base:
         items += '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
@@ -174,7 +175,7 @@ def texi_members(doc, what, base=None, variants=None,
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
-                    items += member_func(m, desc='', suffix=when)
+                    items += member_func(m, '', when)
             else:
                 items += '@item The members of @code{%s}%s\n' % (
                     v.type.doc_type(), when)
-- 
2.26.2


