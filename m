Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB13C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAD020714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc+7hZfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa4b-0001yT-0R
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEa3e-0000fk-RJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEa3d-0007Zb-NR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEa3d-0007UX-J2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQy/e/scga9zarPzuOAeT8d2PRLcnf5E3HLsv0u1yWU=;
 b=dc+7hZfFRaGac7wy3OogKhGxpmeH3J8PMpdIE22qmxkWcT3srxQ6KcSF2bMpZvwgcGg6sg
 r7oUl9cPOSunL1aWY+OiQQxLRbks71T8eh4r4xbokPIZOAviEv4HveXt/Q+3+C0ILTE6/m
 Npt0rpO3ClgYXVhWh7/DRMlA0Ga/1OM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-d2v0WfQ6MpCaiEpIWjLgpA-1; Wed, 18 Mar 2020 10:52:29 -0400
X-MC-Unique: d2v0WfQ6MpCaiEpIWjLgpA-1
Received: by mail-wr1-f72.google.com with SMTP id i18so1380992wrx.17
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lUfyl9yDAO9btjUhY+kMjw1YOH9kmybJnOGo9W8GzWE=;
 b=OMgPfxK0T8GM0fELatz6sjSO5OL8GTgmdtrl0ApSYiZyW/JVC2glKoAV7ZLndRyUfv
 8ZTrK3gxzPPQRKjvdCOuBzfH+eK6BpKQ4IdGykLXGKal+IYh7SOWgRT07GaHWTKq4IS/
 TXpSbKmWdtiwLbh8p428CH8V0hLLWjtcbtiBp6cd0KZWzFqCY+tk2d9Bru4ctXdfDn9a
 EoxFYvCFriqMyR5RUiRnGBFXwI1sO3FefY4kPVb4WJtZgU4mYpzLJWeOiUTbZEMocVvs
 yS/steZYrJulxIZMLLGdw2KJpUd/w2cIhKZkORWMY8SOanD6zpljOMI0zs0aWX2zIJO4
 iCIA==
X-Gm-Message-State: ANhLgQ3E8Fz9ubupKjT4pLsaJ1TDCXyyEldI9XiGhXA0e5ii45VIN5Rl
 XmZEi17AKjLY3nhqEDAyBFScRq/1jv1Q4JxuqYo+cf7aeaf2oa/66vLjU/eoNpTt930xIdyQT9a
 UeISm8kQw16mEWdk=
X-Received: by 2002:adf:e891:: with SMTP id d17mr5988939wrm.348.1584543147798; 
 Wed, 18 Mar 2020 07:52:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2kNtRhQRcxxU3PGE7r91iXroMFrSugvywgZW/dGr6il3sc4NcLXadM2nlCSSBaMPKKLN7dQ==
X-Received: by 2002:adf:e891:: with SMTP id d17mr5988923wrm.348.1584543147602; 
 Wed, 18 Mar 2020 07:52:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b80sm2246178wme.24.2020.03.18.07.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 07:52:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/5] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
Date: Wed, 18 Mar 2020 10:52:02 -0400
Message-Id: <20200318145204.74483-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
References: <20200318145204.74483-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So that kvm_irqchip_assign_irqfd() can have access to the
EventNotifiers, especially the resample event.  It is needed in follow
up patch to cache and kick resamplefds from QEMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
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


