Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2723220738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIfOaDzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2723220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngXG-0007Fy-D8
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWD-0005G1-AN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngW9-0007QL-0v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BS0abpdiPuVnJZzNFn28vzuVgg/Ij6oTCIsBYhyt1Y=;
 b=bIfOaDzq0x0IUF5LoJ0EiNTp0GWSMLoHmZD/GFzzN9luqY2ESBO12J3vUTBqzqqDSVncNN
 ohYGZildyI8ZILIRcCderLDs7a3E6lMBMSaQIOiVDcw/rKFkXxYS10XmYrktKt8NC/kkRE
 bdqhpbEAtP8UqBx8tyPpiXZYn0YVjOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-8elHy-yfODeksUP8_5QalQ-1; Tue, 23 Jun 2020 06:51:02 -0400
X-MC-Unique: 8elHy-yfODeksUP8_5QalQ-1
Received: by mail-wm1-f69.google.com with SMTP id 23so3592463wmi.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1BS0abpdiPuVnJZzNFn28vzuVgg/Ij6oTCIsBYhyt1Y=;
 b=k5zxwSTKkBLG2YrXohV93vpcbHWOEx+7tVaJ5aAxyoBmjvRsd5b6JcX3oFNQK1snmR
 lab+UxSeuPXX3Y6Bmy51ICHsrX1tS+uk3vRYs5iMM4gFrpcb/YCtyF+oCbztDYxSfKK1
 5dFI7KcZBwDJKXybYwmkNUhdL57Qf1PN0vmt768jdAMsUeYHErkuykMm+uXuvJ8gQh5r
 WsnMkqdHe9QvvR2dfY9yk9M/jwyeHtCP4V/kb/QWcUd1sXlnZgS61vU7GGoKv0McaIBy
 SlweNgp1u8TNm1P/KTd8P56teXJNcOlHfXUAWyofd4KTAiWUvEoqY6+DcIYEbe7GSuND
 W7Qg==
X-Gm-Message-State: AOAM5326YWfICjOhoshLTqgYq38WSCxJaMqToZTWDDnFkKnfkE34dV8+
 pNhQuXM0zWVEnkTJgiKSEC+1TaWaYGME3lDjYy3AwQzrv6RcLBu/mriSQFdBm34znuuRwDuFgaS
 AoJRf4kJvaqNflgA=
X-Received: by 2002:adf:9205:: with SMTP id 5mr23264881wrj.232.1592909461398; 
 Tue, 23 Jun 2020 03:51:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjdMOkGSgtWFKbLjB8FzK+2Ae35wW4M/EhzLYOTVgI1sklv0ksqtYAGkGa8RRoxTc2DMk/SA==
X-Received: by 2002:adf:9205:: with SMTP id 5mr23264860wrj.232.1592909461243; 
 Tue, 23 Jun 2020 03:51:01 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 104sm22641857wrl.25.2020.06.23.03.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] accel/kvm: Let kvm_check_extension use global KVM state
Date: Tue, 23 Jun 2020 12:50:46 +0200
Message-Id: <20200623105052.1700-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As KVM supported extentions those should be the same for
all VMs, it is safe to directly use the global kvm_state
in kvm_check_extension().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f24d7da783..934a7d6b24 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -913,7 +913,7 @@ int kvm_check_extension(KVMState *s, unsigned int extension)
 {
     int ret;
 
-    ret = kvm_ioctl(s, KVM_CHECK_EXTENSION, extension);
+    ret = kvm_ioctl(kvm_state, KVM_CHECK_EXTENSION, extension);
     if (ret < 0) {
         ret = 0;
     }
-- 
2.21.3


