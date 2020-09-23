Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EAA2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkvZCmPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAA2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6hw-0008EB-Ty
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL6YK-00037z-7O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL6YH-0004wi-57
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNqHAQasEpOK1KuycqWmfpHDwWuhMI6riKpROkw+oro=;
 b=GkvZCmPB+GCLx43Gwjh+aJFwy9oIN3XfFPgPQQ6X3YmC7Tso/091ZM/a4Mr9MWW3sBecQm
 LzWQC+bLm2TIERMEomfOM4n2YDi858+5QqehC2sh/JrEEkG/pUElY/TKdtUpb+i3+r14DG
 ekeY/hSHLWhO+RFpfOtC1F1ty2t6Aa8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Uqj5iZUpOUiAeBylzZzVmw-1; Wed, 23 Sep 2020 11:19:20 -0400
X-MC-Unique: Uqj5iZUpOUiAeBylzZzVmw-1
Received: by mail-wr1-f71.google.com with SMTP id s8so8930395wrb.15
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eNqHAQasEpOK1KuycqWmfpHDwWuhMI6riKpROkw+oro=;
 b=ELohEaaGDH+2dq1g2FGkoe3f+s2WQiWMaF9MoCmomWZAYPn3RiJcLQ/iUkJGe7aEfR
 y8Icabf9PtfCENLBEI5m7te8tJoN85L/Fq8v9cz1AQk0pTwWUnuW8mSTANBtDGiGk+hz
 wBV/0qgPpnDXULdFIbycJXWyfBu2IUhxZtx8mkP5/Pot/rCeqhw3A8DhJv3r0bM+iHLa
 y04UbWtVgFcwLMP8Lx6+oguE9pB7FZvR6ZrS570fnbBpScyE+dC0ZztUES7jbiCGOKfN
 5UXQ8WRCXapk1vuKx53IePe5DqrPPts8JwchR2n+tsCNYm2NOqeA85cyjX3Cg+nufIHU
 YxtA==
X-Gm-Message-State: AOAM530TUd5DB/E9cqQkBbVn4r7FiUTQYIus1HCnyqNBN+mIoI6PNDCF
 w3UIA3iS9a77RcUav9FY8Yx+NOEGR5Xngjw8MXw1btLK1UQWFZ6VhNRAfq/o3E8OV6FcSfUxAos
 u/vNN5XykMfPC8m0=
X-Received: by 2002:a1c:e087:: with SMTP id x129mr74238wmg.160.1600874358942; 
 Wed, 23 Sep 2020 08:19:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrXzZCUiN8oSkYWfYWeqZPSESHCThuL0H5m8AItskpz2Z9omZeyWhD81lEuOripbj+xRu5FQ==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr74215wmg.160.1600874358700; 
 Wed, 23 Sep 2020 08:19:18 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm112536wmh.29.2020.09.23.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 08:19:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] qemu/atomic: Update coding style to make checkpatch.pl
 happier
Date: Wed, 23 Sep 2020 17:19:00 +0200
Message-Id: <20200923151901.745277-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923151901.745277-1-philmd@redhat.com>
References: <20200923151901.745277-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To limit the number of checkpatch errors in the next commit,
clean coding style issues first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
False positive:

 ERROR: Use of volatile is usually wrong, please add a comment
 #11: FILE: include/qemu/atomic.h:328:
 +#define atomic_read__nocheck(p)   (*(__typeof__(*(p)) volatile *) (p))

 ERROR: Use of volatile is usually wrong, please add a comment
 #12: FILE: include/qemu/atomic.h:329:
 +#define atomic_set__nocheck(p, i) ((*(__typeof__(*(p)) volatile *) (p)) = (i))
---
 include/qemu/atomic.h | 9 +++++----
 util/bitmap.c         | 3 ++-
 util/rcu.c            | 6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index ff72db51154..1774133e5d0 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -325,11 +325,11 @@
 /* These will only be atomic if the processor does the fetch or store
  * in a single issue memory operation
  */
-#define atomic_read__nocheck(p)   (*(__typeof__(*(p)) volatile*) (p))
-#define atomic_set__nocheck(p, i) ((*(__typeof__(*(p)) volatile*) (p)) = (i))
+#define atomic_read__nocheck(p)   (*(__typeof__(*(p)) volatile *) (p))
+#define atomic_set__nocheck(p, i) ((*(__typeof__(*(p)) volatile *) (p)) = (i))
 
 #define atomic_read(ptr)       atomic_read__nocheck(ptr)
-#define atomic_set(ptr, i)     atomic_set__nocheck(ptr,i)
+#define atomic_set(ptr, i)     atomic_set__nocheck(ptr, i)
 
 /**
  * atomic_rcu_read - reads a RCU-protected pointer to a local variable
@@ -440,7 +440,8 @@
 #endif
 #endif
 
-/* atomic_mb_read/set semantics map Java volatile variables. They are
+/*
+ * atomic_mb_read/set semantics map Java volatile variables. They are
  * less expensive on some platforms (notably POWER) than fully
  * sequentially consistent operations.
  *
diff --git a/util/bitmap.c b/util/bitmap.c
index 1753ff7f5bd..c4fb86db72a 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -211,7 +211,8 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
         mask_to_set &= BITMAP_LAST_WORD_MASK(size);
         atomic_or(p, mask_to_set);
     } else {
-        /* If we avoided the full barrier in atomic_or(), issue a
+        /*
+         * If we avoided the full barrier in atomic_or(), issue a
          * barrier to account for the assignments in the while loop.
          */
         smp_mb();
diff --git a/util/rcu.c b/util/rcu.c
index c4fefa9333e..b5238b8ed02 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -82,7 +82,8 @@ static void wait_for_readers(void)
          */
         qemu_event_reset(&rcu_gp_event);
 
-        /* Instead of using atomic_mb_set for index->waiting, and
+        /*
+         * Instead of using atomic_mb_set for index->waiting, and
          * atomic_mb_read for index->ctr, memory barriers are placed
          * manually since writes to different threads are independent.
          * qemu_event_reset has acquire semantics, so no memory barrier
@@ -151,7 +152,8 @@ void synchronize_rcu(void)
 
     QEMU_LOCK_GUARD(&rcu_registry_lock);
     if (!QLIST_EMPTY(&registry)) {
-        /* In either case, the atomic_mb_set below blocks stores that free
+        /*
+         * In either case, the atomic_mb_set below blocks stores that free
          * old RCU-protected pointers.
          */
         if (sizeof(rcu_gp_ctr) < 8) {
-- 
2.26.2


