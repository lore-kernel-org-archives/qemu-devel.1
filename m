Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2AC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC3F22470
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkq0e1KV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC3F22470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJKX-00064Q-Ab
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDy-00065U-Mk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0008Aa-4o
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dx6drhOIGq2D5KRniXEKwbN4KrbNK/3Bnervd6f2W1I=;
 b=fkq0e1KV/d4WqBTxl2Rwt/i/vUQLQeMcloVv6dOKS72TFtQUpxQkq/sqFUKdmJt2+0sxyZ
 1UjDq3mDfwrGytJyvBWS7RP4bygh8QVHCHMaJybs6FBCOpRo3R6/x6OPL5oNzdiUFaplqf
 +ogucnybSOo8Sf0gT1+iiHYBMCJDqdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ayZjWZVQPH2EvunJy00tlg-1; Wed, 21 Oct 2020 14:52:12 -0400
X-MC-Unique: ayZjWZVQPH2EvunJy00tlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49425801AB7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:11 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A636610023A5;
 Wed, 21 Oct 2020 18:52:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] python/qmp: add qom script entry points
Date: Wed, 21 Oct 2020 14:51:55 -0400
Message-Id: <20201021185208.1611145-3-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 'qom', 'qom-set', 'qom-get', 'qom-list', and 'qom-tree' scripts
to the qemu.qmp package. When you install this package, these scripts
will become available on your command line.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/python/setup.cfg b/python/setup.cfg
index 08def52372..506944ef6b 100755
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -18,6 +18,14 @@ classifiers =
 python_requires = >= 3.6
 packages = find_namespace:
 
+[options.entry_points]
+console_scripts =
+    qom = qemu.qmp.qom:main
+    qom-set = qemu.qmp.qom:QOMSet.entry_point
+    qom-get = qemu.qmp.qom:QOMGet.entry_point
+    qom-list = qemu.qmp.qom:QOMList.entry_point
+    qom-tree = qemu.qmp.qom:QOMTree.entry_point
+
 [flake8]
 extend-ignore = E722  # Prefer pylint's bare-except checks to flake8's
 
-- 
2.26.2


