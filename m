Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667C62147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="mCDQBdun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667C62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWcu-00012q-FY
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:33:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLWac-0007yv-Nr
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLWab-0005og-Oz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:46 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hLWaa-0005mQ-BR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so7039185pls.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=uihYHrYj3HakLhRkBBdSUDTDHGZaCyGKyU0mzSpESvQ=;
	b=mCDQBdunO0hUngRO5ZFWMRAjbF81vr8Bgn/0CTyWhREDYSg451LHElqXYoX9LqR/Tx
	72O+yUOHH1XIAMZztm3MzrIkJi2Ay3MT1xV1q4B8PlvR3Z9zPjE2ncs/EXovH1hidaju
	Nl8+DaTTshFZ36ftBLGA1JV27PhbYnz2/cRjaud+rFto0iaO0tfZOv901S3fDezVNwiu
	bigZsA2l277flNS3XhgkYGD4Z4kt0ZMIQkR28fw29of2jN1kHMmo0DDdkVw2eVorzx2d
	oPnhxjSRlse+3T7qGwn01OvFdhT87jOzbVVJ1nylQ2hGQB1+V/Vtsr2Th09I6T+EDeyd
	3JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=uihYHrYj3HakLhRkBBdSUDTDHGZaCyGKyU0mzSpESvQ=;
	b=k3mMecc2yJBfvF9od0TZEvpzrkMmVN+RsrY9nm/crbPe9D3mPVGWCHaiVgXQsSIaUq
	QhY+pqvB/LT4kJhyXvc7Fvj+Ib3ZU8jhUeKchUQTsEWrawU7F1qepF2Xq0yZFwhCV6Lo
	oZAIOxJ968r0Q+QXEM7B5jE8cSFccaB0OsrmMFjP7muzgzNRe4KadsJfQrQBMZ64qug6
	eJO60otdkWgKLWlNcWoFlEfIPNbYgAyWIm8fPz2fhMZIRW8F6gBzD3EOQ0BBrmr1DMgF
	uwTLk4zU1jl4QJsEGQJ5L2uMAiSDSvGQ5Li4GGoTMXiZ9mzuwPV+05n/8/kIAAa8iVY9
	6Eqg==
X-Gm-Message-State: APjAAAU0yUZ0AHbuIYuF1v2yXuZpj5WU18nlx8rApIWKwoVUjwAnnyo6
	pqWLNntmI3C7CtxuvFSj0/7YlTivqZk=
X-Google-Smtp-Source: APXvYqx6/LFfPEs0Dp5RlilHCosSrXJ38nNHAZ4al6ZrPwF3s57vL3GxCnkJ4dpv2ncX7/uTttysLA==
X-Received: by 2002:a17:902:26b:: with SMTP id
	98mr41541345plc.30.1556645442060; 
	Tue, 30 Apr 2019 10:30:42 -0700 (PDT)
Received: from MBP.local.hk ([175.159.180.1]) by smtp.gmail.com with ESMTPSA id
	y23sm52407101pfn.25.2019.04.30.10.30.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 30 Apr 2019 10:30:41 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 01:28:42 +0800
Message-Id: <20190430172842.27369-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.13.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH] target/ppc/kvm: Fix trace typo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Boxuan Li <liboxuan@connect.hku.hk>,
	"open list:PowerPC" <qemu-ppc@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430172842.b9_ywp4DevrgtVsXB9LeV62u4CQTZI3iqgywzEk8VYg@z>

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 target/ppc/kvm.c        | 2 +-
 target/ppc/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 02e22e2017..1a9caf8f40 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1721,7 +1721,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             trace_kvm_handle_dcr_write();
             ret = kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr.data);
         } else {
-            trace_kvm_handle_drc_read();
+            trace_kvm_handle_dcr_read();
             ret = kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr.data);
         }
         break;
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 7b3cfe11fd..3dc6740706 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -22,7 +22,7 @@ kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
 kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KVM"
 kvm_injected_interrupt(int irq) "injected interrupt %d"
 kvm_handle_dcr_write(void) "handle dcr write"
-kvm_handle_drc_read(void) "handle dcr read"
+kvm_handle_dcr_read(void) "handle dcr read"
 kvm_handle_halt(void) "handle halt"
 kvm_handle_papr_hcall(void) "handle PAPR hypercall"
 kvm_handle_epr(void) "handle epr"
-- 
2.13.2


