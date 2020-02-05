Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5BEC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7271F21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+zyoS+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7271F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLYB-0006IW-Fh
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVK-0001V0-IU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVJ-0004bh-F3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVJ-0004ZE-6p
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yE+CLXdD02TVbOQfaDBkHUdhwWAp/SC/thW2yzCYvNk=;
 b=d+zyoS+onTQ4TY84jNeAW6uYpwrq/yO24tiia9pyyq0k3KUQ+pefArfh1B8IcF4zI0RM1o
 I3ao8LgFos80EIGtpx7pj/Jx6nKaVnw7R2Wq1gGjqJ4Gg/+QUkJhZFHj6l4idFhp4kOiAO
 hmqlwrLYGtGA84DxKSW0O6T4n3Dkfuc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-8ivQtaRsMkG4ZUZn0yupCg-1; Wed, 05 Feb 2020 09:18:07 -0500
Received: by mail-qt1-f200.google.com with SMTP id l1so1388735qtp.21
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uArLOZV6r+y65XCWsRz0zJYx4XWcyehI0dFRirWsE7g=;
 b=HVtPuv4iK0BVKhS8776pOT21aw/s6vMTz56Z/psiydMeijyltRVz6y38JMIzBtMhOT
 ObweQkKuSCf+suYT+gJqRwIRB//N5UhG8rd4w+MWOgHCpky+BZK3JGOfexT8BhrWBgQP
 R43qFwMMTb2plL9yBRGY/jwf6hlrPtQe0dbzulLSQXVRgG+qTQtHIJXA/KzYjpIKMQFj
 7b6Jy2+o0r4WAsn+JdDeGa8Tfo2eaLbMaPGlLgk2jMEeikE9cjcVHkEGTGlc/zSqTEa5
 5YmUIt4A8DHIo8VDU+ztcT0ZbAo/ElpkaWfdHaWEOxVRtdPqRmKtwsQRS7NYMvLuvCCy
 ggPQ==
X-Gm-Message-State: APjAAAWM8tPD/nZxw7xEnywcuuGK9zr1UdM1phlpiYq4uQksUX2wnpzt
 64GA4fCnmyy8Ul9gql+/w2E2I/e9OXEZjBjJAW5elBqe60iR4viHGNWPOxr8ucUYLVgl6sT70lW
 B+27z6j4YqCewIbU=
X-Received: by 2002:ad4:4f8f:: with SMTP id
 em15mr31121385qvb.169.1580912286372; 
 Wed, 05 Feb 2020 06:18:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzaB6mRUfa48JlO2cVzQtIGgb1NCVBzRWV4Q7P6Y7qWcch1VE5US1O7KVcwmetKwddH3XeM8A==
X-Received: by 2002:ad4:4f8f:: with SMTP id
 em15mr31121368qvb.169.1580912286191; 
 Wed, 05 Feb 2020 06:18:06 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:18:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 7/9] KVM: Cache kvm slot dirty bitmap size
Date: Wed,  5 Feb 2020 09:17:47 -0500
Message-Id: <20200205141749.378044-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 8ivQtaRsMkG4ZUZn0yupCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cache it too because we'll reference it more frequently in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 1 +
 include/sysemu/kvm_int.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f81e7a644b..ea7b8f7ca5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -548,6 +548,7 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
     hwaddr bitmap_size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                                         /*HOST_LONG_BITS*/ 64) / 8;
     mem->dirty_bmap =3D g_malloc0(bitmap_size);
+    mem->dirty_bmap_size =3D bitmap_size;
 }
=20
 /* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1a19bfef80..71c9946ecf 100644
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
--=20
2.24.1


