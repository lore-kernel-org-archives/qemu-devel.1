Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731AC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB342206E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO0sB51L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB342206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg3i-0004OX-SR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyP-0004V1-RV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyN-0003x2-0l
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aIqBnRsvFqZ230wZvv7A0ZAUlxhRiHC/gfnYkiWsME=;
 b=aO0sB51L/asleHlmR2bOP5nwE7S6lawaWkNZtLrDnjmBVGi1Ht8QfaOBaz35YZwTXTQ6fh
 17uL1OmZ4J9ycWW62ONTktvP5VLnMthDqfMT6H2GICdhn7j9tziSvnSiV8VC18YHBCVCR1
 CAA+XxfyBLIE+B/RXCpRSdro14FcGPQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-UKl5j3llMsWrmUNMEFTgpA-1; Tue, 08 Sep 2020 11:55:49 -0400
X-MC-Unique: UKl5j3llMsWrmUNMEFTgpA-1
Received: by mail-wr1-f71.google.com with SMTP id s8so7092898wrb.15
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3aIqBnRsvFqZ230wZvv7A0ZAUlxhRiHC/gfnYkiWsME=;
 b=JD1k5UXZs5j03Kh75BHGWS2xYUs5gRMXYiN4EH4rkt8YXEuuX3tJu4gQB1hOKWZlBj
 l85huqSksygWqi8ROOR8BTZQw4D1EOQoxSPE3nAT4VmYMku8/eWZOGFlp3w7WVv1Pcsh
 9c11oiTOlsS1IewuxVwFQc9hO8TSQcRmnRC0k6FRyKsivKTgIHM7fjkbOAMPGouBTpl2
 kXckhtP87DPVeR4bdg2y9q98cnfmp4cob8eE2NESIwyMwVIzG6UxRwludwfI1rqKkNqt
 vMq3micUBDefwz/xBuF9iNg24RzyDSMfpN0pbjxx1U8fFN9K9JJmjwwRog2XsDfvsKT/
 fAdA==
X-Gm-Message-State: AOAM530+91Js2qypbdts/ypoo9bHlM+MEflTC+9ecAsvGMeIkZmJOvyc
 BF5ZO7x2R83OGaDLMbWitfiPyG7R8hRN5/kbdhECIqZVYlEr/MkFJaiZFnxU9N1Ge/WPnzeY/Mj
 7p9F32tlF7LwIT9M=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr322934wro.86.1599580547717;
 Tue, 08 Sep 2020 08:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydvCW82xRfqRQuTdYF1MHP5+r8Gl/n2M1Hanlh29I5Vyk61N4IxwQtFwRjtnXQqr5GdlWs1A==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr322919wro.86.1599580547580;
 Tue, 08 Sep 2020 08:55:47 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id j14sm34928939wrr.66.2020.09.08.08.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:55:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] sysemu/xen: Add missing 'exec/cpu-common.h' header for
 ram_addr_t type
Date: Tue,  8 Sep 2020 17:55:27 +0200
Message-Id: <20200908155530.249806-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
References: <20200908155530.249806-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As this header use the ram_addr_t type, it has to include
"exec/cpu-common.h" to avoid odd errors such:

  include/sysemu/xen.h:35:44: error: unknown type name 'ram_addr_t'; did you mean 'in_addr_t'?
   35 | static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
      |                                            ^~~~~~~~~~
      |                                            in_addr_t

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/xen.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 2c2c429ea8b..0ca25697e4f 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -8,6 +8,8 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
+#include "exec/cpu-common.h"
+
 #ifdef NEED_CPU_H
 # ifdef CONFIG_XEN
 #  define CONFIG_XEN_IS_POSSIBLE
-- 
2.26.2


