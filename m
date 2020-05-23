Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C779C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6778320735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxbeeTMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6778320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdUB-0003hB-Iv
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRf-0006tQ-Gc
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRe-0000P5-M2
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWuKxqHpTHrg9vNDgSvtlSiGvO4lTbyQf2mpVceh26Y=;
 b=BxbeeTMQF1a2xSwrElNVNTbIz6Vz523MhouSpEStZwFDxBkn0uVADBx4hbrQeYN/NQnJYE
 YXELD/NDjcACu1/xYXrh+MbbpJ/+KyQnrQorbK/neXHk39ZAnzn6ivhlK7Y5qqeEc5uU9v
 sD3xhyJK+ZDzxRUsSguPTGowG0/KxWQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-GpL6XNN8Pn6QwpFKifHthQ-1; Sat, 23 May 2020 19:20:44 -0400
X-MC-Unique: GpL6XNN8Pn6QwpFKifHthQ-1
Received: by mail-qt1-f200.google.com with SMTP id 19so15963253qtp.8
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWuKxqHpTHrg9vNDgSvtlSiGvO4lTbyQf2mpVceh26Y=;
 b=YHj/a4gdfhEl1F2lDT4A/W4tir+bWI3DtFgpHjUmPUyb/rZPW6h4pjZvHgL1eavP2t
 LaACZIGNZj9VOnIHEITkBfaZ9eYpdgOOLdHoDfFGdLe+Hl/bbCK4N4QQ032P9tZfXn6V
 gtp+RdLEYU/eii3TB9tgFjPcoYJqKcS+iYtrxJSy0ihTAlBsyRfpXTl2fM7nGvCVLRjB
 v/jHHH8mZd8Ji1nNQmD63O1Lz3mTXz153dmDWPX9FGqV0MCHXAOFjMm9QqXfwhpoOxBw
 Bn0nZwaGpkLDowMh5W3VJHGpFuIf8dBQCo5ibvk05HAZF3vr/gfAJIDXleyVv6x/64c+
 CEGQ==
X-Gm-Message-State: AOAM532wX9vB53R9n0ykn6FcI/2wH70zQ1HH04YBsHQuqjffYsz+Mt2y
 nTSWpZdcZUKn9ZxpRTQk4bjUV514EPhPE4sXhiorkVYA7Zo9neFJaIJqPoLBnzu4Wz9TPoA5aF1
 mrZv1lM8VVvVSPxs=
X-Received: by 2002:a37:a949:: with SMTP id s70mr614400qke.111.1590276043647; 
 Sat, 23 May 2020 16:20:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygS5o3xF5CKmnHw37C6T1jF25S7GLCcJ78nmO6rTD1dm3nysTeM7J1xR4LmOAvJLjRQOFGwg==
X-Received: by 2002:a37:a949:: with SMTP id s70mr614384qke.111.1590276043426; 
 Sat, 23 May 2020 16:20:43 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 03/11] KVM: Fixup kvm_log_clear_one_slot() ioctl return
 check
Date: Sat, 23 May 2020 19:20:27 -0400
Message-Id: <20200523232035.1029349-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 18:49:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm_vm_ioctl() handles the errno trick already for ioctl() on
returning -1 for errors.  Fix this.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..6e015aa2d4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -699,14 +699,13 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
     d.num_pages = bmap_npages;
     d.slot = mem->slot | (as_id << 16);
 
-    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
-        ret = -errno;
+    ret = kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d);
+    if (ret) {
         error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=%d, "
                      "start=0x%"PRIx64", size=0x%"PRIx32", errno=%d",
                      __func__, d.slot, (uint64_t)d.first_page,
                      (uint32_t)d.num_pages, ret);
     } else {
-        ret = 0;
         trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
     }
 
-- 
2.26.2


