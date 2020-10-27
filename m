Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99747C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EEB221F7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+xF8lTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EEB221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXdI-0005Xk-3E
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbx-0004FM-G9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXXbv-0006Of-Lu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603838312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BpX0Ra1qe078ntJgXJz4Qr2TQDFhqS6zWubrJ20nQFc=;
 b=N+xF8lTCdx3+oiaa/TUdf6wA/rtO0nQ7O5xRglNYB262UHzA42h3YSyQtAGnl+boYJAK5y
 LNJ0j1dzvupJxQRPpMHmsbl7l3L/2HWy1CZuXwijmk0otnvKkD9pKJ5WTeefcYryJZa1id
 947BavvJpLJb0vNjIBIfx29dP//Ljso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-s6ckx_AFND2QEw7vepw-Kw-1; Tue, 27 Oct 2020 18:38:28 -0400
X-MC-Unique: s6ckx_AFND2QEw7vepw-Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E0D809DE1;
 Tue, 27 Oct 2020 22:38:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48D2D5B4AD;
 Tue, 27 Oct 2020 22:38:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] python: add Makefile for some common tasks
Date: Tue, 27 Oct 2020 18:38:13 -0400
Message-Id: <20201027223815.159802-4-jsnow@redhat.com>
In-Reply-To: <20201027223815.159802-1-jsnow@redhat.com>
References: <20201027223815.159802-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add "make venv" to create the pipenv-managed virtual environment that
contains our explicitly pinned dependencies.

Add "make check" to run the python linters [in the host execution
environment].

Add "make venv-check" which combines the above two: create/update the
venv, then run the linters in that explicitly managed environment.

make clean: delete miscellaneous build output possibly created by
pipenv, pip, or other python packaging utilities

make distclean: delete the above, and the .venv, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Makefile | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 python/Makefile

diff --git a/python/Makefile b/python/Makefile
new file mode 100644
index 000000000000..51915eaec3bc
--- /dev/null
+++ b/python/Makefile
@@ -0,0 +1,35 @@
+.PHONY: help venv venv-check check clean distclean
+
+help:
+	@echo "python packaging help:"
+	@echo ""
+	@echo "make venv:       Create pipenv's virtual environment."
+	@echo "    NOTE: Requires Python 3.6 and pipenv."
+	@echo "          Will download packages from PyPI."
+	@echo "    HINT: On Fedora: 'sudo dnf install python36 pipenv'"
+	@echo ""
+	@echo "make venv-check: run linters using pipenv's virtual environment."
+	@echo ""
+	@echo "make check:      run linters using the current environment."
+	@echo "    Hint: Install deps with: 'pip install \".[devel]\"'"
+	@echo ""
+	@echo "make clean:      remove build output."
+	@echo ""
+	@echo "make distclean:  remove venv files and everything from 'clean'."
+
+
+venv: .venv
+.venv: Pipfile.lock
+	@PIPENV_VENV_IN_PROJECT=1 pipenv sync --dev --keep-outdated
+
+venv-check: venv
+	@pipenv run make check
+
+check:
+	@pytest
+
+clean:
+	rm -rf build/ dist/
+
+distclean: clean
+	rm -rf qemu.egg.info/ .venv
-- 
2.26.2


