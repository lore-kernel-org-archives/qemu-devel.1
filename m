Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44A82078C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrXcNAF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44A82078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj71H-0001rU-0z
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wE-0003d0-Gy
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wD-0000Q9-Kz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5d2BJjR7XQMBkEPqaKVThDr/OlFUq8OgKxiYSdRo8o=;
 b=LrXcNAF4NqKURfxb1uEkW6avPru3kwQkDj9ozvOXpU+QRV9KGFTjM42ZiNOgKEwFBQJ2fQ
 KOOpGsOZofimzc8CHnADeVluwXFBjBaavNTGuAOwvHLY+Z8/0iTNVWKwVG8Zz7FN515YFj
 o2BAlnArlR0wCWLJLVCUZENH1fyHclc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-7i2wYelmOYiLa3YKuBETpQ-1; Wed, 10 Jun 2020 16:03:02 -0400
X-MC-Unique: 7i2wYelmOYiLa3YKuBETpQ-1
Received: by mail-wm1-f70.google.com with SMTP id j128so733974wmj.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A5d2BJjR7XQMBkEPqaKVThDr/OlFUq8OgKxiYSdRo8o=;
 b=tGjXa5+FZAvqQvn14SeMrem/NKvooA4nwdIpCvOX4QKUWiTWr+vreEc1/LtnQNGTXz
 ErAc8qNgeyWK1QTd1Je8GvfoCuEwAUvvk2QRRx956vkAsaLRlbnMVX/eXZlthsKfcIPa
 W1ExJhw/doYxdCNw2zrrD+Wfzz1/6kpaX7vbe62Hh6Ukuy8En87W7f+uXyMpqCwhhaB0
 gcGr8l0Gw5R0G1WURH5FmhNOoO8d5ErE+R2bbCenloNjuD6iGI7jixhjQ1bDB60Ka0lK
 EHADC7nqU0/Q50QLIDzFErpVDZKWmN11c3AvL85NvwJcufI3MtCX5zCpVfbGxMhPGv4b
 QHXg==
X-Gm-Message-State: AOAM532k1kn1a6/Wg0X4Hu+JOr7D++ljQ6M9nLlb7V227ry0/llYbwUN
 h5Fy5lhyE5Gx9ixVaPw0J94hOno3gDE1cjbXML21iStY/BfzEIWi0zVH25RwRpsKBKcWGbsKxN1
 LlQXP8icn9zN3iWU=
X-Received: by 2002:adf:8b47:: with SMTP id v7mr5254552wra.238.1591819380913; 
 Wed, 10 Jun 2020 13:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcKxB2Gf7GrNx5VqvH6Ia4z2jrdVV4BApGKoNs5qrsCcsB1ftAsV91SH3Cg8/yq6KlxqDz0g==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr5254536wra.238.1591819380610; 
 Wed, 10 Jun 2020 13:03:00 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g187sm944660wma.17.2020.06.10.13.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] hw/tpm: Include missing 'qemu/option.h' header
Date: Wed, 10 Jun 2020 22:02:41 +0200
Message-Id: <20200610200247.21378-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Files using the TPM_STANDARD_CMDLINE_OPTS macro declared in
"tpm_int.h" will use QEMU_OPT_STRING definition declared in
"qemu/option.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_int.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 3fb28a9d6c..fd5ebc6489 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -12,6 +12,8 @@
 #ifndef TPM_TPM_INT_H
 #define TPM_TPM_INT_H
 
+#include "qemu/option.h"
+
 #define TPM_STANDARD_CMDLINE_OPTS \
     { \
         .name = "type", \
-- 
2.21.3


