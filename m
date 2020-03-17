Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86178C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D172073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwD0sti3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D172073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIWG-00030s-Ey
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEITa-0008Or-04
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEITY-00050H-Kg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEITY-0004w1-FH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIARl1H3U65zXq4MlRqXVEjDrgSVBYcSfawq25lyOTg=;
 b=HwD0sti3zi8K0SdEOP/tnFOMlf73SdFTFL6HO5jLFzcbMn/cUEJ1DJeWTp6eUFbbnQrAxc
 d08w1clt8QdvV+Xy0n7/c/AnnKgOouw/6DA8jcPrkWPjBqG9TXRD+wCM1z6oDIvItGwen+
 iAKyV6ouYTQDjNpnvw1A29YTuO2WLEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-xS3s4NP8MFSXe28Zc-GFSQ-1; Tue, 17 Mar 2020 16:06:04 -0400
X-MC-Unique: xS3s4NP8MFSXe28Zc-GFSQ-1
Received: by mail-wr1-f72.google.com with SMTP id b12so11276221wro.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mrd5FWvmNFE63RRMy6fTaQFpQYng5ob5o09jcOCUbzM=;
 b=I1wmWjGTnSWrVYHw1sB1UsX2w4i8ia8N8cn2nm1fK8FJ1vU5tfFQBnEA6DHvwnx6PV
 uz88GsfBvH7/4/V6YIDoxPPFjpyh7AYxLJvywRxKYqPb0S1wGdxvwftC43PHYiGMGnAg
 5nYWCaK4yX1kQcDy3eOH7xvt7cdglvYav2ltFLG5m+j1FOhFeH2DHeEM03SHxug/QA0t
 aXG15O1htmdnXsRF/wOxL3bfIlPZpF/1Byp5ZB+zyu0fcSyhcYgDGBJ+KL4s5eRhLvmI
 PSlTnci3xy7JfFdizHJMqeZDgnMpBb+Xu6/JZG2mL12wyIxoiX6b8rjLzw5hecF5rZ7y
 Rzog==
X-Gm-Message-State: ANhLgQ2LMSGPh3PigKHjblSIta1YddyYOAWeHULLuWDr3I+Iweoxoy+d
 iqpCz2T0CwZdKa95/W2UVdNuQ6qwayJus/k6QUZ/y5rErMb/yEiAjjyEo4nqZGqmh242bY3/wLG
 gMt1qE1+eGqIpOq0=
X-Received: by 2002:a1c:2e92:: with SMTP id u140mr730820wmu.84.1584475563057; 
 Tue, 17 Mar 2020 13:06:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuri5ZPg0/tYcFpIGHtBI+xYOPDo7pJVoPe7xPgBmScDhE03Afz8I6bYLAHJhgst5Dmyd7S4g==
X-Received: by 2002:a1c:2e92:: with SMTP id u140mr730798wmu.84.1584475562845; 
 Tue, 17 Mar 2020 13:06:02 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id i8sm5606946wrw.55.2020.03.17.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] .travis.yml: Add a KVM-only s390x job
Date: Tue, 17 Mar 2020 21:05:41 +0100
Message-Id: <20200317200541.6246-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317200541.6246-1-philmd@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to build QEMU on s390x with TCG disabled, so
this configuration won't bitrot over time.

This job is quick, running check-unit: Ran for 4 min 48 sec
https://travis-ci.org/github/philmd/qemu/jobs/663659486

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index b92798ac3b..0109f02ed4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -524,6 +524,48 @@ jobs:
               $(exit $BUILD_RC);
           fi
=20
+    - name: "[s390x] GCC check (KVM)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - TEST_CMD=3D"make check-unit"
+        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --disa=
ble-tools"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
+
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start=
 with a 'v'.
     # This is the case when release candidate tags are created.
--=20
2.21.1


