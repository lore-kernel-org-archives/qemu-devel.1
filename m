Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA302C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80058206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrUmBqap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80058206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvfc-0002Gd-Bl
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveP-0000xz-GJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveN-0004Ce-RH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveN-0004C4-Cf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=122YOYw144hc6vkPSvZo4NtonS9ahelmjBfjzv+fw7s=;
 b=FrUmBqap3sIw5NYm891rFQr1iuSJHUOWoKeuxFpGU25HjRbnISyXNcL3VGrJTXmBCTVQYY
 ht1LDo547WMCDHT38DrFW1kmYWNRvW12p0eWeYYiUa/ODCbQitqbT4Xx8MtZ3KXigL9gaY
 z0YaME+xt5QUbwPEXHuacyiLlfe6RqI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-ULJNS5A2NWu3yyjC7oTesg-1; Tue, 21 Apr 2020 12:21:28 -0400
X-MC-Unique: ULJNS5A2NWu3yyjC7oTesg-1
Received: by mail-qt1-f199.google.com with SMTP id z3so1824873qtb.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hc5q36gUSYxDngylBJ7eysmU7ygS+hXagQQ/ZJe8Efk=;
 b=rqgArRHfBX7ox2+g4/xFjbPVqTtE0/mkviTrI6qgTgWDnVBPKPGWjBBfhAlXFiu3V8
 7FmzTucszjMjVjYTCKk/D9LlBF8KECdh804p08v2Z7zH3L+vncM1x+IUnq5iLKlRyYNS
 t6t7oy5CsPWVv79AI9GQd6wln/F+y+a1b6SS/YGxiX99QznJhYsY6DShuY46ID4se/Mb
 lcnFBFtzBr5TTwoNVItvfjsWnb3vHnwk/2dVNK7RwIPuriPKmvC79UKxMBE+WN2ey+sp
 gQLWI96y8q9mKZxWA3+G4uMY4oTRLfRv04FjQ73YUPxcF5ABoJIG7jlzeX+BRX+seIUi
 HLZQ==
X-Gm-Message-State: AGi0PuYI5H31jBSvbmb/aJHn7h7IWCbaD5yNZakzC0tkIR9x1DXrKG4j
 TRTFAYbn0clg2wIamPd0ECHVNXhD3C7aTshtNI9Pj6FSbdh7Zk5RE8IGKW/qaqpeVBDAnMfROKO
 GAVBa45QIO67hdmY=
X-Received: by 2002:aed:3445:: with SMTP id w63mr21724892qtd.183.1587486087444; 
 Tue, 21 Apr 2020 09:21:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxIGg6zFdz3rLUrny1hQomxwk+/LiFR4emedwHUM5IUYKXKRVTDERRA5i9cgwnIjDks1GIng==
X-Received: by 2002:aed:3445:: with SMTP id w63mr21724869qtd.183.1587486087133; 
 Tue, 21 Apr 2020 09:21:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id r128sm2002105qke.95.2020.04.21.09.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] cpus: Remove the mutex parameter from do_run_on_cpu()
Date: Tue, 21 Apr 2020 12:21:05 -0400
Message-Id: <20200421162108.594796-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must use the BQL for do_run_on_cpu() without much choice, it means the
parameter is helpless.  Remove it.  Meanwhile use the newly introduced
qemu_cond_wait_iothread() in do_run_on_cpu().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus-common.c         | 5 ++---
 cpus.c                | 2 +-
 include/hw/core/cpu.h | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index eaf590cb38..4fc11b4e1c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -121,8 +121,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qem=
u_work_item *wi)
     qemu_cpu_kick(cpu);
 }
=20
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data da=
ta,
-                   QemuMutex *mutex)
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data da=
ta)
 {
     struct qemu_work_item wi;
=20
@@ -141,7 +140,7 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func,=
 run_on_cpu_data data,
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu =3D current_cpu;
=20
-        qemu_cond_wait(&qemu_work_cond, mutex);
+        qemu_cond_wait_iothread(&qemu_work_cond);
         current_cpu =3D self_cpu;
     }
 }
diff --git a/cpus.c b/cpus.c
index 263eddc8b0..5cbc3f30de 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1140,7 +1140,7 @@ void qemu_init_cpu_loop(void)
=20
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
-    do_run_on_cpu(cpu, func, data, &qemu_global_mutex);
+    do_run_on_cpu(cpu, func, data);
 }
=20
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..b26fdb5ab8 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -734,12 +734,10 @@ bool cpu_is_stopped(CPUState *cpu);
  * @cpu: The vCPU to run on.
  * @func: The function to be executed.
  * @data: Data to pass to the function.
- * @mutex: Mutex to release while waiting for @func to run.
  *
  * Used internally in the implementation of run_on_cpu.
  */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data da=
ta,
-                   QemuMutex *mutex);
+void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data da=
ta);
=20
 /**
  * run_on_cpu:
--=20
2.24.1


