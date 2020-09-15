Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3996EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FD320731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6gXfErn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIA8a-00060q-I9
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rO-0001Sl-BD; Tue, 15 Sep 2020 08:14:58 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rM-0008JL-M9; Tue, 15 Sep 2020 08:14:58 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o16so1678388pjr.2;
 Tue, 15 Sep 2020 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=M6gXfErnngeeKfFhqv+Vgr0UqpYON1RVKk6pPLvTxMyiNu0d5gXcwRDkLcZ/YVoF4w
 XzEw0VFbEMVfptJ5HLql9O9VlxiI5PR0DSNfoxU7jq0Ll/wbOIyvfkoOyXfKc+yovwIl
 rO2ZkXDGrZk6sOSeVMEv6+biNrBalW0EnDwVUFZuN3CgHoUMmfNeYFCh7lVAfIiwmDDf
 +nzfKyyZnVwTsIF+vuo3vlHYs+mIOVfN4V8jpwOCSNPBuJG06dVKDrb/e4JymgOc1475
 FDpJawkj3VIV28wET96wguSrm2BVBIJlH4g4xMihHanOkvTjsmsrD8WGWOA4fNSBolC8
 vtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ks2bOk3jYOHrXnI/Shz64S+t7ePZagOpQ3Ju/TypT6Y=;
 b=LNqMNFKXnAD1zKJ97ubSL4dXstxhBnQC8KMYCDkBlo1+QBsILzEpgUkqXDVCJXIAAZ
 GIzpVqd1iukiIR6Sic6onEhJZFZy3uhvgE0/qEe98dJP1dEIdKK4hTQmY85i37avecH/
 pbqTQ871ntiW8nZo6SvBK5+6HcdCMimiO84ywj1ZbXJJxXM1F/iARKXI9g/uyTRNbj7d
 7jNRtSUdrNGs3zHddHU6DiLPW4KMcdB3SuQxMFxAvtZ/wNaPyVSEod7/GHYZTeoDXOzR
 PYLDRkJDD9hB0Z79SupqZW2pQyMEp1dvlcJOBWAH1xoN+lVkNN9xXFbCPufhOUtpU9oa
 a4xw==
X-Gm-Message-State: AOAM530Ey0xcuNW3h5n8puZYrYqJmTtGabw9Hp2u/nAMd97uWZ1lZqJZ
 x464NzXwzWzON3yrol1DeY2x5P89jY4G3ABdT2A=
X-Google-Smtp-Source: ABdhPJwSlyNgD9I3zY8yY0qa0o7rPRisuPynZNgZvdKZ5zYH9SXLM8+VTZprLTCqcerRG79GyK+V+Q==
X-Received: by 2002:a17:902:74c1:b029:d1:e598:401b with SMTP id
 f1-20020a17090274c1b02900d1e598401bmr1557161plt.85.1600172094637; 
 Tue, 15 Sep 2020 05:14:54 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 17/26] tests: Fixes test-io-channel-socket.c tests under
 msys2/mingw
Date: Tue, 15 Sep 2020 20:13:09 +0800
Message-Id: <20200915121318.247-18-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently test-io-channel-socket doesn't init with
qemu_init_main_loop
and that's cause the qemu_aio_context not inited,
and the following is the stack when null pointer accessed:

qemu_fd_register (c:\work\xemu\qemu\util\main-loop.c:336)
qemu_try_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:224)
qemu_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:230)
socket_can_bind_connect (c:\work\xemu\qemu\tests\socket-helpers.c:93)
socket_check_protocol_support (c:\work\xemu\qemu\tests\socket-helpers.c:141)
main (c:\work\xemu\qemu\tests\test-io-channel-socket.c:568)
__tmainCRTStartup (@__tmainCRTStartup:142)
mainCRTStartup (@1400014f6..140001539:3)
BaseThreadInitThunk (@BaseThreadInitThunk:9)
RtlUserThreadStart (@RtlUserThreadStart:12)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-io-channel-socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index d43083a766..743577d744 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -25,6 +25,7 @@
 #include "socket-helpers.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 
 
 static void test_io_channel_set_socket_bufs(QIOChannel *src,
@@ -556,6 +557,7 @@ int main(int argc, char **argv)
     bool has_ipv4, has_ipv6;
 
     module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
     socket_init();
 
     g_test_init(&argc, &argv, NULL);
-- 
2.28.0.windows.1


