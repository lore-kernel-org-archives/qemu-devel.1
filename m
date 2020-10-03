Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23BC4363C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23671206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJZf0oOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23671206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOXYS-0007WL-A9
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 22:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOXUO-0002SV-7z
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 22:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOXUM-0002hG-IZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 22:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601692893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=atYry9IjcahoRsU1YtQbFarNI2d10/MZXv75Kg2GEnM=;
 b=FJZf0oOsPvdwLRiHJ1TQhi5UGrseDNCqHgDDECXmzuiVsdtRV00gF4zM0VjzqJWgE0gbop
 TT0G1vGHq5LFDo/SmCU5+8xJCJeXOlSuDXm/9fd0nwI8+ZrXVvlJAwHNoNqWduJbQgKWw6
 L1I2wkBTKqc2TYJz7SUpR9bg4lF2j5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-n7yl1234OsmmrHnJAh2v0g-1; Fri, 02 Oct 2020 22:41:32 -0400
X-MC-Unique: n7yl1234OsmmrHnJAh2v0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15E8E1005E64;
 Sat,  3 Oct 2020 02:41:31 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D618078482;
 Sat,  3 Oct 2020 02:41:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] kernel-doc: Remove $decl_type='type name' hack
Date: Fri,  2 Oct 2020 22:41:23 -0400
Message-Id: <20201003024123.193840-6-ehabkost@redhat.com>
In-Reply-To: <20201003024123.193840-1-ehabkost@redhat.com>
References: <20201003024123.193840-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 21:51:44
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The $decl_type='type name' hack makes it impossible to document
macros with uppercase names (e.g. most of the macros in
object.h).

Now that we have explicitly tagged the struct and typedef doc
comments in memory.h and object.h, we don't need that hack
anymore.  This will make the documentation for the macros in
object.h finally be rendered as expected.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/kernel-doc | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 57b911ff174..0ff62bb6a2d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1064,14 +1064,6 @@ sub output_blockhead {
 sub dump_declaration($$) {
     no strict 'refs';
     my ($prototype, $file) = @_;
-    if ($decl_type eq 'type name') {
-       if ($prototype =~ /^(enum|struct|union)\s+/) {
-	   $decl_type = $1;
-	} else {
-	   return;
-       }
-    }
-
     my $func = "dump_" . $decl_type;
     &$func(@_);
 }
@@ -1928,9 +1920,7 @@ sub process_name($$) {
 	    ++$warnings;
 	}
 
-	if ($identifier =~ m/^[A-Z]/) {
-	    $decl_type = 'type name';
-	} elsif ($identifier =~ m/^struct\b/) {
+	if ($identifier =~ m/^struct\b/) {
 	    $decl_type = 'struct';
 	} elsif ($identifier =~ m/^union\b/) {
 	    $decl_type = 'union';
-- 
2.26.2


