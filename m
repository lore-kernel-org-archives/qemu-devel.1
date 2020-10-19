Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FD8222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyNQo4z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FD8222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWJp-0008W0-2m
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUWGR-0004C7-2M
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUWGP-00068e-9y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603118152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdqH3KAvjev9k/l+R14+rRuP+1IgqQlwdsKis/Cer6o=;
 b=PyNQo4z1vTe3w62/mxCYn5YpDIzGo1b5fq6eF2DdZyz9M6NNuQZVG5J+z3p71Ub1O8vzxd
 aamn9zTlqUtBns2q3Ygujozp9EdIV1UjElGg3b2z0xbiOioea1FZmTdEdcBa8OJEp+4Ktl
 vOxkTH1aouDJH6kiw35bpkS5/WwJzag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-XdcDWMXKOH2VdrQeDy_GcA-1; Mon, 19 Oct 2020 10:35:48 -0400
X-MC-Unique: XdcDWMXKOH2VdrQeDy_GcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0483800050;
 Mon, 19 Oct 2020 14:35:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-2.ams2.redhat.com
 [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719D25B4B1;
 Mon, 19 Oct 2020 14:35:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] gitlab: skip checkpatch.pl checks if no commit delta on
 branch
Date: Mon, 19 Oct 2020 15:35:36 +0100
Message-Id: <20201019143537.283094-2-berrange@redhat.com>
In-Reply-To: <20201019143537.283094-1-berrange@redhat.com>
References: <20201019143537.283094-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the current branch is synced to the current upstream git master,
there are no commits that need checking. This causes checkpatch.pl
to print an error that it found no commits. We need to avoid calling
checkpatch.pl in this case.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/check-patch.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 5a14a25b13..0ff30ee077 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -33,8 +33,16 @@ ancestor = subprocess.check_output(["git", "merge-base",
 
 ancestor = ancestor.strip()
 
+log = subprocess.check_output(["git", "log", "--format=%H %s",
+                               ancestor + "..."],
+                              universal_newlines=True)
+
 subprocess.check_call(["git", "remote", "rm", "check-patch"])
 
+if log == "":
+    print("\nNo commits since %s, skipping checks\n" % ancestor)
+    sys.exit(0)
+
 errors = False
 
 print("\nChecking all commits since %s...\n" % ancestor)
-- 
2.26.2


