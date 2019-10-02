Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC9C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2158020700
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5gVLW+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2158020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbmx-0005sF-5n
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 06:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFbmD-0005S7-Ce
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFbmB-000093-Hr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:22:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFbmB-00007z-9w
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:22:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so19020430wrt.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IYA27I4k+X20iMhTgUDiQt+Kq5nsLRsXVXPBklSSwWM=;
 b=K5gVLW+/19CuDqiUfAEqgTBp/wCUKyTN5LGJLQuQEV0ROhN/YiKVvzv+uC39cqKd1V
 hXrbf+0jiyIRoEzMGw5Jf77iBQLv883VS/43ka06txWzjYI4lDoVqB1v53Qog3TwJvdW
 PdKs61iUxcxfEFzgkeqGhDOf77tlV6FRIMm+DrwTUonYA5nAAh2QRjUA29vquUWnk1K+
 W+d5nrP398aE8LKZMDDubIm30ooGPm3kVdAx+1V8G3XxDEWSglkQFpTuI4ihZJHgbbun
 tewpIxjnqOozbwtNIQT+5xRbjcjAsm3bJ/YDaElpPjGpMG+z7wbBmJtmrgveBlf8Auz7
 QLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IYA27I4k+X20iMhTgUDiQt+Kq5nsLRsXVXPBklSSwWM=;
 b=OdktzX5Ar651VWTxtN7EmheTwro9Kb9omNXJsAC/NMLJfJkQOFe17sA2jb32mrLBFC
 Tetp7V0dRWZ+MFYxXHZSeMYzu7JM1YviSBpZDpV+6L99cVSQfXHM1KWCDc0lMFid0yYE
 G4TGUqegIEC2FlHVFNy/0OrUREhhwiVoP/6+tJsSBtINU/NkrNDj1DM2g08CBfkyYJho
 wFwXTx4zYIJMPygnD2QLyRXGevKCZdgW6lfzpgF9XwcSE643akBo7MRnrTuEYqPL45DS
 DKZODriH21dRFomCQsNIdZSD7iGuR07vlUvPkU1OxzWnTt6J8VW5ih/pB0ElmWBwrLlm
 NdEg==
X-Gm-Message-State: APjAAAUg8UhVjUkOciJBuipiF1x2Vg/MejbOTKGEKCR/mSYHxTP4hDtp
 ibI7elKbyF0i6/oYwHH4ii8zmQ==
X-Google-Smtp-Source: APXvYqxgRqSiSoPjrsprBlIeWNOCrME4vyWqfcmoAgUJonf+cuG6+6hd0A+XGFvc82HBKSLBvZpRYw==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr2195782wrw.314.1570011748341; 
 Wed, 02 Oct 2019 03:22:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm48250121wrf.73.2019.10.02.03.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 03:22:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC71E1FF87;
 Wed,  2 Oct 2019 11:22:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: ensure ret always set
Date: Wed,  2 Oct 2019 11:22:12 +0100
Message-Id: <20191002102212.6100-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the cross compilers rightly complain there are cases where ret
may not be set. 0 seems to be the reasonable default unless particular
slot explicitly returns -1.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/kvm/kvm-all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aabe097c41..d2d96d73e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     KVMState *s = kvm_state;
     uint64_t start, size, offset, count;
     KVMSlot *mem;
-    int ret, i;
+    int ret = 0, i;
 
     if (!s->manual_dirty_log_protect) {
         /* No need to do explicit clear */
-        return 0;
+        return ret;
     }
 
     start = section->offset_within_address_space;
@@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     if (!size) {
         /* Nothing more we can do... */
-        return 0;
+        return ret;
     }
 
     kvm_slots_lock(kml);
-- 
2.20.1


