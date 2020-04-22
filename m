Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11585C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16C020776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7AplU73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16C020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ7i-0008SB-01
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6T-0006yG-V0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6Q-0004Ma-5O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6P-0004IC-O7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdgNn3lUnQzmA9m/1ezGpFmd+V2YKIrPbC1sLMYdTfY=;
 b=i7AplU73SqhK9Kt+I9XGIVFJJH1VPZy2suEfjERdOiOWzhLAJ3ff602vlsCaQWmAYAUJHH
 HhhTD78TR2TedLJ1+1VIeRI10BSpt7gjLCgqnhH5UiTbgUlA/yQ5mPsh+VVNvKobCtAsGZ
 CS0Y2Us5gvoQAlAD3El6spSe9sU5jLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-il8OglxoN4q61VgtJbeGsQ-1; Wed, 22 Apr 2020 13:23:54 -0400
X-MC-Unique: il8OglxoN4q61VgtJbeGsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB9748017FC;
 Wed, 22 Apr 2020 17:23:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B4A6084B;
 Wed, 22 Apr 2020 17:23:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] docker.py/build: support -t and -f arguments
Date: Wed, 22 Apr 2020 13:23:44 -0400
Message-Id: <20200422172351.26583-2-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The docker.py command line is subtly different from docker and podman's,
in that the tag and Dockerfile are passed via positional arguments.
Remove this gratuitous difference and just parse -f and -t.

-f was previously used by --extra-files, only keep the long option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 tests/docker/docker.py        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 43a8678688..262704663f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,7 +55,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 =09$(call quiet-command,\
-=09=09$(DOCKER_SCRIPT) build qemu:$* $< \
+=09=09$(DOCKER_SCRIPT) build -t qemu:$* -f $< \
 =09=09$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 =09=09$(if $(NOUSER),,--add-current-user) \
 =09=09$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d8268c1111..ad61747bae 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -391,16 +391,16 @@ class BuildCommand(SubCommand):
                             help=3D"""Specify a binary that will be copied=
 to the
                             container together with all its dependent
                             libraries""")
-        parser.add_argument("--extra-files", "-f", nargs=3D'*',
+        parser.add_argument("--extra-files", nargs=3D'*',
                             help=3D"""Specify files that will be copied in=
 the
                             Docker image, fulfilling the ADD directive fro=
m the
                             Dockerfile""")
         parser.add_argument("--add-current-user", "-u", dest=3D"user",
                             action=3D"store_true",
                             help=3D"Add the current user to image's passwd=
")
-        parser.add_argument("tag",
+        parser.add_argument("-t", dest=3D"tag",
                             help=3D"Image Tag")
-        parser.add_argument("dockerfile",
+        parser.add_argument("-f", dest=3D"dockerfile",
                             help=3D"Dockerfile name")
=20
     def run(self, args, argv):
--=20
2.18.2



