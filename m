Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA8C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9402145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWENDNk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9402145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZm-0004Nx-Sy
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59805)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYX-0007sb-JR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYW-0003AL-LX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYW-00039b-Ed
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z1so19805124wru.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=R2KY92Z7mdmQFY2AfwkaNFzZ9VI1hZbFTT8NYQ7db68=;
 b=sWENDNk/wQyoH9tX8MtQ07aEekkeiyHTvpDbXxUMNBqyUMfAqIZtzGNlBUJLUHlS7u
 za+fuA8VvfsnkJfgn1xj4PQkpNCdkCT/aAuMMVlFVDicoL1K9CMkuVrn08NwBnQY/dJZ
 5N2pZG1zleGgAaUOPVn7NCHHXVmVSfmBWxcbOE/oznnr5SKFUQ2OWUtD/pdwn8w37lZL
 KOlAAqgRRG17OPJV7JmFfQN25vsv5upQXctwg+SKCZr1dewVUlGPGcvwwCRT7xgajb3w
 yl9o+YjLrLh2cVsIgl1W0lcd7O+2IOSIPheDIpToJjpuc2bfLWOifunnOO++UINKEuB5
 slFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=R2KY92Z7mdmQFY2AfwkaNFzZ9VI1hZbFTT8NYQ7db68=;
 b=Je/PZQeIsdyMz5IyjZ6l/M80jAiv80yTKOdnxutsJO9WaRgzKJaZWR9sFSsiFCb0xe
 GM5SkFN2iXz4SDafwIoLxJjh7GNUk7A+ZUOUGzxDYOFqeuJ99bevj5eMGkBWgajR9dwf
 SlcJl9dsZp320/tz/r1uigsjxcjlL9zrtYKSnE2LRMC+GrtHWZeKvK3JJvF5oZfSnaPr
 1Gvbi6WaELvfG+GflwI1hlU4mKu0+lUyjTnnxuInmQ6cnd/sFUzn/ziGianFcQJIHHkT
 6OnG2bcogUcoyohKNge/qjZrXrh5M5oGNb7UX4WITzaPwBpLGBF5qpBqktw6qoI8CYDT
 +OcA==
X-Gm-Message-State: APjAAAW1LuNMtsQmBFqZlqf7GoopDtquk0Fnqsuu72urL0Jr0L6qjfVU
 WIsGBqhEW0MG0CUkXyYHro7OTfuXyq8=
X-Google-Smtp-Source: APXvYqy0zvEn3aDOSukVbm4Qf3shFAraLKyKx5BLID/w+L9t02epQpmnLB48sa692GwVuAB/RVX2YA==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr15163612wrj.352.1563264683110; 
 Tue, 16 Jul 2019 01:11:23 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:01 +0200
Message-Id: <1563264677-39718-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 03/19] scsi: add guest-recoverable ZBC errors
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running basic operations on zoned storage from the guest via
scsi-block, the following ASCs are reported for write or read commands
due to unexpected zone status or write pointer status:

     21h 04h: UNALIGNED WRITE COMMAND
     21h 05h: WRITE BOUNDARY VIOLATION
     21h 06h: ATTEMPT TO READ INVALID DATA
     55h 0Eh: INSUFFICIENT ZONE RESOURCES

Reporting these ASCs to the guest, the user applications can handle
them to manage zone/write pointer status, or help the user application
developers to understand the failure reason and fix bugs.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scsi/utils.c b/scsi/utils.c
index ad243a9..873d49c 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -360,6 +360,11 @@ static bool scsi_sense_is_guest_recoverable(int key, int asc, int ascq)
     case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
     case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
 
+    case 0x2104: /* UNALIGNED WRITE COMMAND */
+    case 0x2105: /* WRITE BOUNDARY VIOLATION */
+    case 0x2106: /* ATTEMPT TO READ INVALID DATA */
+    case 0x550e: /* INSUFFICIENT ZONE RESOURCES */
+
     case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
     case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
         return true;
-- 
1.8.3.1



