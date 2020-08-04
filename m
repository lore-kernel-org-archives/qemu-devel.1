Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3DF22B40
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKMuEnQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3DF22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xmv-0003ka-1j
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xko-0001no-3x
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xkl-00058i-PU
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5XVaHyiT/w+3pFr6N+Pkk1Oj8m4LHUScdYK0rWmxkQ=;
 b=LKMuEnQWuZpOFaXqAbKPUpHTgYdi0cy0jnSRyh1uwdkaMKMRrhUmWsc3zSpcsuyhGXSlJI
 SBiDKf4UDM1M43N1MV4pq2qWZlGp6LZ+ez469p/Pq3GXrCrmLJIS8vs7QWTocchpw4uo8j
 mvgIZxwcmkjaVzCxfLFltSCYcaCeM7E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-dslwCg4TOmGadTAbN589_g-1; Tue, 04 Aug 2020 10:17:17 -0400
X-MC-Unique: dslwCg4TOmGadTAbN589_g-1
Received: by mail-qv1-f70.google.com with SMTP id x37so28575868qvf.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H5XVaHyiT/w+3pFr6N+Pkk1Oj8m4LHUScdYK0rWmxkQ=;
 b=dkhroqSay5PBpRW95UsoqD0R31Fa8sdhWn8REMeQbuajcJkPkc+RoEdrEeIYpXceSc
 VucnSeYnr2yUKhi7WAtbiQZhlcztb8nrpHU56KppG7PAWLdtyc+6/zEZAMwMAUvEo7gj
 VR1k/ncPQXRRK65ofACwAoHEXxXwsdbb5jhQayEsjiKnjTSWr2IZGRy0OS4lS88yCsP7
 tBnS1R509P4WtlMqL3jf6Wm7iuTzaGv/84OR0vaYfbg3ZKG4l5YvLhOKbf+y70C9IQ3v
 yG611q8OQWpHf08hBpbu2AM6otS6gZdVy2AOpO/OOSmTnZNrq1B0wWKCjVj7hp0pe1qE
 7wTw==
X-Gm-Message-State: AOAM533WCNQKW1Lnlhf1Y+RfFX5Vb/MMcfAaBI/PF3LeaS9j/Cg2m9lv
 J0VX4RjmO9zAV8Oas0uHpOo7A8wmqIYxWktbCGZvacqPyevQhbCuJYl4jjctordIT7PfkuqEPBm
 Vv2ADaPuTymUFiQo=
X-Received: by 2002:aed:24f2:: with SMTP id u47mr15030292qtc.137.1596550636464; 
 Tue, 04 Aug 2020 07:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMvmT3T8A/n/YaNuL4t79eihBlrkxCNLz1+rYmOKwv4AAhEbpVooNGysdnKIF8Bvupk55SzA==
X-Received: by 2002:aed:24f2:: with SMTP id u47mr15030268qtc.137.1596550636217; 
 Tue, 04 Aug 2020 07:17:16 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id u39sm12976492qtc.54.2020.08.04.07.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:17:15 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] virtio-mem: Correct format specifier mismatch for RISC-V
Message-ID: <20200804141640.591031-4-mst@redhat.com>
References: <20200804141640.591031-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804141640.591031-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 David Hildenbrand <david@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bruce Rogers <brogers@suse.com>

This likely affects other, less popular host architectures as well.
Less common host architectures under linux get QEMU_VMALLOC_ALIGN (from
which VIRTIO_MEM_MIN_BLOCK_SIZE is derived) define to a variable of
type uintptr, which isn't compatible with the format specifier used to
print a user message. Since this particular usage of the underlying data
seems unique to this file, the simple fix is to just cast
QEMU_VMALLOC_ALIGN to uint32_t, which corresponds to the format specifier
used.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20200730130519.168475-1-brogers@suse.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c12e9f79b0..7740fc613f 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -36,7 +36,7 @@
  * Use QEMU_VMALLOC_ALIGN, so no THP will have to be split when unplugging
  * memory (e.g., 2MB on x86_64).
  */
-#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
+#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
 /*
  * Size the usable region bigger than the requested size if possible. Esp.
  * Linux guests will only add (aligned) memory blocks in case they fully
-- 
MST


