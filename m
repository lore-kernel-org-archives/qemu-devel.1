Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F1E2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3x2kPbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F1E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH7y-0004LM-Jg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4L-0007NU-R4
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4K-0005mO-75
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3eSWb5ZiqVJd/J6wtvOwqLRIaFwn4vrmHQmyGByifQ=;
 b=G3x2kPbCgtHtd9oq7RNCop7e0Y61ET4PchlSXZGWu6rvZ6EPIfPtVgOtRrO5xq910sGCLN
 v5euK5ZUZMSkZiYGXu9B4oHJybfkfTquCMdqZFdBQWt5ojequbiVeXVQBWXhavzyzFRtAO
 3knYyUAu83a2zAYupx4bSap65sC+dX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-89St3dN4NkOQO0BooYt1uA-1; Tue, 02 Jun 2020 20:15:36 -0400
X-MC-Unique: 89St3dN4NkOQO0BooYt1uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721AE107ACCA;
 Wed,  3 Jun 2020 00:15:35 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E25777F0B5;
 Wed,  3 Jun 2020 00:15:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] python/qemu: Add pipenv support
Date: Tue,  2 Jun 2020 20:15:20 -0400
Message-Id: <20200603001523.18085-5-jsnow@redhat.com>
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:45:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pipenv is a tool used for managing virtual environments with precisely
specified dependencies. It is separate from the dependencies listed in
setup.py, which are (by 'best practices') not supposed to be pinned.

Note that pipenv is not required to install or use this module; this is
just a convenience for in-tree developing.

Here, a "blank" pipfile is added with no dependencies, but specifies
Python 3.6 for the virtual environment.

Pipfile will specify our version minimums, while Pipfile.lock specifies
an exact loudout of packages that were known to operate correctly. This
latter file provides the real value for easy setup of container images
and CI environments.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 python/Pipfile

diff --git a/python/Pipfile b/python/Pipfile
new file mode 100644
index 00000000000..9534830b5eb
--- /dev/null
+++ b/python/Pipfile
@@ -0,0 +1,11 @@
+[[source]]
+name = "pypi"
+url = "https://pypi.org/simple"
+verify_ssl = true
+
+[dev-packages]
+
+[packages]
+
+[requires]
+python_version = "3.6"
-- 
2.21.3


