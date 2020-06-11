Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142802073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq9rvy3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142802073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTEG-0007GV-5G
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8I-0007DR-Fa
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8E-0000ld-Qy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zmvvk2TUZzoW34IK4IX2JCUHzVDf1ekb5o2RBZ/OgD8=;
 b=Nq9rvy3q+5y/9KzzZqnhPVK+QFcMe7bBXuq5DSTbU1AKfxErfjNvKPONlZcIrrMMIszHX1
 AdY9bjABUJf5C0aVcj0xwdb56H5AU47RaBppZWYNOY9coxvt21VTxUAzThu24enfdiqM2a
 r7SUlON78X25sItBv9Uvs80cNez2s4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-4XK3QQX1M2qRqAbViStqYw-1; Thu, 11 Jun 2020 15:44:52 -0400
X-MC-Unique: 4XK3QQX1M2qRqAbViStqYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80BE91005512
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:44:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27FD45EE0E;
 Thu, 11 Jun 2020 19:44:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 001/115] docker.py/build: support -t and -f arguments
Date: Thu, 11 Jun 2020 15:42:55 -0400
Message-Id: <20200611194449.31468-2-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The docker.py command line is subtly different from docker and podman's,
in that the tag and Dockerfile are passed via positional arguments.
Remove this gratuitous difference and just parse -f and -t.

-f was previously used by --extra-files, only keep the long option.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 tests/docker/docker.py        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ed46bd98eb..f32a95b488 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,7 +55,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
-		$(DOCKER_SCRIPT) build qemu:$* $< \
+		$(DOCKER_SCRIPT) build -t qemu:$* -f $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 5a9735db78..d96ccc9b19 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -392,16 +392,16 @@ class BuildCommand(SubCommand):
                             help="""Specify a binary that will be copied to the
                             container together with all its dependent
                             libraries""")
-        parser.add_argument("--extra-files", "-f", nargs='*',
+        parser.add_argument("--extra-files", nargs='*',
                             help="""Specify files that will be copied in the
                             Docker image, fulfilling the ADD directive from the
                             Dockerfile""")
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
-        parser.add_argument("tag",
+        parser.add_argument("-t", dest="tag",
                             help="Image Tag")
-        parser.add_argument("dockerfile",
+        parser.add_argument("-f", dest="dockerfile",
                             help="Dockerfile name")
 
     def run(self, args, argv):
-- 
2.26.2



