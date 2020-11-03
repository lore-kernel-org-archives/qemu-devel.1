Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BBC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ED3206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6DLNd4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuUQ-0004FV-U6
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSF-0002D7-8J
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuSB-0006Xo-0q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsldW9KcK6vt6+l44bfLcLh5QfAWQnVBXAW4qRe393k=;
 b=Y6DLNd4/MJsirDaDxICZiKo0AD5e8EIfaL9jGjEJPPTePO2d0hzBboIPU6WAE1JV+CEfHf
 mrMw6AE1H66rNwTEiZz6qWRgkT910ngzfKtKnA7h8qgjiu1eA3HLek4Z0Eeo4WSYbVBIcV
 U0VHT7HKmo+MJj09oDtqeU2qcsIaXNQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-DB9rMa2SPc2mshJmB9qGZw-1; Tue, 03 Nov 2020 06:26:15 -0500
X-MC-Unique: DB9rMa2SPc2mshJmB9qGZw-1
Received: by mail-wr1-f69.google.com with SMTP id w3so5588939wrt.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jsldW9KcK6vt6+l44bfLcLh5QfAWQnVBXAW4qRe393k=;
 b=F9gVdeDy13hRBcBVvQyVu8xod0gJsck6VCuusZ4xQo0emSatf6FR4rKK410mEYDW6v
 feUcMtqdLiPk7KuEe7PXfCKLjChu6RWHW20WkclKeRx/6AkWngAQebdA25zsxFONY8x5
 kBc4dUvMcDd1mH3IJj77mogJk9ZD7oOTdMdSBOf71NvRnSgcKmreaeRhVoDllb8JK/kN
 uRoVM2SvMgBDjKelsNq64u1wxc2FiFRVJNZHbsC9G0DkAS24vtveLNIghNI0i7hkT3eB
 CTbfqIISRSsDwVdiD9mxP23YoI8UWsWQytB1P3HDPF1OAupW44f39Z9G6rwWjs21pgmP
 2pNA==
X-Gm-Message-State: AOAM5319XMyD7+wfwMD1dM5Yvv7kFQqlbMzWs0iYcxBeq39HEDDmfO7y
 AhNA0cmZGeVRK0K87ZYO0P6XZXmhV7GkiWEw9u4odBi42VA9E8Bz1Z8RIM9oLcniH7zuZ3M3lls
 E/VRhS8hz/u1ZLI4=
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr3229473wmk.180.1604402771193; 
 Tue, 03 Nov 2020 03:26:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl52Ds1oRu6dTtUZhGm8AV0CHCxfu1jIdltfQr0X/jECQCS5/5xrlI7Ccy0qyfSva7NILQ9Q==
X-Received: by 2002:a7b:c2ef:: with SMTP id e15mr3229451wmk.180.1604402771044; 
 Tue, 03 Nov 2020 03:26:11 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n22sm2083018wmk.40.2020.11.03.03.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:26:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/4] hw/display/cirrus_vga: Fix hexadecimal format
 string specifier
Date: Tue,  3 Nov 2020 12:25:56 +0100
Message-Id: <20201103112558.2554390-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103112558.2554390-1-philmd@redhat.com>
References: <20201103112558.2554390-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The '%u' conversion specifier is for decimal notation.
When prefixing a format with '0x', we want the hexadecimal
specifier ('%x').

Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/cirrus_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index e14096deb46..fdca6ca659f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2105,7 +2105,7 @@ static void cirrus_vga_mem_write(void *opaque,
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "cirrus: mem_writeb 0x" TARGET_FMT_plx " "
-                      "value 0x%02" PRIu64 "\n", addr, mem_value);
+                      "value 0x%02" PRIx64 "\n", addr, mem_value);
     }
 }
 
-- 
2.26.2


