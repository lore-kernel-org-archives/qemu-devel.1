Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6AC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FF2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHLnU4wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIIE-0003za-FQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIF1-00082d-OV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIF0-0002Wl-Ms
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIF0-0002VV-Ij
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584474666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAbf6Xk4iOWYyl7F2sdd+EDJE3ppod0snPr2a8tOFFs=;
 b=eHLnU4wmFt7+rox9CcsZgdvhJGTFEAYwC1yEFnzDJzZt+HHAT0Nts06iFti1u+2zbxTQrI
 BUpk5LFMK0/ZBbdIFUeO0yPH+F55zVU9UcweESl1DrNaoJEpVzTYdWpFjXVn+QzO4XIasA
 7czx8MnVtqs1B53lW1Hzk7Vhxy1TrbE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-B9Rq6U7yNJ29w7LpVZkNuA-1; Tue, 17 Mar 2020 15:51:04 -0400
X-MC-Unique: B9Rq6U7yNJ29w7LpVZkNuA-1
Received: by mail-wm1-f70.google.com with SMTP id g26so182598wmk.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2pYteEERbnpshws/vnpLsSSgy0J+668YOCAjLaOgJUQ=;
 b=lrxbz891neLRYiMXxd7fUR/MTUukWZppyeO63QxtrxzmigN0XJ7I7CbIaLvL7LgmRn
 OKcyQKGzPLFG1eOUWf5q/mlgb+g6UDzlZTUwzm44Uo80PqbVm6pFdfovYtcyG7a/DJ0K
 pqxNGqnxfqxNAZmeFcq5jnbqt0u7KrUE1gqWLcEgIgKrvfUUSeLkstu3A2DfUGL9d6nW
 SDTsTQMwKR/BxSxzpQy66odYwhNge/j7CkrKDLa8RYt3Mv1R+v7cb7obVVzsqA4fjNdK
 bSy9PnfQaGQDHiFC5Zbcnoq+LAkX9XsWbBzUSVyQtPO9ekC6Mb9uLjE98ih9GhoSyfU6
 3KDw==
X-Gm-Message-State: ANhLgQ0QlG8TQi05iaT+aUYdEQ/lI39jaDTrK6ZCcWgYRZrezo2dsSi8
 tGZRUiQTJlia0+IMaVkoT5xCGeQ2BR4NfdJO7xlAYCX+3rqFwOIQFtVN+a4fDS+d3EarTciCqf0
 QoBbMGEc0TzwQa0c=
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr760178wrw.56.1584474662600;
 Tue, 17 Mar 2020 12:51:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs6D6pf0etYHZvKIYUdqlTyYAIWMqmaWcH9PgQ+F7rYEviILi0He4rObRA/dsPRunKTx+co3Q==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr760163wrw.56.1584474662406;
 Tue, 17 Mar 2020 12:51:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id s15sm6280600wrr.45.2020.03.17.12.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:51:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
Date: Tue, 17 Mar 2020 15:50:40 -0400
Message-Id: <20200317195042.282977-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317195042.282977-1-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So that kvm_irqchip_assign_irqfd() can have access to the
EventNotifiers, especially the resample event.  It is needed in follow
up patch to cache and kick resamplefds from QEMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


