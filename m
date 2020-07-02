Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1734C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA882070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZvr/pgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA882070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxma-00046t-Ju
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkG-0007hj-Rw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxkE-0007PS-I1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=QQL1xXAIE5gAyGjWtJORQEY4XjnpDAOEuoxG6TeQngs=;
 b=XZvr/pgyn94eS79fmOxxLPZmqbjG0SGOT5FKMBHzPBHtfPMOxL1FC8RTdMHa9sNqwRTdr/
 mkAPDlXkk65Lj9aN10SrZYSxRo9urRx/O37QF/eMnBLI5lOAQywL8LaX19HQt819CWhZGs
 /uWxFZNZ7mykrv7ydCEY1Ws9WDYLPjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-A5-Wa65-POmYpiY6uWPM3g-1; Thu, 02 Jul 2020 07:51:05 -0400
X-MC-Unique: A5-Wa65-POmYpiY6uWPM3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446C487950D;
 Thu,  2 Jul 2020 11:51:04 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C937C60CD3;
 Thu,  2 Jul 2020 11:51:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 07/11] pc-bios: s390x: Move panic() into header
 and add infinite loop
Date: Thu,  2 Jul 2020 13:50:41 +0200
Message-Id: <20200702115045.6171-8-thuth@redhat.com>
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
References: <20200702115045.6171-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

panic() was defined for the ccw and net bios, i.e. twice, so it's
cleaner to rather put it into the header.

Also let's add an infinite loop into the assembly of disabled_wait() so
the caller doesn't need to take care of it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200624075226.92728-9-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c     | 7 -------
 pc-bios/s390-ccw/netmain.c  | 8 --------
 pc-bios/s390-ccw/s390-ccw.h | 9 +++++++--
 pc-bios/s390-ccw/start.S    | 5 +++--
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8b912454c9..146a50760b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -46,13 +46,6 @@ void write_iplb_location(void)
     lowcore->ptr_iplb = ptr2u32(&iplb);
 }
 
-void panic(const char *string)
-{
-    sclp_print(string);
-    disabled_wait();
-    while (1) { }
-}
-
 unsigned int get_loadparm_index(void)
 {
     return atoui(loadparm_str);
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index f1ee63577a..056e93a818 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -439,14 +439,6 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
     return rc;
 }
 
-void panic(const char *string)
-{
-    sclp_print(string);
-    for (;;) {
-        disabled_wait();
-    }
-}
-
 void write_subsystem_identification(void)
 {
     SubChannelId *schid = (SubChannelId *) 184;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c5820e43ae..36b884cced 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -50,12 +50,11 @@ typedef unsigned long long __u64;
 #include "iplb.h"
 
 /* start.s */
-void disabled_wait(void);
+void disabled_wait(void) __attribute__ ((__noreturn__));
 void consume_sclp_int(void);
 void consume_io_int(void);
 
 /* main.c */
-void panic(const char *string);
 void write_subsystem_identification(void);
 void write_iplb_location(void);
 extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
@@ -91,6 +90,12 @@ bool menu_is_enabled_enum(void);
 
 #define MAX_BOOT_ENTRIES  31
 
+static inline void panic(const char *string)
+{
+    sclp_print(string);
+    disabled_wait();
+}
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index aa8fceb19d..ce519300a1 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -47,8 +47,9 @@ memsetxc:
  */
 	.globl disabled_wait
 disabled_wait:
-        larl %r1,disabled_wait_psw
-        lpswe   0(%r1)
+	larl	%r1,disabled_wait_psw
+	lpswe	0(%r1)
+1:	j	1b
 
 
 /*
-- 
2.18.1


