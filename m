Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB768C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918D9206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epg5kZ0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918D9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBRd-00073f-PO
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQR-0004Id-Pe
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27848
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQQ-0001we-Bi
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zVv0NlCMOK9FHuZTBuePmIxIrGLXBKKurLXnwxcUO4=;
 b=epg5kZ0euwrdWXqaOKzp7lOiwHe0X/sw0vTAiedRmesLRVJ/Y3ZsfWaYJtqX2MCl0A51m8
 o0giD9oTp4rIQLgxi7JdXCVAb6iiNwOnqsXIaM8D/GzZYgtJbUCSJ89O84T9VhHPOcriNk
 ntYxJkSrucH9CvF1TLBhcGobIr63vSg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-uvrMG9GQPWCfp2zl5I4Rwg-1; Fri, 22 May 2020 13:25:33 -0400
X-MC-Unique: uvrMG9GQPWCfp2zl5I4Rwg-1
Received: by mail-wr1-f71.google.com with SMTP id r7so4658689wrc.13
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/zVv0NlCMOK9FHuZTBuePmIxIrGLXBKKurLXnwxcUO4=;
 b=ZoWB18QBCXMy7/EbNIsub6JV5L5E5eh2SxNWSO189bxUs+DiyXsdBoEkMP7ViK4uFT
 XJkEvkSPe4vfQOcjMb1MuJidV3VielVqhnVg0oIHTh3Eg7Mj9jjeDYjQYc4uJbiCWfT0
 E/UwKodPdRZ3wLnw5dMBcaNG2OahF1b0SmtgUClrrXIw91NnkM3sRBqxQsCzZCHG+PTk
 rQTtD/Z11N0PR1HIzqA/jZgkXomgNtJ5aH4hjy/1EDnXPNljMJr6e+CRl3KWFhR6TrNf
 35LK85tcrms+ZZzu2qmcDCYnEXHf27knzDZKNEP1sdOgFw7Mf3lw/25IZXRl6cR+1DCM
 71Pg==
X-Gm-Message-State: AOAM533Q/tOhh/9XTV9LWsrLH6U79/k/3QGiY8EbbKZgh5ac3aXS2Jvb
 MvO0WnCLkmH0LXyQDh8xC6H3Ji/jm6vBmVsvMti4oyjglygPPxImZbqxrF3JC8u0cYoswvKzrlf
 9SdTXNvflfCqfy7E=
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr4155952wrm.404.1590168332638; 
 Fri, 22 May 2020 10:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3LskL7pEEAgIRi14/ELBuch4/BnO95S5SPntuYMUld7V2gbjKoma2SaM7Jh4froix6nuhEw==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr4155932wrm.404.1590168332397; 
 Fri, 22 May 2020 10:25:32 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 1sm10449061wmz.13.2020.05.22.10.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/13] tests/Makefile: Restrict some softmmu-only tests
Date: Fri, 22 May 2020 19:25:01 +0200
Message-Id: <20200522172510.25784-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we are going to remove some objects from the
util-obj-y variable (objects which are not used by user-mode,
when configured with --disable-system).
Then some system-mode tests are going to fail, due to the missing
objects:

  $ make check-unit -k
    LINK    tests/test-iov
  /usr/bin/ld: tests/test-iov.o: in function `iov_from_buf':
  include/qemu/iov.h:49: undefined reference to `iov_from_buf_full'
  make: *** [rules.mak:124: tests/test-iov] Error 1
    LINK    tests/test-timed-average
  /usr/bin/ld: tests/test-timed-average.o: in function `account':
  tests/test-timed-average.c:27: undefined reference to `timed_average_account'
  make: *** [rules.mak:124: tests/test-timed-average] Error 1
    LINK    tests/test-util-filemonitor
  /usr/bin/ld: tests/test-util-filemonitor.o: in function `qemu_file_monitor_test_event_loop':
  tests/test-util-filemonitor.c:83: undefined reference to `main_loop_wait'
  make: *** [rules.mak:124: tests/test-util-filemonitor] Error 1
    LINK    tests/test-util-sockets
  /usr/bin/ld: tests/test-util-sockets.o: in function `test_socket_fd_pass_name_good':
  tests/test-util-sockets.c:91: undefined reference to `socket_connect'
  make: *** [rules.mak:124: tests/test-util-sockets] Error 1
    LINK    tests/test-base64
  /usr/bin/ld: tests/test-base64.o: in function `test_base64_good':
  tests/test-base64.c:35: undefined reference to `qbase64_decode'
  collect2: error: ld returned 1 exit status
  make: *** [rules.mak:124: tests/test-base64] Error 1
    LINK    tests/test-bufferiszero
  /usr/bin/ld: tests/test-bufferiszero.o: in function `test_1':
  tests/test-bufferiszero.c:31: undefined reference to `buffer_is_zero'
  make: *** [rules.mak:124: tests/test-bufferiszero] Error 1
  make: Target 'check-unit' not remade because of errors.

Instead, restrict these tests to system-mode, by using the
$(CONFIG_SOFTMMU) variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/Makefile.include | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6bc3d1096b..0cb58aad26 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -66,14 +66,14 @@ check-unit-y += tests/check-qlit$(EXESUF)
 check-unit-y += tests/test-qobject-output-visitor$(EXESUF)
 check-unit-y += tests/test-clone-visitor$(EXESUF)
 check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
-check-unit-y += tests/test-qmp-cmds$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qmp-cmds$(EXESUF)
 check-unit-y += tests/test-string-input-visitor$(EXESUF)
 check-unit-y += tests/test-string-output-visitor$(EXESUF)
 check-unit-y += tests/test-qmp-event$(EXESUF)
 check-unit-y += tests/test-opts-visitor$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
 check-unit-y += tests/test-visitor-serialization$(EXESUF)
-check-unit-y += tests/test-iov$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-iov$(EXESUF)
 check-unit-y += tests/test-bitmap$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
@@ -108,7 +108,7 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-y += tests/test-qdev-global-props$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -126,9 +126,9 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tl
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
-check-unit-y += tests/test-timed-average$(EXESUF)
-check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
-check-unit-y += tests/test-util-sockets$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-timed-average$(EXESUF)
+check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) += tests/test-util-filemonitor$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-util-sockets$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-simple$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-list$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-authz-listfile$(EXESUF)
@@ -139,7 +139,7 @@ check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-file$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-io-channel-tls$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-command$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-io-channel-buffer$(EXESUF)
-check-unit-y += tests/test-base64$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-base64$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT))) += tests/test-crypto-pbkdf$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-ivgen$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-afsplit$(EXESUF)
@@ -147,7 +147,7 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) += tests/test
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-block$(EXESUF)
 check-unit-y += tests/test-logging$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) += tests/test-replication$(EXESUF)
-check-unit-y += tests/test-bufferiszero$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) += tests/test-bufferiszero$(EXESUF)
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
-- 
2.21.3


