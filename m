Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E824C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED3520735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrxhOifP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED3520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkYa-0001cE-64
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVQ-0004HS-LK
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVP-0001tV-Mr
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxO/QfhV7TdK4OIX7B7RR3nAolSQ5KL0SwXgbuIknFc=;
 b=IrxhOifPTe+j91upsc2c2OXBdBQEeurm9UBtG8tRknIOExAzd0sa11R987aydcVQ9UJ5eH
 U6aBVutYIqH/ZXSH/rCF0RpviK2nqiOTweuCNc9Qs/MTgn+PO6fzqXQjF2ZTQHZHtqxVy4
 ffrCBPPNFi4CDF/hw6uYNO3dDG02BM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-vDE5JFgDPJOIxdrQJLu2sQ-1; Thu, 07 May 2020 13:40:16 -0400
X-MC-Unique: vDE5JFgDPJOIxdrQJLu2sQ-1
Received: by mail-wm1-f69.google.com with SMTP id o74so1358353wme.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AYsaK9GNOXZIFUV300k/n6Vn/uB0ELw2OsZ7tcgl1LI=;
 b=KCxjFb4Mvf0PWMi114i882UVszO7MebtyJh9fJvW9FimXet4tFz5dK3EyHnnu/qDta
 FO5sH01SZ38vpfiD4sYCIFzKX0lk6bpLGCf1fYAgwVnUyWKHm1FBhk0UBcI9R4z2ATSx
 GiUi539r2O47hXArtRtaK7Oglw8fhD4bQfcVsb8RAVrw9Uc29UMcgYczNMIELKLxKrbd
 W8hgK9UarOYezHcDkLilgGUACl1iisiIDK7Oj8KVCNiP7TlXcZoihAnM+01gd/biQDtZ
 kOdJYbIKdRO0VyRfdpoNRYr5+6gzBcMGYaO4NPwPWvEO9rZnIFtqrxZbp6rjXKZ1upvd
 BnrA==
X-Gm-Message-State: AGi0PubnphL7TDaBpHAfh0u3a7KRc1B8oxz+RT4gcawiMPr21BnqvdIK
 ALHKb2PuVRAyBNB/Z6BLPfYl2u8enZsV3zbY/vjiwGeioWpD+XT8uS2lwFe6g7EhtVp6lCUZ+7c
 Rvnj7Cg4wVUwb5+E=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr3291881wmj.100.1588873215514; 
 Thu, 07 May 2020 10:40:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/AaUMzxN6c9AoFV7na/bw7wTqjkWo0VEqXrFVogrggBfyPF77EaBvs4PKan+/nsLzTJ6QVQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr3291851wmj.100.1588873215269; 
 Thu, 07 May 2020 10:40:15 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k23sm8431664wmi.46.2020.05.07.10.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 02/10] exec/ramblock: Add missing 'qemu/rcu.h' include
Date: Thu,  7 May 2020 19:39:50 +0200
Message-Id: <20200507173958.25894-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
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

The first field of RAMBlock is a rcu_head structure.
We need to include the "qemu/rcu.h" to avoid errors when
including "exec/ramblock.h" without "qemu/rcu.h":

  include/exec/ramblock.h:27:21: error: field =E2=80=98rcu=E2=80=99 has inc=
omplete type
     27 |     struct rcu_head rcu;
        |                     ^~~
  include/exec/ramblock.h:39:5: error: expected specifier-qualifier-list be=
fore =E2=80=98QLIST_ENTRY=E2=80=99
     39 |     QLIST_ENTRY(RAMBlock) next;
        |     ^~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ramblock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 07d50864d8..6ac0aa7a89 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -21,6 +21,7 @@
=20
 #ifndef CONFIG_USER_ONLY
 #include "cpu-common.h"
+#include "qemu/rcu.h"
=20
 struct RAMBlock {
     struct rcu_head rcu;
--=20
2.21.3


