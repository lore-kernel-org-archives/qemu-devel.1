Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA948C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938522074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3DBtdZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938522074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Mj-0007iO-OC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k19Ip-0001E0-QX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:12:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k19In-0004I2-25
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzBIF3mB2xmF46OsHhJUcCq/p+2yfCrRkyersC8FDx0=;
 b=E3DBtdZbP6zVaTEGZOXKH+LM5db26DGsuhVmNVjfkx0fDSAmNnyjIgH9VN2FcARqTXOYWt
 gZb1OTvOe4zJuOwXfK3ySqu0SSwX/hcGJjKvg2fzOhZqsuZiF92MRUcCnTaSN3A1Jkxfpp
 tRmNy7/WWFdeT5BG9srkkYu/MhS5SHE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-OyxJi6M7O0iKs1JtEjrpPA-1; Thu, 30 Jul 2020 10:12:55 -0400
X-MC-Unique: OyxJi6M7O0iKs1JtEjrpPA-1
Received: by mail-wr1-f69.google.com with SMTP id b13so5239192wrq.19
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 07:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wzBIF3mB2xmF46OsHhJUcCq/p+2yfCrRkyersC8FDx0=;
 b=A+U1pmyXEyI6gN0krRyadaGm/OjKlThcZZqDbpKzsUG65XdO8+cRPIvqnVR6n5yFFH
 ALilKSzGKbffqpDLc4Fijmx2TyXOpLJeNQy8a36Q7XZSPf1PLaO1AKRUpO1bZSTcgf3s
 2URW+8IfB11Y9P7KMnA8UfWt+XpqkK5C6Pjma/OrnZVB6iuOqNBTnFfR4LpRaZHYNamQ
 E/dWcgLMB2TXEwmxeeK7TM0Fpuaie0ogPo11DNpVIXzdJFy6uhHYEuWEMG3nMzLg9X46
 o8CtTUElrqdVeTufto3m+TDUVG0c8Xq50mMXE3zphfK8jHT4sLRm8tX6ae6EKDHQikgX
 RgiQ==
X-Gm-Message-State: AOAM533aJbDsPcDA3lJvtcw8ilsTjiHYQD3227Rb8Wo6ysNGIxWIMvvT
 O3wp+eS/BXwly0XlaHH+CMT88KtRibFk1vKRnnvma4dwd5TiTfJmt7msrvIhnoyUiZGJgz9TQ2x
 WBP5UQGqneYc/nOw=
X-Received: by 2002:a05:6000:12c1:: with SMTP id
 l1mr2874734wrx.270.1596118373525; 
 Thu, 30 Jul 2020 07:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT6wwK4v6vGZ6RN86OQz0/t9EYwC/x3YdgMMj4ZYne65BxsiQuJlNPry4tJPmuVKaL5qu6/w==
X-Received: by 2002:a05:6000:12c1:: with SMTP id
 l1mr2874704wrx.270.1596118373300; 
 Thu, 30 Jul 2020 07:12:53 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id o10sm9536174wrw.79.2020.07.30.07.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 07:12:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? v2 1/2] qemu/osdep: Make QEMU_VMALLOC_ALIGN unsigned
 long
Date: Thu, 30 Jul 2020 16:12:44 +0200
Message-Id: <20200730141245.21739-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730141245.21739-1-philmd@redhat.com>
References: <20200730141245.21739-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Kaige Li <likaige@loongson.cn>,
 kvm@vger.kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU_VMALLOC_ALIGN is sometimes expanded to signed type,
other times to unsigned. Unify using unsigned.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/osdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20872e793e..085df8d508 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -454,10 +454,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
       Valgrind does not support alignments larger than 1 MiB,
       therefore we need special code which handles running on Valgrind. */
-#  define QEMU_VMALLOC_ALIGN (512 * 4096)
+#  define QEMU_VMALLOC_ALIGN (512 * 4096UL)
 #elif defined(__linux__) && defined(__s390x__)
    /* Use 1 MiB (segment size) alignment so gmap can be used by KVM. */
-#  define QEMU_VMALLOC_ALIGN (256 * 4096)
+#  define QEMU_VMALLOC_ALIGN (256 * 4096UL)
 #elif defined(__linux__) && defined(__sparc__)
 #include <sys/shm.h>
 #  define QEMU_VMALLOC_ALIGN MAX(qemu_real_host_page_size, SHMLBA)
-- 
2.21.3


