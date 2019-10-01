Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FCECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012542190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVZgO7RL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012542190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIYB-0002rr-5U
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKX-0006Bp-AF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKW-0001lb-A3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKW-0001kR-4K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so15585985wro.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=o4ShqMwkYwxwFlVxZ6kVT6vik/5tXcWE7uO0LUlRUd4=;
 b=JVZgO7RLl95Eltb6TuuCJdM9LXXyc8wcyQEhxy/HYclwQW59uHhFmeF3u4icxTsHHm
 Ll2shWQlUuG1dDvmNqd20ST5H2PlnOnahCfGaiFK+sW3KxFiiRn3ZvkexYho61PsgkBW
 CsN1Zw7mJNdn/OZfVr3pT9A7IbNZcm8vyLWvaylXjv1p+N3fyopxzOqKWY4ucalsN/Mj
 qIBEwBtVkTAJeDrLtgf96/SBHxzL5ZzTZc3GZK6JMZBI0YfUvUI7Mv6dStPc0ooR0ZDG
 xsEQq5QSihARJDdI9mliedf5MV2npl2k/SwJQRYTEI+ESQq6MOUNQ7bJ5gk4utVQrVEC
 S/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=o4ShqMwkYwxwFlVxZ6kVT6vik/5tXcWE7uO0LUlRUd4=;
 b=pOo2PluP/l2WUc+wyE0rJuAMpiZ/Js5N0oFuviywTjF5TE2mkd0tcOB7J3kU1FPkkZ
 VRgLCzxusnhBCvuk93Puf1aZBcbBkqkfSK353mkiwr16Q28r+KpLd1tIV/3yF/h/P5LX
 kk5CXIE4EYVnj31OAbgFl3vcOCVBYy3xPbZnr5SC/O1NTmWeEC53Bsn6WSxYNt0R8e84
 TVNODsjHbTREOXIkjlraW6nFCeIZIxPgIYYMNOJe7gj460eXhJbbtnN19GiPYjUCIJub
 1SOF/LKye0CSEz0Vl2mRvRDfu4ibPfxJ3m5K8108g8E4Z+SOSAXfF+9e8ybxgtUFZbrt
 JeBg==
X-Gm-Message-State: APjAAAUC852c449PnYZwazmxmJk+iBguTPZJTPVpl+asfNxagsc5lfiT
 n2Pqcd8OVCavtgC7lfb7e6mA7wAd
X-Google-Smtp-Source: APXvYqxCIA5lbehH0rrYkeapVwuSFFskgmYqhzyQP6QgHEkEFoOghys9fq3Qmew6AaIR64zP6IT43Q==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr16909132wru.12.1569936998867; 
 Tue, 01 Oct 2019 06:36:38 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] docker: test-debug: disable LeakSanitizer
Date: Tue,  1 Oct 2019 15:36:28 +0200
Message-Id: <1569936988-635-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

There are just too many leaks in device-introspect-test (especially for
the plethora of arm and aarch64 boards) to make LeakSanitizer useful;
disable it for now.

Whoever is interested in debugging leaks can also use valgrind like this:

   QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 \
   QTEST_QEMU_IMG=qemu-img \
   valgrind --trace-children=yes --leak-check=full \
   tests/device-introspect-test -p /aarch64/device/introspect/concrete/defaults/none

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/test-debug b/tests/docker/test-debug
index 137f4f2..c050fa0 100755
--- a/tests/docker/test-debug
+++ b/tests/docker/test-debug
@@ -21,6 +21,7 @@ cd "$BUILD_DIR"
 OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
 OPTS="--enable-debug --enable-sanitizers $OPTS"
 
+export ASAN_OPTIONS=detect_leaks=0
 build_qemu $OPTS
 check_qemu check V=1
 install_qemu
-- 
1.8.3.1


