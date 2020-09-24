Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D9C23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWP3emaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D9C23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOTB-0007MB-HX
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUs-0003Md-E0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUj-0006Eb-50
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2kqUoyTfnbv5OPTGcrz0KXILjZKbfyiGkhcMMRhzV4=;
 b=DWP3emaaZQYnjDQb4Rloan5rIqcZbDQJfI02ehLdXBFa/gU7zJvav+2Ho/+puSD6FD+Ujd
 8pgfI//mkcmlwCgxNE/pw+oB4/5OcrDptAtBuNvopVTDhWEHsrN1O/WVk2+TiPl4d/Zg7y
 W0m0YyEGXKimPzsvslJSnw7juTEG2BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-T4a0rpPUNiGIIGtIZ88tUA-1; Thu, 24 Sep 2020 05:24:49 -0400
X-MC-Unique: T4a0rpPUNiGIIGtIZ88tUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45CB6104D3F6;
 Thu, 24 Sep 2020 09:24:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8E7755778;
 Thu, 24 Sep 2020 09:24:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 80/92] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
Date: Thu, 24 Sep 2020 05:23:02 -0400
Message-Id: <20200924092314.1722645-81-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Dov Murik <dovmurik@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dov Murik <dovmurik@linux.vnet.ibm.com>

According to the coding style document, we should use literal '0x' prefix
instead of printf's '#' flag (which appears as '%#' or '%0#' in the format
string).  Add a checkpatch rule to enforce that.

Note that checkpatch already had a similar rule for trace-events files.

Example usage:

  $ scripts/checkpatch.pl --file chardev/baum.c
  ...
  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #366: FILE: chardev/baum.c:366:
  +            DPRINTF("Broken packet %#2x, tossing\n", req); \
  ...
  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #472: FILE: chardev/baum.c:472:
  +        DPRINTF("unrecognized request %0#2x\n", req);
  ...

Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-Id: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 22bb634c8e..83967d9c6e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2880,14 +2880,20 @@ sub process {
 				$herecurr);
 		}
 
-# check for %L{u,d,i} in strings
+# format strings checks
 		my $string;
 		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
 			$string = substr($rawline, $-[1], $+[1] - $-[1]);
 			$string =~ s/%%/__/g;
+			# check for %L{u,d,i} in strings
 			if ($string =~ /(?<!%)%L[udi]/) {
 				ERROR("\%Ld/%Lu are not-standard C, use %lld/%llu\n" . $herecurr);
-				last;
+			}
+			# check for %# or %0# in printf-style format strings
+			if ($string =~ /(?<!%)%0?#/) {
+				ERROR("Don't use '#' flag of printf format " .
+				      "('%#') in format strings, use '0x' " .
+				      "prefix instead\n" . $herecurr);
 			}
 		}
 
-- 
2.26.2



