Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C826C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243262074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kna5XPTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243262074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwoy-0007om-8E
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkC-0003zC-Hj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkA-0004Tl-2w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602504956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgJl3lyw3zlJ4rwBHSsLrJq7aR281tmH8GHtlDsXSws=;
 b=Kna5XPTMGQH4QSKf6XB4Zv5BVwjhOVQY6Jt2M6oVWYwKWk18eCssaFAGWD8CBrUa2J2gLM
 IklArjXzgyCGKeKnCsL/paGK2wGv7IvMNUMideOq0kXwwzgKUWxCTL9AaSreJIkUPGyrZ6
 UsQz5xGnwZZGCm4ajhMe0SSBAQ13zhc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-n8_tc1-qPB-QfJn31xhyaA-1; Mon, 12 Oct 2020 08:15:54 -0400
X-MC-Unique: n8_tc1-qPB-QfJn31xhyaA-1
Received: by mail-wr1-f70.google.com with SMTP id u15so9267296wrn.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PgJl3lyw3zlJ4rwBHSsLrJq7aR281tmH8GHtlDsXSws=;
 b=LX6koYd3ehTi3YiKsy9csAZ4Uw5OeP2ycYU2jP1+DtKIt+0gx61pB0Czah7bRYfrNM
 QG7mRucTjDkJVJXApijdPsQERhz8lm3sWrTUCu+GA55qyErp/Qr2w20bRgctlYhfiBMP
 ZT65Q/5V5J+p2wFSG30HyZA8+4yU3KxB7wJM1MWs9Ovt49xLoj//Uudk8QCEcQzBewQi
 w8EznRLkNpowlnmdZFevtXq9yYE5jLi0789REk4P+1ZbtS6NQLf0LQq53HsXNku/i7Ji
 pvM7l6m0SkYjgtlda1EJX1RF9JHm1EzCUSJkuBx/v91umzc8eH+k47v0ojYrjCU4zyum
 vEYg==
X-Gm-Message-State: AOAM531JsSag6/ptwpGb4/ByQJ42N/WhgZXjj4PUO0gNwIxBcmW/tgVH
 ee1/HMUdIGXIoZVjVHA5EHQIVoswV1dogUf58zhb3m/yawsL5p1+bRUkJdZu0MwymsxPywXqWPA
 5EeTfJIoyNyYYHTU=
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr27530566wrq.254.1602504953123; 
 Mon, 12 Oct 2020 05:15:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPXKJoRuNkuaLK5MItsZ/rjhub7YYwh4l98TVQ1DKvOc5WgBpacVjym95pHEXhqN3TaHPhTA==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr27530544wrq.254.1602504952929; 
 Mon, 12 Oct 2020 05:15:52 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w1sm25023393wrp.95.2020.10.12.05.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 3/5] qapi: Restrict '(p)memsave' command to machine code
Date: Mon, 12 Oct 2020 14:15:34 +0200
Message-Id: <20201012121536.3381997-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012121536.3381997-1-philmd@redhat.com>
References: <20201012121536.3381997-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting memsave/pmemsave to machine.json pulls slightly
less QAPI-generated code into user-mode and tools.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 61 -----------------------------------------------
 2 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 55328d4f3ca..5a3bbcae01b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -887,6 +887,67 @@
 { 'enum': 'HostMemPolicy',
   'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
 
+##
+# @memsave:
+#
+# Save a portion of guest memory to a file.
+#
+# @val: the virtual address of the guest to start from
+#
+# @size: the size of memory region to save
+#
+# @filename: the file to save the memory to as binary data
+#
+# @cpu-index: the index of the virtual CPU to use for translating the
+#             virtual address (defaults to CPU 0)
+#
+# Returns: Nothing on success
+#
+# Since: 0.14.0
+#
+# Notes: Errors were not reliably returned until 1.1
+#
+# Example:
+#
+# -> { "execute": "memsave",
+#      "arguments": { "val": 10,
+#                     "size": 100,
+#                     "filename": "/tmp/virtual-mem-dump" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'memsave',
+  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
+
+##
+# @pmemsave:
+#
+# Save a portion of guest physical memory to a file.
+#
+# @val: the physical address of the guest to start from
+#
+# @size: the size of memory region to save
+#
+# @filename: the file to save the memory to as binary data
+#
+# Returns: Nothing on success
+#
+# Since: 0.14.0
+#
+# Notes: Errors were not reliably returned until 1.1
+#
+# Example:
+#
+# -> { "execute": "pmemsave",
+#      "arguments": { "val": 10,
+#                     "size": 100,
+#                     "filename": "/tmp/physical-mem-dump" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'pmemsave',
+  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
+
 ##
 # @Memdev:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 90fd862a6cb..9fa702b0f66 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -177,67 +177,6 @@
 ##
 { 'command': 'stop' }
 
-##
-# @memsave:
-#
-# Save a portion of guest memory to a file.
-#
-# @val: the virtual address of the guest to start from
-#
-# @size: the size of memory region to save
-#
-# @filename: the file to save the memory to as binary data
-#
-# @cpu-index: the index of the virtual CPU to use for translating the
-#             virtual address (defaults to CPU 0)
-#
-# Returns: Nothing on success
-#
-# Since: 0.14.0
-#
-# Notes: Errors were not reliably returned until 1.1
-#
-# Example:
-#
-# -> { "execute": "memsave",
-#      "arguments": { "val": 10,
-#                     "size": 100,
-#                     "filename": "/tmp/virtual-mem-dump" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'memsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
-
-##
-# @pmemsave:
-#
-# Save a portion of guest physical memory to a file.
-#
-# @val: the physical address of the guest to start from
-#
-# @size: the size of memory region to save
-#
-# @filename: the file to save the memory to as binary data
-#
-# Returns: Nothing on success
-#
-# Since: 0.14.0
-#
-# Notes: Errors were not reliably returned until 1.1
-#
-# Example:
-#
-# -> { "execute": "pmemsave",
-#      "arguments": { "val": 10,
-#                     "size": 100,
-#                     "filename": "/tmp/physical-mem-dump" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'pmemsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
-
 ##
 # @cont:
 #
-- 
2.26.2


