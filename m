Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78DE206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bdkwvjf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78DE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Inm-0005uq-T7
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ije-0000Wa-7d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijd-0002h5-5n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijc-0002em-Ua
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y11so7799656wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGzD1fnYqJucooAWR/6jjHsELD6Wua5qgxiKhqNXiBA=;
 b=Bdkwvjf1Ht6ZzhUErzkXSHz+tHXmVxhMT92XnMbCvMn2ykoOwccQzVEYSELyoRVIWU
 5sHbYqLgz+14duGha+TuD2tdKvMOcdxcrsXMw2rMXZ21BJNMyx3wg64rPryjiWGdajYT
 rxiyPVMlX5oF8hBA5SA9qJrI4TxFaHQA5ry+C+hJDfwJ8m6UuaefLURrKyd5wD2Y9eIB
 MBx4d1f3QF8V0TeFP8CbBsaJY6a7xBA617u0N7AvBdbYXhPpx84gK5mCFV+98/3PfcMI
 y8H1xuLotDKjig1wCunOpBC9YpELDuRePIRb84Osm0Tv0/v9s5Dl9Ol1m0Qsku76s3Rs
 SHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sGzD1fnYqJucooAWR/6jjHsELD6Wua5qgxiKhqNXiBA=;
 b=DhxzFnv2WVFLvd+TrCEbbLYbLL14sOfp1UJ5IWZmbeLytn7wx0CN/SW/kV3mdv/AeS
 oY2IyfR821bt05UrV980vo3MiaP/kolWw+lnUIsroYNwMa8fKAfHpCS+3DX9hMVktzTm
 D7uVTLsJ0xA9plIJg3974dbfFiUlo0VKcy40bzNguHfHx/W1vejctHIXkKN2kISFLfes
 4A8DzwOYr+mIPEEPaF1UuDN4KnEctGI0XKTd5kXFcr2ThO3O8Hx/CpMb31QOOn3kVyUK
 PUrkaAC7XQJBcjp4VVQW5X0FzNHt+mm9k6Y2X9pMMzbKCCHB/dHhUrFpUUbtdxBrrd4V
 Hz0g==
X-Gm-Message-State: APjAAAVDJuFEmDfeeQl5JswSSg1Kp+fxx2IazIB8b5FQfwLyOfbxHBIM
 O2HyEXEXSzV29mUW2cBxf6US70+stxo=
X-Google-Smtp-Source: APXvYqyp5vIV6tJ6nys+Ep0AEdSKpp17crvqiwpngqCkRkiYs9XAGF4WZiianZn1YvXrmQE8c0wBsg==
X-Received: by 2002:a5d:614a:: with SMTP id y10mr8406616wrt.73.1581616626610; 
 Thu, 13 Feb 2020 09:57:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/30] qapi/ui.json: Put input-send-event body text in the
 right place
Date: Thu, 13 Feb 2020 17:56:28 +0000
Message-Id: <20200213175647.17628-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the doc comment for input-send-event, there is a multi-line
chunk of text ("The @device...take precedence") which is intended
to be the main body text describing the event. However it has
been placed after the arguments and Returns: section, which
means that the parser actually thinks that this text is
part of the "Returns" section text.

Move the body text up to the top so that the parser correctly
classifies it as body.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index ba873e1e298..e8b8b708c72 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -949,13 +949,6 @@
 #
 # Send input event(s) to guest.
 #
-# @device: display device to send event(s) to.
-# @head: head to send event(s) to, in case the
-#        display device supports multiple scanouts.
-# @events: List of InputEvent union.
-#
-# Returns: Nothing on success.
-#
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
 # same kind are added to the virtual machine and (b) you have
@@ -967,6 +960,13 @@
 # are admissible, but devices with input routing config take
 # precedence.
 #
+# @device: display device to send event(s) to.
+# @head: head to send event(s) to, in case the
+#        display device supports multiple scanouts.
+# @events: List of InputEvent union.
+#
+# Returns: Nothing on success.
+#
 # Since: 2.6
 #
 # Note: The consoles are visible in the qom tree, under
-- 
2.20.1


