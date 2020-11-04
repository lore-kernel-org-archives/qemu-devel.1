Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D54C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEC3223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaDNhD9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEC3223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6y8-00057z-Ec
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6n5-0006KJ-7a
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6n1-0004pS-7o
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QuQaF6iiaUBvHFsB5tFzilcDmfaadSV7wQWEbVMWB8=;
 b=iaDNhD9BuZGPs3onPDNs+IKETFmDHx71wFF7KG9iciE6wAtbwpWgXrGBjk8CxMdSVrqICi
 ACxJAsrbGiFKweTGx4ugk8Dl716cpa1vmGPCqFWgC6hc4XJC3lcGN7Xq/tsh5R2BAT4Vcb
 I7stQgov5LCWMqtefJP9esL9larYLeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-UNPloPR3PwGBYVc2FyC8gg-1; Tue, 03 Nov 2020 19:36:36 -0500
X-MC-Unique: UNPloPR3PwGBYVc2FyC8gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D396D9CC08
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:30 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE03655766;
 Wed,  4 Nov 2020 00:36:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/72] python: add fuse command to 'qom' tools
Date: Tue,  3 Nov 2020 19:35:05 -0500
Message-Id: <20201104003602.1293560-16-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/qom.py | 12 +++++++++++-
 python/setup.cfg       |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/python/qemu/qmp/qom.py b/python/qemu/qmp/qom.py
index 912d1809e60d..52e06a949ab3 100644
--- a/python/qemu/qmp/qom.py
+++ b/python/qemu/qmp/qom.py
@@ -1,7 +1,7 @@
 """
 QEMU Object Model testing tools.
 
-usage: qom.py [-h] {set,get,list,tree} ...
+usage: qom.py [-h] {set,get,list,tree,fuse} ...
 
 Query and manipulate QOM data
 
@@ -14,6 +14,7 @@
     get                Get a QOM property value
     list               List QOM properties at a given path
     tree               Show QOM tree from a given path
+    fuse               Mount a QOM tree as a FUSE filesystem
 """
 ##
 # Copyright John Snow 2020, for Red Hat, Inc.
@@ -36,6 +37,15 @@
 from .qom_common import QOMCommand
 
 
+try:
+    from .qom_fuse import QOMFuse
+except ImportError:
+    # either fusepy isn't installed, or qom_fuse itself is broken.
+    pass
+else:
+    assert issubclass(QOMFuse, QOMCommand)
+
+
 class QOMSet(QOMCommand):
     """QOM Command - Set a property to a given value."""
     name = 'set'
diff --git a/python/setup.cfg b/python/setup.cfg
index a9a76784d45a..908e53527ddc 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -36,6 +36,7 @@ console_scripts =
     qom-get = qemu.qmp.qom:QOMGet.entry_point
     qom-list = qemu.qmp.qom:QOMList.entry_point
     qom-tree = qemu.qmp.qom:QOMTree.entry_point
+    qom-fuse = qemu.qmp.qom_fuse:QOMFuse.entry_point
 
 [flake8]
 extend-ignore = E722  # Prefer pylint's bare-except checks to flake8's
-- 
2.26.2


