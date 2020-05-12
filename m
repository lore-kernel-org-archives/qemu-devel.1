Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FCEC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62795206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akSLD2/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62795206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSI9-0004Gj-5J
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDZ-0006f2-Mh
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDZ-0007UJ-0d
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOtCARhB88XtH+7DaaroGpTjVIhIb43b3LSLjds5GUw=;
 b=akSLD2/A0Ip6YVP9iNnJ4krRL2iuA+NoOpo3VNpa3utcej16tgoa1SN54Cya4bBLX4FC3i
 XQEpZjKCxSkcNNCYReHrQ4ZhA4qI5+T/UL7BLPxZkdR/S/M5Ec+Uk8eIJd9ye04HMaEX7i
 4tCXEkx2sPKW7Wo58hbxwuM3DxMWJQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-W3BiperrMAugvXB27e3IVQ-1; Tue, 12 May 2020 06:32:51 -0400
X-MC-Unique: W3BiperrMAugvXB27e3IVQ-1
Received: by mail-wm1-f71.google.com with SMTP id e15so935723wme.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zOtCARhB88XtH+7DaaroGpTjVIhIb43b3LSLjds5GUw=;
 b=eHzZXZ6iA2T3OjDEBGDGARta9i9xkFn8LmOigEZOM2WzPDYSpM97DbsdpeY9uOf56W
 mY5VMrTXbFe4BsLDBxYR7bTGeCzlAubL2Q7XtD8q1Z8Hk6Sm51gvTUqYArd9Etosi1/O
 n36NsRFaaS3mgqJuZF3q3Em0070IdH+nixKAw7YF9BfKz6v+TyYAHl9RWrX98ZjHOi8r
 HVeiuOfSopmiV1onZTbFY37U1DMz/QqGsZS4I65RMQ+TWQKT6SbiZTV6ctX4vTRblsT+
 BVRHUqYUr6omHCyDs8flWLRRP2E1wrb1R1PofAU63bcf43Ic0LrObQ8MErlFZ9lq474R
 5FHw==
X-Gm-Message-State: AGi0PuaohfovRioGZvdnclBdnFAIDRFClszPzNu2taSlXK8/m/0BXqaB
 8UvSV3BMjM7abOOmmvC7AAfPlmkLdZZCBC0gD9xIlRKmZvYjrPLcIuK4meQoNNZwlEGRiQRXFAQ
 +LygwN+hFHifZRhc=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr12858077wrp.427.1589279570203; 
 Tue, 12 May 2020 03:32:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIp4cKlTsev0nh13QNGo5ccEqxoYf5orH801v8Ck5Kq9gfAUjGI6X3+2CENt1I9LXed1D7kpQ==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr12858058wrp.427.1589279570025; 
 Tue, 12 May 2020 03:32:50 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u74sm31235914wmu.13.2020.05.12.03.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:32:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] scripts/qemu-gdb: Use Python 3 interpreter
Date: Tue, 12 May 2020 12:32:34 +0200
Message-Id: <20200512103238.7078-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512103238.7078-1-philmd@redhat.com>
References: <20200512103238.7078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
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
 scripts/qemu-gdb.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index f2a305c42e..e0bfa7b5a4 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -1,5 +1,5 @@
-#!/usr/bin/python
-
+#!/usr/bin/env python3
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
-- 
2.21.3


