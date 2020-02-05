Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39DFC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA8921741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoHelwjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA8921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLWN-0002rD-S3
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLV9-0001HQ-IE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLV8-0003kA-JP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:17:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLV8-0003iH-FF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwnOjzlxPiLrUtXS9/Js+Kwd14a7kfPZ/UhB56CISFs=;
 b=HoHelwjghXicfJkw8nVdth8YmzH0952GVIDH6q+rIjz+D4N4ChyHbs1Fib41w99w78/cE7
 SxCiHTGhgIPKfvUWmkJT3uUaEJTat3ebTjdx8fhorXmQkQlxyiiogi/yg7NgbQgfC873WH
 8PcqYleCDxWqeGwyXPt2aTQxCbE/Va0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-IZdwwqIkNUaD9xpu-mq9KA-1; Wed, 05 Feb 2020 09:17:56 -0500
Received: by mail-qt1-f199.google.com with SMTP id a13so1419635qtp.8
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vPwF7koEOtFK/v1GMHKbe9mr0XFSrZCmlysXssYQcTU=;
 b=uEieijiNqNzvwnhkV57EhPPceZYShI/WwYKNFb3FsmqsSz14ZGWFWkLUjEI43nI60k
 TlixF93JwUfSLU7MtRMv3KWWu6bl8Cvg1GviMpZslJAZi3G5Pj/hw/tsbmamOjguhDND
 pIVlhjsY696jOwRP2+12g21HIjnqQNMl9y2Y/nZHUmQVJq6mSwwzVxiBq5aYZycEoXtX
 EcrSNhhWUR10tJ5Ra6St1w4oF+lhGRHfneBXvIfm6zZTpbhTLYuEfeJtp8quPDnVwZEq
 H5qG5y3OqnlL8TeF/bEuVRcDtjibusEVvw5+kbfoX/A9kMb0FHbUVeVcZqCwEusVZ7jz
 3GMQ==
X-Gm-Message-State: APjAAAWzqjSYftJZrHU76C61/5lO3JDEfJu8PkfIHsTfEmexszhfKvT4
 pZPWEdh6jS6wF4wpuLP3ZrUb7VogCCMBoa4iHsR0OwPRMn0acvjhxzH4dW+KlezEFqVl882Erkc
 OwdCemSwosKgbOis=
X-Received: by 2002:a37:bfc5:: with SMTP id
 p188mr30637316qkf.283.1580912275968; 
 Wed, 05 Feb 2020 06:17:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyd9oiXw+azTzKyugkFI9dxzMAUXdBlv4TSa5kfh+LkumO2XqNNYevrYWNKCPVxWMhOJJKjHg==
X-Received: by 2002:a37:bfc5:: with SMTP id
 p188mr30637294qkf.283.1580912275744; 
 Wed, 05 Feb 2020 06:17:55 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:17:54 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 1/9] KVM: Fixup kvm_log_clear_one_slot() ioctl return check
Date: Wed,  5 Feb 2020 09:17:41 -0500
Message-Id: <20200205141749.378044-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: IZdwwqIkNUaD9xpu-mq9KA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

kvm_vm_ioctl() handles the errno trick already for ioctl() on
returning -1 for errors.  Fix this.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312dfd..4be3cd2352 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -688,14 +688,13 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int a=
s_id, uint64_t start,
     d.num_pages =3D bmap_npages;
     d.slot =3D mem->slot | (as_id << 16);
=20
-    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) =3D=3D -1) {
-        ret =3D -errno;
+    ret =3D kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d);
+    if (ret) {
         error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=3D%d, "
                      "start=3D0x%"PRIx64", size=3D0x%"PRIx32", errno=3D%d"=
,
                      __func__, d.slot, (uint64_t)d.first_page,
                      (uint32_t)d.num_pages, ret);
     } else {
-        ret =3D 0;
         trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
     }
=20
--=20
2.24.1


