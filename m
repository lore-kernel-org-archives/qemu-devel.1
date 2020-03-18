Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BAC4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E40420754
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC3sM7fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E40420754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhDB-0000oQ-CT
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEhAE-0004ji-DJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEhAD-00041O-7g
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEhAD-00040V-4g
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIARl1H3U65zXq4MlRqXVEjDrgSVBYcSfawq25lyOTg=;
 b=EC3sM7fuhFUyYagtkDHrNJtaEwZIf3D4I6YgAwQvoa78v3oHc26uQB85yOfwSzxFwl60/1
 pjqQwX5ElANzqbWwh4O7sUl1wyj61RhYMtTsGsfDDDoyDz3FgFKJJSLnW2H9ZGMwxDo6Fm
 c8aOiJW7clwfzd9T3vHWTTagoIiHiIc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-KjXR1mtAN0WK5ziyXms4mw-1; Wed, 18 Mar 2020 18:27:45 -0400
X-MC-Unique: KjXR1mtAN0WK5ziyXms4mw-1
Received: by mail-wm1-f70.google.com with SMTP id x7so187474wmi.4
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mrd5FWvmNFE63RRMy6fTaQFpQYng5ob5o09jcOCUbzM=;
 b=loJ9ZhC71YWfiTGaQ2TgBr3eIF8ltaUl8+3eTYZ2CgD7tEWLTJAGXBMyWdwQ0OIx3/
 MphMoodVPNaixoLaVVowDO5iiT1ldeUbpGbp5Wn8Y8wa7Q7Yt3zJZYsnIejT+GbZBy+a
 ZDbe2syEpb796lqokfdk78cvn+n+h8fF+cP/2+m7yxVEjn3E49pf+7yr+eeEsKAhnWtm
 28vBe1RiWAl0LMkNAKIjJJm31WSDM6iKLnkmsue1c3tVXrkdCHoc+MwkdNxmhE/UQF1s
 gc8Yy7/SS2BQ5xSpjJVRUEO8YZJ3kYJvgYv6XwGea8+x0bSuJbE4a8fGwDdVfrfspKMX
 w1IQ==
X-Gm-Message-State: ANhLgQ2gC7zhmHuA4P/O3N+0BzKVWXN9GYCIcT9zhs/I2Ax/lvy1Bv9W
 3SdHQcRn2qaRU6UHrSSCNKRFISVckeiRTAkwXVEr11VikpC9yQK3JSJzClpTuA1KmvJJFYxjI77
 oTc32tZveBHsy6k8=
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr91631wrs.263.1584570464205;
 Wed, 18 Mar 2020 15:27:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu8hwjUqwo3VHUuUiNol4An7cefKjxNPSOCyoPNLqBGeCPZBRSazXz+16RXXKZXB7QOyouFow==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr91604wrs.263.1584570463987;
 Wed, 18 Mar 2020 15:27:43 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f12sm302077wmh.4.2020.03.18.15.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:27:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] .travis.yml: Add a KVM-only s390x job
Date: Wed, 18 Mar 2020 23:27:17 +0100
Message-Id: <20200318222717.24676-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318222717.24676-1-philmd@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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


