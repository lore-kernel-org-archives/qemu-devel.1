Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6208E20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrwJznvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6208E20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn2f-0000kY-LW
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvU-0003Eb-FV
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvS-0001P3-MX
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6r2FskKwB1C7cd0JfHkwqOjL7yF8DU7eDQFn/2WuCI=;
 b=NrwJznvPfI/kXVe8t/K/IMUJNyfZhefArlXyRr3y/5WQT9dW4/3pb36Rf+GAZri+p/7JWx
 2Eqq38fUBFtChuDPbJf9JC5ptkKZU9z4JNqRqz+jDe+j1leGcQ8w/nJQnvkL+6Icd67IEX
 j7x1zz/zE57xu/WiRHZ5jB6RhksnF28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-jciBYOJOMCy7ITHZeCMhoQ-1; Sat, 04 Jul 2020 14:30:06 -0400
X-MC-Unique: jciBYOJOMCy7ITHZeCMhoQ-1
Received: by mail-wr1-f72.google.com with SMTP id j16so31064169wrw.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P6r2FskKwB1C7cd0JfHkwqOjL7yF8DU7eDQFn/2WuCI=;
 b=hlz+maUY66BxNp+WvWips5bEW1n5tJ2fS1EgqbbCjQp/RWnJF0dMso0qCmPGQLMeH2
 sh8dVHfqnm5Kk0csbHPqEat89BgOORuejtWDltreXaUFRw/yEmamy0/wINHi2199dqTa
 fCxbLQQKrHBH8oewIDRS8CltWMRvXhgQbiB3gjOHeF41DgqY0vidccRT2xSUiyGskadT
 yzGweb/1IyrCqMyLHBAr3F9OgONVmeNoZcFulteymz7j+xZhmbxbwh/+MAUPRwWFBVOP
 ZNSdLms+/XfeOcCH1NDdaYU+ybm47BOKR6x+iUzplHYfdFjwzTEAkeftv8012JVGnhpY
 QeOA==
X-Gm-Message-State: AOAM530v2syI0Qgm4LhxhVYKLn05I7GlDYPDnKhVjqL5dY8WzLp3c0W0
 SY7r2jXru66mR3tOll6W8nrhfnZjh+r2QStwdETxn1a9Ji0VmsnsblvyrLxsC5YHR+GmG6VXUBt
 OA+xoV3GmDu9Zw0I=
X-Received: by 2002:a1c:4444:: with SMTP id r65mr40310672wma.129.1593887405609; 
 Sat, 04 Jul 2020 11:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziOhc08D/FoT6hHyBL2TK+sGvS3ui80NYHBuOuFxQQikwOOleQieaiGuMLkTR2kG2t+zx4dg==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr40310659wma.129.1593887405418; 
 Sat, 04 Jul 2020 11:30:05 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b184sm17722440wmc.20.2020.07.04.11.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:04 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/41] MAINTAINERS: Add myself as virtio-mem maintainer
Message-ID: <20200704182750.1088103-16-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's make sure patches/bug reports find the right person.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-13-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..5f02160436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,6 +1790,15 @@ F: hw/virtio/virtio-crypto.c
 F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
+virtio-mem
+M: David Hildenbrand <david@redhat.com>
+S: Supported
+W: https://virtio-mem.gitlab.io/
+F: hw/virtio/virtio-mem.c
+F: hw/virtio/virtio-mem-pci.h
+F: hw/virtio/virtio-mem-pci.c
+F: include/hw/virtio/virtio-mem.h
+
 nvme
 M: Keith Busch <kbusch@kernel.org>
 L: qemu-block@nongnu.org
-- 
MST


