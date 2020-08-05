Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818EF22B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+KMo8kA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818EF22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FDj-0005yz-Ra
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FCx-0004xA-35
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FCv-00012W-C1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gXNBGJiNm5FTx5pHj82gzCAwm35Mno7eSXSp6uSccW4=;
 b=R+KMo8kAeYxmGLiUwIcaZ9VDRlyTAOlDlCITFLqQMRLqOVL9LDLmL9wCW5Q+l1U+2HKZ91
 sdmWoq7POh7aT9aZnmmdCD85in2OYiHRq8sA9RdOhdu1m/LErhf9PyO3O419gCSFtC9Gbe
 0/agCf3ikT3Ta9js5z69uLhTN7syNS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-0AEIyoZzMySGw1b2lY8I8Q-1; Wed, 05 Aug 2020 04:55:30 -0400
X-MC-Unique: 0AEIyoZzMySGw1b2lY8I8Q-1
Received: by mail-wm1-f71.google.com with SMTP id i15so2201873wmb.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gXNBGJiNm5FTx5pHj82gzCAwm35Mno7eSXSp6uSccW4=;
 b=YykvrL0sBub9S/lgyIWF7b83O3DHjDnPeo+p8r2JtXr1o3YYhn6ze+7hXJ+e6bBOuO
 NG3LubCF+hPeyxko1vt/+/LofBpW2ib08bqU4Z/yjvH6Vs30LQUrIqH0R+Q6uwqbQCPw
 MjqM8dLh+wryEQo7RTIS8bM/+NyGbE+jL0lkL+xt0W3HWTiY2Nc2EndLmcklQWz41e2k
 BU28w0K+wNOjvogkE2yTR0uLvwuXUZ5dGrdkQa84XjBCLpvephdV0Wl1V4gedMreuu5l
 A1suKXxfqGn0VVafvlMEr3+EwWsFbHsuRuhJahe3DQ/Makp3leLrh2vrQvTMSVIlFlU1
 KVjg==
X-Gm-Message-State: AOAM533gLzpWUytccSWqRvauGqKWyjN4v5+c41cuPCIVsHWaGAWClU5m
 rpp9KUGbxZAs825xzZRF600tXZJ4XR4tx2oBxxVuWUAmjJ+1i/wO5k58RY7aCSH+kjupqdy3WQa
 4kZ8toWm47c0V04Y=
X-Received: by 2002:a1c:6446:: with SMTP id y67mr2336756wmb.49.1596617729063; 
 Wed, 05 Aug 2020 01:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUhUAIYTApTo59tlCeZq8kjjFxF/eZYlDdKwBfEREikJ27n7O8KsX6vCV3C7ox0E+PIOl3jA==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr2336739wmb.49.1596617728830; 
 Wed, 05 Aug 2020 01:55:28 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 62sm1867773wrq.31.2020.08.05.01.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 01:55:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 0/2] stubs: Fix notify-event stub linkage error on
 MinGW
Date: Wed,  5 Aug 2020 10:55:24 +0200
Message-Id: <20200805085526.9787-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2 trivial patches to fix the link error reported by Thomas:

  LINK    tests/test-timed-average.exe
 libqemuutil.a(main-loop.o): In function `qemu_notify_event':
 util/main-loop.c:139: multiple definition of `qemu_notify_event'
 tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5: first defined here
 collect2: error: ld returned 1 exit status
 rules.mak:124: recipe for target 'tests/test-timed-average.exe' failed

Philippe Mathieu-Daudé (2):
  exec: Restrict icount to softmmu
  stubs: Remove qemu_notify_event()

 include/sysemu/cpus.h  | 4 ++++
 exec.c                 | 4 ----
 softmmu/cpus.c         | 7 +++++++
 stubs/cpu-get-icount.c | 2 +-
 stubs/notify-event.c   | 6 ------
 stubs/Makefile.objs    | 1 -
 6 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 stubs/notify-event.c

-- 
2.21.3


