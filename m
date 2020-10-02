Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CC9206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMA2qWUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CC9206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLL6-0003Tk-50
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHs-0007Zc-V2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHm-0005Rh-IE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l++0FncV4p/balcOSro5u4OfFvevG6nmzhJ8fBAOs6w=;
 b=CMA2qWUGKaJFPOl0xhGRkqRJydMFHE/FmbhQU6a7ZBwhMjgpWmsmnjpmOVyZuLlumvB6Y1
 6E+J1hXmJ0pWFAEvPkSpteVeuafaRmgZxX18bWOuyvMTx9UNnAH4ik6TwLKEEwITrK5ClC
 8uVqal1/E8Mcjd1PAMKodt8yPS13IeI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-33mi2_fyNU6lwhs5Mup5YQ-1; Fri, 02 Oct 2020 09:39:44 -0400
X-MC-Unique: 33mi2_fyNU6lwhs5Mup5YQ-1
Received: by mail-wm1-f70.google.com with SMTP id a25so436338wmb.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l++0FncV4p/balcOSro5u4OfFvevG6nmzhJ8fBAOs6w=;
 b=JpyMfO+dhZtz8EI8CN0E7ulbTRAqQc+KamtAiaDZ3DSqKAPxEsRRaht6T0444U/sAf
 LDdmMKyMVdrgx7F73WgdFfrhdNtuzTuRegG6nTAfzXcEoZ69z1ZQ9IyYYlzLiF+jYMS2
 JxqhzR7NwewP9RfXZv89o5iVexqfhzFHftPgdctVMs1ptQqLqHfMTq0HpLoWISsEe912
 6KSbPqDzWERRqPuWWqhjkq2af00LlLU6aXO/NqmgXlufWtVD/YGyB5qjPwzoOZ4ja9Yq
 C2c71/v7If9KRNfOcIyLh/AEQaCX8xHzXo3UIJzc7OiBiTkUSQxcf3Cs2bZeoh89rJp4
 op6A==
X-Gm-Message-State: AOAM532Bro7os5m9kYXoXcT6ii8MYUEKzl8vhYGGMN80TGxkVhKbkS5k
 qKZSNtcQ53bz7T3rq2h1tOABHrZxtOXwY1rCDbNuY9F9Li15USA4nH1gLGlM6d9sggD6spxZtlP
 BZzizLlBpfnm0GYM=
X-Received: by 2002:a1c:9a0c:: with SMTP id c12mr3069203wme.85.1601645982656; 
 Fri, 02 Oct 2020 06:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytnflmvzG2NbHjeDXeHd5cEjLZ7ujLVl3vbAMVyGFRFjZMyWEyqKmjFZCL5TRb0S/3cpVZiw==
X-Received: by 2002:a1c:9a0c:: with SMTP id c12mr3069171wme.85.1601645982462; 
 Fri, 02 Oct 2020 06:39:42 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 13sm1358682wmk.30.2020.10.02.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] qapi: Restrict '(p)memsave' command to machine code
Date: Fri,  2 Oct 2020 15:39:21 +0200
Message-Id: <20201002133923.1716645-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002133923.1716645-1-philmd@redhat.com>
References: <20201002133923.1716645-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting memsave/pmemsave to machine.json pulls slightly
less QAPI-generated code into user-mode and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 61 -----------------------------------------------
 2 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 55328d4f3c..5a3bbcae01 100644
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
index cce2e71e9c..2a5d03a69e 100644
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


