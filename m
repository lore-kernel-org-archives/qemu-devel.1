Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79430ECE58A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4954B222C0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5PPPk2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4954B222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi2j-0001VM-M9
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrO-0005UN-V0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrN-0003TG-UL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrN-0003SK-OJ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id r19so7972187wmh.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=o4ShqMwkYwxwFlVxZ6kVT6vik/5tXcWE7uO0LUlRUd4=;
 b=d5PPPk2nnU7aUaFAH8CSpKWhlo/QYavS0FIqGOodv1EaJ5/76l3yMDG7wJ+hFWrBUI
 D+pxq9p9SvAYVLrLfcIiC914SDOYkGXDck0vjELcFtfiVVKyYaEYmpcFtQ+TG0x1jRy0
 QIgFzj0nIAhRl3fGQO5VK20F6SFcmXNfER9+pHJ7Ql9KR6tLSKZK+8zKsr5UFPW5AlZ7
 0pVPpKr9goLvmfb7hHLuE7ycpKvsEkPoHw4tZxOcfI/Ugcchmt8qc/U+2I4ZZ1a7CK3B
 4jYj4jtnOlqB+gd/XhyUq/xGLpQ4dO9/anGCKh/EM3aRP9BdBxnjOKIxoFGVs6CIvBSh
 TgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=o4ShqMwkYwxwFlVxZ6kVT6vik/5tXcWE7uO0LUlRUd4=;
 b=adYuCOKFSL65iapH7AduTicOGcG+bBHfzINLh8lIg63p6kdCMb26IAvYVSTSfcke9i
 /9MpY+VdsbU9PB1M5bCWSDAiK2G18lrsiC4zze3uOC0iDLG3f99zJDR97SIFr66WCV0A
 e7PXyM5AhiOSdTuUKK9XuQxA1yt2KkQhdP/TqD6Cnb3P/iDb3qAcC2b+S3SuB95wCtE/
 ZO8pDEWXiiAzWxQJcK+9M9IcOpBU28+sI/mURZezj3AMclRCnFQ4pZRwNv3YpnQ2m/Ta
 tXiUoOJPWUDPR0sjZMSxhh7GMvZqR1a5CT0hYrma8/7UIOk+AxqlffL+uA7mFO1ttn/h
 LPLg==
X-Gm-Message-State: APjAAAU4t2w6U/YiO75S+ifvjVtovo/x6AsV99eiZ0FGnLVb62wp6qt8
 Uan7nQAJ+5e/sajvBjs3ZVOntioI
X-Google-Smtp-Source: APXvYqw74FGTA+4Wk2EL7bL6U/LjrkxbfC+rfOtFH6+ym9elpGNmytF/ZE3/4WHgg7gjwJbvlvT9mg==
X-Received: by 2002:a1c:a94b:: with SMTP id s72mr3627073wme.9.1570035136458;
 Wed, 02 Oct 2019 09:52:16 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/30] docker: test-debug: disable LeakSanitizer
Date: Wed,  2 Oct 2019 18:51:44 +0200
Message-Id: <1570035113-56848-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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



