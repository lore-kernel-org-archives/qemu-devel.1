Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD42C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090CF20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTHZQlyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090CF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdWe-0000EB-7P
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRp-0007Ff-E5
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRo-0000TB-Ec
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XYb0vyiefli8SR2efrdEhLZZ34eLVw3ObV8/l5+n3E=;
 b=MTHZQlycqfOVXOiVusodBa9rz4GORcUC6wo75XIa9E18/nZpKPfiNF18ozh+c2134T0Iqm
 Y8TGMIBc6bD7K+VP3PvOUa7kXjOBWv3sHogAE4hksE2kDzk5zWhzgozTPoSLgeBxfSBVWV
 jbCNRVucWxo+inJpK+3e8ivQjuZaV30=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-z2BQPtiUNwyaZva6JJ6K1Q-1; Sat, 23 May 2020 19:20:52 -0400
X-MC-Unique: z2BQPtiUNwyaZva6JJ6K1Q-1
Received: by mail-qv1-f71.google.com with SMTP id l1so12106745qvy.20
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XYb0vyiefli8SR2efrdEhLZZ34eLVw3ObV8/l5+n3E=;
 b=gd06fwb2k40lxhvzQCpPsKAC8CxCbad8hH9gBE+Isnvm7EgkLb8lYhkZA4L+lg32bD
 STAdyHtZ3m9XgB+QPS0gnRW76Zh75UdaR2KH0TodtsetsS890Q8sSFv3j5OCU3jNaNfr
 lyQh8aw/PHs8JKEdO5t+lt8HnYwRGpUQJRk8//ojwnkbSyUL6r2IXv9WoCu8tP3yCOKE
 2ng5Gn+GoGydhaCHvPPKz92Rz7MM+TbgJoM1xQAqb0hGYWIPV6D0/j2VQXFP6Zj8wqs1
 LGNOTOo0L81qzNhHtNvlT3uDn90clPlev7rW1gzlSqJC7dt29Mey9hhBVzst9W8Rp9P7
 WVvQ==
X-Gm-Message-State: AOAM532nEk0LB87ZwytdEDsu83tm7iaUgf0ChCytbver77vdNkTKvPxX
 ny6bEdPgRsOLAE1i6HSqw2kzO2AhQWStSyFFEbnx19MUeT0iO1w1XpKlZazXZXyuzZxcm3NR6lq
 jxt9SAxxtXz9mN8s=
X-Received: by 2002:aed:3ff7:: with SMTP id w52mr22694621qth.148.1590276051454; 
 Sat, 23 May 2020 16:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys09leCwe3eIXUQUyovUNIiTNGvQavMemqWX3XVBWfuk8bWdUOq1vj5OdY+gbfR81d3yaDVQ==
X-Received: by 2002:aed:3ff7:: with SMTP id w52mr22694608qth.148.1590276051243; 
 Sat, 23 May 2020 16:20:51 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 08/11] KVM: Simplify dirty log sync in kvm_set_phys_mem
Date: Sat, 23 May 2020 19:20:32 -0400
Message-Id: <20200523232035.1029349-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:20:44
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

kvm_physical_sync_dirty_bitmap() on the whole section is inaccurate, because
the section can be a superset of the memslot that we're working on.  The result
is that if the section covers multiple kvm memslots, we could be doing the
synchronization for multiple times for each kvmslot in the section.

With the two helpers that we just introduced, it's very easy to do it right now
by calling the helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 016bad1089..f7c8e6bebe 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1099,7 +1099,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                 goto out;
             }
             if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-                kvm_physical_sync_dirty_bitmap(kml, section);
+                kvm_slot_get_dirty_log(kvm_state, mem);
+                kvm_slot_sync_dirty_pages(mem);
             }
 
             /* unregister the slot */
-- 
2.26.2


