Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CA3C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B965212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJfrwnBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B965212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShpA-000602-BF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnM-0004H5-RG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnK-0005YV-Fi
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602685821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkWiUjvNADpjvr/+VDXIBgW9PW8F3GWGhJsIZt6ik5E=;
 b=VJfrwnBNWKaMmIkdEI9TU8FLf8hwYW4+QE8NbKbIZYo9UDdLubdMenO56HSpvhwX8jL9Ja
 kIiGgpy30E/CUhuFIVb//TlkO0+kewupnC7pbelhHesdRG/Bcme6UstNFNwjuWtOEKkvHo
 WcOwbrP7vV5jxOFTFlFC1XKwxWSTivw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-jedh3lEPPL63I6dU0QMlBg-1; Wed, 14 Oct 2020 10:30:18 -0400
X-MC-Unique: jedh3lEPPL63I6dU0QMlBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF76410866AD;
 Wed, 14 Oct 2020 14:30:16 +0000 (UTC)
Received: from scv.redhat.com (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 224F876649;
 Wed, 14 Oct 2020 14:30:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] python: add qemu package installer
Date: Wed, 14 Oct 2020 10:29:44 -0400
Message-Id: <20201014142957.763624-3-jsnow@redhat.com>
In-Reply-To: <20201014142957.763624-1-jsnow@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add setup.cfg and setup.py, necessary for installing a package via
pip. Add a rst document explaining the basics of what this package is
for and who to contact for more information. This document will be used
as the landing page for the package on PyPI.

I am not yet using a pyproject.toml style package manifest, because
using pyproject.toml (and PEP-517) style packages means that pip is not
able to install in "editable" or "develop" mode, which I consider
necessary for the development of this package.

Use a light-weight setup.py instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/PACKAGE.rst | 23 +++++++++++++++++++++++
 python/setup.cfg   | 18 ++++++++++++++++++
 python/setup.py    | 23 +++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 python/PACKAGE.rst
 create mode 100755 python/setup.cfg
 create mode 100755 python/setup.py

diff --git a/python/PACKAGE.rst b/python/PACKAGE.rst
new file mode 100644
index 0000000000..6e82f05606
--- /dev/null
+++ b/python/PACKAGE.rst
@@ -0,0 +1,23 @@
+QEMU Python Tooling
+===================
+
+This package provides QEMU tooling used by the QEMU project to build,
+configure, and test QEMU. It is not a fully-fledged SDK and it is subject
+to change at any time.
+
+Usage
+-----
+
+The ``qemu.core`` subpackage offers rudimentary facilities for launching
+QEMU and communicating with it via QMP. Refer to the module documentation
+(``>>> help(qemu.core)``) for more information.
+
+Contributing
+------------
+
+This package is maintained by John Snow <jsnow@redhat.com> as part of
+the QEMU source tree. Contributions are welcome and follow the `QEMU
+patch submission process
+<https://wiki.qemu.org/Contribute/SubmitAPatch>`_. There is a `Gitlab
+mirror <https://gitlab.com/jsnow/qemu/-/tree/python>`_, but
+contributions must be sent to the list for inclusion.
diff --git a/python/setup.cfg b/python/setup.cfg
new file mode 100755
index 0000000000..12b99a796e
--- /dev/null
+++ b/python/setup.cfg
@@ -0,0 +1,18 @@
+[metadata]
+name = qemu
+maintainer = QEMU Developer Team
+maintainer_email = qemu-devel@nongnu.org
+url = https://www.qemu.org/
+download_url = https://www.qemu.org/download/
+description = QEMU Python Build, Debug and SDK tooling.
+long_description = file:PACKAGE.rst
+long_description_content_type = text/x-rst
+classifiers =
+    Development Status :: 3 - Alpha
+    License :: OSI Approved :: GNU General Public License v2 (GPLv2)
+    Natural Language :: English
+    Operating System :: OS Independent
+
+[options]
+python_requires = >= 3.6
+packages = find_namespace:
diff --git a/python/setup.py b/python/setup.py
new file mode 100755
index 0000000000..e93d0075d1
--- /dev/null
+++ b/python/setup.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+"""
+QEMU tooling installer script
+Copyright (c) 2020 John Snow for Red Hat, Inc.
+"""
+
+import setuptools
+import pkg_resources
+
+
+def main():
+    """
+    QEMU tooling installer
+    """
+
+    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
+    pkg_resources.require('setuptools>=39.2')
+
+    setuptools.setup()
+
+
+if __name__ == '__main__':
+    main()
-- 
2.26.2


