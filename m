Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C385D215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff+nIfLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C385D215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaisp-0001pv-Tf
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iahsR-0000nO-Hp
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iahsN-0002D4-Ea
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:08:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iahsN-00021G-4y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:08:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id n1so35616710wra.10
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yAum3F1mw2jhcWFArLz9v4AhBBgrLxLEGQQeRnm1vEo=;
 b=ff+nIfLgsi7RwPr8VifrQABifpPTzEcfkOF7vfjZKx64ssiUTvtRM2lS/7JjKREZcK
 2Z0IritwujkEPwD/mmpOOIQZKYRh67BUDTefwyjUxc/iJrO5BtbTGr4ouXxFiDJ1PNlt
 XliRifzcr1crhKAo08lDJ8bN2RwDM2dcfQUrPoR1vbz3iPBMTXb6+Dn9aABQvidtMuZa
 NyE/OR7touqsvgRUi/bgW5PnGafa4raHHWEs4AbPzOOe7XDxl0e7HmrysDbHfSXqsJrB
 XS3UT/LMUtDqklh2f07P9K5aG6VONI3CqR7B8mtRx6FlDAlHTNCbav7x0XGEVoSPwxxx
 7JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yAum3F1mw2jhcWFArLz9v4AhBBgrLxLEGQQeRnm1vEo=;
 b=G4PDy2lKWbdbJfFZICy5APK4aqo3FYcKj41j93VmAzrX8/BI8fG3yGbpiod6zNjgy4
 EqdD9TUk7vCRSHm4T9DWltkWtyTQZ04vQDAXhuOjGtBAngRhdFc4fe4hSC9E/acjS3TL
 6m+Wr7dG8IpKHdUAMrZuBUZ6RQhIcBJgYpZoHjCSEepnI5DW5uAT6fJx/Ue3tFDO76t6
 e8QwsZUG7sCfx7g262aO0KaCTvDvaDWKk1HuXKDL+JeqnGi5HLHpAE0x+kSqbwcE1vZp
 WrzPIXL1eAsoIhiZWOKcKo8WgoOBiVITOQrgttljmw5rNB/DUgMRrH1KBYBrKMNESJdB
 b17Q==
X-Gm-Message-State: APjAAAUdgS+r9C2CQpOro2Xu0HI5DrEv4PMei5KXMTemc6EDoCdjb6vH
 ynPMxsFa3datkZHnEHWgnNuiKIUQ
X-Google-Smtp-Source: APXvYqyxRmaEtjpQdXD1CYyeegvDacc1xWYZ3+OCBX5LS37mVtQb9VnFd2Mba6j+RXfPsboh9wOqZA==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr47587859wrq.123.1575040083438; 
 Fri, 29 Nov 2019 07:08:03 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e19sm13908041wme.6.2019.11.29.07.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 07:08:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker: remove libcap development packages
Date: Fri, 29 Nov 2019 16:08:01 +0100
Message-Id: <20191129150801.26654-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: berrange@redhat.com, groug@kaod.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Libcap was dropped from virtio-9p, so remove it from the dockerfiles as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker     | 1 -
 tests/docker/dockerfiles/ubuntu.docker     | 1 -
 tests/docker/dockerfiles/ubuntu1804.docker | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4ddc7dd112..47732fc5d5 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -25,7 +25,6 @@ ENV PACKAGES \
     libasan \
     libattr-devel \
     libblockdev-mpath-devel \
-    libcap-devel \
     libcap-ng-devel \
     libcurl-devel \
     libfdt-devel \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index f486492224..ecea155646 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -23,7 +23,6 @@ ENV PACKAGES flex bison \
     libbrlapi-dev \
     libbz2-dev \
     libcacard-dev \
-    libcap-dev \
     libcap-ng-dev \
     libcurl4-gnutls-dev \
     libdrm-dev \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 3cc4f492c4..32a607471a 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -12,7 +12,6 @@ ENV PACKAGES flex bison \
     libbrlapi-dev \
     libbz2-dev \
     libcacard-dev \
-    libcap-dev \
     libcap-ng-dev \
     libcurl4-gnutls-dev \
     libdrm-dev \
-- 
2.21.0


