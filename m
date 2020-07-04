Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52684C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1781820747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1YulLyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1781820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn6q-0006oG-By
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvz-0004Ln-1H
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvw-0001XX-FT
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+cCdkPsrD4TM/VrIcZdX3Ig4P6coUYr9PkA+fapcI0=;
 b=e1YulLyXiCpI2QJ9eiDHP3JpdkO+9llBtnwK4W0yHpC6fl75YShZj30NXWfQNVu9pMoKbT
 HJtD0QoWZ3Q96i9LyF1czXcli52mfZ2ywLkiQMfbusmELqmft9Ax2gbSHisbMwqXHYGGzs
 o6QbfVtfdeOsM/iap6LgX9mekhusREM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-AFZcn_qtODmrmunOpxQmPQ-1; Sat, 04 Jul 2020 14:30:38 -0400
X-MC-Unique: AFZcn_qtODmrmunOpxQmPQ-1
Received: by mail-wm1-f70.google.com with SMTP id q20so30339225wme.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b+cCdkPsrD4TM/VrIcZdX3Ig4P6coUYr9PkA+fapcI0=;
 b=RXXqrn9kuiNPohMw3uD/XlwZ6ybWLSUTe2I1v0OboHY+CHsxLj4P3M4sDpXkHL3Xg+
 pDFkjHfjyo725QmtzhJReeVUUXGQN934Fgrvcakxx5W8ffizJnITZaiZGE4oD+wz4Ckd
 sQjAypYM7EaY6GH09EFpecD4btFVd8EnKE7IfRhZHQRZ4GJjctOzgp98fSIkrbeV+oQl
 FQpICKe4duBygvlKMRpcoJzn2Ai4yg7cv8G2ISGuGwyDRsNeqJwwfb2oB3V/LBjDDzKt
 +YeEpRFz50/Fm583RUFcTZ0eVVWa3F8i+xEtg/80rIgVi6icqnLjEU/8u52Lw9zDyRrz
 jMNA==
X-Gm-Message-State: AOAM532tivUtbk5cobPG+KsSXXcOriQ3fEc27b6Qhpa4iVg4hBiNRngB
 IuvZxhdk6nvhfuGhypFY6XZ/ssFu3PYlez8NZQ7c34QWeLRQBBwEaWt3DEv61PXN6Qve29QONZ/
 bdB8mIc1u4JmoREg=
X-Received: by 2002:a5d:6412:: with SMTP id z18mr40873158wru.310.1593887436656; 
 Sat, 04 Jul 2020 11:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySJsC7pHE2exasR13nd1GGexOVm/Dg/X6BKJ49WB11jxf2N6CmEnfOyBDnB1jiIhqj3HGKbg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr40873143wru.310.1593887436533; 
 Sat, 04 Jul 2020 11:30:36 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 h13sm17293163wml.42.2020.07.04.11.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:36 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 27/41] MAINTAINERS: add VT-d entry
Message-ID: <20200704182750.1088103-28-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Add this entry as suggested by Jason and Michael.

CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200701124418.63060-1-peterx@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f02160436..49a0d837d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2624,6 +2624,15 @@ F: tests/uefi-test-tools/
 F: .gitlab-ci.d/edk2.yml
 F: .gitlab-ci.d/edk2/
 
+VT-d Emulation
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Peter Xu <peterx@redhat.com>
+R: Jason Wang <jasowang@redhat.com>
+S: Supported
+F: hw/i386/intel_iommu.c
+F: hw/i386/intel_iommu_internal.h
+F: include/hw/i386/intel_iommu.h
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
-- 
MST


