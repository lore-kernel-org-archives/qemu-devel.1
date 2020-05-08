Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BC220708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGroNXsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BC220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy3v-00078D-6j
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy2v-0005rZ-Nb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy2u-0006aV-UK
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuYs7UxkZXmIi+x04iSR/3r2g41gsXRftXIHWrzE+iQ=;
 b=NGroNXsKEX5qDXVmC1U4ONJEQ5jQZ5LD+MhZYZGIcHfai0MS1IJEPGPn/Pr6Bu3GkB0u9W
 1r6MJ5P7O54L4OJwKIRuHKsy+DG8Mum4Tvmpm3VtWhKHhth6a0H9qpVl3Dx12CxSVBync+
 f/n3VW6+ThrWHBhMivZz/u4H1Gv/kJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-vWIICob_M_-pMX5SosV8Bg-1; Fri, 08 May 2020 04:07:46 -0400
X-MC-Unique: vWIICob_M_-pMX5SosV8Bg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so523895wrn.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KmYk5oCCH0iOigKwyECVQLnLIP/7UbsMDa2NDl9JB4g=;
 b=V2UhL5KoouSkRHwGx6f6lXOVoJOekrjmAeK/0bErKrdohSDsrU0T5O1SboyECFYUcv
 xZwSAwWKVJGDYm+rFDyHdU/46qrrQdspDkBoQWdyOptT03NVOVXYQpmjYp/WjHYzNUaY
 wFGbYiEPNGFJfp5f7kbjkvAknfYlKR2W80DBHb6tH4DIFcjTplfdZFp5roHRUy/FRLuQ
 bukI+0CSxS49yupQjG7B8IexZyLcovZzheByBh8HSgkURRD+EHJGONQcQ456Mw0MqRsW
 NAyladV7HXCnREqDuAiFjPTWnLMw9qTkXQY95n7jGaeZEWZy7iWsUCwXqMdk7EKrQuOw
 Ylww==
X-Gm-Message-State: AGi0PuZmPLq6OzhRL+OjywThmihSYqRsA2Wo+6jYUvSC/yzupuIFAY09
 lli1bZmfSgo2qYKM4+nRKPE0c2p0sFGDUufwvWo2jQcL+M9Hq8PxZgE4PZLohFOx/jt73DaFCfl
 FvwzTzzpOhgjeua8=
X-Received: by 2002:adf:80ee:: with SMTP id 101mr1546309wrl.156.1588925265455; 
 Fri, 08 May 2020 01:07:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXOBfLV/4JiC9sd75VwtKJJwa7gBFo2sTQ0zCOhSHeGR5hqWbusQ4EiH/EH8+RYbtPLF5MyQ==
X-Received: by 2002:adf:80ee:: with SMTP id 101mr1546287wrl.156.1588925265280; 
 Fri, 08 May 2020 01:07:45 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x13sm12113449wmc.5.2020.05.08.01.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:07:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] exec: Check Xen is enabled before calling the Xen API
Date: Fri,  8 May 2020 10:07:37 +0200
Message-Id: <20200508080738.2646-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200508080738.2646-1-philmd@redhat.com>
References: <20200508080738.2646-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..dd8713179e 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -330,7 +330,9 @@ static inline void cpu_physical_memory_set_dirty_range(=
ram_addr_t start,
         }
     }
=20
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
=20
 #if !defined(_WIN32)
@@ -388,7 +390,9 @@ static inline void cpu_physical_memory_set_dirty_lebitm=
ap(unsigned long *bitmap,
             }
         }
=20
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIE=
NTS_NOCODE;
=20
--=20
2.21.3


