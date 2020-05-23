Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3687C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCA520735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tq9cfdWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCA520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdUe-0004yz-TM
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRr-0007Jj-2F
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRp-0000Tp-Uk
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdBTNtboGBy9lg3+b3bykeoaluEQ3dTDeb6ikWfO2cs=;
 b=Tq9cfdWSX2f8bX5plZNInXH5xjthRzNTJIEpAWf8UZIsLs+tk6YAAN66amxByJ6ReZvElX
 3gKSX/HR3gb04knXDB6HQf+a/rm6KWc/iWJ7V12id649m+bQz3OF5SZtcdQR6wZs7R8M+9
 cUdWljHqaSGdpt1awzZh1/E+cr7VBNk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-brDNya00PIC1RE-g0x6E9g-1; Sat, 23 May 2020 19:20:53 -0400
X-MC-Unique: brDNya00PIC1RE-g0x6E9g-1
Received: by mail-qk1-f199.google.com with SMTP id n187so2391791qkd.10
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cdBTNtboGBy9lg3+b3bykeoaluEQ3dTDeb6ikWfO2cs=;
 b=XBkTBhUyjSU039iSZS46wTaQOwuC0gymeMKfAU4y5NI9vce4ePb0SLGRLVwJ+dDBOr
 pdmv9X1ZlJfrEqbrgBkrscnMUx7hbk8h7sHyhRHphysIYI2h0w1VZxl6DpPzQ2wAALdi
 LCMzR5OX8woe/BreY1Ji9+w0JvyaBhe3n0FFSyTzkb6XeHZJ22xT99uT1J4Sbabk3QkW
 t3PYLfb5RDrQUZFPLiz1D9KQwaNQlM72uGM0dcFRb+tLh93hMqzPgmwUKWr7lkUcgA9p
 hcWgMcflRAn+VhEzV1HjzitSXOtKoMXI2xFKWuaKctnpVsMGswBxnsNs3BIeeXun3zyU
 o9dQ==
X-Gm-Message-State: AOAM533ZICviqVxLf1n5TF0x4Wcni4InJGV/62Vf0dzQ0sLY5SvCkgYM
 I14HYg+S3t+gFXkJzbHmJobrAbYfOWWz3TCZYgx61k6Ln9Qn77qcy/3dECCo9bja3apX/yy3UdB
 mjVsesH2GXqK1AhU=
X-Received: by 2002:ac8:768c:: with SMTP id g12mr22221482qtr.51.1590276052794; 
 Sat, 23 May 2020 16:20:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx/bv8Q9ugZF4DKvnROLq/0qMBy+phWv7UBncJ9ATO7JN5oaUOA3iHvOKy4x0NXOQsTEjwRw==
X-Received: by 2002:ac8:768c:: with SMTP id g12mr22221464qtr.51.1590276052564; 
 Sat, 23 May 2020 16:20:52 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 09/11] KVM: Cache kvm slot dirty bitmap size
Date: Sat, 23 May 2020 19:20:33 -0400
Message-Id: <20200523232035.1029349-10-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cache it too because we'll reference it more frequently in the future.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 1 +
 include/sysemu/kvm_int.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f7c8e6bebe..b9aaa7912c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -561,6 +561,7 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
     hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                                         /*HOST_LONG_BITS*/ 64) / 8;
     mem->dirty_bmap = g_malloc0(bitmap_size);
+    mem->dirty_bmap_size = bitmap_size;
 }
 
 /* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 4a35d04478..b4d2886e26 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -23,6 +23,7 @@ typedef struct KVMSlot
     int old_flags;
     /* Dirty bitmap cache for the slot */
     unsigned long *dirty_bmap;
+    unsigned long dirty_bmap_size;
     /* Cache of the address space ID */
     int as_id;
     /* Cache of the offset in ram address space */
-- 
2.26.2


