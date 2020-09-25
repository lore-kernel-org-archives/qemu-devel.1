Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A591C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9B72371F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INvd7znI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9B72371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLboz-00054S-Od
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcN-0001BB-LF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcG-0000Cx-QK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UwIbjyB0chSx2kXG1CfAG0/PqtX/jJxxt9+SS423G8=;
 b=INvd7znIRgLP0v9zcVkpo5YXtVVdLk3b13IEe3hSD1uxOuqW/gv0LgVoul5JalmIm+kBNz
 e55xJCJQVbyADHRgJdzCsYfhNAb9DkVDvwuIV9K3osF/5EJTxOtnk05KL2vmhY57oLZ9pR
 onmN8JCdCEXpHO2Hmgunu/2BB7qX/ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-o-c1e57zO6KEyy1ePmlZLA-1; Thu, 24 Sep 2020 20:29:26 -0400
X-MC-Unique: o-c1e57zO6KEyy1ePmlZLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137031008550
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:26 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69EB75D9DD;
 Fri, 25 Sep 2020 00:29:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 28/47] qapi/commands.py: enable checking with mypy
Date: Thu, 24 Sep 2020 20:28:41 -0400
Message-Id: <20200925002900.465855-29-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/mypy.ini | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index b668776d94..9da1dccef4 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -4,11 +4,6 @@ strict_optional = False
 disallow_untyped_calls = False
 python_version = 3.6
 
-[mypy-qapi.commands]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.doc]
 disallow_subclassing_any = False
 disallow_untyped_defs = False
-- 
2.26.2


