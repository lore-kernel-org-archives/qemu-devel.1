Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34EC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E874020BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7vCKzVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E874020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQ52-00024o-Uv
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqv-0001p1-LZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqt-0000TC-RQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600710227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWtdcaSlRL03NB4tiaS/+t74UPE2IWjl3rKsB18MrpA=;
 b=Z7vCKzVypw+C713IefRBipNn3eJE9LiC7iR8kRZbgbGYnvzF3pgiN8b1eLtHpAsudjsbs1
 ElobLcLlw0Wnr14ALrbhOL9x8ouT1Qx4jmFM2LRce3IKGK0gas4nQBcWgy25wWBvUKRyzf
 twtTmGQKTnsyW08LhqRqBvM7o+j0pN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-ERj3jWBHMpOKLOLyTM9VFw-1; Mon, 21 Sep 2020 13:43:45 -0400
X-MC-Unique: ERj3jWBHMpOKLOLyTM9VFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3144118BA281;
 Mon, 21 Sep 2020 17:43:44 +0000 (UTC)
Received: from thuth.com (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9D285D9CD;
 Mon, 21 Sep 2020 17:43:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/7] tests/docker: Update the tricore container to debian 10
Date: Mon, 21 Sep 2020 19:43:16 +0200
Message-Id: <20200921174320.46062-4-thuth@redhat.com>
In-Reply-To: <20200921174320.46062-1-thuth@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not support Debian 9 anymore, thus update the Tricore container
to Debian 10 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/containers.yml                          | 2 +-
 tests/docker/Makefile.include                        | 2 +-
 tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 6769eef0ff..089cea7c14 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -210,7 +210,7 @@ sparc64-debian-cross-container:
 tricore-debian-cross-container:
   <<: *container_job_definition
   stage: containers-layer2
-  needs: ['amd64-debian9-container']
+  needs: ['amd64-debian10-container']
   variables:
     NAME: debian-tricore-cross
 
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 75704268ff..02ec92830b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -137,7 +137,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
-docker-image-debian-tricore-cross: docker-image-debian9
+docker-image-debian-tricore-cross: docker-image-debian10
 docker-image-debian-all-test-cross: docker-image-debian10
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 769d95c77b..985925134c 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,7 +7,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM qemu/debian9
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
-- 
2.18.2


