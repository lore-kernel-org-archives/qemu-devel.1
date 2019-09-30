Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A773C35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D736C22509
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne4HFvLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D736C22509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2SL-0005PT-9a
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2He-00040F-BP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2Hc-0002Yk-QE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iF2Hc-0002XY-JH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l3so12807812wru.7
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=ne4HFvLzpXtVHrUVStWSDQk73R/uQAaUcLR3Arn01TGvqOD6z7h2+0HbIcsliAtQVY
 D/Z/Q25tqcDELqSl7cbY5M63RQqTU05XEUzXm1kwmm9NULWjPfbC3Udy/WYpzc/h5W74
 SBOFsunziguTxHAwi6g+Ij8JxqfCyVtx9KNsz4asd2M63sKowhkGdMtAYmG0TDhRLcz7
 WczQB/sqDQ4WGhhLz7iNe7K9jN62OBSqgvHDvsxjOpBeN+o5W9i/xDseTFxSVJf5vyiU
 Vf5HmawGhijGqFvBKJWHc3fj1w1xxsyIbZkCCEWS5FsQFtm4QOa4cmS+Ndp8vE0rVyRc
 Z9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=s/fFh0pBFt7r1EoBTe1T4iNXiuf2gNJq/h75ygR/W5+3//QWXgqtX+wkqyYd8bR8Mx
 l0UcLUKkFBf8Bz2DpqdUj4KWQSi8hdXTU8MrlAOLsusqUTNtMkPVIJxb8ovRaryXB/r2
 7PuOTZEKzRGeWUKdp10jJrUEm0s1Ix33g7aUy+rmhykEk1qwPBbaVu9HJxicekf0BuKM
 Y4mP7anj/UKdLeW2R9V7nBajBRP6PAKfYH5gfQAEHtAZN+2mOvc9agyL0iZM8y4SmBR7
 QKYIf9WvS1TimlC/R7T4c0/8/cEovFe6/qIhkEjrMx8kRFFmvqQFjJxJcXLgWTaym5va
 BHnA==
X-Gm-Message-State: APjAAAUKcvflGTOGHo2ZdLHcKKMJ8VsynBdIiLorZC1D3qYChjSXi8yF
 l073cYxERrWetsf446KJlQ6DVtLz
X-Google-Smtp-Source: APXvYqy4Ds+z/KK8Wt/fzmOg3NTxZHIn72dTrtjlyH1dr5zR3EXuzTHmsHBfbb6P2LhKImjahRyXsw==
X-Received: by 2002:adf:a415:: with SMTP id d21mr13856343wra.94.1569875315442; 
 Mon, 30 Sep 2019 13:28:35 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.gmail.com with ESMTPSA id o9sm34402911wrh.46.2019.09.30.13.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:28:34 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/10] audio: basic support for multichannel audio
Date: Mon, 30 Sep 2019 22:28:59 +0200
Message-Id: <35de004f4e540b72defda75a9804dd599a497dcb.1569874641.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
References: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which currently only means removing some checks.  Old code won't require
more than two channels, but new code will need it.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 7 -------
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index eddf013a53..f37ce1ce85 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -493,13 +493,6 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (nchannels != 1 && nchannels != 2) {
-        alsa_logerr2 (err, typ,
-                      "Can not handle obtained number of channels %d\n",
-                      nchannels);
-        goto err;
-    }
-
     if (apdo->buffer_length) {
         int dir = 0;
         unsigned int btime = apdo->buffer_length;
diff --git a/audio/audio.c b/audio/audio.c
index c00f4deddd..7fc3aa9d16 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -242,7 +242,7 @@ static int audio_validate_settings (struct audsettings *as)
 {
     int invalid;
 
-    invalid = as->nchannels != 1 && as->nchannels != 2;
+    invalid = as->nchannels < 1;
     invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
-- 
2.23.0


