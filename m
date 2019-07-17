Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F8C76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7D320818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeqOG9GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7D320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZmq-00077m-5q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlD-0000PO-2w
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlC-000667-5y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlC-00065Y-06
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:38 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so11065451pls.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e/myvR8UUqBBLg5JmLrRZ1lh6zWyj3aqESVQCWDzo60=;
 b=UeqOG9GStswvomrQRyq/EmfU8c4b6IdmhENzogOP7kjzol+Y0Y11dmkJbukWAXHlB3
 Kv6zwvY3A9UWRfvfO8zxxEIv7EnEqOF6fcBkeJCP69MvWdxqXDT5CGNVU0hDOUWE9fCU
 KzsHrjJLTeSEo5TwfmCL7MygbsMfG5NCGtIDfsW/zfnczvUmfXYBDwEPzX9mfsbpctHM
 Z7qxNrpFkKtog58f4R1/eHqMvgSNEIl9RzKw/6814HnFNTUqLuc26LFy6Z41y188FGgq
 CCHbwFwmqd/8IX3cqKPiuQyi0Fsov17vjfXdGOTX2bHPlAdbRzZ37rPjlJ1waW7sbujv
 VnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e/myvR8UUqBBLg5JmLrRZ1lh6zWyj3aqESVQCWDzo60=;
 b=iF977RxjFum2N2bHR+Ut+1a6eZDmuIzeGbXDhTJmG82ppzLXyU6PG1/13Gaes7Al1V
 pcaWqa85rcRMPyqDYPb6pY1RWPjRbg1oTH77uPLZYUiQ7qqM0Y/Ir1L0tNPZCp52jzbC
 hYoiNgMNs+G3swOJA/3VbFBQb5Y5FKesKmEHcwbML9klidCR0jQLAP7GtMfeYHe+uRig
 NqIlom+9LDkdU7uXkBJnmf6DHPWEP/xfTlT4BUQZyzt59/rDHr4SSBqlRbwxFLt4bzZb
 JeGGW4GFque3voAqp+c5eL8KVIs3K459BbEUaO99FMiyQblrtZ9btzSQqm11ASEVXjH7
 e3mg==
X-Gm-Message-State: APjAAAX6ZvupbUmiNMSUSUfbarzG15wa8+pzVaXcWyEZdSk54o3rftEb
 UwM2xhachONJPo2cYm+ihN8PPSQT
X-Google-Smtp-Source: APXvYqzd8GxjqssTpvMl4775NVKE5Kz7cvEIFaeswlfrGNV+a/3t8puPAtVhWnNOSrv6Wz0Ffq4jDQ==
X-Received: by 2002:a17:902:b603:: with SMTP id
 b3mr40327360pls.9.1563330816769; 
 Tue, 16 Jul 2019 19:33:36 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:36 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:02 +0800
Message-Id: <20190717023310.197246-4-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v14 03/11] qemu_thread: supplement error
 handling for qmp_dump_guest_memory
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error instead of the
temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 1358e62fb7..07a983cf4c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2022,9 +2022,8 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
-        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED, &error_abort);
+                           s, QEMU_THREAD_DETACHED, errp);
     } else {
         /* sync dump */
         dump_process(s, errp);
-- 
2.11.0


