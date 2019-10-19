Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6BCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E3D22459
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd4l1uFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E3D22459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqQF-0002ze-J9
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNn-0001BT-Eq
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNm-0006wT-DT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNl-0006vL-Uh
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id q70so1771463wme.1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZIx2URSbhQtQxwSH9NicQbjsqcplkfjt7F3Xbrr+u4U=;
 b=Kd4l1uFFazh2DoCkM8fdoqUDeViykhAvUrdMDWy7uphQvUivYxmBoIHWSUFJEpDppp
 dNy3vwpMFoZ7/x5vM/oa2Upgl1JyyoWgVpPbX3xp2tQ4wHF9uvrCTXStZhjseYPeR9a8
 oAHXaUJwxLxbexN3nSuZl05d/3NQ9y9tQpbocxf84rYXc9fwmXuROG6L/IrsLaRgXc2O
 XHiCNRgpZ2+Js2/CCUqg52rtIAJB1TRr1KWZoaLn2/xnMPRTaeD34e78SascEq6mZFzm
 HhdREVzZTvS2PewK+6vkefrw+fnjFNwcYBAdj6xsItFetWWcKYPrPKM5/w+SmTZOVTJs
 gJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZIx2URSbhQtQxwSH9NicQbjsqcplkfjt7F3Xbrr+u4U=;
 b=UKzVWKPQx4QmLuHKIYVndJ4zx/wgKt210O8povMJ7DBSwnvBoECDcc3Ozk3nHMKw5P
 vjmpQ3NRqbuH4/xzhk70mWgZGeN82H3RXXlEIcs2Wx93uh8P34pQ9d+DzNIbr17wHgmu
 qXN/WMo432JUHP3Om14O/M8VhuGJz+bLR1rVr/fumyoUmweQtjPWVJxWQokxYeQXA0LK
 M+00NAojQcQUi7dMskGEaFANF+ypDApjSzsQUpZn4/IDpvUDrBxol91rufNsInGdltcS
 BDYcpITEmvHcTN7VpPyQSNHo7+cHDDjHYakn2TG8dAqap4QeKiKTiw/WcaEn4MI6lBJi
 6BWA==
X-Gm-Message-State: APjAAAX34ab+MaaZbk2junZipVC7JelwtWQGAtkOAMIJ93qWamsBqes+
 VdRHI2n7LUL03tyTo/8mnI5/dTO6
X-Google-Smtp-Source: APXvYqwAtQM9RTXi4wAFgi/Ytd+nw+zbTN0FVM8/WXUPWSO0Dn1Iu/K5oV2SFqeS1/zVFwHRjUqhPA==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr12614037wmc.34.1571497863792; 
 Sat, 19 Oct 2019 08:11:03 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] tests/acceptance: Fixe wait_for_console_pattern() hangs
Date: Sat, 19 Oct 2019 17:10:49 +0200
Message-Id: <20191019151058.31733-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Because of a possible deadlock (QEMU waiting for the socket to
become writable) let's close the console socket as soon as we
stop to use it.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index e3101cba30..a0450e5263 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
         if success_message in msg:
             break
         if failure_message and failure_message in msg:
+            console.close()
             fail = 'Failure message found in console: %s' % failure_message
             test.fail(fail)
 
-- 
2.21.0


