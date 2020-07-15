Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03E020656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAUfr93b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03E020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvllm-0006E6-NO
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgR-0001N8-RP
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgQ-0005k8-CU
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPS3oUy1D9QDtKtmSP52MHC/LqwrHbfAwMxKgJave6A=;
 b=ZAUfr93b5w8sSxA9d0Z/SjK9pwrFItmmfOxTG4dVJpRpnmleHKBUtwaSAFp+ygC7apPG0x
 +MpCzOhtNljhZxM07Ao1904EmDxZvX7LiQldt9zLlX103WyKFYJbpYPpr38HDgLvUZJ8iW
 Xbmz6Sqi/WOd9oquJb3ACQYHFRTPehA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-XGxYr9H7NWuopfwyc2giZg-1; Wed, 15 Jul 2020 13:59:03 -0400
X-MC-Unique: XGxYr9H7NWuopfwyc2giZg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1834021wru.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HPS3oUy1D9QDtKtmSP52MHC/LqwrHbfAwMxKgJave6A=;
 b=DZtyQK/91KULePkOPkz3mWm3jdaoL0c/Zo7sagbQSy7LFL6/lZY28GMdfOe1PxRdUp
 8eHeCb/s7AtaYymRFKQu+/NkR5AvufbsFr0gxw7P5PRSiKfoORcGVSTrulTH6G6W15K7
 Yk4fX+LzU1b+fSJgDKa0RYWlAs2nH1+sX4C89ofkiKZ/XmVO5dXA5gKOF4NrQWN+eya+
 3zh5HmLf6uofDaNfMLcRuaCfSi1Uv5ZP3KVfQYnQGC/+AE2+Te72T0RpPAzXDg8yJw9v
 /8MZvzyzGMXrFZjyvugSG0lE7ndpAy7r1teS4la0CVfFNaIB67sxA2oG/AYtVc49s3K0
 BRsw==
X-Gm-Message-State: AOAM532uw73lzPYg8f0MC1sm5x5O+pTDNjCp0sXgwt6WSIr2dU40fyLa
 Ztkf9vipTKXx0nROapAHGkUayZVy423rHXKuvCdEvLp9YSROhBBIlEdzF4r9NVhMJ2ioFuyqcCd
 8lw6fMSlDB6AgOzA=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr592381wmc.45.1594835942475; 
 Wed, 15 Jul 2020 10:59:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMIiuL/TSrDenXgYQ4mLaRhXe2iuRsfnMEVJGb+AvXz65YbXUy9049mBiOT7bwIslWpWvl/Q==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr592366wmc.45.1594835942330; 
 Wed, 15 Jul 2020 10:59:02 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c20sm5774298wrb.65.2020.07.15.10.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 5/5] hw/virtio: Simplify
 virtio_mem_set_requested_size()
Date: Wed, 15 Jul 2020 19:58:35 +0200
Message-Id: <20200715175835.27744-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify by directly using visit_type_size() return value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/virtio/virtio-mem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ddf09ed1bf..e407abc2d8 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -687,12 +687,9 @@ static void virtio_mem_set_requested_size(Object *obj, Visitor *v,
                                           Error **errp)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
-    Error *err = NULL;
     uint64_t value;
 
-    visit_type_size(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
 
-- 
2.21.3


