Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C60C20836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URsdPstX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C60C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHjD-0005Zt-S6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcK-0007gw-Oq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcI-0004R4-Fd
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6r2FskKwB1C7cd0JfHkwqOjL7yF8DU7eDQFn/2WuCI=;
 b=URsdPstXbIRMJlecVJRPGjvhpoIdOPMfzuetcJk9VSIBZIzKoQLmWtu9fVfkp40YJbC+jJ
 HkGITV9QS2krJkU9vgOb+0tLPssABBBpLUZVVxe6aeHx2hrpYxHpHVaEY+Jb5oVG+LEk7O
 f6wvLJ3ra0rviU26/Ws8RKvmRDqHv4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-PejkPt9pOOqRY1bWuln9jA-1; Fri, 03 Jul 2020 05:04:14 -0400
X-MC-Unique: PejkPt9pOOqRY1bWuln9jA-1
Received: by mail-wr1-f69.google.com with SMTP id 89so7685250wrr.15
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P6r2FskKwB1C7cd0JfHkwqOjL7yF8DU7eDQFn/2WuCI=;
 b=nUVDvCr+689DdWLBda+ACuoqjuUk5UQHwL6JK4dG56K/1uK5m5Y6upwDDjlDNpdxgN
 8mAylJGLYED5rAqiZh6pa1Q2wIdXG2dF9P+/Px4jOy2oxKFiWWeMS6d/p93RCM1pMLhz
 jjRaJny5K4XlGWgX4qm7JMtRFMJ091d8Jmwl3GfbQnIpQRn5mox15ta3KnqX+SjfRFn3
 jDm+oHN3E5nmc1ikj4p7cY8FxgV8pez+ojAVQzygpAzgo539meTqr+t+MGE7kX3tPrKB
 79PUuDPiWIB63/HdWrh+8ygBR64Ug/InObBZ08YPSkSGXVfzR+JFOHdwOjwEbqSBWEfK
 Mh1Q==
X-Gm-Message-State: AOAM5309LcsaRaVZI9V42csEkOeh5rqLhqAJYQqvNhzXJOCtXEZfaUYE
 YLukEhlHt7hIUtKvd0dG9BVQq9av6KFnvWQ4dAYv+HB2pPuR1ljoXtf8KIWTeJ2Dfk6+2DK10Tn
 c6PdGqrnyEMn7cyE=
X-Received: by 2002:a1c:e303:: with SMTP id a3mr34579936wmh.26.1593767053107; 
 Fri, 03 Jul 2020 02:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyULuYM79VfesmYoDfTAtNW1iVtfC6NfFHPE6PFOiNAZbnmQ3dtxKI/PHw0T5AdCb2v3GOGSA==
X-Received: by 2002:a1c:e303:: with SMTP id a3mr34579920wmh.26.1593767052894; 
 Fri, 03 Jul 2020 02:04:12 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c25sm1208719wml.18.2020.07.03.02.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:12 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] MAINTAINERS: Add myself as virtio-mem maintainer
Message-ID: <20200703090252.368694-16-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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


