Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE28C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0999F2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cv34WTac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0999F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH6n-0002TZ-AK
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4I-0007EU-A0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4G-0005ks-M7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ia/6ohJHcyQBersi3xa5mO8YWsZ1L7lkNHxmC1J3vRk=;
 b=Cv34WTac+AMU//W906GQn+syILQRma8i39TEFKs5gu6MJ7Nd576JR/QEnLrhAJNIFqug7j
 mcc2kN61LmisztgDUUluYaFG7kwnXoRmCEYju7vZf70aMBxIqnkRt4fDAUngZ7GmG4sR/m
 jo5J3qwOHZaso61hAkM8iZR0+RfK3wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-iZGpfqrCMwKF3rQ-UVF-6Q-1; Tue, 02 Jun 2020 20:15:33 -0400
X-MC-Unique: iZGpfqrCMwKF3rQ-UVF-6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1A151005510;
 Wed,  3 Jun 2020 00:15:31 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6256278B56;
 Wed,  3 Jun 2020 00:15:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] python/qemu: formalize as package
Date: Tue,  2 Jun 2020 20:15:18 -0400
Message-Id: <20200603001523.18085-3-jsnow@redhat.com>
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:54:57
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

NB: I am choosing Python 3.6 here. Although our minimum requirement is
3.5, this code is used only by iotests (so far) under which we have been
using a minimum version of 3.6.

3.6 is being preferred here for variable type hint capability, which
enables us to use mypy for this package.

RFC: This uses the version tags of the parent tree here, so packages
will be installed as e.g. 5.0.0, 5.1.0-rc0, etc.

Pros:
 - Easy to tell which versions of QEMU it supports
 - Simple

Cons:
 - Implies semver, which we do NOT follow for QEMU releases
 - Implies the package is in a stable state


We could also start a separate versioning for just the Python SDK at
e.g. 0.1;

Pros:
 - We can use semver, which is expected of Python packaging
 - Allows us to break compatibility for 0.x releases

Cons:
 - More complex, the mapping from SDK version to QEMU version
   is less obvious
 - Requires someone to manage a secondary version commit for
   the Python SDK.

Or, perhaps, we could start versioning with 0.5.0.0, 0.5.1.0, etc to
combine a bit of both flavors; bumping the major version number only
when incompatible changes to the Python interface itself are made,
treating the major version number more like an epoch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/README.rst |  6 ++++++
 python/setup.py   | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 python/README.rst
 create mode 100755 python/setup.py

diff --git a/python/README.rst b/python/README.rst
new file mode 100644
index 00000000000..25f6d93fd5f
--- /dev/null
+++ b/python/README.rst
@@ -0,0 +1,6 @@
+QEMU Python Tooling
+-------------------
+
+This package provides QEMU tooling used by the QEMU project to build,
+configure, and test QEMU. It is not a fully-fledged SDK and it is subject
+to change at any time.
diff --git a/python/setup.py b/python/setup.py
new file mode 100755
index 00000000000..f897ceac970
--- /dev/null
+++ b/python/setup.py
@@ -0,0 +1,50 @@
+#!/usr/bin/env3 python
+"""
+QEMU tooling installer script
+Copyright (c) 2020 John Snow for Red Hat, Inc.
+"""
+
+import setuptools
+
+def main():
+    """
+    QEMU tooling installer
+    """
+
+    kwargs = {
+        'name': 'qemu',
+        'use_scm_version': {
+            'root': '..',
+            'relative_to': __file__,
+        },
+        'maintainer': 'QEMU Developer Team',
+        'maintainer_email': 'qemu-devel@nongnu.org',
+        'url': 'https://www.qemu.org/',
+        'download_url': 'https://www.qemu.org/download/',
+        'packages': setuptools.find_namespace_packages(),
+        'description': 'QEMU Python Build, Debug and SDK tooling.',
+        'classifiers': [
+            'Development Status :: 5 - Production/Stable',
+            'License :: OSI Approved :: GNU General Public License v2 (GPLv2)',
+            'Natural Language :: English',
+            'Operating System :: OS Independent',
+        ],
+        'platforms': [],
+        'keywords': [],
+        'setup_requires': [
+            'setuptools',
+            'setuptools_scm',
+        ],
+        'install_requires': [
+        ],
+        'python_requires': '>=3.6',
+        'long_description_content_type': 'text/x-rst',
+    }
+
+    with open("README.rst", "r") as fh:
+        kwargs['long_description'] = fh.read()
+
+    setuptools.setup(**kwargs)
+
+if __name__ == '__main__':
+    main()
-- 
2.21.3


