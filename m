Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BBC4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6711C20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA5NGAs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6711C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75b0-0008GH-Ix
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j75a5-0007AX-5d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j75a3-0002Er-Sn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j75a3-0002EU-Ou
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582757702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQ+3B2PsBNwy91uRvIR6aBTCd/S80BOOKAQ9EBJ4pwU=;
 b=FA5NGAs6moiXN431OuU7VI4zjRCNTeJ9WG2M8o6yh6mJVrCmQazp1u8BBtfh68E5943J7x
 5oabUnp/Qn29mpFA2Te3jT3g8rHUTcmxaYeJ+DpfGd5nIeVEhjnK/ZiFLafQOn4inbB9Bi
 Zt5VRSxdevqGM5F32fk8fR04l6jeKa0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Cvn24Kk7N1K38MSJrsABbQ-1; Wed, 26 Feb 2020 17:55:01 -0500
X-MC-Unique: Cvn24Kk7N1K38MSJrsABbQ-1
Received: by mail-qk1-f200.google.com with SMTP id e11so1288176qkl.8
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6iF/hzx5xbCPUIf+puVE70hJQRDvIvHhsPT7aYBtNUQ=;
 b=SG8A1SnHBryJ3Y/loUBnqKeZESC+FOvZeKUWEMnbMW4bbmWKR7oi7XaQy+4B01r826
 Eyz2BVbkAHxnLkFQ/Q4ZrNZ9m9I9t4IehCwZmODrPvJxb70vd0Mp74mBapWhTL3O8WHq
 C9UT+/DFtfkpTyaMFRcZHNyoAhAHaZiYLGRmfZUWwcpfAVaB3eKiQnZICSSOBgfU/7XC
 MLZZcHQyry4zd5Tz5tKbXhZfUPhUO7F8rX0/qgNokRbSVwKne63kvP3SYxm4j3FPFIBh
 muWIVrHE/7LLvcAE/FqdA5ncg/yZ2HJqUGbxiTl9GnHpsQBi7GFWhGS6pHYyt+M4wyBj
 Hjvg==
X-Gm-Message-State: APjAAAW0mfevNk1WvxtMqJZCFepEI2cuJQ0fJdPDSXuJKTOI8FxVZBYM
 c05SEIx5T4fCyHfKOm1bUI0V6EwGG1FMsoJplbItB4ZUmcMBebQREgMwHitLOWW4+Ww/UNWErDb
 BX3Onmb9VsHhmxZ0=
X-Received: by 2002:a37:6841:: with SMTP id d62mr1705297qkc.365.1582757700027; 
 Wed, 26 Feb 2020 14:55:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4xcaICWehbAkrsogjl5WAcyo1Iz+HUNOtbzBC/XHoZnKF76Ffq1b9zP/GBq6YIRY1j5YXqQ==
X-Received: by 2002:a37:6841:: with SMTP id d62mr1705270qkc.365.1582757699779; 
 Wed, 26 Feb 2020 14:54:59 -0800 (PST)
Received: from xz-x1.redhat.com
 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id n188sm1881855qkc.106.2020.02.26.14.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 14:54:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
Date: Wed, 26 Feb 2020 17:54:57 -0500
Message-Id: <20200226225457.217014-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So that kvm_irqchip_assign_irqfd() can have access to the
EventNotifiers, especially the resample event.  It is needed in follow
up patch to cache and kick resamplefds from QEMU.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 439a4efe52..d49b74512a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1628,9 +1628,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int vi=
rq, MSIMessage msg,
     return kvm_update_routing_entry(s, &kroute);
 }
=20
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int rfd, int virq=
,
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
                                     bool assign)
 {
+    int fd =3D event_notifier_get_fd(event);
+    int rfd =3D resample ? event_notifier_get_fd(resample) : -1;
+
     struct kvm_irqfd irqfd =3D {
         .fd =3D fd,
         .gsi =3D virq,
@@ -1735,7 +1739,9 @@ int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32=
_t vcpu, uint32_t sint)
     return -ENOSYS;
 }
=20
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool as=
sign)
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
+                                    bool assign)
 {
     abort();
 }
@@ -1749,15 +1755,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int v=
irq, MSIMessage msg)
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n),
-           rn ? event_notifier_get_fd(rn) : -1, virq, true);
+    return kvm_irqchip_assign_irqfd(s, n, rn, virq, true);
 }
=20
 int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                           int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n), -1, virq,
-           false);
+    return kvm_irqchip_assign_irqfd(s, n, NULL, virq, false);
 }
=20
 int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
--=20
2.24.1


