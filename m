Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F90C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D58220722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKYYkF5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSJM-0006Et-Kq
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDb-0006if-E5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDa-0007Ue-9K
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWSfUmBy5G7w8s0mFzIrpHSBiQEAL75l96FocmDeH+w=;
 b=JKYYkF5pg+/SSLA7p+rqe6rlvo1hrguFd3la7Ll+H3KBcOiz5nrz4hEkCH85sEj9Un3+ZG
 IPnL3DeTFhiHvDG1MuHHOHpZzNTCgsyGZ0Ot+JP3cjnDJ8j1Bl0HWsthy93iwF/2elttoa
 koy6bo3iixfwM7BEMmzKGwQ1a1OVmJM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-MxkKFgYxPcG4hfqgxGxhuA-1; Tue, 12 May 2020 06:32:56 -0400
X-MC-Unique: MxkKFgYxPcG4hfqgxGxhuA-1
Received: by mail-wr1-f69.google.com with SMTP id y7so6706362wrd.12
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oWSfUmBy5G7w8s0mFzIrpHSBiQEAL75l96FocmDeH+w=;
 b=hoMXENDEEgGF5yXBnNH01Qfm3STm2Jnh9fmkm52dF1CBuy5ciLZndgJb+HhoP/JRXQ
 b7S/ZtzE7QEyQlmeqkoGn3NWmwX1Pd/D0q8/tosfQLLK3jzT5tpg+/eFdea2xeAHT8B9
 Dpk2XQgFXmG2ZdMaF9s0Nu0DNBjrljq+v+czATqo5EFzABZDW/45cvZnIBRoTaidcsb7
 1TZNEy1D2ngdyqSwIwGnJXA0nYkISTV4waVcjbhDE8nBLUmQICZmymPXLuT3qCXINuHS
 38BzBp7D222x1ATprocjTJmh6eqItjNaZHf4YD+ozB9tU+IykuJOf7Czqh/WGzRWRxAS
 zcsA==
X-Gm-Message-State: AGi0PuYYSQ4h9F+KGrK7HHtGGnKwXHUxK21qlx64llDq9wSRLuWURSSX
 pMkgyb01QOBpkhozW0yf70XSetu+8nzEzxVgpfLMDQ0TPXnbjB+tQjAFbMGH9xKUjntFGEj6Jr5
 kfwbCEjYyE1yrcyw=
X-Received: by 2002:a5d:560c:: with SMTP id l12mr23822077wrv.309.1589279574899; 
 Tue, 12 May 2020 03:32:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIQhhMzrfHJzuqqGpCMtne83+qTrDIGPL9GtO3XV5eyvzYb43eEF0XvrPWMJEaysSiQNLomJg==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr23822059wrv.309.1589279574750; 
 Tue, 12 May 2020 03:32:54 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b18sm1112431wrn.82.2020.05.12.03.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:32:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] scripts/qmp: Use Python 3 interpreter
Date: Tue, 12 May 2020 12:32:35 +0200
Message-Id: <20200512103238.7078-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512103238.7078-1-philmd@redhat.com>
References: <20200512103238.7078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qmp/qom-get  | 2 +-
 scripts/qmp/qom-list | 2 +-
 scripts/qmp/qom-set  | 2 +-
 scripts/qmp/qom-tree | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 007b4cd442..7c5ede91bb 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 03bda3446b..bb68fd65d4 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index c37fe78b00..19881d85e9 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 1c8acf61e7..fa91147a03 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
-- 
2.21.3


