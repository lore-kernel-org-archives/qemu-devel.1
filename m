Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACDC223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4M9Ui14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACDC223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7f7-0001sr-WB
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6o6-0007f5-06
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6o1-0004zG-IR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YnOAzercV1xIfq73DlkplazlGkduPLwRDwqOGs3CQA=;
 b=c4M9Ui14eAXuaAj7K/4Ku2VvHOlg/A+B12W01QfbsAe0y7q3xFhl73IpTevm+Gm663USHR
 vJhszoHkK1J6/aewKuXvuBOhqMmC5aKV//7O9Id03ySZp2RSvJFkLagv04SQlXmtLwvLGn
 qkTFI0eaik148jWAajYrqwLqK/Re4tU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-uogC_avfMlafE_IE0Wneyw-1; Tue, 03 Nov 2020 19:37:39 -0500
X-MC-Unique: uogC_avfMlafE_IE0Wneyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1552E1891E84
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:38 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4026355766;
 Wed,  4 Nov 2020 00:37:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 70/72] scripts/qmp-shell: move to
 python/qemu/qmp/qmp_shell.py
Date: Tue,  3 Nov 2020 19:36:00 -0500
Message-Id: <20201104003602.1293560-71-jsnow@redhat.com>
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

The script will be unavailable for a commit or two, which will help
preserve development history attached to the new file. A forwarder will
be added shortly afterwards.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell => python/qemu/qmp/qmp_shell.py | 3 ---
 1 file changed, 3 deletions(-)
 rename scripts/qmp/qmp-shell => python/qemu/qmp/qmp_shell.py (99%)
 mode change 100755 => 100644

diff --git a/scripts/qmp/qmp-shell b/python/qemu/qmp/qmp_shell.py
old mode 100755
new mode 100644
similarity index 99%
rename from scripts/qmp/qmp-shell
rename to python/qemu/qmp/qmp_shell.py
index 15aedb80c2af..337acfce2d26
--- a/scripts/qmp/qmp-shell
+++ b/python/qemu/qmp/qmp_shell.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python3
 #
 # Copyright (C) 2009, 2010 Red Hat Inc.
 #
@@ -96,8 +95,6 @@
     Sequence,
 )
 
-
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qmp
 from qemu.qmp import QMPMessage
 
-- 
2.26.2


