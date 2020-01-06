Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD7C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F19207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGVN+828"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F19207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXjG-0007bA-9Q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioXOe-0004q5-Nd
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioXOZ-0003I5-7h
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioXOY-0003H8-PG
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578336389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtCAaREUfb5bmCXH03wjqlQoiSqbMgLqqNesZ69/gd4=;
 b=MGVN+828/9Cst5lD/Bi+HCpFFqB/b7eKHHHlhFjUZeGokRMi02zAC8WXPQ7NR+MxMWCoxC
 BCrvYudK6OBEn1SULzaU1hPtpB8O48oS4P4+OTcYQ2+aphsWuFIJoc/7xkUYVG6avYewc+
 cOQyfVmOG+mP3k+Kh+T0cH6nsq2k6K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-Vrqdy2gFNkWXQMCgrwqM_A-1; Mon, 06 Jan 2020 13:46:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1D619057B5;
 Mon,  6 Jan 2020 18:46:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F9060FA2;
 Mon,  6 Jan 2020 18:46:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] gitlab-ci-edk2.yml: Use ccache
Date: Mon,  6 Jan 2020 19:46:01 +0100
Message-Id: <20200106184601.25453-4-philmd@redhat.com>
In-Reply-To: <20200106184601.25453-1-philmd@redhat.com>
References: <20200106184601.25453-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Vrqdy2gFNkWXQMCgrwqM_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using ccache we reduce the job duration from
40 minutes 26 seconds to 32 minutes 6 seconds.

  Running after script...
  $ ccache --show-stats
  cache hit (direct)                  6604
  files in cache                     12090
  cache size                         335.5 MB

For now downloading this cache takes 16 seconds, archiving
it 44 seconds.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .gitlab-ci-edk2.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
index abfaf52874..329ba24f20 100644
--- a/.gitlab-ci-edk2.yml
+++ b/.gitlab-ci-edk2.yml
@@ -14,12 +14,19 @@ build-edk2:
    - edk2-stdout.log
    - edk2-stderr.log
  image: ubuntu:16.04 # Use Ubuntu Xenial
+ variables:
+   CCACHE_DIR: ${CI_PROJECT_DIR}/.ccache
+ cache: # Use the same cache for all EDK2 jobs
+   key: ubuntu16.04-edk2-ccache
+   paths:
+   - ${CCACHE_DIR}
  before_script: # Install packages requiered to build EDK2
  - apt-get update --quiet --quiet
  - DEBIAN_FRONTEND=3Dnoninteractive
    apt-get install --assume-yes --no-install-recommends --quiet --quiet
      build-essential
      ca-certificates
+     ccache
      dos2unix
      gcc-aarch64-linux-gnu
      gcc-arm-linux-gnueabi
@@ -29,9 +36,13 @@ build-edk2:
      nasm
      python
      uuid-dev
+ - export PATH=3D/usr/lib/ccache:$PATH
+ - ccache --zero-stats
  script: # Clone the required submodules and build EDK2
  - git submodule update --init roms/edk2
  - git -C roms/edk2 submodule update --init
  - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
  - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
  - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr.lo=
g >&2)
+ after_script:
+ - ccache --show-stats
--=20
2.21.1


