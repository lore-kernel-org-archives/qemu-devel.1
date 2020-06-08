Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1692EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EA5206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoVQNWal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EA5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKse-00025d-2y
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnI-0002Kq-QM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnH-0005uN-NX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGdPCleeORN77Cg1Z7Vxtc5Yz2ZP9+voDYcAmfnN6vI=;
 b=NoVQNWalICUT0dEVlHcu/aG8ykleEkbboBYDp/YOIoXPkDGhrDarlN27S5PQv3a3QuVN7S
 J4uwf7ZW59ECBtn1tkXExO8ZERE1hw0nJwWuezTuPPMbCesLSE8hqotQpAeWANjDXqpWxw
 7FBiunMjDDoh9DTAcv6azGkQW8YHDp0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-hVFDZ9TaMoSvywasXlCkdw-1; Mon, 08 Jun 2020 12:38:37 -0400
X-MC-Unique: hVFDZ9TaMoSvywasXlCkdw-1
Received: by mail-wr1-f71.google.com with SMTP id c14so7368640wrm.15
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xGdPCleeORN77Cg1Z7Vxtc5Yz2ZP9+voDYcAmfnN6vI=;
 b=ZxvY5twnI2l1Od/Mm3WhHwqMWIBOqZnYFHAQyl5rF1zXrRduqwgBdekpb09v9oXgPA
 LD4XKWd0aQFDuYOGUUtCfkqTVlx4adR5kYXgCNIVKma0RjfYOVyolWn4Wv9fetFEQN5n
 5QpqcouyUdLXqXghUc+Re+L9YzFwi2uIyhp0jb9Kh6rGskEeoT16KvYn9ChevEJbPj00
 OR7ImHhnjRCjybdVxJVlCjxHLuzLjcv3SZqvTxoXqBHm9+evKNolrXBckJpe346odVe0
 2ctgx8BqyBbA+fGgNeNmcMc73Ip55owXi4cC+xpU87y51dYH+bJp2HLrWhrRTBhV0Vg6
 5CyQ==
X-Gm-Message-State: AOAM532uyHZFYtScB3JWCJcPjB46Wj9h6E0INZql3BnBp0Hz2G7ts6d+
 A9qh8dVvitt0GgWRrDZ/bH+iUqe9ZdkzPTjy+jdMI4Kv6yE7CH+GxsxnWnB0QnMfSPY8Xf2gEsu
 D49P7ODoR8t8GXzo=
X-Received: by 2002:a5d:6905:: with SMTP id t5mr23913558wru.113.1591634315675; 
 Mon, 08 Jun 2020 09:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8pDxtjD8gI2k2uX4mYhVlqhJ1RiWwtfyGXABN9YFQglNOVi+VlWMF7ZbOXuYZEYcrETV6vQ==
X-Received: by 2002:a5d:6905:: with SMTP id t5mr23913538wru.113.1591634315528; 
 Mon, 08 Jun 2020 09:38:35 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a16sm298018wrx.8.2020.06.08.09.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/10] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Mon,  8 Jun 2020 18:38:15 +0200
Message-Id: <20200608163823.8890-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53239b060b..93dd8eb8b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -416,6 +416,17 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/accel.c
+F: accel/Makefile.objs
+F: accel/stubs/Makefile.objs
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


