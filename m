Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914CC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7695F20776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InO9ItUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7695F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJAX-0004u4-K5
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6V-0006zi-65
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6R-0004OW-65
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6Q-0004Ne-Ps
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuB60exFZOVxc3L6T8y64lcDmB9bKM9IPSAni+oZjKg=;
 b=InO9ItUWYQ6EWspESg5jlI6UUn4RrYxX4nZvQHNXgTKEs8sXqEgM6aFBtAJVQfJN6roWYb
 HKz1pQ35U/w8vn3i0Fnq211wsDilRAcPZifRtgDMP6o0cED0utmNJVVCYz9PCZCu+iKjPq
 NEx0TUNwRsaeLNYIhMbuKu0kECyG1u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-dntXZBs_PIi2xQ9pk0oIBg-1; Wed, 22 Apr 2020 13:23:58 -0400
X-MC-Unique: dntXZBs_PIi2xQ9pk0oIBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F56DB60;
 Wed, 22 Apr 2020 17:23:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E10476084B;
 Wed, 22 Apr 2020 17:23:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] run-coverity-scan: use --no-update-tools in docker run
Date: Wed, 22 Apr 2020 13:23:49 -0400
Message-Id: <20200422172351.26583-7-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Tools are already updated via the docker build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-sca=
n/run-coverity-scan
index 9403429849..0c2c0e4087 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -318,17 +318,16 @@ if [ "$DOCKER" =3D yes ]; then
     fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
+    ARGS=3D"--no-update-tools"
     if [ "$DRYRUN" =3D yes ]; then
-        DRYRUNARG=3D--dry-run
+        ARGS=3D"$ARGS --dry-run"
     fi
     echo "Running scanner..."
     # If we need to capture the output tarball, get the inner run to
     # save it to the secrets directory so we can copy it out before the
     # directory is cleaned up.
     if [ ! -z "$RESULTSTARBALL" ]; then
-        RTARGS=3D"--results-tarball /work/cov-int.tar.xz"
-    else
-        RTARGS=3D""
+        ARGS=3D"$ARGS --results-tarball /work/cov-int.tar.xz"
     fi
     # Arrange for this docker run to get access to the sources with -v.
     # We pass through all the configuration from the outer script to the i=
nner.
@@ -336,8 +335,8 @@ if [ "$DOCKER" =3D yes ]; then
     tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUI=
LD_CMD \
            -v "$SECRETDIR:/work" coverity-scanner \
            ./run-coverity-scan --version "$VERSION" \
-           --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token=
 \
-           --srcdir /qemu --src-tarball /work/qemu-sources.tgz $RTARGS
+           --description "$DESCRIPTION" $ARGS --tokenfile /work/token \
+           --srcdir /qemu --src-tarball /work/qemu-sources.tgz
     if [ ! -z "$RESULTSTARBALL" ]; then
         echo "Copying results tarball to $RESULTSTARBALL..."
         cp "$SECRETDIR/cov-int.tar.xz" "$RESULTSTARBALL"
--=20
2.18.2



