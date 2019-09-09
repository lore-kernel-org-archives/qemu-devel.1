Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98813C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDED206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgTom8is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDED206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GIV-0001EC-Ib
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7GHe-0000jh-Qe
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7GHd-0002zP-8H
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:48:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7GHd-0002yP-0Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:48:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id k6so934105wrn.11
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bULc1zGTtRFCu6ZKD/sIGS3tUnWL3tf9I0v3qKoMIdU=;
 b=FgTom8isNtMeuTDq2Jlz5Ec7dW/VOqNqYsDBOWx8zJHLvUiDJ7bhK+MsDlkhPyTKpZ
 1b9YPzM9xtXafE6ZeZ+z41JnLmNxGuPuFl7S93U+TITZlGQz1JviLve3EBmZEyZwPpnc
 g1yBZ7C9M0nrAnbWntabLtkE8DmVevxngn4xOf5QlDDhAFblMRhLUnB3Qw2BEx5NXGs8
 a62OY7bQ/4NPCC9kNKltF2vLrmiVhrxv+FO1bZKoj/Cz47+RTgcNXbnsRsxhtPFL6B8d
 ArYgovAIiuK0CgyG+6QmcIi8q5sO5J9x/A6GdpFqw8rrAk77B/VRxVrJbemqiv/csD8x
 AybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bULc1zGTtRFCu6ZKD/sIGS3tUnWL3tf9I0v3qKoMIdU=;
 b=CxRk9WA9mGxxiF8zuVoC/TlcvYfHLmYuorm7tekGq2AL8sRtD3BjtOIcE3O/OldPoY
 6cbCzF39SwjeRvWiU9TgGWoLuyFKdnr4la+BG4CE4X9Cp7iEB5aFNi1lLWz741qj10cM
 ruH+k0Z3GU31G0DNsi7/YjI9KOn4aIVeoh9rknQetaxcSmTu6Am4hcRAQbp88csQG1gG
 VhtjjY4jrTvvAiJCtoRein2Ho+dTZj2gieNZZ0WZkIb+USxh8U5PEZBkvGKI0VU6A9ia
 yEvLISD5T9vjQ9H57a+GGgkKg1vZCkUa0+zIYsXy9s1TKp5L1rScaF5SyFwJM8HYvjUf
 beBw==
X-Gm-Message-State: APjAAAXKTyAvYSyVLBJuKDLYXEiuWColybB85F8Sg0oxrZKhoO9VfxjX
 91FWNGOcw5YeNKbzV0+FYUj9BQ==
X-Google-Smtp-Source: APXvYqx+zpOZ7CMtTTLEWJa+mk4fevJeu14BuYtiwMeZPGbsGzzj4dP/FDKpQFw0tYpeOw4JXcj1RA==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr17696817wrj.139.1568022507058; 
 Mon, 09 Sep 2019 02:48:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u22sm27543692wru.72.2019.09.09.02.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 02:48:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B873C1FF87;
 Mon,  9 Sep 2019 10:48:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 10:48:16 +0100
Message-Id: <20190909094816.1970-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PATCH] tests/docker: update Debian Sid image
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are not currently using it we might as well keep the image
for later usage. So:

  - update to a more recent snapshot
  - clean up verbiage in commentary
  - remove duplicate shell from a merge failure

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-sid.docker | 24 ++++++++--------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
index 513459ca7f8..2a1bcc33b24 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -1,25 +1,19 @@
 #
 # Debian Sid Base
 #
-# A number of our guests exist as ports only. We can either use the
-# ports repo or get everything from Sid. However Sid is a rolling
-# distro which may be broken at any particular time. If you are
-# unlucky and try and build your images while gcc is in the process of
-# being uploaded this can fail. Your only recourse is to try again in
-# a few hours when the repos have re-synced. Once built however you
-# won't be affected by repo changes unless the docker recipies are
-# updated and trigger a re-build.
+# Currently we can build all our guests with cross-compilers in the
+# latest Debian release (Buster). However new compilers will first
+# arrive in Sid. However Sid is a rolling distro which may be broken
+# at any particular time. To try and mitigate this we use Debian's
+# snapshot archive which provides a "stable" view of what state Sid
+# was in.
 #
 
 # This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20181011-slim
+FROM debian:sid-20190812-slim
 
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
+ # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20190820"
 RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
 
 # Duplicate deb line as deb-src
-- 
2.20.1


