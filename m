Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49404C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12435207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7TX3QrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12435207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDV9y-0005IC-7g
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1P-0001Bs-5z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDV1N-0005Ts-7d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=uArgolhOjF5ZWs4AQePvKXSJB9ZggBrCPlGecRWiG2E=;
 b=U7TX3QrVYGTNEX3Y7m9exGeM/xloneQSSu8+yJq/X47gTrzia31JwkuB4kpaOxif4mFCM/
 nRE8ugYL9+gcJGPdc/3HhlObcbpAoNoL0BmIyy0h3k2u154sQ8uRVWp/VsSokVjvvqZN8C
 MYb0XUJnu5SZTaOeBEiyLb8yTmLhF3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-gcnGVU8QOZ-eVYWMg3w_oQ-1; Wed, 02 Sep 2020 11:49:57 -0400
X-MC-Unique: gcnGVU8QOZ-eVYWMg3w_oQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F732425E7;
 Wed,  2 Sep 2020 15:49:56 +0000 (UTC)
Received: from thuth.com (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9785E5D9CC;
 Wed,  2 Sep 2020 15:49:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 13/15] gitlab/travis: Rework the disabled features tests
Date: Wed,  2 Sep 2020 17:49:30 +0200
Message-Id: <20200902154932.390595-14-thuth@redhat.com>
In-Reply-To: <20200902154932.390595-1-thuth@redhat.com>
References: <20200902154932.390595-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's focus on the gitlab-ci when testing the compilation with disabled
features, thus add more switches there (and while we're at it, sort them
also alphabetically). This should cover the test from the Travis CI now,
too, so that we can remove the now-redundant job from the Travis CI.

Message-Id: <20200806155306.13717-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 26 +++++++++++++++++++-------
 .travis.yml    |  6 ------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b7967b9a13..8ae3e31c3f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -190,13 +190,25 @@ build-disabled:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --disable-rdma --disable-slirp --disable-curl
-      --disable-capstone --disable-live-block-migration --disable-glusterfs
-      --disable-replication --disable-coroutine-pool --disable-smartcard
-      --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
-      --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
-      --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
-    TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
+    CONFIGURE_ARGS: --disable-attr --disable-avx2 --disable-bochs
+      --disable-brlapi --disable-bzip2 --disable-cap-ng --disable-capstone
+      --disable-cloop --disable-coroutine-pool --disable-curl --disable-curses
+      --disable-dmg --disable-docs --disable-glusterfs --disable-gnutls
+      --disable-gtk --disable-guest-agent --disable-iconv --disable-kvm
+      --disable-libiscsi --disable-libpmem --disable-libssh --disable-libusb
+      --disable-libxml2 --disable-linux-aio --disable-live-block-migration
+      --disable-lzo --disable-malloc-trim --disable-mpath --disable-nettle
+      --disable-numa --disable-parallels --disable-pie --disable-qcow1
+      --disable-qed --disable-qom-cast-debug --disable-rbd --disable-rdma
+      --disable-replication --disable-sdl --disable-seccomp --disable-sheepdog
+      --disable-slirp --disable-smartcard --disable-snappy --disable-spice
+      --disable-strip --disable-tpm --disable-usb-redir --disable-vdi
+      --disable-vhost-crypto --disable-vhost-net --disable-vhost-scsi
+      --disable-vhost-user --disable-vhost-vdpa --disable-vhost-vsock
+      --disable-virglrenderer --disable-vnc --disable-vte --disable-vvfat
+      --disable-xen --disable-zstd
+    TARGETS: arm-softmmu i386-softmmu ppc64-softmmu mips64-softmmu
+      s390x-softmmu i386-linux-user
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
diff --git a/.travis.yml b/.travis.yml
index 6695c0620f..1d0ade0a13 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -159,12 +159,6 @@ jobs:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-
-    - name: "GCC some libs disabled (main-softmmu)"
-      env:
-        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-libusb --disable-replication --target-list=${MAIN_SOFTMMU_TARGETS}"
-
-
     # Module builds are mostly of interest to major distros
     - name: "GCC modules (main-softmmu)"
       env:
-- 
2.18.2


