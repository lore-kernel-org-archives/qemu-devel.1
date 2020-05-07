Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B78C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35A02173E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dilP+YDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWka9-0004mZ-T2
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVd-0004cw-1J
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVb-000238-OY
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTInzwfX63p1qih9M+Dgx3t+UyJi8t1Fm5i0KyZ44dI=;
 b=dilP+YDoYFV0p+PcNr3yDD9pVVV/giapUSXUxxCa20OjyyoUpbpTrx1sndwwKF8mcDzvpK
 hrLnhOlXfWMSq6NL5M6h/Ez1R3EFtB36hbY7gwIVBWTbq1/Pikz1nLhfDgZ7XuqChDnNwx
 Ltu/aSPETncIYlJzhAiEoTiwSwv5C80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Td0NmQ9GMdKRYqYPmoGBsQ-1; Thu, 07 May 2020 13:40:29 -0400
X-MC-Unique: Td0NmQ9GMdKRYqYPmoGBsQ-1
Received: by mail-wm1-f69.google.com with SMTP id o26so3019873wmh.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cufZfBHIUwQzCgzD4HBPhihgc0XcJ+ZYlhn0GKj8V9k=;
 b=ZT2tHtA5uhE52AdZADDY6WKcVUAdZYvKFZW95XUvDCiNLZBx9zZiHC0ggYhPNQvCsA
 G4m79pRAbHmajkSaecqPyiPTtkDmE3yPtlC+mKfp67oCHYRpmVJOzrAFgG1GevvW2m44
 bpRVHOyz1t6g5563+0HF0EKzTz2t15jTyYWathbIp4KHMm6kbmSejB55URS1uPAVw7Cp
 44tuHf5fo/4UG5+gPjj+KdOlrTUlbwpIxE8R5KlJHhtclPBcb55StYn4WLAsSBxWFvXb
 5XO9pvPT3A3O6fdVzniKrgSDbaURPF5jZCKSiPTS5WiGpkkS29e6he0mBx73+ByVHROa
 5tRg==
X-Gm-Message-State: AGi0PubA2nr5v2aJDweZJmaCTMUdSDze5ts/NHSdRpG88liBbGYISfud
 bDP8Oyd9Dq8gS3n3hybQ+ctJ+7yVCawCaisVz4wbRaTWkMaVTOckOmyMipm5CG+lHuiGtY6zeHY
 v1237+CTzywUQhj4=
X-Received: by 2002:a1c:5642:: with SMTP id k63mr11361487wmb.188.1588873228044; 
 Thu, 07 May 2020 10:40:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbDQPmlpA5L5mUbNL57avc7o0U8xeDyRm/PDLK7AdA2hywNGuD6taYQC/vj9FG7kxQww3kOw==
X-Received: by 2002:a1c:5642:: with SMTP id k63mr11361466wmb.188.1588873227814; 
 Thu, 07 May 2020 10:40:27 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm8941896wro.12.2020.05.07.10.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 04/10] exec/memory-internal: Check CONFIG_SOFTMMU instead of
 CONFIG_USER_ONLY
Date: Thu,  7 May 2020 19:39:52 +0200
Message-Id: <20200507173958.25894-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CONFIG_SOFTMMU definition is poisoned in "exec/poison.h".
As this header is internal, check for poisoned CONFIG_SOFTMMU
instead of CONFIG_USER_ONLY to make this include harder to use.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.=
h
index 9fcc2af25c..b2b7c1e78a 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -22,7 +22,7 @@
=20
 #include "cpu.h"
=20
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
--=20
2.21.3


