Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB75FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55EF2074B
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCQMDnUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55EF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR0S-0002VB-SG
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzG-0000ng-Cr
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzF-0006eU-JH
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly/BNyoFscwcUlEdMi1CDGrrxngHJB98Yaq6NCa8Sss=;
 b=RCQMDnUdyBjsa1xhJ27PLnBho2J+oTh3+9/ISOo7cLxTmcrmMYeJcyXFZL5DoQPfUDeIJh
 ikAHqYgN2DSW/VinzTlsgJC6TJ/V8ESJyKsMWRwXhq4Zx4oFucT05vbbTWoPWjsmBadBdA
 ZGMCqIDzpQWXjP2ONQXJUICLKldoJpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-NFJOCalZNWOMDdvzVfd3Hg-1; Sun, 31 May 2020 12:38:57 -0400
X-MC-Unique: NFJOCalZNWOMDdvzVfd3Hg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so3614456wrp.5
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ly/BNyoFscwcUlEdMi1CDGrrxngHJB98Yaq6NCa8Sss=;
 b=ZSnUyaK8QgJ0oLRQAK6B8rXpWzINkSdMIsVfucfWvFTmUgk57lJ7r7/h76CbNlwlBj
 pivvjaLJcEnVo9CsTkzOX5syEub9EuM4Gpm/CWIw0GjiChGZqKJhnMmfi8kS4CN9QHOT
 3xvqGIVn8qM4jDFhy9K/r7TdfSjPs2fFgCzhuZpgZAHraefIsmppncjAKAwPYaEL+rI3
 zvpSFkvaU+0OvOJ0PzMzUD7pY4Y0F5RDFmq7Dmk+VtEk0ZdUzHZ1MJZN9jOfcuxXvpR7
 gdsDF/OFHbffJJrV0y2fy0dd59ZQ3BuyF0FVUkrQEJlqR+vo0hoz0enbTSnrmADJE2/C
 OJ9w==
X-Gm-Message-State: AOAM531OHG+WSNf5+stLPndhF7l4inuhhj8CqaipTb1WhJM2VHXo9UR9
 LO4m04R26HOCkQU+at2NBenml6tsG4I6CHNLYQTDsJ/ZejkGS+BjGgB2iim8STpwrnZDUWhYKWH
 KJR+CAyAfYHcGbTY=
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr18519117wrt.350.1590943135211; 
 Sun, 31 May 2020 09:38:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe7sJn4ZGtJgKpS26KNwTyhpDQC9oFjhczDjqsHEXGXaRKqr+VepBPJMpNihdteRynA8wNuA==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr18519096wrt.350.1590943134994; 
 Sun, 31 May 2020 09:38:54 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id v7sm8920008wme.46.2020.05.31.09.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:38:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/25] scripts/qemugdb: Remove shebang header
Date: Sun, 31 May 2020 18:38:22 +0200
Message-Id: <20200531163846.25363-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

These scripts are loaded as plugin by GDB (and they don't
have any __main__ entry point). Remove the shebang header.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200512103238.7078-2-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qemugdb/__init__.py  | 3 +--
 scripts/qemugdb/aio.py       | 3 +--
 scripts/qemugdb/coroutine.py | 3 +--
 scripts/qemugdb/mtree.py     | 4 +---
 scripts/qemugdb/tcg.py       | 1 -
 scripts/qemugdb/timers.py    | 1 -
 6 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/scripts/qemugdb/__init__.py b/scripts/qemugdb/__init__.py
index 969f552b26..da8ff612e5 100644
--- a/scripts/qemugdb/__init__.py
+++ b/scripts/qemugdb/__init__.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright (c) 2015 Linaro Ltd
diff --git a/scripts/qemugdb/aio.py b/scripts/qemugdb/aio.py
index 2ba00c4444..d7c1ba0c28 100644
--- a/scripts/qemugdb/aio.py
+++ b/scripts/qemugdb/aio.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support: aio/iohandler debug
 #
 # Copyright (c) 2015 Red Hat, Inc.
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 41e079d0e2..db61389022 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 3030a60d3f..8fe42c3c12 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
@@ -84,4 +83,3 @@ def print_item(self, ptr, offset = gdb.Value(0), level = 0):
         while not isnull(subregion):
             self.print_item(subregion, addr, level)
             subregion = subregion['subregions_link']['tqe_next']
-
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 18880fc9a7..16c03c06a9 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python
 # -*- coding: utf-8 -*-
 #
 # GDB debugging support, TCG status
diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index f0e132d27a..46537b27cf 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python
 # -*- coding: utf-8 -*-
 # GDB debugging support
 #
-- 
2.21.3


