Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45072206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZLnaO/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45072206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBT3-0001WR-97
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQF-0003xU-PB
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQE-0001rV-JZ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgZlGUY22rV8RWoGEVzXdsh/Q/2FAX4GHFlUmso+7+4=;
 b=DZLnaO/TZwJ4A7LvYWgkEANXUTysU8yZmgtlZv8wRLlEhU6egs0q/aJ0uKBR4u9ll4U7Xb
 WhTmD3QNwHffLKT5/OfOmMyGnDbk5dFKCvk7Us5aY/+172PKWaKHTFvp3AUW/tD2j8g7/g
 JS03ETLcExk1DRHCyN1UZcEut42cGqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-hK6HwuHFNlOshJNvHT0yYA-1; Fri, 22 May 2020 13:25:24 -0400
X-MC-Unique: hK6HwuHFNlOshJNvHT0yYA-1
Received: by mail-wr1-f72.google.com with SMTP id e1so2165856wrm.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jgZlGUY22rV8RWoGEVzXdsh/Q/2FAX4GHFlUmso+7+4=;
 b=l7ZTyEfYtEU4vRz/N9WMRgdVJNwJtlN7W618rm5rczsP3S7xmLDzuryX+bD0ly1Uo3
 P5eM73EDTSjUp55VnTt+64ZyzQKPSmWSZZk+WwijQ6gCq7kIJ+ZGpXECHzW2TzpHDuyW
 HcPazuCO2szzEUxVAkJkQS5vDUkDD+Mja1qvAIWNj8xnhreugXrIO3xhgCvbKW9N7LHg
 qqdkNu2naQZ2w40InxY/99C5MsIL7UPQi8eDTCS4j51UO/xGduvtwYxAMOL7PK2ajU6B
 /3EkSTno/A5h7mg32O5iGr7m9MU5Opt1mrcDZOWpBCBsNx36FDW3EzaX6/u54td9Kl9y
 Au/w==
X-Gm-Message-State: AOAM531Ic3eiYcZPjmhWZrXGQ3BUoke0UsrnzM1Z/T3+4Oj50LQoH0gi
 sWeGjlNw25tHSfsrzmGRq43Gm7e5jioW1u1XZe1nkSID2/PYgh+FioBrv5o5ec3wlwy9BqiHBlZ
 tJ4+eOz0dg8D3las=
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4563979wrp.81.1590168322922;
 Fri, 22 May 2020 10:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+6a07xH61ez0EqUOI1p9j5aofX1C1m/qY1s4oS5CeugnNzbl2ty/XQ88gT5/sRF2lb+/2Zg==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4563964wrp.81.1590168322779;
 Fri, 22 May 2020 10:25:22 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b12sm10559661wmj.0.2020.05.22.10.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/13] configure: Avoid building TCG when not needed
Date: Fri, 22 May 2020 19:24:59 +0200
Message-Id: <20200522172510.25784-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 2fc05c4465..35e7951b95 100755
--- a/configure
+++ b/configure
@@ -1663,6 +1663,10 @@ if [ "$ARCH" = "unknown" ]; then
   linux_user="no"
 fi
 
+if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
+  tcg="no"
+fi
+
 default_target_list=""
 
 mak_wilds=""
-- 
2.21.3


