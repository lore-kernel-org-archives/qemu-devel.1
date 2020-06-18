Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5C22070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbG/clpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5C22070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltl1-0005jv-0e
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltk0-0004CW-2J
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22549
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltjy-0004kj-Hi
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6A9Myjz2xIFJ0p/+Ilwbl6ahUirOvgUENcTOtgqZWg=;
 b=JbG/clpJyRwbdmkdMWbSh7jPUm2gs3+9ZBSkFYpS4uaAKSNG3BEtjWMtUO3Cfykczrc/T9
 guEPN4TBw/UvGuP85qFT7kjLyQoO8YAjKavJc9zWaamOrL9B3kALSzyGln8PdsvTO8JtX4
 zcDOBWDnDyJKvR8NFOMXyQrGRxdX+SA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-W38ida5HMui3eQYFgs7GXg-1; Thu, 18 Jun 2020 08:33:56 -0400
X-MC-Unique: W38ida5HMui3eQYFgs7GXg-1
Received: by mail-wr1-f71.google.com with SMTP id d6so2742742wrn.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b6A9Myjz2xIFJ0p/+Ilwbl6ahUirOvgUENcTOtgqZWg=;
 b=mh/9tp4qj02jombVSA2d2cRqok1l2dhVmq++2jOsJNabq0omvObKMW8WXJXhgAI8Pa
 c8B/fbDYQuDpMt47eChn3aEXVmm/2mkK3x2fwlYFoAHN83F1N0GbX87GFpLXIhYKvT6M
 LqQ+KJUcJhZheiUq14DvcqdKmi31K6JVnkrg6SdLse4da1j8IKLr29cVOHGvEEQnQe9A
 vwGAlmSgC0QTKGETDLJ2cTbBNAhINoT3F3aH3DdkmwDKWX96hyWDqL1wHiCqA5vJkVJl
 bAUOmLxTOKVhoX5XGzRRdiqcnp0KRc8TtUDNi/JMdO3XtbbnnkPhiaAca1OVEz4THUR5
 URYw==
X-Gm-Message-State: AOAM533hin35Tj2KplDvVbdMZ4F+QnV2uLKRyOX4hU32dpbn4ry3FiPf
 5+GpxeOclUZX4TV3eexUwutvQgiFtwAx6/x2WYKbEcmw8Sw3UKCgRmLzen9+EO+eJ/jRld2Nx1W
 /2yWj/sI6x+6x9tY=
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr3808269wmi.48.1592483634685; 
 Thu, 18 Jun 2020 05:33:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT3PW6GYEKCPuH0vp0J2f+7eTExNCzKTpYhKoq4qDryxTb+dGBNqWB76knQM8Hv8WBQ0EJ2w==
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr3808250wmi.48.1592483634546; 
 Thu, 18 Jun 2020 05:33:54 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id x186sm3509943wmg.8.2020.06.18.05.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:33:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/10] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Thu, 18 Jun 2020 14:33:34 +0200
Message-Id: <20200618123342.10693-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
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
index 5184cf46b3..426439a2c3 100644
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


